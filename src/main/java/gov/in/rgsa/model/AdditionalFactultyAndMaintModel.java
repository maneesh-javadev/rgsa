package gov.in.rgsa.model;

import java.util.List;

import gov.in.rgsa.entity.InstitueInfraHrActivityDetails;
import gov.in.rgsa.entity.TIWiseProposedDomainExperts;

public class AdditionalFactultyAndMaintModel {
	
	private Integer instituteInfraHrActivityTypeId;
	
	private Integer instituteInfraHrActivityId;
	
	private Integer districtsSupported;
	
	private String dbFileName;
  
	private Integer districtCode;
	
	private List<TIWiseProposedDomainExperts> tIWiseProposedDomainExperts;
	
	private List<InstitueInfraHrActivityDetails> institueInfraHrActivityDetails;
	
	private Integer noOfUnits;
	
	private Integer unitCost;
	
	private Integer noOfMonths;
	
	private Integer fund;
	
	private Integer otherExpenses;
	
	private Integer totalFund;
	
	private String remarks;
	
	private Integer additionalRequirement;
	
	private Integer total;
	
	private Integer grand_total;
	
	private String userType;

	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public Integer getGrand_total() {
		return grand_total;
	}

	public void setGrand_total(Integer grand_total) {
		this.grand_total = grand_total;
	}

	public Integer getNoOfUnits() {
		return noOfUnits;
	}

	public void setNoOfUnits(Integer noOfUnits) {
		this.noOfUnits = noOfUnits;
	}

	public Integer getUnitCost() {
		return unitCost;
	}

	public void setUnitCost(Integer unitCost) {
		this.unitCost = unitCost;
	}

	public Integer getNoOfMonths() {
		return noOfMonths;
	}

	public void setNoOfMonths(Integer noOfMonths) {
		this.noOfMonths = noOfMonths;
	}

	public Integer getFund() {
		return fund;
	}

	public void setFund(Integer fund) {
		this.fund = fund;
	}

	public Integer getOtherExpenses() {
		return otherExpenses;
	}

	public void setOtherExpenses(Integer otherExpenses) {
		this.otherExpenses = otherExpenses;
	}

	public Integer getTotalFund() {
		return totalFund;
	}

	public void setTotalFund(Integer totalFund) {
		this.totalFund = totalFund;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	public List<InstitueInfraHrActivityDetails> getInstitueInfraHrActivityDetails() {
		return institueInfraHrActivityDetails;
	}

	public void setInstitueInfraHrActivityDetails(List<InstitueInfraHrActivityDetails> institueInfraHrActivityDetails) {
		this.institueInfraHrActivityDetails = institueInfraHrActivityDetails;
	}

	public Integer getAdditionalRequirement() {
		return additionalRequirement;
	}

	public void setAdditionalRequirement(Integer additionalRequirement) {
		this.additionalRequirement = additionalRequirement;
	}

	public Integer getInstituteInfraHrActivityId() {
		return instituteInfraHrActivityId;
	}

	public void setInstituteInfraHrActivityId(Integer instituteInfraHrActivityId) {
		this.instituteInfraHrActivityId = instituteInfraHrActivityId;
	}

	public String getDbFileName() {
		return dbFileName;
	}

	public void setDbFileName(String dbFileName) {
		this.dbFileName = dbFileName;
	}

	public Integer getInstituteInfraHrActivityTypeId() {
		return instituteInfraHrActivityTypeId;
	}

	public void setInstituteInfraHrActivityTypeId(Integer instituteInfraHrActivityTypeId) {
		this.instituteInfraHrActivityTypeId = instituteInfraHrActivityTypeId;
	}

	public List<TIWiseProposedDomainExperts> gettIWiseProposedDomainExperts() {
		return tIWiseProposedDomainExperts;
	}

	public void settIWiseProposedDomainExperts(List<TIWiseProposedDomainExperts> tIWiseProposedDomainExperts) {
		this.tIWiseProposedDomainExperts = tIWiseProposedDomainExperts;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public Integer getDistrictCode() {
		return districtCode;
	}

	public void setDistrictCode(Integer districtCode) {
		this.districtCode = districtCode;
	}

	public Integer getDistrictsSupported() {
		return districtsSupported;
	}

	public void setDistrictsSupported(Integer districtsSupported) {
		this.districtsSupported = districtsSupported;
	}

	
	

}
