package gov.in.rgsa.model;

public class ViewReportAtMoprModel {

	private Integer finYearId=0;
	private Integer stateCode=0;
	private Boolean isDemoGraphic=false;
	private Boolean isAnnualPlan=false;
	public Integer getFinYearId() {
		return finYearId;
	}
	public void setFinYearId(Integer finYearId) {
		this.finYearId = finYearId;
	}
	public Integer getStateCode() {
		return stateCode;
	}
	public void setStateCode(Integer stateCode) {
		this.stateCode = stateCode;
	}
	public Boolean getIsDemoGraphic() {
		return isDemoGraphic;
	}
	public void setIsDemoGraphic(Boolean isDemoGraphic) {
		this.isDemoGraphic = isDemoGraphic;
	}
	public Boolean getIsAnnualPlan() {
		return isAnnualPlan;
	}
	public void setIsAnnualPlan(Boolean isAnnualPlan) {
		this.isAnnualPlan = isAnnualPlan;
	}
}
