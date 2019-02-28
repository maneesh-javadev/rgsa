package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 *
 * @author ANJIT
 */
@Entity
@Table(name = "form_master", schema = "rgsa")
public class FormsMaster implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Basic(optional = false)
	@Column(name = "form_id", nullable = false)
	private Integer formId;
	@Column(name = "form_label", length = 99)
	private String formLabel;

	@Column(name = "user_type")
	private String userType;
	@Column(name = "type")
	private String type;

	/*
	 * @OneToMany(mappedBy = "formsMaster", fetch = FetchType.LAZY)
	 * 
	 * @LazyCollection(LazyCollectionOption.FALSE) private List<MenuProfile>
	 * menuProfile;
	 */

	@Column(name = "cat_id")
	private String catId;

	public Integer getFormId() {
		return formId;
	}

	public void setFormId(Integer formId) {
		this.formId = formId;
	}

	public String getFormLabel() {
		return formLabel;
	}

	public void setFormLabel(String formLabel) {
		this.formLabel = formLabel;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getCatId() {
		return catId;
	}

	public void setCatId(String catId) {
		this.catId = catId;
	}

}
