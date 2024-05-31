package com.bolivariano.microservice.utilitarioms.utils;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Component;

@Component
public class Util {
	@Autowired	
	private ResourceLoader resourceLoader;
	   
	public InputStream getResourceAsInputStream(String resourceString) {
	    Resource resource = resourceLoader.getResource(resourceString);
        try {
			InputStream inputStream = resource.getInputStream();
			return inputStream;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		} 
	}
	
	public String getResourceAsString(String resourceString) {
		InputStream inputStream = getResourceAsInputStream(resourceString);
		try {
			return convert(inputStream);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "";
		}
	}
	
	public String convert(InputStream inputStream) throws IOException {
		   ByteArrayOutputStream result = new ByteArrayOutputStream();
		   byte[] buffer = new byte[1024];
		   int length;
		   while ((length = inputStream.read(buffer)) != -1) {
		       result.write(buffer, 0, length);
		   }
		   return result.toString("UTF-8");
	   }
	
}
