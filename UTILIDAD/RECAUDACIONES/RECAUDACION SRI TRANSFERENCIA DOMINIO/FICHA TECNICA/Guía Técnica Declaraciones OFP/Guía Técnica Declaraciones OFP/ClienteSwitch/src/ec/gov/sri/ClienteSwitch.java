package ec.gov.sri;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ClienteSwitch {
	public static void main(String[] args) throws Exception{
	    File archivoAEnviar = new File("ejemplosDeTramas/TSW_PCK_RISE.TSW_PRO_CONSULTA.xml");
        //File archivoAEnviar = new File("ejemplosDeTramas/TSW_PCK_RISE.TSW_PRO_PAGO.xml");
        //File archivoAEnviar = new File("ejemplosDeTramas/TSW_PCK_RISE.TSW_PRO_REVERSO.xml");
		FileInputStream fis = new FileInputStream(archivoAEnviar);
		String trama="";
		int a;
		while((a = fis.read())>0) {
			trama+=(char)a;
		}
		fis.close();
		FileOutputStream fos = new FileOutputStream( getNombreArchivoRespuesta(archivoAEnviar.getName()));
		//10.1.9.12 //10.1.7.30
		fos.write(enviarTrama("10.1.9.12",7777,trama).getBytes());
		fos.close();
	}
	
	public static String getNombreArchivoRespuesta(String nombreArchivoAEnviar) {
	    String result = "respuestasTramas/" + nombreArchivoAEnviar.substring(0,nombreArchivoAEnviar.length()-4) + "-";
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd-hhmmss");
	    result += sdf.format(new Date()) + ".xml";
	    return result;
	}
	
	public static byte[] numeroEnBytes (long numero) {
		byte bytes[] = new byte[2];
		bytes[0] = (byte)(numero / 256); // considerar que es una división entera
		bytes[1] = (byte)(numero % 256);
		return bytes;
	}

	public static long bytesEnNumero (byte[]bytes) {
        int byte1 = bytes[1];
        //los byte en java tienen signo por lo que el siguiente codigo transforma a entero positivo
        byte1=byte1<0?byte1+256:byte1; 
		return ((long)bytes[0]*256 + (long)byte1);
	}	
	
	public static String enviarTrama(String ip, int puerto,String mensaje) throws Exception{
		// CODIGO PARA ESCRIBIR UN MENSAJE
		String respuesta="";
		Socket sc = new Socket(ip,puerto);
		System.out.println("Conexión Establecida");
		
		OutputStream os =sc.getOutputStream();
		byte mensajeBytes[] =mensaje.getBytes();

		System.out.println("Se va a enviar el mensaje: \"" + mensaje + "\"");
		os.write(numeroEnBytes(mensajeBytes.length+2));
		os.write(mensajeBytes);
		os.flush();

		// CODIGO PARA LEER LA RESPUESTA
		InputStream is = sc.getInputStream();
		System.out.println("Se inicia la lectura");
	    byte longRespEnBytes[]= new byte[2];
	    is.read(longRespEnBytes);
	    long longRespuesta = bytesEnNumero(longRespEnBytes)-2;
        System.out.println("Longitud Recibida: " + longRespuesta);
	    for (int i=0; i<longRespuesta; i++) {
	    	int byteLeido=is.read();
	    	if (byteLeido!= 0) {
	    	   respuesta+=(char)byteLeido;
	    	}
	    }
        System.out.println("Mensaje Recibido: \"" + respuesta + "\"");
        System.out.println("Fin comunicación");
	    sc.close();
		return respuesta;
	}

}
