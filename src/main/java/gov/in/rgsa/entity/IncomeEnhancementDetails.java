package gov.in.rgsa.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

/**
 * @author Mohammad Ayaz 18/09/2018
 *
 */
@Entity
@Table(name="income_enhancement_details",schema="rgsa")
@NamedQuery(name="DELETE_INCM_ENHNCMNT_DETAILS_BY_ID",query="delete from IncomeEnhancementDetails where incomeEnhancementDetailsId=:incomeEnhancementDetailsId")
public class IncomeEnhancementDetails {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="income_enhancement_details_id",nullable=false)
	private Integer incomeEnhancementDetailsId;
	
	@ManyToOne(cascade=CascadeType.ALL , fetch=FetchType.EAGER)
	@JoinColumn(name="income_enhancement_id" , referencedColumnName="income_enhancement_id")
	private IncomeEnhancementActivity  incomeEnhancementActivity;
	
	@Column(name="activty_name")
	private String activtyName;
	
	/*@Column(name="fund_source_type")
	private Character fundSourceType;*/
	
	@Column(name="fund_source_code")
	private Integer fundSourceCode;
	
	@Column(name="district_code")
	private Integer districtCode;
	
	@Column(name="block_code")
	private Integer blockCode;
	
	@Column(name="total_no_of_gp_covered")
	private Integer totalNoOfGpCovered;
	
	@Column(name="no_of_aspirational_gp")
	private Integer noOfAspirationalGp;
	
	@Column(name="year_from")
	private Integer yearFrom;
	
	@Column(name="year_to")
	private Integer yearTo;
	
	@Column(name="total_cost_of_project")
	private Integer totalCostOfProject;
	
	@Column(name="funds_required")
	private Integer fundsRequired;
	
	@Column(name="brief_about_activity")
	private String briefAboutActivity;
	
	@Column(name="plan_approved_by_dpc")
	private Boolean planApprovedByDpc = false;
	
	@Column(name="file_name")
	private String fileName;
	
	@Column(name="file_content_type")
	private String fileContentType;
	
	@Column(name="file_location")
	private String fileLocation;
	
	@Column(name="is_active")
	private Boolean isActive ;
	
	@Column(name="is_approved")
	private Boolean isApproved ;
	
	@Column(name="remarks")
	private String remarks ;
	
	@Transient
	private MultipartFile file;
	
	@Transient
	private String blockName;
	
	@Transient
	private List<Block> blockListFromDb;

	public Integer getIncomeEnhancementDetailsId() {
		return incomeEnhancementDetailsId;
	}

	public void setIncomeEnhancementDetailsId(Integer incomeEnhancementDetailsId) {
		this.incomeEnhancementDetailsId = incomeEnhancementDetailsId;
	}

	public IncomeEnhancementActivity getIncomeEnhancementActivity() {
		return incomeEnhancementActivity;
	}

	public void setIncomeEnhancementActivity(IncomeEnhancementActivity incomeEnhancementActivity) {
		this.incomeEnhancementActivity = incomeEnhancementActivity;
	}

	public String getActivtyName() {
		return activtyName;
	}

	public Boolean getIsApproved() {
		return isApproved;
	}

	public void setIsApproved(Boolean isApproved) {
		this.isApproved = isApproved;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public void setActivtyName(String activtyName) {
		this.activtyName = activtyName;
	}

	/*public Character getFundSourceType() {
		return fundSourceType;
	}

	public void setFundSourceType(Character fundSourceType) {
		this.fundSourceType = fundSourceType;
	}*/

	public Integer getFundSourceCode() {
		return fundSourceCode;
	}

	public void setFundSourceCode(Integer fundSourceCode) {
		this.fundSourceCode = fundSourceCode;
	}

	public Integer getDistrictCode() {
		return districtCode;
	}

	public void setDistrictCode(Integer districtCode) {
		this.districtCode = districtCode;
	}

	public Integer getBlockCode() {
		return blockCode;
	}

	public void setBlockCode(Integer blockCode) {
		this.blockCode = blockCode;
	}

	public Integer getTotalNoOfGpCovered() {
		return totalNoOfGpCovered;
	}

	public void setTotalNoOfGpCovered(Integer totalNoOfGpCovered) {
		this.totalNoOfGpCovered = totalNoOfGpCovered;
	}

	

	public Integer getNoOfAspirationalGp() {
		return noOfAspirationalGp;
	}

	public void setNoOfAspirationalGp(Integer noOfAspirationalGp) {
		this.noOfAspirationalGp = noOfAspirationalGp;
	}

	public Integer getYearFrom() {
		return yearFrom;
	}

	public void setYearFrom(Integer yearFrom) {
		this.yearFrom = yearFrom;
	}

	public Integer getYearTo() {
		return yearTo;
	}

	public void setYearTo(Integer yearTo) {
		this.yearTo = yearTo;
	}

	public Integer getTotalCostOfProject() {
		return totalCostOfProject;
	}

	public void setTotalCostOfProject(Integer totalCostOfProject) {
		this.totalCostOfProject = totalCostOfProject;
	}

	public Integer getFundsRequired() {
		return fundsRequired;
	}

	public void setFundsRequired(Integer fundsRequired) {
		this.fundsRequired = fundsRequired;
	}

	public String getBriefAboutActivity() {
		return briefAboutActivity;
	}

	public void setBriefAboutActivity(String briefAboutActivity) {
		this.briefAboutActivity = briefAboutActivity;
	}

	public Boolean getPlanApprovedByDpc() {
		return planApprovedByDpc;
	}

	public void setPlanApprovedByDpc(Boolean planApprovedByDpc) {
		this.planApprovedByDpc = planApprovedByDpc;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileContentType() {
		return fileContentType;
	}

	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
	}

	public String getFileLocation() {
		return fileLocation;
	}

	public void setFileLocation(String fileLocation) {
		this.fileLocation = fileLocation;
	}

	public Boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public String getBlockName() {
		return blockName;
	}

	public void setBlockName(String blockName) {
		this.blockName = blockName;
	}

	public List<Block> getBlockListFromDb() {
		return blockListFromDb;
	}

	public void setBlockListFromDb(List<Block> blockListFromDb) {
		this.blockListFromDb = blockListFromDb;
	}
	
}
