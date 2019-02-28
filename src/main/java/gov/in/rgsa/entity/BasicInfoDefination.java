package gov.in.rgsa.entity;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "basic_info_defination", schema = "rgsa")
@NamedQueries({@NamedQuery(name = "FIND_BASIC_DEFINATION_BY_FIN_YEAR_ID", 
query = "SELECT B FROM BasicInfoDefination B LEFT OUTER JOIN FETCH B.basicInfoDefinationDetails BI WHERE B.finYearId=:yearId and B.formType=:formType ORDER BY BI.orderNo"),
@NamedQuery(name = "FIND_BASIC_DEFINATION_BY_FIN_YEAR_ID_AND_ID", 
query = "SELECT B FROM BasicInfoDefination B LEFT OUTER JOIN FETCH B.basicInfoDefinationDetails BI WHERE B.finYearId=:yearId and BI.basicInfoDefinationDetailsId=:basicInfoDefinationDetailsId ORDER BY BI.orderNo"),


}) 
public class BasicInfoDefination implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "basic_info_defination_id")
	private Integer basicInfoDefinationId;

	@Column(name = "year_id")
	private Integer finYearId;

	@Column(name = "is_active")
	private boolean isActive;
	
	@Column(name = "type_of_form")
	private String formType;

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "basicInfoDefination")
	private List<BasicInfoDefinationDetails> basicInfoDefinationDetails;

	public Integer getBasicInfoDefinationId() {
		return basicInfoDefinationId;
	}

	public void setBasicInfoDefinationId(Integer basicInfoDefinationId) {
		this.basicInfoDefinationId = basicInfoDefinationId;
	}

	public Integer getFinYearId() {
		return finYearId;
	}

	public void setFinYearId(Integer finYearId) {
		this.finYearId = finYearId;
	}

	public boolean isActive() {
		return isActive;
	}

	public void setActive(boolean isActive) {
		this.isActive = isActive;
	}

	public List<BasicInfoDefinationDetails> getBasicInfoDefinationDetails() {
		return basicInfoDefinationDetails;
	}

	public void setBasicInfoDefinationDetails(List<BasicInfoDefinationDetails> basicInfoDefinationDetails) {
		this.basicInfoDefinationDetails = basicInfoDefinationDetails;
	}

	
	
	
	public String getFormType() {
		return formType;
	}

	public void setFormType(String formType) {
		this.formType = formType;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((basicInfoDefinationId == null) ? 0 : basicInfoDefinationId.hashCode());
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
		BasicInfoDefination other = (BasicInfoDefination) obj;
		if (basicInfoDefinationId == null) {
			if (other.basicInfoDefinationId != null)
				return false;
		} else if (!basicInfoDefinationId.equals(other.basicInfoDefinationId))
			return false;
		return true;
	}

}
