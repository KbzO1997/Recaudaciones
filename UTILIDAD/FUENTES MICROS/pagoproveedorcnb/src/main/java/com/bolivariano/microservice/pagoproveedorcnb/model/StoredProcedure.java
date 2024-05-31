package com.bolivariano.microservice.pagoproveedorcnb.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

import java.io.Serializable;
import java.util.List;

@JsonIgnoreProperties(value = {"id"})

@JsonInclude(Include.NON_NULL)
public class StoredProcedure implements Serializable {

    /**
     *
     */
	private static final long serialVersionUID = -6178245662847169284L;
	private String id;

	private String name;

	private String description;

	private String alias;

	private List<Parameter> parameters;

	private String schema;

	private String state = "active";

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getAlias() {
		return alias;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}

	public List<Parameter> getParameters() {
		return parameters;
	}

	public void setParameters(List<Parameter> parameters) {
		this.parameters = parameters;
	}

	public String getSchema() {
		return schema;
	}

	public void setSchema(String schema) {
		this.schema = schema;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@JsonIgnoreProperties(value = { "nameInSybaseScript", "caseSensitive", "indexInSybaseScript" })
	//@Data
	@JsonInclude(Include.NON_NULL)
	public static class Parameter implements Serializable {
		/**
		 * 
		 */
		private static final long serialVersionUID = 2551134616676908147L;
		private String name;

		private String description;

		private EnumTypes.DataType dataType;

		private EnumTypes.ParamType type;

		private String alias;

		private String format;

		private String capacity;
		private String nameInSybaseScript;
		private int indexInSybaseScript;
		private EnumTypes.CaseSensitive caseSensitive;

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getDescription() {
			return description;
		}

		public void setDescription(String description) {
			this.description = description;
		}

		public com.bolivariano.microservice.pagoproveedorcnb.model.EnumTypes.DataType getDataType() {
			return dataType;
		}

		public void setDataType(com.bolivariano.microservice.pagoproveedorcnb.model.EnumTypes.DataType dataType) {
			this.dataType = dataType;
		}

		public com.bolivariano.microservice.pagoproveedorcnb.model.EnumTypes.ParamType getType() {
			return type;
		}

		public void setType(com.bolivariano.microservice.pagoproveedorcnb.model.EnumTypes.ParamType type) {
			this.type = type;
		}

		public String getAlias() {
			return alias;
		}

		public void setAlias(String alias) {
			this.alias = alias;
		}

		public String getFormat() {
			return format;
		}

		public void setFormat(String format) {
			this.format = format;
		}

		public String getCapacity() {
			return capacity;
		}

		public void setCapacity(String capacity) {
			this.capacity = capacity;
		}

		public String getNameInSybaseScript() {
			return nameInSybaseScript;
		}

		public void setNameInSybaseScript(String nameInSybaseScript) {
			this.nameInSybaseScript = nameInSybaseScript;
		}

		public int getIndexInSybaseScript() {
			return indexInSybaseScript;
		}

		public void setIndexInSybaseScript(int indexInSybaseScript) {
			this.indexInSybaseScript = indexInSybaseScript;
		}

		public com.bolivariano.microservice.pagoproveedorcnb.model.EnumTypes.CaseSensitive getCaseSensitive() {
			return caseSensitive;
		}

		public void setCaseSensitive(com.bolivariano.microservice.pagoproveedorcnb.model.EnumTypes.CaseSensitive caseSensitive) {
			this.caseSensitive = caseSensitive;
		}

		@Override
		public String toString() {
			return "Parameter [name=" + name + ", description=" + description + ", dataType=" + dataType + ", type="
					+ type + ", alias=" + alias + ", format=" + format + ", capacity=" + capacity
					+ ", nameInSybaseScript=" + nameInSybaseScript + ", indexInSybaseScript=" + indexInSybaseScript
					+ ", caseSensitive=" + caseSensitive + "]";
		}
		
		
	}
}
