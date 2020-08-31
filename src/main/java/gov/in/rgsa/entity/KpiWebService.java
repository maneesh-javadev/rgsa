package gov.in.rgsa.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.Transient;

import org.hibernate.annotations.CreationTimestamp;



@Entity
@NamedNativeQueries({ @NamedNativeQuery(name = "FETCH_KPI_DATA", query = "select row_number() OVER () as id, * from rgsa.darpantable where yr=:yr and mCode=:mCode and state_code=:stateCode and dept_code=:deptCode and project_code=:projectCode and sector_code=:secCode", resultClass = KpiWebService.class),
})

public class KpiWebService {
   @Id
   @Column(name="id")
   private Integer id;
	
	@Column(name="mcode")
	private Integer mCode;
	
	
	@Column(name="State_Code")
	private Integer stateCode;
	
	@Column(name="District_Code")
	private Integer districtCode;
	
	@Column(name="teh_code")
	private Integer tehCode;
	
	@Column(name="blk_code")
	private Integer blkCode;
	
	@Column(name="sector_code")
	private Integer sectorCode;
	
	@Column(name="gp_code")
	private Integer gpCode;
	
	@Column(name="vill_code")
	private Integer villCode;
	
	@Column(name="dept_code")
	private Integer deptCode;
	
	@Column(name="project_code")
	private Integer projectCode;
	
	@Column(name="cnt1")
	private Long cnt1;
	
	@Column(name="cnt2")
	private Long cnt2;
	
	@Column(name="cnt3")
	private Long cnt3;
	
	@Column(name="cnt4")
	private Long cnt4;
	
	@Column(name="cnt5")
	private Long cnt5;
	
	@Column(name="dataportmode")
	private Integer dataportMode;
	
	@Column(name="modedesc")
	private Integer modeDesc;
	
	@Column(name="data_lvl_code")
	private Integer dataLvlCode;
	
	@Column(name="yr")
	private Integer Yr;
	
	@Column(name="mnth")
	Integer Mnth;
	
	@CreationTimestamp
	@Column(name="datadt",updatable=false)
	private Timestamp dataDt;
	
	@Transient
	private Integer halfYear;

	public Integer getId() {
		return id;
	}


	public void setId(Integer id) {
		this.id = id;
	}


	public Integer getmCode() {
		return mCode;
	}


	public void setmCode(Integer mCode) {
		this.mCode = mCode;
	}


	public Integer getStateCode() {
		return stateCode;
	}


	public void setStateCode(Integer stateCode) {
		this.stateCode = stateCode;
	}


	


	public Integer getDistrictCode() {
		return districtCode;
	}


	public void setDistrictCode(Integer districtCode) {
		this.districtCode = districtCode;
	}


	public Integer getTehCode() {
		return tehCode;
	}


	public void setTehCode(Integer tehCode) {
		this.tehCode = tehCode;
	}


	public Integer getBlkCode() {
		return blkCode;
	}


	public void setBlkCode(Integer blkCode) {
		this.blkCode = blkCode;
	}


	public Integer getSectorCode() {
		return sectorCode;
	}


	public void setSectorCode(Integer sectorCode) {
		this.sectorCode = sectorCode;
	}


	public Integer getGpCode() {
		return gpCode;
	}


	public void setGpCode(Integer gpCode) {
		this.gpCode = gpCode;
	}


	public Integer getVillCode() {
		return villCode;
	}


	public void setVillCode(Integer villCode) {
		this.villCode = villCode;
	}


	public Integer getDeptCode() {
		return deptCode;
	}


	public void setDeptCode(Integer deptCode) {
		this.deptCode = deptCode;
	}


	public Integer getProjectCode() {
		return projectCode;
	}


	public void setProjectCode(Integer projectCode) {
		this.projectCode = projectCode;
	}


	public Long getCnt1() {
		return cnt1;
	}


	public void setCnt1(Long cnt1) {
		this.cnt1 = cnt1;
	}


	public Long getCnt2() {
		return cnt2;
	}


	public void setCnt2(Long cnt2) {
		this.cnt2 = cnt2;
	}


	public Long getCnt3() {
		return cnt3;
	}


	public void setCnt3(Long cnt3) {
		this.cnt3 = cnt3;
	}


	public Long getCnt4() {
		return cnt4;
	}


	public void setCnt4(Long cnt4) {
		this.cnt4 = cnt4;
	}


	public Long getCnt5() {
		return cnt5;
	}


	public void setCnt5(Long cnt5) {
		this.cnt5 = cnt5;
	}


	public Integer getDataportMode() {
		return dataportMode;
	}


	public void setDataportMode(Integer dataportMode) {
		this.dataportMode = dataportMode;
	}


	public Integer getDataLvlCode() {
		return dataLvlCode;
	}


	public void setDataLvlCode(Integer dataLvlCode) {
		this.dataLvlCode = dataLvlCode;
	}


	public Integer getYr() {
		return Yr;
	}


	public void setYr(Integer yr) {
		Yr = yr;
	}


	public Integer getMnth() {
		return Mnth;
	}


	public void setMnth(Integer mnth) {
		Mnth = mnth;
	}


	public Timestamp getDataDt() {
		return dataDt;
	}


	public void setDataDt(Timestamp dataDt) {
		this.dataDt = dataDt;
	}



	public Integer getModeDesc() {
		return modeDesc;
	}


	public void setModeDesc(Integer modeDesc) {
		this.modeDesc = modeDesc;
	}


	public Integer getHalfYear() {
		return halfYear;
	}


	public void setHalfYear(Integer halfYear) {
		this.halfYear = halfYear;
	}
	
	
 
}
