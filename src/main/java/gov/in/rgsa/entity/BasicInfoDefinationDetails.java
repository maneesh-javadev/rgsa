package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "basic_info_defination_details", schema = "rgsa")
public class BasicInfoDefinationDetails implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "basic_info_defination_details_id")
	private Integer basicInfoDefinationDetailsId;

	@ManyToOne()
	@JoinColumn(name = "basic_info_defination_id", referencedColumnName = "basic_info_defination_id")
	private BasicInfoDefination basicInfoDefination;

	@Column(name = "label_name")
	private String labelName;

	@Column(name = "is_dp")
	private boolean isDP;

	@Column(name = "is_bp")
	private boolean isBP;

	@Column(name = "is_gp")
	private boolean isGP;

	@Column(name = "field_type")
	private String fieldType;

	@Column(name = "is_mandatory")
	private boolean isMandatory;

	

	@Column(name = "is_sub_info")
	private boolean isSubInfo;

	@Column(name = "order_no")
	private Integer orderNo;

	@Column(name = "parent_id")
	private Integer parentId;
	
	@Column(name = "is_state")
	private boolean state;

	public Integer getBasicInfoDefinationDetailsId() {
		return basicInfoDefinationDetailsId;
	}

	public void setBasicInfoDefinationDetailsId(Integer basicInfoDefinationDetailsId) {
		this.basicInfoDefinationDetailsId = basicInfoDefinationDetailsId;
	}

	public BasicInfoDefination getBasicInfoDefination() {
		return basicInfoDefination;
	}

	public void setBasicInfoDefination(BasicInfoDefination basicInfoDefination) {
		this.basicInfoDefination = basicInfoDefination;
	}

	public String getLabelName() {
		return labelName;
	}

	public void setLabelName(String labelName) {
		this.labelName = labelName;
	}

	public boolean isDP() {
		return isDP;
	}

	public void setDP(boolean isDP) {
		this.isDP = isDP;
	}

	public boolean isBP() {
		return isBP;
	}

	public void setBP(boolean isBP) {
		this.isBP = isBP;
	}

	public boolean isGP() {
		return isGP;
	}

	public void setGP(boolean isGP) {
		this.isGP = isGP;
	}

	public String getFieldType() {
		return fieldType;
	}

	public void setFieldType(String fieldType) {
		this.fieldType = fieldType;
	}

	public boolean isMandatory() {
		return isMandatory;
	}

	public void setMandatory(boolean isMandatory) {
		this.isMandatory = isMandatory;
	}

	

	public boolean isSubInfo() {
		return isSubInfo;
	}

	public void setSubInfo(boolean isSubInfo) {
		this.isSubInfo = isSubInfo;
	}

	public Integer getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(Integer orderNo) {
		this.orderNo = orderNo;
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	
	
	
	

	public boolean isState() {
		return state;
	}

	public void setState(boolean state) {
		this.state = state;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((basicInfoDefinationDetailsId == null) ? 0 : basicInfoDefinationDetailsId.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		BasicInfoDefinationDetails other = (BasicInfoDefinationDetails) obj;
		if (basicInfoDefinationDetailsId == null) {
			if (other.basicInfoDefinationDetailsId != null)
				return false;
		} else if (!basicInfoDefinationDetailsId.equals(other.basicInfoDefinationDetailsId))
			return false;
		return true;
	}

}
