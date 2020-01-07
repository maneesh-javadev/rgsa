package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

import org.hibernate.annotations.Type;

import com.fasterxml.jackson.databind.JsonNode;

@Entity
@Table(name="dashboard_data",schema="rgsa")
// @NamedQuery(name="FETCH_EGOV_ACTIVITY", query="SELECT E FROM DashboardData E where stateCode =:stateCode and yearId =:yearId and userType =:userType")

public class DashboardData implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -2670115372162436683L;
	
	

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="dashboard_data_id", updatable=false, nullable=false)
	public Integer dashboardDataId;
	
	@Column(name="state_code", nullable=false)
	public Integer stateCode;
	
	@Column(name="state_name")
	public String stateName;
	
	@Column(name="page_reference_name", nullable=false)
	public String pageReferenceName;
	
	@Column(name="json_data")
	@Type(type = "gov.in.rgsa.types.hibernate.JsonType")
	public JsonNode jsonData;

	public Integer getStateCode() {
		return stateCode;
	}

	public void setStateCode(Integer stateCode) {
		this.stateCode = stateCode;
	}

	public String getStateName() {
		return stateName;
	}

	public void setStateName(String stateName) {
		this.stateName = stateName;
	}

	public String getPageReferenceName() {
		return pageReferenceName;
	}

	public void setPageReferenceName(String pageReferenceName) {
		this.pageReferenceName = pageReferenceName;
	}

	public JsonNode getJsonData() {
		return jsonData;
	}

	public void setJsonData(JsonNode jsonData) {
		this.jsonData = jsonData;
	}
	
	/*
	 -- Generation SQL
	 CREATE TABLE rgsa.dashboard_data
	(
	  dashboard_data_id serial NOT NULL,
	  state_code integer NOT NULL,
	  state_name character varying,
	  page_reference_name character varying NOT NULL,
	  json_data jsonb,
	  CONSTRAINT dashboard_data_ukey PRIMARY KEY (dashboard_data_id),
	  CONSTRAINT dashboard_data_pkey UNIQUE (state_code, page_reference_name)
	)
	WITH (
	  OIDS=FALSE
	);
	ALTER TABLE rgsa.dashboard_data
	  OWNER TO postgres;
	 */

}
