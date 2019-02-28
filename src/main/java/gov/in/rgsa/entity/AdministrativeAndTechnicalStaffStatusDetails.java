package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="administrative_technical_support_cs_details",schema="rgsa")
public class AdministrativeAndTechnicalStaffStatusDetails implements Serializable	{
	
	/**
	 * Sourabh rai
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "at_cs_details_id")
	private Integer administrativeAndTechnicalStaffStatusDetailsId;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="at_cs_id")
	private AdministrativeAndTechnicalStaffStatus administrativeAndTechnicalStaffStatus;
	
	@ManyToOne
	@JoinColumn(name="post_id",referencedColumnName="post_id")
	private PostType postType;
	
	@ManyToOne
	@JoinColumn(name="post_level_id",referencedColumnName="post_level_id")
	private PostLevel postLevel;
	
	@Column(name="reg_no_of_sanctioned")
	private Integer regNoOfSanctioned;
	
	@Column(name="reg_no_of_positioned")
	private Integer regNoOfPositioned;
	
	@Column(name="contr_no_of_positioned")
	private Integer contrNoOfPositioned;

	public Integer getAdministrativeAndTechnicalStaffStatusDetailsId() {
		return administrativeAndTechnicalStaffStatusDetailsId;
	}

	public void setAdministrativeAndTechnicalStaffStatusDetailsId(Integer administrativeAndTechnicalStaffStatusDetailsId) {
		this.administrativeAndTechnicalStaffStatusDetailsId = administrativeAndTechnicalStaffStatusDetailsId;
	}

	public AdministrativeAndTechnicalStaffStatus getAdministrativeAndTechnicalStaffStatus() {
		return administrativeAndTechnicalStaffStatus;
	}

	public void setAdministrativeAndTechnicalStaffStatus(
			AdministrativeAndTechnicalStaffStatus administrativeAndTechnicalStaffStatus) {
		this.administrativeAndTechnicalStaffStatus = administrativeAndTechnicalStaffStatus;
	}

	public PostType getPostType() {
		return postType;
	}

	public void setPostType(PostType postType) {
		this.postType = postType;
	}

	public PostLevel getPostLevel() {
		return postLevel;
	}

	public void setPostLevel(PostLevel postLevel) {
		this.postLevel = postLevel;
	}

	public Integer getRegNoOfSanctioned() {
		return regNoOfSanctioned;
	}

	public void setRegNoOfSanctioned(Integer regNoOfSanctioned) {
		this.regNoOfSanctioned = regNoOfSanctioned;
	}

	public Integer getRegNoOfPositioned() {
		return regNoOfPositioned;
	}

	public void setRegNoOfPositioned(Integer regNoOfPositioned) {
		this.regNoOfPositioned = regNoOfPositioned;
	}

	public Integer getContrNoOfPositioned() {
		return contrNoOfPositioned;
	}

	public void setContrNoOfPositioned(Integer contrNoOfPositioned) {
		this.contrNoOfPositioned = contrNoOfPositioned;
	}
}
