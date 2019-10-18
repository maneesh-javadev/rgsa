package gov.in.rgsa.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.Table;

@Entity
@Table(schema = "lgd")
@NamedNativeQueries({
	@NamedNativeQuery(query = "select state_code,state_version,state_name_english,state_name_local,state_or_ut from lgd.get_state_list_fn();", name = "GET_ALL_STATE_LIST", resultClass = State.class),
	@NamedNativeQuery(query = "select  state_code,state_version,state_name_english,state_name_local,state_or_ut from lgd.get_states_by_code_fn(:id);", name = "FETCH_STATE_BY_CODE", resultClass = State.class),
	@NamedNativeQuery(query = "select  state_code,state_version,state_name_english,state_name_local,state_or_ut from lgd.get_state_list_fn() order by state_name_english;", name = "stateListOrdered", resultClass = State.class),
	@NamedNativeQuery(query = "select distinct s.state_code,s.state_version,s.state_name_english,s.state_name_local,s.state_or_ut from lgd.get_state_list_fn() s INNER JOIN lgd.view_all_lb_details lb ON(s.state_code=lb.state_code)"+ 
"where lb.local_body_type_code=:lbCode order by state_name_english", name = "stateListbylbCode", resultClass = State.class),
	@NamedNativeQuery(query = "SELECT Distinct U.state_code,state_version,state_name_english,state_name_local,state_or_ut FROM lgd.get_state_list_fn() S INNER JOIN audit.universe_department U ON (S.state_code=U.state_code) ORDER BY state_name_english",
	name = "stateListInDeptUniverse", resultClass = State.class),
	@NamedNativeQuery(query = " select s.state_code,p.plan_code as state_version,s.state_name_english,s.state_name_local,state_or_ut from rgsa.plan p inner join lgd.state s on p.state_code=s.state_code" + 
			"  where  p.isactive and s.isactive and p.year_id=:yearId and  plan_status_id=5 order by s.state_name_english",	name = "CEC_APPROVED_STATE", resultClass = State.class),	
})

public class State implements Serializable {
	/**
		 * 
		 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "state_code")
	private int stateCode;

	@Column(name = "state_version")
	private int stateVersion;

	@Column(name = "state_name_english")
	private String stateNameEnglish;

	@Column(name = "state_name_local")
	private String stateNameLocal;

	@Column(name = "state_or_ut")
	private String stateOrUt;

	@Column(name = "isactive")
	private Boolean isactive;

	public int getStateCode() {
		return stateCode;
	}

	public void setStateCode(int stateCode) {
		this.stateCode = stateCode;
	}

	public int getStateVersion() {
		return stateVersion;
	}

	public void setStateVersion(int stateVersion) {
		this.stateVersion = stateVersion;
	}

	public String getStateNameEnglish() {
		return stateNameEnglish;
	}

	public void setStateNameEnglish(String stateNameEnglish) {
		this.stateNameEnglish = stateNameEnglish;
	}

	public String getStateNameLocal() {
		return stateNameLocal;
	}

	public void setStateNameLocal(String stateNameLocal) {
		this.stateNameLocal = stateNameLocal;
	}

	public String getStateOrUt() {
		return stateOrUt;
	}

	public void setStateOrUt(String stateOrUt) {
		this.stateOrUt = stateOrUt;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + stateCode;
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
		State other = (State) obj;
		if (stateCode != other.stateCode)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "State [stateCode=" + stateCode + ", stateNameEnglish="
				+ stateNameEnglish + "]";
	}

	public Boolean getIsactive() {
		return isactive;
	}

	public void setIsactive(Boolean isactive) {
		this.isactive = isactive;
	}
}
