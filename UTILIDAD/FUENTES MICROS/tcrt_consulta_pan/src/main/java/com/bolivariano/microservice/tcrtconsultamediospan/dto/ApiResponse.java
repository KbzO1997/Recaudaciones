package com.bolivariano.microservice.tcrtconsultamediospan.dto;

import lombok.NoArgsConstructor;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Data;

@Data
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ApiResponse {

    private RouteResponse response;
    private Object data;

    public ApiResponse(RouteResponse response, Object data) {
        this.response = response;
        this.data = data;
    }

    public ApiResponse(RouteResponse response) {
        this.response = response;
    }

    public RouteResponse getResponse() {
        return response;
    }

    public void setResponse(RouteResponse response) {
        this.response = response;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
