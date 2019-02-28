package gov.in.rgsa.model;

public class PesaPlanDetailsResponse {
	
	private Integer pesaPlanDetailsId;
	
	private Integer pesaPlanId;
	
	private Integer pesaPostId;
	
	private Integer noOfUnits;
	
	private Integer unitCostPerMonth;
	
	private Integer noOfMonths;
	
	private Integer funds;
	
	private String remarks;

	public Integer getPesaPlanDetailsId() {
		return pesaPlanDetailsId;
	}

	public void setPesaPlanDetailsId(Integer pesaPlanDetailsId) {
		this.pesaPlanDetailsId = pesaPlanDetailsId;
	}

	public Integer getPesaPlanId() {
		return pesaPlanId;
	}

	public void setPesaPlanId(Integer pesaPlanId) {
		this.pesaPlanId = pesaPlanId;
	}

	public Integer getPesaPostId() {
		return pesaPostId;
	}

	public void setPesaPostId(Integer pesaPostId) {
		this.pesaPostId = pesaPostId;
	}

	public Integer getNoOfUnits() {
		return noOfUnits;
	}

	public void setNoOfUnits(Integer noOfUnits) {
		this.noOfUnits = noOfUnits;
	}

	public Integer getUnitCostPerMonth() {
		return unitCostPerMonth;
	}

	public void setUnitCostPerMonth(Integer unitCostPerMonth) {
		this.unitCostPerMonth = unitCostPerMonth;
	}

	public Integer getNoOfMonths() {
		return noOfMonths;
	}

	public void setNoOfMonths(Integer noOfMonths) {
		this.noOfMonths = noOfMonths;
	}

	public Integer getFunds() {
		return funds;
	}

	public void setFunds(Integer funds) {
		this.funds = funds;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

}
