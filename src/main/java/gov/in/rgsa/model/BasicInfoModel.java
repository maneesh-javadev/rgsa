package gov.in.rgsa.model;

import java.util.List;
import java.util.Map;

public class BasicInfoModel {
	
	

	private Integer basicInfoId;
	private String status;
	
	private Integer basicInfoDefinationId;
	
	private Map<String, List<String>> data;
	
	public Integer getBasicInfoId() {
		return basicInfoId;
	}

	public void setBasicInfoId(Integer basicInfoId) {
		this.basicInfoId = basicInfoId;
	}

	public Map<String, List<String>> getData() {
		return data;
	}

	public void setData(Map<String, List<String>> data) {
		this.data = data;
	}

	public Integer getBasicInfoDefinationId() {
		return basicInfoDefinationId;
	}

	public void setBasicInfoDefinationId(Integer basicInfoDefinationId) {
		this.basicInfoDefinationId = basicInfoDefinationId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	

}
