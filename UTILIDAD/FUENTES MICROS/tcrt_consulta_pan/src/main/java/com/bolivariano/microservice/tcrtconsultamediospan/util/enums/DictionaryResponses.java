package com.bolivariano.microservice.tcrtconsultamediospan.util.enums;

public enum DictionaryResponses {
    OK(200, "Consulta completada exitosamente"),
    BAD_REQUEST(400, "Request incorrecto"),
    INTERNAL_ERROR(500, "Hay un problema con la acción, revise la aplicación e inténtalo de nuevo."),
    NOT_FOUND(404, "No se han encontrado registros relacionados con su búsqueda"),
    CONFLICT_WITH_DATA(406, "Existe un problema con los datos ingresados"),
    INCOMPLETE_DATA(407, "La cantidad de detalles no coincide con las enviadas en cabecera");
	private final int code;
    private final String message;
    DictionaryResponses(int response,String responseReason){
        code = response;
        message = responseReason;
    }
    public String getMessage(){
        return message;
    }
    public int getCode(){
        return code;
    }

}
