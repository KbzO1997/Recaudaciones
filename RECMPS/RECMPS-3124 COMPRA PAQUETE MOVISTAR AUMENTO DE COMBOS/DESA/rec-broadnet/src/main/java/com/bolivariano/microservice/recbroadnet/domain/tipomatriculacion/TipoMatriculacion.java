
package com.bolivariano.microservice.recbroadnet.domain.tipomatriculacion;

import javax.xml.bind.annotation.XmlEnum;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for tipoMatriculacion.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <p>
 * <pre>
 * &lt;simpleType name="tipoMatriculacion"&gt;
 *   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *     &lt;enumeration value="MATRICULABLE"/&gt;
 *     &lt;enumeration value="NO_MATRICULABLE"/&gt;
 *   &lt;/restriction&gt;
 * &lt;/simpleType&gt;
 * </pre>
 * 
 */
@XmlType(name = "tipoMatriculacion", namespace = "http://www.bolivariano.com/dominio/TipoMatriculacion")
@XmlEnum
public enum TipoMatriculacion {

    MATRICULABLE,
    NO_MATRICULABLE;

    public String value() {
        return name();
    }

    public static TipoMatriculacion fromValue(String v) {
        return valueOf(v);
    }

}
