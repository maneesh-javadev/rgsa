package gov.in.rgsa.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.NamedNativeQuery;
import javax.persistence.NamedNativeQueries;
import javax.persistence.Entity;

@Entity
@NamedNativeQueries(
{ @NamedNativeQuery(name = "FETCH_ANUAL_ACTION_PLAN_DETAILS_TD", query = "select tad.training_id as id,(select cast(array_to_string(array(select tc.training_category_name from rgsa.training_wise_category twc inner join rgsa.training_categories tc on twc.training_category_id=tc.training_category_id where twc.training_id =tad.training_id), ',') as char varying)) as column1,\r\n\t \t  (select cast(array_to_string(array(select subject_name from rgsa.training_subjects ts inner join rgsa.subjects s on ts.subject_id=s.subject_id \r\n\t \t\twhere ts.training_id =tad.training_id),',') as char varying)) as column2, (select cast(array_to_string(array(select target_group_master_name from rgsa.training_target_groups ttg inner \r\n\t \t\tjoin rgsa.target_group_master tgm on ttg.target_group_master_id= tgm.target_group_master_id where ttg.training_id =tad.training_id),',') as char varying) \r\n\t \t\ttarget_group_master_name ) as column3,tvl.training_venue_level_name as column4, tm.training_mode_name as column5,    CAST(tad.no_of_participants as varchar) as column6,CAST(tad.no_of_days as varchar) as column7,CAST(tad.unit_cost as varchar) as column8,CAST(tad.funds as varchar) as column9,\r\n\t \t\tCOALESCE( tad.remarks ,'N/A') as column10 , CAST(1 as varchar) as column11 ,CAST(null as varchar)  as column12 ,CAST(ta.additional_requirement as varchar) as column13 ,CAST(null as varchar)  as column14 from rgsa.training_activity ta inner join rgsa.training_activity_details tad on ta.training_activity_id =tad.training_activity_id  inner join rgsa.training_venue_level tvl on tad.training_venue_level_id=\r\n\t \t\ttvl.training_venue_level_id inner join rgsa.training_mode tm on tad.training_mode_id=tm.training_mode_id where ta.state_code =:stateCode and ta.year_id=:yearId and version_no=:version and user_type='S'\tand tad.is_active=true order by tad.training_id", resultClass = AnualActionPlanPhysically.class),
		@NamedNativeQuery(name = "FETCH_ANUAL_ACTION_PLAN_DETAILS_PP", query = "select ppd.id as id, ppo.pesa_post_name as column1 , CAST(ppd.no_of_units as varchar) as column2, CAST(ppd.unit_cost_per_month as varchar) as column3, CAST(COALESCE(ppd.no_of_months,'0') as varchar) as column4, CAST(COALESCE(ppd.funds,'0') as varchar) as column5, CAST(pp.additional_requirement as varchar) as column6 , CAST(pp.user_type  as varchar) as column7, COALESCE(ppd.remarks,'N/A') as column8 , CAST(null as varchar) as column9  ,CAST(null as varchar) as column10 ,  CAST(6 as varchar)  as column11 ,CAST(null as varchar)  as column12 ,CAST(null as varchar) as column13 ,CAST(null as varchar)  as column14 from rgsa.pesa_plan pp ,  rgsa.pesa_plan_details ppd ,rgsa.pesa_post ppo where pp.pesa_plan_id =ppd.pesa_plan_id and  pp.state_code =:stateCode and pp.year_id=:yearId and ppd.designation_id =ppo.pesa_post_id and pp.user_type= 'S' and  pp.version_no=:version order by ppd.id", resultClass = AnualActionPlanPhysically.class),
		@NamedNativeQuery(name = "FETCH_ANUAL_ACTION_PLAN_DETAILS_EE", query = "select eed.e_enablement_details_id as id , eem.ee_name as column1 , cast(eed.no_of_units as varchar) as column2 ,cast(eed.aspirational_gps as varchar)as column3, cast(eed.unit_cost as varchar) as column4,COALESCE(eed.remarks,'N/A') as column5 ,cast(eed.funds as varchar) as column6, cast(ee.additional_requirement as varchar) as  column7 ,CAST(null as varchar) as column8 ,  CAST(null as varchar)  as column9 ,CAST(null as varchar) as column10 ,  CAST(5 as varchar)  as column11 ,CAST(null as varchar)  as column12 ,CAST(null as varchar) as column13 ,CAST(null as varchar)  as column14 from rgsa.e_enablement ee ,rgsa.e_enablement_details eed ,rgsa.e_enablement_master eem where ee.e_enablement_id =eed.e_enablement_id and eem.ee__master_id =eed.ee_master_id and state_code =:stateCode and year_id =:yearId  and ee.user_type='S'\r\nand ee.version_no=:version", resultClass = AnualActionPlanPhysically.class),
		@NamedNativeQuery(name = "FETCH_ANUAL_ACTION_PLAN_DETAILS_PB", query = "select pbad.id as id ,   cast(case when ga.activity_id < 4 then   CONCAT(ga.activity_name, ' ', '(New Building)')  else  CONCAT(ga.activity_name, ' ', '(Carry Forward)')  END as varchar) column1 , cast(pba.additional_requirement as varchar) as  column2, cast(COALESCE(pbad.unit_cost,'0') as varchar) as column3, cast(COALESCE(pbad.funds,'0') as varchar ) as column4,cast(COALESCE(pbad.aspirational_gps  ,'0') as varchar) as column5,cast(mission_antyodaya_gps as varchar) as  column6, cast(COALESCE(pbad.no_of_gps,'0') as varchar) as  column7, cast(pbad.work_type as varchar )as column8,COALESCE(pbad.remarks ,'N/A') as column9 ,CAST(ga.activity_id as varchar) as column10 ,  CAST(3 as varchar)  as column11 ,CAST(null as varchar)  as column12 ,CAST(null as varchar) as column13 ,CAST(null as varchar)  as column14 from rgsa.panhcayat_bhawan_activity pba ,rgsa.panhcayat_bhawan_activity_details  pbad ,rgsa.gps_activity ga where pba.panhcayat_bhawan_activity_id =pbad.panhcayat_bhawan_activity_id and ga.activity_id =pbad.activity_id and  pba.state_code =:stateCode and pba.year_id=:yearId and pba.version_no =:version and user_type='S' order by id", resultClass = AnualActionPlanPhysically.class),
		@NamedNativeQuery(name = "FETCH_ANUAL_ACTION_PLAN_DETAILS_DLS", query = "  select sad.satcom_activity_details_id as id ,sm.satcom_master_name as column1 ,sl.satcom_level_name as column2, cast(COALESCE(sad.no_of_units,'0') as varchar) as column3, cast(COALESCE(sad.unit_cost,'0') as varchar) as column4,cast(COALESCE(sad.unit_cost,'0') as varchar) as column5 ,CAST(COALESCE(sad.remarks,'N/A') as varchar) as column6 ,  CAST(null as varchar)  as column7 ,CAST(null as varchar) as column8 ,  CAST(null as varchar)  as column9 ,CAST(null as varchar) as column10 ,  CAST(7 as varchar)  as column11 ,CAST(null as varchar)  as column12 ,CAST(null as varchar) as column13 ,CAST(null as varchar)  as column14 from rgsa.satcom_activity sa ,rgsa.satcom_master sm,rgsa.satcom_activity_details sad left join   rgsa.satcom_level sl on sl.satcom_level_id =sad.satcom_level_id   where sa.satcom_activity_id =sad.satcom_activity_id and sm.satcom_master_id =sad.satcom_master_id and sa.state_code=:stateCode and sa.year_id =:yearId and sa.user_type='S' and sa.version_no=:version order by sad.satcom_activity_details_id", resultClass = AnualActionPlanPhysically.class),
		@NamedNativeQuery(name = "FETCH_ANUAL_ACTION_PLAN_DETAILS_IEC", query = "select  distinct iadd.iec_activity_details_id id ,\r\n(select cast(array_to_string(array(select iad.nature_iec_activity from rgsa.iec_activity ia ,  rgsa.iec_activity_details iadd ,rgsa.iec_details_dropdown idd ,rgsa.iec_activity_dropdown iad\r\nwhere ia.id =iadd.iec_activity_id and  ia.state_code =:stateCode and ia.year_id=:yearId and ia.version_no =:version and\r\n iadd.iec_activity_details_id =idd.iec_activity_details_id and iad.iec_id =idd.iec_activity_dropdown_id and ia.user_type='S'), ',') as char varying)) as column1,\r\ncast(iadd.total_amount_proposed as varchar) as column2, iadd.remarks column3 ,CAST(null as varchar) as column4, CAST(null as varchar) as column5, CAST(null as varchar) as column6,  CAST(null as varchar)  as column7 ,CAST(null as varchar) as column8 ,  CAST(null as varchar)  as column9 ,CAST(null as varchar) as column10 ,  CAST(11 as varchar)  as column11 ,CAST(null as varchar)  as column12 ,CAST(null as varchar) as column13 ,CAST(null as varchar)  as column14 from rgsa.iec_activity ia ,  rgsa.iec_activity_details iadd ,rgsa.iec_details_dropdown idd ,rgsa.iec_activity_dropdown iad\r\nwhere ia.id =iadd.iec_activity_id and  ia.state_code =:stateCode and ia.year_id=:yearId and ia.version_no =:version and iadd.iec_activity_details_id =idd.iec_activity_details_id and iad.iec_id =idd.iec_activity_dropdown_id and ia.user_type='S' order by iadd.iec_activity_details_id ", resultClass = AnualActionPlanPhysically.class),
		@NamedNativeQuery(name = "FETCH_ANUAL_ACTION_PLAN_DETAILS_ATS", query = "  select distinct atsd.id id,ptm.post_type_name column1,pt.post_name column2,COALESCE(apl.post_level_name ,'N/A') column3, cast(COALESCE(atsd.no_of_units ,'0') as varchar )  column4,cast(COALESCE(atsd.unit_cost,'0') as varchar) column5,cast(COALESCE(atsd.no_of_months,'0') as varchar) column6,cast(COALESCE(atsd.funds,'0') as varchar) column7 ,CAST(ats.additional_requirement as varchar) as column8 ,  CAST(null as varchar)  as column9 ,CAST(null as varchar) as column10 ,  CAST(4 as varchar)  as column11 ,CAST(null as varchar)  as column12 ,CAST(null as varchar) as column13 ,CAST(null as varchar)  as column14  from rgsa.administrative_technical_support ats ,rgsa.post_type pt,rgsa.post_type_master ptm , rgsa.administrative_technical_support_details atsd left join rgsa.at_post_levels apl on atsd.level_id =apl.post_level_id\r\nwhere ats.administrative_technical_support_id =atsd.administrative_technical_support_id and atsd.post_id =pt.post_id  and ptm.post_type_id =pt.post_type_id and  ats.state_code =:stateCode and ats.year_id=:yearId and ats.version_no=:version and user_type='S' order by atsd.id", resultClass = AnualActionPlanPhysically.class),
		@NamedNativeQuery(name = "FETCH_ANUAL_ACTION_PLAN_DETAILS_TRA", query = "select cad.cb_activity_detail_id id, \r\n\t\t   cm.cb_name column1, \r\n\t\t  cast(COALESCE(cad.no_of_units ,'0') as varchar) column2 , \r\n\t\t  cast(COALESCE(cad.unit_cost,'0') as varchar) column3 , \r\n\t\t  cast(COALESCE(cad.no_of_days ,'0') as varchar) column4 , \r\n\t\t  cast(COALESCE(cad.funds ,'0') as varchar) column5 , \r\n\t\t   cast(ca.additional_requirement as varchar) column6, \r\n\t\t  COALESCE(cad.remarks ,'N/A') column7, \r\n\t\t  COALESCE(cad.collab_institute ,'N/A') column8,CAST(null as varchar)  as column9 ,CAST(null as varchar) as column10 ,  CAST(13 as varchar)  as column11 ,CAST(null as varchar)  as column12 ,CAST(null as varchar) as column13 ,CAST(null as varchar)  as column14 \r\n  from rgsa.cb_activity ca ,  rgsa.cb_activity_details cad , rgsa.cb_master cm  where ca.cb_activity_id =cad.cb_activity_id and  cm.cb_master_id =cad.cb_master_id and  ca.state_code =:stateCode and ca.year_id=:yearId and ca.version_no =:version and  ca.user_type='S' order by ca.cb_activity_id ", resultClass = AnualActionPlanPhysically.class),
		@NamedNativeQuery(name = "FETCH_ANUAL_ACTION_PLAN_DETAILS_PMU", query = "\r\nselect pad.pmu_activity_details_id id , pt.pmu_type_name column1, pat.pmu_activity_type_name column2 ,cast(pad.no_of_units as varchar )  column3,cast(pad.unit_cost as varchar) column4,cast(pad.no_of_months as varchar) column5,cast(pad.other_expenses as varchar) column6, pad.remarks column7,cast(pa.additional_requirement as varchar) column8,CAST(null as varchar)  as column9 ,CAST(null as varchar) as column10 ,  CAST(12 as varchar)  as column11 ,CAST(null as varchar)  as column12 ,CAST(null as varchar) as column13, CAST(null as varchar)  as column14 from rgsa.pmu_activity pa , rgsa.pmu_activity_details pad , rgsa.pmu_activity_type pat,rgsa.pmu_type pt where state_code=:stateCode and year_id=:yearId and pa.pmu_activity_id =pad.pmu_activity_id and pad.pmu_activity_type_id =pat.pmu_activity_type_id and pat.pmu_type_id =pt.pmu_type_id and pa.version_no=:version and user_type='S'", resultClass = AnualActionPlanPhysically.class),
		@NamedNativeQuery(name = "FETCH_ANUAL_ACTION_PLAN_DETAILS_AFD", query = "\r\nselect ad.admin_financial_data_cell_activity_detail_id id , pt.pmu_type_name column1, pat.pmu_activity_type_name column2 ,cast(ad.no_of_staffs_proposed as varchar )  column3,cast(ad.unit_cost as varchar) column4,cast(ad.no_of_months as varchar) column5,cast(ad.other_expenses as varchar) column6, ad.remarks column7,cast(a.additional_requirement as varchar) column8,CAST(ad.funds as varchar)  as column9 ,CAST(null as varchar) as column10 ,  CAST(8 as varchar)  as column11 ,CAST(null as varchar)  as column12 ,CAST(null as varchar) as column13 ,CAST(null as varchar)  as column14  from rgsa.admin_financial_data_cell_activity a , rgsa.admin_financial_data_cell_activity_details ad , rgsa.pmu_activity_type pat,rgsa.pmu_type pt where a.state_code=:stateCode and a.year_id=:yearId and a.admin_financial_data_cell_activity_id =ad.admin_financial_data_cell_activity_id and ad.pmu_activity_type_id =pat.pmu_activity_type_id and pat.pmu_type_id =pt.pmu_type_id and a.version_no=:version and a.user_type='S' order by id", resultClass = AnualActionPlanPhysically.class),
		@NamedNativeQuery(name = "FETCH_ANUAL_ACTION_PLAN_DETAILS_IE", query = "\r\nselect distinct ied.income_enhancement_details_id id , ied.activty_name column1, sm.scheme_name column2 ,cast(d.district_name_english as varchar )  column3,cast(b.block_name_english as varchar) column4,cast(ied.total_no_of_gp_covered as varchar) column5,cast(ied.no_of_aspirational_gp as varchar) column6, ied.year_from column7,cast(ied.year_to as varchar) column8,CAST(ied.total_cost_of_project as varchar)  as column9 ,CAST(ied.funds_required as varchar) as column10 ,  CAST(10 as varchar)  as column11 ,cast(ied.brief_about_activity as varchar ) column12 ,cast(iea.additional_requirement as varchar) column13, ied.remarks as column14 from rgsa.income_enhancement_activity iea , rgsa.income_enhancement_details ied , rgsa.schemes_master sm,lgd.district  d ,lgd.block b where iea.state_code=:stateCode and iea.year_id=:yearId and iea.income_enhancement_id =ied.income_enhancement_id and ied.fund_source_code=sm.scheme_id and ied.district_code =d.district_code and ied.block_code =b.block_code and iea.version_no=:version and iea.user_type='S' order by id\r\n ", resultClass = AnualActionPlanPhysically.class),
		@NamedNativeQuery(name = "FETCH_ANUAL_ACTION_PLAN_DETAILS_IA", query = "select iad.id ,iad.about_activity column1,cast(iad.funds_name as varchar) column2,iad.about_activity as  column3,cast(iad.year_from as varchar) as column4 ,cast(iad.year_to as varchar) column5 ,cast(ia.additional_requirement as varchar) column6 ,iad.remarks as column7 ,CAST(null as varchar)  as column8,CAST(null as varchar)  as column9 ,CAST(null as varchar) as column10 ,  CAST(9 as varchar)  as column11 ,CAST(null as varchar)  as column12 ,CAST(null as varchar) as column13 ,CAST(null as varchar)  as column14 from rgsa.innovative_activity  ia ,rgsa.innovative_activity_details iad where ia.innovative_activity_id=iad.innovative_activity_id and ia.state_code =:stateCode and ia.year_id =:yearId and ia.version_no =:version order by iad.id\r\n", resultClass = AnualActionPlanPhysically.class),
		@NamedNativeQuery(name = "FETCH_ANUAL_ACTION_PLAN_DETAILS_HR", query = "\r\nselect iad.institue_infra_hr_activity_details_id id ,tit.training_institue_type_name column1, iha.institue_infra_hr_activity_type_name column2, cast(COALESCE(iad.no_of_units ,'0') as varchar) column3, cast(iad.unit_cost as varchar) column4, cast(COALESCE(iad.no_of_months,'0') as varchar) column5 ,cast(iad.other_expenses as varchar) column6,cast(iad.funds as varchar) column7, COALESCE(iad.remarks ,'sa') as column8, CAST(tit.training_institue_type_id as varchar)  as column9 ,CAST(null as varchar) as column10 ,  CAST(14 as varchar)  as column11 ,CAST(null as varchar)  as column12 ,CAST(null as varchar) as column13 ,CAST(null as varchar)  as column14 from rgsa.institue_infra_hr_activity  ia ,rgsa.institue_infra_hr_activity_details  iad,rgsa.institue_infra_hr_activity_type  iha,rgsa.training_institue_type tit\r\nwhere ia.institue_infra_hr_activity_id  =iad.institue_infra_hr_activity_id and iad.institue_infra_hr_activity_type_id =iha.institue_infra_hr_activity_type_id and iha.training_institue_type_id =tit.training_institue_type_id and ia.state_code=:stateCode and ia.year_id=:yearId and user_type='S' and ia.version_no=:version order by id", resultClass = AnualActionPlanPhysically.class),
		@NamedNativeQuery(name = "FETCH_ANUAL_ACTION_PLAN_DETAILS_EGOV", query = "select ead.egov_support_activity_details_id id ,epl.egov_post_level_name column1, ep.egov_post_name column2, cast(COALESCE(ead.no_of_units ,'0') as varchar) column3, cast(COALESCE(ead.unit_cost, '0') as varchar) column4, cast(COALESCE(ead.no_of_months,'0') as varchar) column5 ,cast(epl.egov_post_level_id as varchar) column6,cast(COALESCE(ead.funds,'0') as varchar) column7, COALESCE(ead.remarks ,'N/A') column8, CAST(additional_req_spmu as varchar)  as column9 ,CAST(additional_req_dpmu as varchar) as column10 ,  CAST(15 as varchar)  as column11 ,CAST(null as varchar)  as column12 ,CAST(null as varchar) as column13 ,CAST(null as varchar)  as column14 from rgsa.egov_support_activity  ea ,rgsa.egov_support_activity_details  ead,rgsa.egov_post  ep,rgsa.egov_post_level epl\r\nwhere ea.egov_support_activity_id  =ead.egov_support_activity_id and ead.egov_post_id =ep.egov_post_id and ep.egov_post_level_id =epl.egov_post_level_id and ea.state_code=:stateCode and ea.year_id=:yearId and ea.version_no=:version and user_type='S' order by id", resultClass = AnualActionPlanPhysically.class),
		@NamedNativeQuery(name = "FETCH_ANUAL_ACTION_PLAN_DETAILS_IIF", query = "select id.institutional_infra_activity_details_id id ,cast(case when id.work_type = 'N' then   CONCAT( ty.training_institue_type_name, ' ', '(New Building)')  else  CONCAT( ty.training_institue_type_name, ' ', '(Carry Forward)')  END as varchar) column1 ,cast(id.fund_proposed as varchar) column2,cast(id.total_fund as varchar) column3,cast(id.remarks as varchar)column4,(select district_name_english from lgd.district where dlc =  id.institutional_infra_location )  column5,cast(id.work_type as varchar) column6 ,cast(coalesce(id.fund_released ,'0') as varchar) column7 ,cast(coalesce(id.fund_required ,'0') as varchar)column8,cast(coalesce(id.fund_required,'0') as varchar) column9, cast(coalesce(id.fund_sanctioned ,'0') as varchar) column10,cast(2 as varchar) column11,cast(coalesce(id.fund_utilized ,'0') as varchar)column12 ,cast(ia.additional_requirement  as varchar)column13 ,cast(ia.additional_requirement_dprc  as varchar)column14  from rgsa.institutional_infra_activity ia ,rgsa.institutional_infra_activity_details id,rgsa.training_institue_type ty where ia.institutional_infra_activity_id =id.institutional_infra_activity_id    and ia.state_code =:stateCode and ia.year_id =:yearId and ia.version_no =:version and id.institutional_activity_type_id =ty.training_institue_type_id and user_type='S'", resultClass = AnualActionPlanPhysically.class) })
