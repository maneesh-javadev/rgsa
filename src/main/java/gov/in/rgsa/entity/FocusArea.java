package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "focusarea", schema = "rgsa")
@NamedQuery(name="FATCH_FOCUS_AREAS",query="SELECT FA FROM FocusArea FA")
public class FocusArea implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 3511779411513471013L;

	@Id
	@Column(name = "s_no",nullable = false)
	private Integer serialNumber;
	
	@Column(name="focus_area_code")
	private String focusAreaCode;
	
	@Column(name="focus_area_name")
	private String focusAreaName;

	public Integer getSerialNumber() {
		return serialNumber;
	}

	public void setSerialNumber(Integer serialNumber) {
		this.serialNumber = serialNumber;
	}

	public String getFocusAreaCode() {
		return focusAreaCode;
	}

	public void setFocusAreaCode(String focusAreaCode) {
		this.focusAreaCode = focusAreaCode;
	}

	public String getFocusAreaName() {
		return focusAreaName;
	}

	public void setFocusAreaName(String focusAreaName) {
		this.focusAreaName = focusAreaName;
	}
	
	
}
