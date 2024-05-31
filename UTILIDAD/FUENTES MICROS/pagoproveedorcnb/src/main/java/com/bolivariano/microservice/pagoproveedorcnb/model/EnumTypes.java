package com.bolivariano.microservice.pagoproveedorcnb.model;

public class EnumTypes {
    public enum CaseSensitive{
        UPPER,
        LOWER,
        CAPITALIZE,
        NONE
    }

    public enum LoggingLevel{
        INFO,
        WARN,
        ERROR,
        DEBUG
    }

    public enum DataType{
        VARCHAR,
        NUMBER,
        INTEGER,
        DATE,
        CURSOR,
        CLOB
    }

    public enum ParamType{
        IN,
        OUT,
        INOUT
    }


    public enum Type{
        SYNC,
        ASYNC,
        HYBRID
    }
}