public class AnualActionPlanPhysically
{
	@Id
	@Column(name = "id")
	private Integer id;
	@JsonIgnoreProperties
	@Column(name = "column1")
	private String column1;
	@JsonIgnoreProperties
	@Column(name = "column2")
	private String column2;
	@JsonIgnoreProperties
	@Column(name = "column3")
	private String column3;
	@JsonIgnoreProperties
	@Column(name = "column4")
	private String column4;
	@JsonIgnoreProperties
	@Column(name = "column5")
	private String column5;
	@JsonIgnoreProperties
	@Column(name = "column6")
	private String column6;
	@JsonIgnoreProperties
	@Column(name = "column7")
	private String column7;
	@JsonIgnoreProperties
	@Column(name = "column8")
	private String column8;
	@JsonIgnoreProperties
	@Column(name = "column9")
	private String column9;
	@JsonIgnoreProperties
	@Column(name = "column10")
	private String column10;
	@JsonIgnoreProperties
	@Column(name = "column11")
	private String column11;
	@JsonIgnoreProperties
	@Column(name = "column12")
	private String column12;
	@JsonIgnoreProperties
	@Column(name = "column13")
	private String column13;
	@JsonIgnoreProperties
	@Column(name = "column14")
	private String column14;

	public Integer getId()
	{
		return this.id;
	}

