package com.bolivariano.microservice.pagoproveedorcnb.utils;

import org.w3c.dom.Node;

import javax.xml.bind.JAXBElement;
import javax.xml.bind.annotation.XmlAnyElement;
import javax.xml.bind.annotation.adapters.XmlAdapter;
import javax.xml.namespace.QName;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class MapAdapter extends XmlAdapter<MapType, Map<String, Object>> {
    @Override
    public MapType marshal(Map<String, Object> m) throws Exception {
        MapType wrapper = new MapType();
        List<Object> elements = new ArrayList<>();
        for (Map.Entry<String, Object> property : m.entrySet()) {
            if (property.getValue() instanceof Map)
                elements.add(new JAXBElement<MapType>(new QName("##other", getCleanLabel(property.getKey()), "o"),
                        MapType.class, marshal((Map) property.getValue())));
            else
                elements.add(new JAXBElement<String>(new QName("##other", getCleanLabel(property.getKey()), "o"),
                        String.class, property.getValue().toString()));
        }
        wrapper.elements = elements;
        return wrapper;
    }

    @Override
    public Map<String, Object> unmarshal(MapType v) throws Exception {
        Map<String, Object> objectMap = new LinkedHashMap<>();
        for(Object element: v.elements){
            Node node = (Node) element;
            Map<String, Object> objectMapChild = new LinkedHashMap<>();
            if(node.hasChildNodes()){
                for(int index= 0; index< node.getChildNodes().getLength(); index++){
                    Map<String, Object> objectMapChildTemp = createMap();
                    if(objectMapChildTemp.size()>0)
                        objectMapChild.putAll(objectMapChildTemp);
                }
            }
            objectMap.put(node.getLocalName(), objectMapChild );
        }
        return objectMap;
    }

    public Map<String, Object> createMap() {
        
        return new LinkedHashMap<>();
    }

    private String getCleanLabel(String attributeLabel) {
        attributeLabel = attributeLabel.replaceAll("[()]", "").replaceAll("[^\\w\\s]", "_").replace(" ", "_");
        return attributeLabel;
    }
}

class MapType {
    @XmlAnyElement()
    List<Object> elements;
}