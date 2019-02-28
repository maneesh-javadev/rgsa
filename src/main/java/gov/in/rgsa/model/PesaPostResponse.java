package gov.in.rgsa.model;

import gov.in.rgsa.entity.PesaPlan;

public class PesaPostResponse {
	
	private Integer pesaPostId;
	
	private String pesaPostName;
	
	private Integer ceilingValue;
	
	private PesaPlan pesaPlan;

	public Integer getPesaPostId() {
		return pesaPostId;
	}

	public void setPesaPostId(Integer pesaPostId) {
		this.pesaPostId = pesaPostId;
	}

	public String getPesaPostName() {
		return pesaPostName;
	}

	public void setPesaPostName(String pesaPostName) {
		this.pesaPostName = pesaPostName;
	}

	public Integer getCeilingValue() {
		return ceilingValue;
	}

	public void setCeilingValue(Integer ceilingValue) {
		this.ceilingValue = ceilingValue;
	}

}
