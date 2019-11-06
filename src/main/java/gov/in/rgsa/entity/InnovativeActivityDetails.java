package gov.in.rgsa.entity;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;

/**
 * @author Mohammad Ayaz
 */

@Entity
@NamedQueries({
	@NamedQuery(name="FETCH_INNOVATIVE_ACTIVITY_BY_ID",query="Delete FROM InnovativeActivityDetails where id=:id"),
	@NamedQuery(name="FETCH_ALL_INNOVATIVE_DETAILS_EXCEPT_CURRENT_VERSION",query="from InnovativeActivityDetails where innovativeActivity.stateCode=:stateCode and innovativeActivity.versionId !=:versionNo and innovativeActivity.userType in('S','M') order by id")
})

@Table(name="innovative_activity_details" , schema="rgsa")
public class InnovativeActivityDetails  implements Serializable{
	private static final long serialVersionUID =1L;
	
	@Id
	@Column(name="id",nullable=false , updatable =false)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@ManyToOne
	@JoinColumn(name="innovative_activity_id",referencedColumnName="innovative_activity_id")
	private InnovativeActivity innovativeActivity;
	
	@Column(name="activity_name")
	private String activityName;
	
	@Column(name="funds_name")
	private Integer fundsName;
	
	@Column(name="about_activity")
	private String aboutActivity;
	
	@Column(name="year_from")
	private Integer yearFrom;
	
	@Column(name="year_to")
	private Integer yearTo;
	
	@Column(name="is_active")
	private Boolean isActive;
	
	
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

	@Column(name="remarks")
	private String remarks;
	
	@Column(name="file_name")
	private String fileName;
	
	@Column(name="file_content_type")
	private String fileContentType;
	
	@Column(name="file_location")
	private String fileLocation;
	
	@Column(name="is_approved")
	private Boolean isApproved;

	@Transient
	private MultipartFile file; 
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public InnovativeActivity getInnovativeActivity() {
		return innovativeActivity;
	}

	public void setInnovativeActivity(InnovativeActivity innovativeActivity) {
		this.innovativeActivity = innovativeActivity;
	}

	public String getActivityName() {
		return activityName;
	}

	public void setActivityName(String activityName) {
		this.activityName = activityName;
	}

	public Integer getFundsName() {
		return fundsName;
	}

	public void setFundsName(Integer fundsName) {
		this.fundsName = fundsName;
	}

	public String getAboutActivity() {
		return aboutActivity;
	}

	public void setAboutActivity(String aboutActivity) {
		this.aboutActivity = aboutActivity;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
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

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public Boolean getIsApproved() {
		return isApproved;
	}

	public void setIsApproved(Boolean isApproved) {
		this.isApproved = isApproved;
	}

	public Boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
}