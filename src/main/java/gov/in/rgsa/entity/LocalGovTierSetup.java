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
@NamedNativeQueries(value = {
@NamedNativeQuery(query="select local_body_type_code,nomenclature_english,local_body_type_name,nomenclature_local,category,level  from lgd.get_local_gov_setup_fn(:stateId)",name="LOCAL_GOV_TIER_SETUP_BY_STATE",resultClass=LocalGovTierSetup.class),
@NamedNativeQuery(query="select local_body_type_code,nomenclature_english,local_body_type_name,nomenclature_local,category,level  from lgd.get_local_gov_setup_fn(:stateId,:category)",name="local_gov_tier_setup_by_category",resultClass=LocalGovTierSetup.class),
@NamedNativeQuery(query="select local_body_type_code,nomenclature_english,local_body_type_name,nomenclature_local,category,level  from lgd.get_local_gov_setup_fn(:stateId,:category) where local_body_type_code=:lbtc",name="local_gov_tier_setup_by_category_and_lbtc",resultClass=LocalGovTierSetup.class),
@NamedNativeQuery(query="select local_body_type_code,nomenclature_english,local_body_type_name,nomenclature_local,category,level  from lgd.get_local_gov_setup_fn(:stateId) where local_body_type_code=:lbtc ",name="local_gov_tier_setupwith_lbtc",resultClass=LocalGovTierSetup.class),
@NamedNativeQuery(query="select local_body_type_code,nomenclature_english,local_body_type_name,nomenclature_local,category,level  from lgd.get_local_gov_setup_fn(:stateId,:category) where local_body_type_code=:lbcode ",name="local_gov_tier_setup_by_category_and_lbcode",resultClass=LocalGovTierSetup.class),
@NamedNativeQuery(query="select distinct local_body_type_code,local_body_type_name, CAST(''  AS character varying)nomenclature_english, CAST(''  AS character varying)nomenclature_local, CAST(''  AS char)category, CAST(''  AS char)as level from lgd.view_all_lb_details where category IN('P','U') order by local_body_type_code",name="local_gov_tier_setup_centre",resultClass=LocalGovTierSetup.class)



})
public class LocalGovTierSetup implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue
	@Column(name = "local_body_type_code")
	private	Integer localBodyTypeCode;

	@Column(name = "nomenclature_english")
	private String nomenclatureEnglish;
	
	@Column(name = "local_body_type_name")
	private String localbodytypename;
	
	public String getLocalbodytypename() {
		return localbodytypename;
	}

	public void setLocalbodytypename(String localbodytypename) {
		this.localbodytypename = localbodytypename;
	}

	@Column(name = "nomenclature_local")
	private String	nomenclatureLocal;
	
	@Column(name = "category")
	private	char category;
	
	@Column(name = "level")
	private	char level;
	
	public Integer getLocalBodyTypeCode() {
		return localBodyTypeCode;
	}

	public void setLocalBodyTypeCode(Integer localBodyTypeCode) {
		this.localBodyTypeCode = localBodyTypeCode;
	}


	public String getNomenclatureEnglish() {
		return nomenclatureEnglish;
	}

	public void setNomenclatureEnglish(String nomenclatureEnglish) {
		this.nomenclatureEnglish = nomenclatureEnglish;
	}

	public String getNomenclatureLocal() {
		return nomenclatureLocal;
	}

	public void setNomenclatureLocal(String nomenclatureLocal) {
		this.nomenclatureLocal = nomenclatureLocal;
	}

	public char getCategory() {
		return category;
	}

	public void setCategory(char category) {
		this.category = category;
	}

	public char getLevel() {
		return level;
	}

	public void setLevel(char level) {
		this.level = level;
	}

}

