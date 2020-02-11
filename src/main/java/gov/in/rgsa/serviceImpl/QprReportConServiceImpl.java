package gov.in.rgsa.serviceImpl;

import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.FinYear;
import gov.in.rgsa.entity.QuarterDuration;
import gov.in.rgsa.entity.State;
import gov.in.rgsa.outbound.QprEGovResponse;
import gov.in.rgsa.outbound.QprQuartProgress;
import gov.in.rgsa.service.QprReportConService;
 

@Service
public class QprReportConServiceImpl implements QprReportConService
{

	@Autowired
	private CommonRepository dao;

	public List<FinYear> fetchFinYearList()
	{
		return dao.findAll("FETCH_ALL_FIN_YEAR", null);
	}

	public List<State> fetchStateList()
	{
		return dao.findAll("GET_ALL_STATE_LIST", null);
	}

	public Object fetchfindQuaterList()
	{
		return dao.findAll("GET_ALL_STATE_LIST", null);
	}

	public List<QuarterDuration> fetchQuarterList()
	{

		return dao.findAll("FETCH_QUARTER_DURATION", null);
	}

	@Override
	public List fetchTrainingActivityList(String statecode,String yearId,String UserType,String quarterId)
	{
		List  datalist=new LinkedList();
		try {
			StringBuilder query=new StringBuilder();
			query.append(" Select cm.cb_name,cad.no_of_units,cad.funds, qcad.no_of_days_completed,qcad.no_of_units_completed,COALESCE(qcad.expenditure_incurred,0) expenditure_incurred  from rgsa.qpr_cb_activity_details qcad ");
			query.append(" inner join rgsa.qpr_cb_activity qca on qca.qpr_cb_activity_id=qcad.qpr_cb_activity_id ");
			query.append(" inner join rgsa.cb_activity_details cad on cad.cb_activity_detail_id=qcad.cb_activity_detail_id ");
			query.append(" inner join rgsa.cb_master cm on cm.cb_master_id=cad.cb_master_id ");
			query.append("  where qca.qtr_id="+quarterId+" and qca.cb_activity_id =(select cb_activity_id from rgsa.cb_activity where state_code="+statecode+" and user_type='"+UserType+"' and year_id="+yearId+" and is_active)  ");
			/*
			 * query.append("union all"); query.
			 * append(" select 'Total',sum(COALESCE(cad.no_of_units,0)),sum(COALESCE(cad.funds,0)),sum(COALESCE(qcad.no_of_days_completed,0)),sum(COALESCE(qcad.no_of_units_completed,0)),sum(COALESCE(qcad.expenditure_incurred,0)) from rgsa.qpr_cb_activity_details qcad "
			 * ); query.
			 * append(" inner join rgsa.qpr_cb_activity qca on qca.qpr_cb_activity_id=qcad.qpr_cb_activity_id "
			 * ); query.
			 * append(" inner join rgsa.cb_activity_details cad on cad.cb_activity_detail_id=qcad.cb_activity_detail_id "
			 * ); query.
			 * append(" inner join rgsa.cb_master cm on cm.cb_master_id=cad.cb_master_id ");
			 * query.
			 * append(" where qca.qtr_id=3 and qca.cb_activity_id =(select cb_activity_id from rgsa.cb_activity where state_code=11 and user_type='C' and year_id=2 and is_active)  "
			 * );
			 */
			
			List list=dao.findAllByNativeQuery(query.toString(), null);
			if(list!=null && !list.isEmpty()) {
			 for(Iterator itr=list.iterator(); itr.hasNext();)
			 {
				 Object []  obj=(Object [])itr.next();
				 Map <String,String> map=new LinkedHashMap<>();
				 map.put("cb_name", obj[0].toString()); 
				 map.put("no_of_units", obj[1].toString());
				 map.put("funds", obj[2].toString());
				 map.put("no_of_days_completed", obj[3].toString());
				 map.put("no_of_units_completed", obj[4].toString());
				 map.put("expenditure_incurred", obj[5].toString());
				 datalist.add(map);
			 }
		 }
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return datalist;
	}
	
	
	public List fetchQprTrainingDetails(String statecode,String yearId,String UserType,String quarterId) {
		List  datalist=new LinkedList();
		try {
			StringBuilder query=new StringBuilder();
			query.append(" Select tc.training_category_name,s.subject_name, tvl.training_venue_level_name,COALESCE(tad.no_of_participants,0) as no_of_participants,COALESCE(tad.funds,0) as funds,COALESCE(qtd.expenditure_incurred,0) as expenditure_incurred from rgsa.qpr_trainings_details qtd ");
			query.append("  inner join rgsa.qpr_trainings qt on qt.qpr_trainings_id=qtd.qpr_trainings_id ");
			query.append("  inner join rgsa.training_activity_details tad on tad.training_id=qtd.training_activity_details_id ");
			query.append("  inner join rgsa.training_activity td on td.training_activity_id= tad.training_activity_id ");
			query.append("  inner join rgsa.training_subjects ts on ts.training_id=tad.training_id ");
			query.append("  inner join rgsa.subjects s on s.subject_id=ts.subject_id");
			query.append("  inner join rgsa.training_target_groups ttg on ttg.training_id=tad.training_id ");
			query.append("  inner join rgsa.training_wise_category twc on twc.training_id=tad.training_id ");
			query.append("  inner join rgsa.training_categories tc on tc.training_category_id=twc.training_category_id");
			query.append("  inner join rgsa.training_venue_level tvl on tvl.training_venue_level_id= tad.training_venue_level_id ");
			query.append("  where qt.qtr_id="+quarterId+" and td.state_code="+statecode+" and td.year_id="+yearId+" and td.user_type='"+UserType+"' and td.is_active ");
			query.append("  and qt.training_activity_id=(select training_activity_id from rgsa.training_activity where state_code="+statecode+" and year_id="+yearId+" and user_type='"+UserType+"' and is_active)");
			List list=dao.findAllByNativeQuery(query.toString(), null);
			if(list!=null && !list.isEmpty()) {
				 for(Iterator itr=list.iterator(); itr.hasNext();)
				 {
					 Object []  obj=(Object [])itr.next();
					 Map <String,String> map=new LinkedHashMap<>();
					 map.put("Training_Category", obj[0].toString()); 
					 map.put("Training_Subjects", obj[1].toString());
					 map.put("Venue_Level", obj[2].toString());
					 map.put("Total_Participants", obj[3].toString());
					 map.put("Approved_Amount", obj[4].toString());
					 map.put("expenditure_incurred", obj[5].toString());
					 datalist.add(map);
				 }
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return datalist;
	}
	
	
	public List fetchQprHRsupportSprcDprc(String statecode,String yearId,String UserType,String quarterId) {
		List  datalist=new LinkedList();
		try {
			StringBuilder query=new StringBuilder();
			query.append(" select iht.institue_infra_hr_activity_type_id, tit.training_institue_type_name, iht.institue_infra_hr_activity_type_name,COALESCE(qihd.no_of_units_filled,0) no_of_units_filled,COALESCE(qihd.expenditure_incurred,0) expenditure_incurred  from rgsa.qpr_inst_infra_hr_details qihd  ");
			query.append("  inner join rgsa.qpr_inst_infra_hr qih on qih.qpr_inst_infra_hr_id=qihd.qpr_inst_infra_hr_id ");
			query.append("  inner join rgsa.institue_infra_hr_activity_type iht on iht.institue_infra_hr_activity_type_id=qihd.institue_infra_hr_activity_type_id ");
			query.append("  inner join rgsa.training_institue_type tit on tit.training_institue_type_id=iht.training_institue_type_id ");
			query.append("  where qih.institue_infra_hr_activity_id in (select institue_infra_hr_activity_id from rgsa.institue_infra_hr_activity where state_code="+statecode+" and user_type='"+UserType+"' and is_active and year_id="+yearId+")and qih.qtr_id="+quarterId+" ");
			 
			List qprlist=dao.findAllByNativeQuery(query.toString(), null);
			
		    query=new StringBuilder();
			query.append("  select iihd.institue_infra_hr_activity_type_id,COALESCE(iihd.no_of_units,0) no_of_units ,COALESCE(iihd.funds,0) funds,COALESCE(iha.additional_requirement,0)additional_requirement  from rgsa.institue_infra_hr_activity_details iihd  ");
			query.append("  inner join rgsa.institue_infra_hr_activity iha on iha.institue_infra_hr_activity_id=iihd.institue_infra_hr_activity_id ");
			query.append("  where iha.state_code="+statecode+" and iha.user_type='"+UserType+"'  and iha.is_active and iha.year_id="+yearId+"  ");
			
			List list=dao.findAllByNativeQuery(query.toString(), null);
			
			if(list!=null && !list.isEmpty()) {
				 for(Iterator itr=list.iterator(); itr.hasNext();)
				 {
					 Object []  obj=(Object [])itr.next();
					 
					 for(Iterator datItr=qprlist.iterator(); datItr.hasNext();)
					 {
						 Object []  obj11=(Object [])datItr.next();
						 if(obj11[0]!=null && obj[0]!=null && obj11[0].equals(obj[0]))
						 {
							 Map <String,String> map=new LinkedHashMap<>();
							 map.put("Type_of_Center", String.valueOf(obj11[1])); 
							 map.put("Faculty_and_Staff", String.valueOf(obj11[2]));
							 map.put("No_of_Units_Approved", String.valueOf(obj[1]) );
							 map.put("funds", String.valueOf(obj[2]));
							 map.put("No_of_Units_Filled", String.valueOf(obj11[3]));
							 map.put("expenditure_incurred", String.valueOf(obj11[4]));
							 datalist.add(map); 
						 }
					 }
					
				 }
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return datalist;
	}
	 
	public List fetchQprEgovProgressReport(String statecode,String yearId,String UserType,String quarterId) {
		List  datalist=new LinkedList();
		try {
			 Map<String, Object> qParams = new HashMap<>();
		        qParams.put("quarterId", quarterId);
		        qParams.put("stateCode", statecode);
		        qParams.put("yearId", yearId);
		        qParams.put("userType", 'C');
		        List<QprEGovResponse> qprEGovs = dao.findAll("FETCH_QPR_EGOV_SUPPORT", qParams);
			 
			if(qprEGovs!=null && !qprEGovs.isEmpty()) {
				 for(Iterator<QprEGovResponse> itr=qprEGovs.iterator(); itr.hasNext();)
				 {
					 QprEGovResponse  obj= itr.next();
					 Map <String,String> map=new LinkedHashMap<>();
					 map.put("Level", obj.getEgovPostLevelName()); 
					 map.put("Designation", obj.getEgovPostName());
					 map.put("No_of_Posts_approved", String.valueOf(obj.getPostApproved()) );
					 map.put("Unit_Cost_Approved", String.valueOf(obj.getCostApproved() ));
					 map.put("No_of_Post_filled", String.valueOf( obj.getPostFilled() ) );
					 map.put("expenditure_incurred", String.valueOf( obj.getFunds() ) );
					 datalist.add(map);
				 }
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return datalist;
	}
	
	public List fetchQprPesaReport(String statecode,String yearId,String UserType,String quarterId) {
		List  datalist=new LinkedList();
		try {
			 Map<String, Object> qParams = new HashMap<>();
		        qParams.put("quarterId", quarterId);
		        qParams.put("stateCode", statecode);
		        qParams.put("yearId", yearId);
		        qParams.put("userType", 'C');
		        List<QprQuartProgress> qprQuartProgress = dao.findAll("FETCH_QPR_PESA", qParams);
			 
			if(qprQuartProgress!=null && !qprQuartProgress.isEmpty()) {
				 for(Iterator<QprQuartProgress> itr=qprQuartProgress.iterator(); itr.hasNext();)
				 {
					 QprQuartProgress  obj= itr.next();
					 Map <String,String> map=new LinkedHashMap<>();
					 map.put("Designation", obj.getPesaPostName()); 
					 map.put("No_of_Units_Approved ",""+ obj.getNoOfUnits());
					 map.put("Fund_sanctioned ", String.valueOf(obj.getFunds()) );
					 map.put("No_of_Units_Completed", String.valueOf(obj.getNoOfUnitsFilled() ));
					 map.put("expenditure_incurred", String.valueOf( obj.getExpenditureIncurred() ) );
					 datalist.add(map);
				 }
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return datalist;
	}
	
	
	public List fetchQprEenablementProgressReport(String statecode,String yearId,String UserType,String quarterId) {
		List  datalist=new LinkedList();
		try { 
			StringBuilder query=new StringBuilder();
			query.append(" select   eed.no_of_units,eed.unit_cost,eed.funds,qed.local_body_code,lb.local_body_name_english ,qed.expenditure_incurred,em.ee_name,qe.additional_requirement  from rgsa.e_enablement ee ");
			query.append("  left join rgsa.e_enablement_details eed on ee.e_enablement_id=eed.e_enablement_id  ");
			query.append("  inner join rgsa.qpr_e_enablement qe on qe.e_enablement_id=ee.e_enablement_id ");
			query.append("  left join rgsa.qpr_e_enablement_details qed on qed.qpr_e_enablement_id= qe.qpr_e_enablement_id ");
			query.append("  left join rgsa.qpr_e_enablement_status_master em on qed.qpr_status=em.ee__master_id ");
			query.append("  inner join lgd.localbody lb on lb.local_body_code=qed.local_body_code ");
			query.append("  where ee.year_id="+yearId+" and ee.user_type='"+UserType+"' and ee.state_code="+statecode+"  and lb.isactive and ee.is_active=true and qe.qtr_id="+quarterId+" ");
			List list=dao.findAllByNativeQuery(query.toString(), null);
			if(list!=null && !list.isEmpty()) {
				 for(Iterator itr=list.iterator(); itr.hasNext();)
				 {
					 Object []  obj=(Object [])itr.next();
					 Map <String,String> map=new LinkedHashMap<>();
					 map.put("GP_Name", obj[4].toString()); 
					 map.put("Amount Sanctioned", obj[1].toString());
					 map.put("Expenditure_Incurred", obj[5].toString());
					 map.put("Status", obj[6].toString());
					 datalist.add(map);
				 }
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return datalist;
	}
	
	public List fetchQprIEC(String statecode,String yearId,String UserType,String quarterId) {
		List  datalist=new LinkedList();
		try {
			StringBuilder query=new StringBuilder();
			query.append(" select (select string_agg(   ad.nature_iec_activity , ',' ) ase from rgsa.iec_details_dropdown idd ");
			query.append(" inner join rgsa.iec_activity_dropdown ad on ad.iec_id=idd.iec_details_dropdown_id) nature ,iad.total_amount_proposed , qid.expenditure_incurred from rgsa.iec_activity ia ");
			query.append(" inner join rgsa.iec_activity_details iad on iad.iec_activity_id=ia.id ");
			query.append("  inner join  rgsa.qpr_iec qi on qi.id=ia.id  ");
			query.append(" inner join rgsa.qpr_iec_details qid on qid.qpr_iec_id=qi.qpr_iec_id ");
			query.append(" where ia.state_code="+statecode+" and ia.user_type='"+UserType+"' and ia.year_id="+yearId+" and qi.qtr_id="+quarterId+"  group by iad.total_amount_proposed,qid.expenditure_incurred ");
			 
			List list=dao.findAllByNativeQuery(query.toString(), null);
			if(list!=null && !list.isEmpty()) {
				 for(Iterator itr=list.iterator(); itr.hasNext();)
				 {
					 Object []  obj=(Object [])itr.next();
					 Map <String,String> map=new LinkedHashMap<>();
					 map.put("Nature_of_the_IEC_Activity", obj[0].toString()); 
					 map.put("Total_Amount_Proposed", obj[1].toString());
					 map.put("Expenditure Incurred", obj[2].toString());
					 datalist.add(map);
				 }
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return datalist;
	}
	
	
	public List fetchQprPMU(String statecode,String yearId,String UserType,String quarterId) {
		List  datalist=new LinkedList();
		try {
			StringBuilder query=new StringBuilder();
			query.append(" select   pat.pmu_activity_type_name , pt.pmu_type_name,pad.no_of_units,pad.funds,qpd.no_of_units_filled,qpd.expenditure_incurred  from rgsa.pmu_activity pa ");
			query.append(" right outer join rgsa.pmu_activity_details pad on pad.pmu_activity_id=pa.pmu_activity_id ");
			query.append(" inner join rgsa.pmu_activity_type pat on pat.pmu_activity_type_id = pad.pmu_activity_type_id ");
			query.append(" inner join rgsa.pmu_type pt on pt.pmu_type_id=pat.pmu_type_id  ");
			query.append(" inner join  rgsa.qpr_pmu qp on qp.pmu_activity_id=pa.pmu_activity_id ");
			query.append(" right outer join rgsa.qpr_pmu_details qpd on qpd.qpr_pmu_id=qp.qpr_pmu_id ");
			query.append("  where pa.state_code="+statecode+" and pa.user_type='"+UserType+"' and pa.year_id="+yearId+" and qp.qtr_id="+quarterId+"  ");
			query.append("  group by pat.pmu_activity_type_name,pt.pmu_type_name,pad.no_of_units,pad.funds,qpd.no_of_units_filled,qpd.expenditure_incurred  ");
			
			List list=dao.findAllByNativeQuery(query.toString(), null);
			if(list!=null && !list.isEmpty()) 
			{
				 for(Iterator itr=list.iterator(); itr.hasNext();)
				 {
					 Object []  obj=(Object [])itr.next();
					 Map <String,String> map=new LinkedHashMap<>();
					 map.put("pmu_activity_type_name", obj[1].toString()); 
					 map.put("pmu_type_name", obj[0].toString());
					 map.put("no_of_units", obj[2].toString());
					 map.put("funds", obj[3].toString());
					 map.put("no_of_units_filled", obj[4].toString());
					 map.put("expenditure_incurred", obj[5].toString());
					 datalist.add(map);
				 }
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return datalist;
	}
	
	public List fetchQprPanchayatBhawan(String statecode,String yearId,String UserType,String quarterId) {
		List  datalist=new LinkedList();
		try {
			StringBuilder query=new StringBuilder();
			query.append(" select ga.activity_name,l.local_body_name_english,gs.gp_bhawan_status_name,qpd.expenditure_incurred from rgsa.panhcayat_bhawan_activity pa ");
			query.append(" inner join rgsa.panhcayat_bhawan_activity_details pad on pa.panhcayat_bhawan_activity_id = pad.panhcayat_bhawan_activity_id ");
			query.append(" inner join rgsa.panhcayat_bhawan_activity_gps pg on pad.id = pg.panhcayat_bhawan_activity_details_id ");
			query.append(" inner join rgsa.qpr_panhcayat_bhawan qp on pa.panhcayat_bhawan_activity_id = qp.panhcayat_bhawan_activity_id  ");
			query.append(" inner join rgsa.qpr_panhcayat_bhawan_details qpd on qp.qpr_panhcayat_bhawan_id = qpd.qpr_panhcayat_bhawan_id ");
			query.append(" inner join rgsa.gp_bhawan_status gs on qpd.gp_bhawan_status_id = gs.gp_bhawan_status_id ");
			query.append(" left join lgd.localbody l on qpd.local_body_code = l.local_body_code ");
			query.append(" left join rgsa.gps_activity ga on ga.activity_id = qp.activity_id ");
			query.append(" where pa.user_type = '"+UserType+"' and  qp.qtr_id ="+quarterId+" and pa.state_code ="+statecode+" and pa.year_id = "+yearId+" and pa.is_active =True  and pg.isactive ");
			query.append(" group by ga.activity_name,l.local_body_name_english,gs.gp_bhawan_status_name,qpd.expenditure_incurred ");
			List list=dao.findAllByNativeQuery(query.toString(), null);
			if(list!=null && !list.isEmpty()) 
			{
				 for(Iterator itr=list.iterator(); itr.hasNext();)
				 {
					 Object []  obj=(Object [])itr.next();
					 Map <String,String> map=new LinkedHashMap<>();
					 map.put("Activity_Type", obj[0].toString()); 
					 map.put("Gram_Panchayat", obj[1].toString());
					 map.put("GP_Bhawan_Status", obj[2].toString());
					 map.put("expenditure_incurred", obj[3].toString());
					 datalist.add(map);
				 }
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return datalist;
	}
	
	public List fetchQprAdministrativeAndTechnicalSupport(String statecode,String yearId,String UserType,String quarterId) {
		List  datalist=new LinkedList();
		try {
			StringBuilder query=new StringBuilder();
			query.append(" select atsd.post_id,ptm.post_type_name,   pt.post_name,  atsd.no_of_units, atsd.unit_cost  ,  atsd.funds,   at.additional_requirement  ");
			query.append(" from  rgsa.administrative_technical_support at right outer join rgsa.administrative_technical_support_details atsd  on at.administrative_technical_support_id=atsd.administrative_technical_support_id ");
			query.append("  inner join rgsa.post_type pt on pt.post_id=atsd.post_id ");
			query.append("  inner join rgsa.post_type_master ptm  on pt.post_type_id=ptm.post_type_id ");
			query.append(" where at.year_id="+yearId+"  and at.user_type='"+UserType+"'  and at.state_code="+statecode+"  and at.is_active=true ");
			 
			List list=dao.findAllByNativeQuery(query.toString(), null);
			
		    query=new StringBuilder();
			query.append("  select qad.post_id,qad.no_of_units_filled,qad.expenditure_incurred from rgsa.qpr_ats qa   ");
			query.append("  inner join rgsa.administrative_technical_support at  on qa.administrative_technical_support_id = at.administrative_technical_support_id ");
			query.append("  inner join rgsa.qpr_ats_details qad on qad.qpr_ats_id=qa.qpr_ats_id ");
			query.append(" where at.year_id="+yearId+"  and at.user_type='"+UserType+"'  and qtr_id="+quarterId+" and at.state_code="+statecode+"  and at.is_active=true ") ;
			
			List qprlist=dao.findAllByNativeQuery(query.toString(), null);
			
			if(list!=null && !list.isEmpty()) {
				 for(Iterator itr=list.iterator(); itr.hasNext();)
				 {
					 Object []  obj=(Object [])itr.next();
					 
					 for(Iterator datItr=qprlist.iterator(); datItr.hasNext();)
					 {
						 Object []  obj11=(Object [])datItr.next();
						 if(obj11[0]!=null && obj[0]!=null && obj11[0].equals(obj[0]))
						 {
							 Map <String,String> map=new LinkedHashMap<>();
							 map.put("Post_Type", String.valueOf(obj[1])); 
							 map.put("Post Name", String.valueOf(obj[2]));
							 map.put("No_of_Units_Approved", String.valueOf(obj[3]) );
							 map.put("No_Cost_Approved", String.valueOf(obj[4]) );
							 map.put("funds", String.valueOf(obj[2]));
							 map.put("No_of_Units_Filled", String.valueOf(obj11[1]));
							 map.put("expenditure_incurred", String.valueOf(obj11[2]));
							 datalist.add(map); 
						 }
					 }
				 }
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return datalist;
	}
	
	
	public List fetchQprIncomeEnhancement(String statecode,String yearId,String UserType,String quarterId) {
		List  datalist=new LinkedList();
		try {
			StringBuilder query=new StringBuilder();
			query.append(" select id.activty_name ,id.district_code ,id.funds_required,ied.expenditure_incurred from rgsa.income_enhancement_activity ia ,"
					+ " rgsa.income_enhancement_details id,rgsa.qpr_income_enhancement_details  ied , rgsa.qpr_income_enhancement qie where ia.state_code = "+statecode+" and ia.year_id ="+ yearId +" and ia.user_type = '"+UserType+"'  and qie.qtr_id="+quarterId+" " 
					+ " and ia.income_enhancement_id = id.income_enhancement_id and ia.is_active = True "
					+ " and id.is_active = True and id.income_enhancement_details_id = ied.income_enhancement_details_id and ied.qpr_income_enhancement_id = qie.qpr_income_enhancement_id ; ");
			 
			List list=dao.findAllByNativeQuery(query.toString(), null);
			if(list!=null && !list.isEmpty()) 
			{
				 for(Iterator itr=list.iterator(); itr.hasNext();)
				 {
					 Object []  obj=(Object [])itr.next();
					 Map <String,String> map=new LinkedHashMap<>();
					 map.put("Activity_Name", obj[0].toString()); 
					 map.put("District", obj[1].toString());
					 map.put("Fund_Sanctioned", obj[2].toString());
					 map.put("expenditure_incurred", obj[3].toString());
					 datalist.add(map);
				 }
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return datalist;
	}
	
	public List fetchQprSATCOM(String statecode,String yearId,String UserType,String quarterId) {
		List  datalist=new LinkedList();
		try {
			StringBuilder query=new StringBuilder();
			query.append(" select  sl.satcom_level_name,sm.satcom_master_name,sad.no_of_units,sad.unit_cost,sad.funds, sdp.no_of_units_completed,sdp.expenditure_incurred,sapr.additional_requirement from rgsa.satcom_activity sa   ");
			query.append("  inner join rgsa.satcom_activity_details sad  on sa.satcom_activity_id=sad.satcom_activity_id ");
			query.append("  inner join rgsa.satcom_master sm on sm.satcom_master_id=sad.satcom_master_id ");
			query.append("  left join rgsa.satcom_level sl on sl.satcom_level_id= sad.satcom_level_id ");
			query.append("  left join rgsa.satcom_activity_progress_report sapr on sapr.satcom_activity_id=sa.satcom_activity_id ");
			query.append("  inner join rgsa.satcom_details_progress_report sdp on sdp.satcom_activity_progress_report_id= sapr.satcom_activity_progress_report_id ");
			query.append("   where sa.year_id="+yearId+" and sa.user_type='"+UserType+"' and sa.state_code="+statecode+"   and sa.is_active=true and sdp.quarter_id= "+quarterId+"   ");
			
			List  list=dao.findAllByNativeQuery(query.toString(), null);
			
			if(list!=null && !list.isEmpty()) {
				 for(Iterator itr=list.iterator(); itr.hasNext();)
				 {
					 Object []  obj=(Object [])itr.next();
						 
							 Map <String,String> map=new LinkedHashMap<>();
							 map.put("satcom_level_name", String.valueOf(obj[0])); 
							 map.put("satcom_master_name", String.valueOf(obj[1]));
							 map.put("No_of_Units_Approved", String.valueOf(obj[2]) );
							 map.put("No_Cost_Approved", String.valueOf(obj[3]) );
							 map.put("funds", String.valueOf(obj[5]));
							 map.put("No_of_Units_Filled", String.valueOf(obj[6]));
							 map.put("expenditure_incurred", String.valueOf(obj[7]));
							 datalist.add(map); 
				 }
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return datalist;
	}
	
	public List fetchQprInstitutionalInfrastructure(String statecode,String yearId,String UserType,String quarterId) {
		List  datalist=new LinkedList();
		try {
			StringBuilder query=new StringBuilder();
			query.append("  select  tit.training_institue_type_name,d.district_name_english,iss.inst_infra_status_name,idd.work_type,idd.fund_sanctioned,COALESCE(qd.expenditure_incurred,0) expenditure_incurred ,COALESCE(qi.additional_requirement,0) additional_requirement ,COALESCE(qi.additional_requirement_dprc,0) additional_requirement_dprc  \r\n" + 
					" from rgsa.institutional_infra_activity ia  ");
			query.append("  left join rgsa.institutional_infra_activity_details idd on ia.institutional_infra_activity_id=idd.institutional_infra_activity_id  ");
			query.append(" inner join rgsa.training_institue_type tit on tit.training_institue_type_id=idd.institutional_activity_type_id  ");
			query.append(" inner join lgd.district d on d.district_code= idd.institutional_infra_location  ");
			query.append(" inner join rgsa.qpr_inst_infra qi on qi.institutional_infra_activity_id= ia.institutional_infra_activity_id  ");
			query.append(" inner join rgsa.qpr_inst_infra_details qd on qd.qpr_inst_infra_id=qi.qpr_inst_infra_id  ");
			query.append(" left join rgsa.inst_infra_status iss on iss.inst_infra_status_id=qd.inst_infra_status_id  ");
			query.append(" where ia.year_id="+yearId+" and ia.user_type='"+UserType+"' and ia.state_code="+statecode+"   and d.isactive and ia.is_active=true and qi.qtr_id="+quarterId+" ");
			
			List  list=dao.findAllByNativeQuery(query.toString(), null);
			
			if(list!=null && !list.isEmpty()) {
				 for(Iterator itr=list.iterator(); itr.hasNext();)
				 {
					 Object []  obj=(Object [])itr.next();
						 
							 Map <String,String> map=new LinkedHashMap<>();
							 map.put("training_institue_type_name", String.valueOf(obj[0])); 
							 map.put("district_name_english", String.valueOf(obj[1]));
							 map.put("inst_infra_status_name", String.valueOf(obj[2]) );
							 map.put("work_type", String.valueOf(obj[3]) );
							 map.put("funds", String.valueOf(obj[4]));
							 map.put("expenditure_incurred", String.valueOf(obj[5]));
							 map.put("additional_requirement", String.valueOf( Integer.parseInt(obj[6].toString())+Integer.parseInt(obj[7].toString())  ));
							 datalist.add(map);
				 }
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return datalist;
	}
	
	
}