	public void setId(final Integer id)
	{
		this.id = id;
	}

	public String getColumn1()
	{
		return this.column1;
	}

	public void setColumn1(final String column1)
	{
		this.column1 = column1;
	}

	public String getColumn2()
	{
		return this.column2;
	}

	public void setColumn2(final String column2)
	{
		this.column2 = column2;
	}

	public String getColumn3()
	{
		return this.column3;
	}

	public void setColumn3(final String column3)
	{
		this.column3 = column3;
	}

	public String getColumn4()
	{
		return this.column4;
	}

	public void setColumn4(final String column4)
	{
		this.column4 = column4;
	}

	public String getColumn5()
	{
		return this.column5;
	}

	public void setColumn5(final String column5)
	{
		this.column5 = column5;
	}

	public String getColumn6()
	{
		return this.column6;
	}

	public void setColumn6(final String column6)
	{
		this.column6 = column6;
	}

	public String getColumn7()
	{
		return this.column7;
	}

	public void setColumn7(final String column7)
	{
		this.column7 = column7;
	}

	public String getColumn8()
	{
		return this.column8;
	}

	public void setColumn8(final String column8)
	{
		this.column8 = column8;
	}

	public String getColumn9()
	{
		return this.column9;
	}

	public void setColumn9(final String column9)
	{
		this.column9 = column9;
	}

	public String getColumn10()
	{
		return this.column10;
	}

	public void setColumn10(final String column10)
	{
		this.column10 = column10;
	}

	public String getColumn11()
	{
		return this.column11;
	}

	public void setColumn11(final String column11)
	{
		this.column11 = column11;
	}

	public String getColumn12()
	{
		return this.column12;
	}

	public void setColumn12(final String column12)
	{
		this.column12 = column12;
	}

	public String getColumn13()
	{
		return this.column13;
	}

	public void setColumn13(final String column13)
	{
		this.column13 = column13;
	}

	public String getColumn14()
	{
		return this.column14;
	}

	public void setColumn14(final String column14)
	{
		this.column14 = column14;
	}
}