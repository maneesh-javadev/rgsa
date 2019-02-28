package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="egov_post",schema="rgsa")
@NamedQuery(name="FIND_ALL_POST_LEVEL",query ="SELECT R FROM EGovPost R ORDER BY R.eGovPostId")
public class EGovPost {
	
	@Id
	@Column(name="egov_post_id")
	private Integer eGovPostId;
	
	@Column(name="egov_post_name")
	private String EGovPostName;
	
	@ManyToOne
	@JoinColumn(name="egov_post_level_id",referencedColumnName="egov_post_level_id")
	private EGovPostLevel EGovPostLevel;
	
	@Column(name="ceiling_value")
	private Integer ceilingValue;

	public Integer geteGovPostId() {
		return eGovPostId;
	}

	public void seteGovPostId(Integer eGovPostId) {
		this.eGovPostId = eGovPostId;
	}

	public String getEGovPostName() {
		return EGovPostName;
	}

	public void setEGovPostName(String eGovPostName) {
		EGovPostName = eGovPostName;
	}

	public Integer getCeilingValue() {
		return ceilingValue;
	}

	public void setCeilingValue(Integer ceilingValue) {
		this.ceilingValue = ceilingValue;
	}

	public EGovPostLevel getEGovPostLevel() {
		return EGovPostLevel;
	}

	public void setEGovPostLevel(EGovPostLevel eGovPostLevel) {
		EGovPostLevel = eGovPostLevel;
	}

}
