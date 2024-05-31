package com.bolivariano.microservice.tcrtconsultamediospan.dto;

public class RouteResponse {
    private int code;
    private String message;

    public RouteResponse() {
        // COnstructor Por defecto
    }
    public RouteResponse(Status status) {
        this.code = status.getCode();
        this.message = status.getMessage();
    }

    public RouteResponse(Status status, String message) {
        this.code = status.getCode();
        this.message = message;
    }

    public static RouteResponse response(Status status) {
        return new RouteResponse(status);
    }

    public static RouteResponse response(Status status, String message) {
        return new RouteResponse(status, message);
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public enum Status {
        OK(200, "Consulta completada exitosamente"),
        BAD_REQUEST(400, "Request incorrecto"),
        INTERNAL_ERROR(500, "Hay un problema con la acción, revise la aplicación e inténtalo de nuevo."),
        NOT_FOUND(404, "No se han encontrado registros relacionados con su búsqueda"),
        CONFLICT_WITH_DATA(406, "Existe un problema con los datos ingresados"),
        INCOMPLETE_DATA(407, "La cantidad de detalles no coincide con las enviadas en cabecera");

        private final int code;
        private final String message;

        Status(int code, String message) {
            this.code = code;
            this.message = message;
        }

        public int getCode() {
            return code;
        }

        public String getMessage() {
            return message;
        }
    }
}