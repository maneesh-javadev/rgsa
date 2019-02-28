package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.NamedNativeQueries;
import org.hibernate.annotations.NamedNativeQuery;

@Entity
@Table(schema = "lgd")
@NamedNativeQueries({
		@NamedNativeQuery(query = "select designation_code,designation_name from lgd.get_designation_by_org_unit(:orgCode,null);", name = "getDesignationByOrgUnit", resultClass = DesignationPojo.class),
		@NamedNativeQuery(query = "select designation_code,designation_name from lgd.get_designation_details_by_located_at_level(:orgCode,:level);", name = "getDesignationByLocatedLevel", resultClass = DesignationPojo.class),
		@NamedNativeQuery(query = "select designation_code,designation_name from lgd.get_designation_details_by_located_at_level(:orgCode,:level) where designation_code=:designationCode ", name = "getDesignationByLocatedLevelbasedOnOrg", resultClass = DesignationPojo.class),
		@NamedNativeQuery(query = "select designation_code,designation_name from lgd.get_designation_details_by_located_at_level_code(:levelCode) order by designation_name ", name = "getDesignationByLocatedLevelByLevel", resultClass = DesignationPojo.class),
		@NamedNativeQuery(query = "select designation_code,designation_name from lgd.get_state_wise_designation_list(:stateCode,:levelCode) where officialtype = 'OFFICIAL' order by designation_name;", name = "getDesignationByPanchayatLevel", resultClass = DesignationPojo.class),
		@NamedNativeQuery(query = "select designation_id as designation_code,designation_name from audit.designation where level_code=:levelCode order by designation_name", name = "FIND_DESIGNATION_BY_LEVEL_CODE", resultClass = DesignationPojo.class),
		@NamedNativeQuery(query = "select designation_id as designation_code,designation_name from audit.designation order by designation_name", name = "FIND_ALL_DESIGNATION", resultClass = DesignationPojo.class),
		@NamedNativeQuery(query = "select distinct designation_id as designation_code , designation_name from  (select l.designation_id ,(select name from audit.get_designation_name((select distinct category from audit.user_active_location l where l.user_id=p.created_by),l.designation_id) where  name is not null) "
				+ "as designation_name  from audit.user_profile p JOIN audit.user_active_location l ON (l.user_id=p.user_id) where   l.entity_code in(select  auditee_code from audit.configuration config  "
				+ "INNER JOIN audit.assign_auditee auditee ON(config.configuration_id=auditee.configuration_id) "
				+ "where config.auditor_department in (:entityCode)) and l.designation_id is not null  order by designation_name) t where t.designation_name is not null", name = "FIND_DESIGNATION_IN_USER_PROFILE", resultClass = DesignationPojo.class)
		})
public class DesignationPojo implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "designation_code")
	private Integer designationCode;

	@Column(name = "designation_name")
	private String designationName;
	
	@Transient 
	public boolean isSearch;

	public boolean isSearch() {
		return isSearch;
	}

	public void setSearch(boolean isSearch) {
		this.isSearch = isSearch;
	}

	public Integer getDesignationCode() {
		return designationCode;
	}

	public void setDesignationCode(Integer designationCode) {
		this.designationCode = designationCode;
	}

	

	public String getDesignationName() {
		return designationName;
	}

	public void setDesignationName(String designationName) {
		this.designationName = designationName;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((designationCode == null) ? 0 : designationCode.hashCode());
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
		DesignationPojo other = (DesignationPojo) obj;
		if (designationCode == null) {
			if (other.designationCode != null)
				return false;
		} else if (!designationCode.equals(other.designationCode))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "DesignationPojo [designationCode=" + designationCode
				+ ", designationName=" + designationName + "]";
	}


}
