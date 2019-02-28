package gov.in.rgsa.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 * 
 * @author sourabh
 *
 */

@Entity
@Table(name="schemes_master", schema = "rgsa")

@NamedQueries({
	@NamedQuery(name="FETCH_SCHEME_MASTER",query="from SchemeMaster order by schemeId asc"),

	@NamedQuery(name = "FETCH_SCHEME_MASTER_BY_ID", 
	query = "from SchemeMaster where schemeId=:schemeId"),
})

public class SchemeMaster {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="scheme_id")
	private Integer schemeId;
	
	@Column(name="scheme_name")
	private String schemeName;
	
	@Column(name="pes_scheme_id")
	private Integer pesSchemeId;

	public Integer getSchemeId() {
		return schemeId;
	}

	public void setSchemeId(Integer schemeId) {
		this.schemeId = schemeId;
	}

	public String getSchemeName() {
		return schemeName;
	}

	public void setSchemeName(String schemeName) {
		this.schemeName = schemeName;
	}

	public Integer getPesSchemeId() {
		return pesSchemeId;
	}

	public void setPesSchemeId(Integer pesSchemeId) {
		this.pesSchemeId = pesSchemeId;
	}
	
}