package gov.in.rgsa.dto;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;

@Entity
@NamedNativeQueries({
	@NamedNativeQuery(name="_FECH_PLAN_CODE_SEQUENCE",query="select nextval('rgsa.plan_plan_code_seq')"),
})
public class Sequence {
	
	@Id
	public Integer id;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	

}
