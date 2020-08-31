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
		int index1=0;
		
		try {
			StringBuilder query=new StringBuilder();
			//query.append(" Select cm.cb_name,cad.no_of_units,cad.funds, qcad.no_of_days_completed,qcad.no_of_units_completed,COALESCE(qcad.expenditure_incurred,0) expenditure_incurred,COALESCE(qca.additional_requirement,0) additional  from rgsa.qpr_cb_activity_details qcad ");
			//query.append(" inner join rgsa.qpr_cb_activity qca on qca.qpr_cb_activity_id=qcad.qpr_cb_activity_id ");
			//query.append(" inner join rgsa.cb_activity_details cad on cad.cb_activity_detail_id=qcad.cb_activity_detail_id ");
			//query.append(" inner join rgsa.cb_master cm on cm.cb_master_id=cad.cb_master_id ");
			//query.append("  where qca.qtr_id="+quarterId+" and qca.cb_activity_id =(select cb_activity_id from rgsa.cb_activity where state_code="+statecode+" and user_type='"+UserType+"' and year_id="+yearId+" and is_active)  ");
			
			query.append(" Select COALESCE(qcad.no_of_days_completed,0) no_of_days_completed ,COALESCE(qcad.no_of_units_completed,0) no_of_units_completed ,COALESCE(qcad.expenditure_incurred,0) expenditure_incurred,COALESCE(qca.additional_requirement,0) additional  from rgsa.qpr_cb_activity_details qcad ");
			query.append(" inner join rgsa.qpr_cb_activity qca on qca.qpr_cb_activity_id=qcad.qpr_cb_activity_id ");
			query.append(" inner join rgsa.cb_activity ca on ca.cb_activity_id=qca.cb_activity_id ");
			query.append("  where qca.qtr_id="+quarterId+" and ca.state_code="+statecode+" and ca.user_type='"+UserType+"' and ca.year_id="+yearId+" and ca.is_active ");
			
			List list=dao.findAllByNativeQuery(query.toString(), null);
			
			query=new StringBuilder();
			query.append("  select cm.cb_name,COALESCE(cad.no_of_units,0) no_of_units ,COALESCE(cad.funds,0) funds from rgsa.cb_activity ca ");
			query.append(" inner join rgsa.cb_activity_details cad on cad.cb_activity_id=ca.cb_activity_id ");
			query.append("  inner join rgsa.cb_master cm on cm.cb_master_id=cad.cb_master_id  ");
			query.append("  where ca.state_code="+statecode+" and ca.user_type='"+UserType+"' and ca.year_id="+yearId+" and ca.is_active ");
			
			List actionlist=dao.findAllByNativeQuery(query.toString(), null);
			
			if(list!=null && !list.isEmpty() && actionlist!=null && !actionlist.isEmpty()) {
			 for(Iterator itr=actionlist.iterator(); itr.hasNext();)
			 {
				 Object []  dobj=(Object [])itr.next();
				 index1++;
				 int index2=0;
				 for(Iterator ditr=list.iterator(); ditr.hasNext();)
				 {
					 Object []  obj=(Object []) ditr.next();
					 index2++;
					 if(index1==index2) {
						 Map <String,String> map=new LinkedHashMap<>();
						 map.put("cb_name", dobj[0].toString()); 
						 map.put("no_of_units", dobj[1].toString());
						 map.put("funds", dobj[2].toString());
						 map.put("no_of_days_completed", obj[0].toString());
						 map.put("no_of_units_completed", obj[1].toString());
						 map.put("expenditure_incurred", obj[2].toString());
						 map.put("additional_requirement", obj[3].toString());
						 datalist.add(map);
						 break;
					 }
				 }
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
			query.append(" select qtd.qpr_trainings_details_id,tc.training_category_name,(select cast(array_to_string(array(select s.subject_name from rgsa.training_subjects ts "); 
			query.append(" inner join  rgsa.subjects s on ts.subject_id=s.subject_id where ts.training_id=tad.training_id ),',') as varchar)subject_name),");
			query.append(" tvl.training_venue_level_name,COALESCE(tad.no_of_participants,0) as no_of_participants,COALESCE(tad.funds,0) as funds,");
			query.append(" COALESCE(qtd.expenditure_incurred,0) as expenditure_incurred ,sum( COALESCE(qtb.sc_males,0)+COALESCE(qtb.sc_females,0)+COALESCE(qtb.st_males,0)+");
			query.append(" COALESCE(qtb.st_females,0)+COALESCE(qtb.others_males,0)+COALESCE(qtb.others_females,0))as trained_no_of_participants,");
			query.append(" COALESCE( qt.additional_requirement,0) additional_requirement ");
			query.append(" from  rgsa.training_activity td ");
			query.append(" inner join rgsa.training_activity_details tad on tad.training_activity_id=td.training_activity_id ");
			query.append(" inner join rgsa.qpr_trainings qt on qt.training_activity_id =td.training_activity_id ");
			query.append(" inner join rgsa.qpr_trainings_details qtd on qtd.qpr_trainings_id =qt.qpr_trainings_id and tad.training_id=qtd.training_activity_details_id ");
			query.append(" inner join rgsa.training_wise_category twc on tad.training_id=twc.training_id ");
			query.append(" inner join rgsa.training_categories tc on tc.training_category_id=twc.training_category_id ");
			query.append(" inner join rgsa.training_venue_level tvl on tvl.training_venue_level_id= tad.training_venue_level_id ");
			query.append(" left join rgsa.qpr_training_breakup qtb on qtb.qpr_trainings_details_id = qtd.qpr_trainings_details_id ");
			query.append(" where td.state_code=:stateCode and td.year_id=:yearId and td.user_type=:UserType and td.is_active  and qt.qtr_id=:quarterId ");
			query.append(" group by qtd.qpr_trainings_details_id ,tc.training_category_name , subject_name, tvl.training_venue_level_name,");
			query.append(" tad.no_of_participants,tad.funds,qtd.expenditure_incurred,qt.additional_requirement ");
			query.append(" order by qtd.qpr_trainings_details_id");
			
			Map<String, Object> parameter = new HashMap<String, Object>();
			parameter.put("stateCode",Integer.parseInt(statecode));
			parameter.put("yearId",Integer.parseInt(yearId));
			parameter.put("UserType",UserType);
			parameter.put("quarterId",Integer.parseInt(quarterId));
			
	        List list=dao.findAllByNativeQuery(query.toString(), parameter);
			if(list!=null && !list.isEmpty()) {
				 for(Iterator itr=list.iterator(); itr.hasNext();)
				 {
					 Object []  obj=(Object [])itr.next();
					 Map <String,String> map=new LinkedHashMap<>();
					 map.put("Training_Category", obj[1].toString()); 
					 map.put("Training_Subjects", obj[2].toString());
					 map.put("Venue_Level", obj[3].toString());
					 map.put("Total_Participants", obj[4].toString()); 
					 map.put("Trained_Participants", obj[7].toString());
					 map.put("Approved_Amount", obj[5].toString());
					 map.put("expenditure_incurred", obj[6].toString());
					 map.put("additional_requirement", obj[8].toString()); 
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
			query.append(" select iht.institue_infra_hr_activity_type_id, tit.training_institue_type_name, iht.institue_infra_hr_activity_type_name,COALESCE(qihd.no_of_units_filled,0) no_of_units_filled,COALESCE(qihd.expenditure_incurred,0) expenditure_incurred, COALESCE( qih.additional_req_dprc,  0) additional_req_dprc, COALESCE( qih.additional_req_sprc, 0) additional_req_sprc  from rgsa.qpr_inst_infra_hr_details qihd  ");
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
			
			if(list!=null && !list.isEmpty() && qprlist!=null && !qprlist.isEmpty()) {
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
							 map.put("additional_req_dprc", obj11[5].toString());
							 map.put("additional_req_sprc", obj11[6].toString());
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
		        qParams.put("quarterId", Integer.parseInt(quarterId));
		        qParams.put("stateCode", Integer.parseInt(statecode));
		        qParams.put("yearId", Integer.parseInt(yearId));
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
					 if(obj.getFunds()!=null ) {
						 map.put("expenditure_incurred", String.valueOf( obj.getIncurred() ) );	 
					 }else {
						 map.put("expenditure_incurred", "0" );	 
					 }
					
					 if(obj.getAdditionalReqSpmu()!=null) {
					 map.put("additional_requirement_spmu", String.valueOf( obj.getAdditionalReqSpmu()) );
					 }else {
						 map.put("additional_requirement_spmu", "0" );	 
					 }
					 if(obj.getAdditionalReqDpmu()!=null) {
						 map.put("additional_requirement_dpmu", String.valueOf( obj.getAdditionalReqDpmu()) );
					 }else {
						 map.put("additional_requirement_dpmu", "0" );	 
					 }
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
		        qParams.put("quarterId", Integer.parseInt(quarterId));
		        qParams.put("stateCode", Integer.parseInt(statecode));
		        qParams.put("yearId", Integer.parseInt(yearId));
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
					 map.put("additional_requirement", String.valueOf( obj.getAdditionalRequirement()) );
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
			query.append(" select   eed.no_of_units,eed.unit_cost,eed.funds,qed.local_body_code,lb.local_body_name_english ,COALESCE(qed.expenditure_incurred,0) expenditure_incurred, em.ee_name,COALESCE(qe.additional_requirement,0) additional_requirement from rgsa.e_enablement ee ");
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
					 if(obj[6]!=null) {
						 map.put("Status", obj[6].toString()); 
					 }else {
						 map.put("Status","");  
					 }
					 map.put("expenditure_incurred", obj[5].toString());
					 map.put("additional_requirement", obj[7].toString());
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
			query.append("  select (select string_agg(   iac.nature_iec_activity , ',' ) ase from rgsa.iec_details_dropdown idd \r\n" + 
					" inner join rgsa.iec_activity_dropdown  iac on iac.iec_id=idd.iec_activity_dropdown_id\r\n" + 
					" inner join  rgsa.iec_activity_details iec on iec.iec_activity_details_id=idd.iec_activity_details_id\r\n" + 
					"  inner join rgsa.iec_activity  ia on iec.iec_activity_id=ia.id \r\n" + 
					" where ia.state_code="+statecode+" and ia.user_type='"+UserType+"' and ia.year_id="+yearId+" and ia.is_active ) nature ,COALESCE(iad.total_amount_proposed,0) total_amount_proposed , COALESCE(qid.expenditure_incurred,0) expenditure_incurred  from rgsa.iec_activity ia ");
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
					 map.put("expenditure_incurred", obj[2].toString());
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
		int index1=0;
		try {
			StringBuilder query=new StringBuilder();
			//query.append(" select   pat.pmu_activity_type_name , pt.pmu_type_name,COALESCE(pad.no_of_units,0) no_of_units ,COALESCE(pad.funds,0) funds ,COALESCE(qpd.no_of_units_filled ,0) no_of_units_filled ,COALESCE(qpd.expenditure_incurred,0) expenditure_incurred ,COALESCE(qp.additional_requirement,0) additional_requirement  from rgsa.pmu_activity pa ");
			//query.append(" right outer join rgsa.pmu_activity_details pad on pad.pmu_activity_id=pa.pmu_activity_id ");
			//query.append(" inner join rgsa.pmu_activity_type pat on pat.pmu_activity_type_id = pad.pmu_activity_type_id ");
			//query.append(" inner join rgsa.pmu_type pt on pt.pmu_type_id=pat.pmu_type_id  ");
			//query.append(" inner join  rgsa.qpr_pmu qp on qp.pmu_activity_id=pa.pmu_activity_id ");
			//query.append(" right outer join rgsa.qpr_pmu_details qpd on qpd.qpr_pmu_id=qp.qpr_pmu_id ");
			//query.append("  where pa.state_code="+statecode+" and pa.user_type='"+UserType+"' and pa.year_id="+yearId+" and qp.qtr_id="+quarterId+"  ");
			//query.append("  group by pat.pmu_activity_type_name,pt.pmu_type_name,pad.no_of_units,pad.funds,qpd.no_of_units_filled,qpd.expenditure_incurred ,qp.additional_requirement ");
			
			query.append(" select    pat.pmu_activity_type_name , pt.pmu_type_name,COALESCE(pad.no_of_units,0) no_of_units ,COALESCE(pad.funds,0) funds   from rgsa.pmu_activity pa ");
			query.append(" right outer join rgsa.pmu_activity_details pad on pad.pmu_activity_id=pa.pmu_activity_id  ");
			query.append(" inner join rgsa.pmu_activity_type pat on pat.pmu_activity_type_id = pad.pmu_activity_type_id   ");
			query.append(" inner join rgsa.pmu_type pt on pt.pmu_type_id=pat.pmu_type_id  ");
			query.append(" where pa.state_code="+statecode+" and pa.user_type='"+UserType+"' and pa.year_id="+yearId+" and pa.is_active  ");
			
			List list=dao.findAllByNativeQuery(query.toString(), null);
			
			query=new StringBuilder();
			query.append(" select COALESCE(qpd.no_of_units_filled ,0) no_of_units_filled ,COALESCE(qpd.expenditure_incurred,0) expenditure_incurred ,COALESCE(qp.additional_requirement,0) 		additional_requirement from rgsa.qpr_pmu qp ");
			query.append(" inner join  rgsa.pmu_activity pa on qp.pmu_activity_id=pa.pmu_activity_id ");
			query.append(" inner join rgsa.qpr_pmu_details qpd  on qpd.qpr_pmu_id=qp.qpr_pmu_id  ");
			query.append(" where pa.state_code="+statecode+" and pa.user_type='"+UserType+"' and pa.year_id="+yearId+" and qp.qtr_id="+quarterId+"  order by qpd.qpr_pmu_details_id ");
			
			List qtlist=dao.findAllByNativeQuery(query.toString(), null);
			
			if(list!=null && !list.isEmpty() && qtlist!=null && !qtlist.isEmpty()) 
			{
				 for(Iterator itr=list.iterator(); itr.hasNext();)
				 {
					 Object []  obj=(Object [])itr.next();
					index1++;
					int index2=0;
					 for(Iterator qitr=qtlist.iterator(); qitr.hasNext();)
					 {
						 Object []  qb=(Object [])qitr.next();
						 index2++;
						 if(index1==index2) {
						 Map <String,String> map=new LinkedHashMap<>();
						 map.put("pmu_activity_type_name", obj[1].toString()); 
						 map.put("pmu_type_name", obj[0].toString());
						 map.put("no_of_units", obj[2].toString());
						 map.put("funds", obj[3].toString());
						 map.put("no_of_units_filled", qb[0].toString());
						 map.put("expenditure_incurred", qb[1].toString());
						 map.put("additional_requirement", qb[2].toString());
						 datalist.add(map);
						 break;
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
	
	public List fetchQprPanchayatBhawan(String statecode,String yearId,String UserType,String quarterId) {
		List  datalist=new LinkedList();
		try {
			StringBuilder query=new StringBuilder();
			query.append(" select ga.activity_name,l.local_body_name_english,gs.gp_bhawan_status_name,COALESCE(qpd.expenditure_incurred,0) expenditure_incurred ,COALESCE( qp.additional_requirement,0) additional_requirement from rgsa.panhcayat_bhawan_activity pa ");
			query.append(" inner join rgsa.panhcayat_bhawan_activity_details pad on pa.panhcayat_bhawan_activity_id = pad.panhcayat_bhawan_activity_id ");
			query.append(" inner join rgsa.panhcayat_bhawan_activity_gps pg on pad.id = pg.panhcayat_bhawan_activity_details_id ");
			query.append(" inner join rgsa.qpr_panhcayat_bhawan qp on pa.panhcayat_bhawan_activity_id = qp.panhcayat_bhawan_activity_id  ");
			query.append(" inner join rgsa.qpr_panhcayat_bhawan_details qpd on qp.qpr_panhcayat_bhawan_id = qpd.qpr_panhcayat_bhawan_id ");
			query.append(" inner join rgsa.gp_bhawan_status gs on qpd.gp_bhawan_status_id = gs.gp_bhawan_status_id ");
			query.append(" left join lgd.localbody l on qpd.local_body_code = l.local_body_code ");
			query.append(" left join rgsa.gps_activity ga on ga.activity_id = qp.activity_id ");
			query.append(" where pa.user_type = '"+UserType+"' and  qp.qtr_id ="+quarterId+" and pa.state_code ="+statecode+" and pa.year_id = "+yearId+" and pa.is_active =True  and pg.isactive ");
			query.append(" group by ga.activity_name,l.local_body_name_english,gs.gp_bhawan_status_name,qpd.expenditure_incurred,qp.additional_requirement ");
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
					 map.put("additional_requirement", obj[4].toString());
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
			query.append(" select atsd.post_id,ptm.post_type_name,   pt.post_name,  COALESCE(atsd.no_of_units,0) no_of_units, COALESCE(atsd.unit_cost,0) unit_cost  ,  COALESCE(atsd.funds,0) funds ");
			query.append(" from  rgsa.administrative_technical_support at right outer join rgsa.administrative_technical_support_details atsd  on at.administrative_technical_support_id=atsd.administrative_technical_support_id ");
			query.append("  inner join rgsa.post_type pt on pt.post_id=atsd.post_id ");
			query.append("  inner join rgsa.post_type_master ptm  on pt.post_type_id=ptm.post_type_id ");
			query.append(" where at.year_id="+yearId+"  and at.user_type='"+UserType+"'  and at.state_code="+statecode+"  and at.is_active=true ");
			 
			List list=dao.findAllByNativeQuery(query.toString(), null);
			
		    query=new StringBuilder();
			query.append("  select qad.post_id, COALESCE(qad.no_of_units_filled,0) no_of_units_filled , COALESCE(qad.expenditure_incurred,0) expenditure_incurred  , COALESCE(qa.additional_requirement,0 ) additional_requirement from rgsa.qpr_ats qa   ");
			query.append("  inner join rgsa.administrative_technical_support at  on qa.administrative_technical_support_id = at.administrative_technical_support_id ");
			query.append("  inner join rgsa.qpr_ats_details qad on qad.qpr_ats_id=qa.qpr_ats_id ");
			query.append(" where at.year_id="+yearId+"  and at.user_type='"+UserType+"'  and qtr_id="+quarterId+" and at.state_code="+statecode+"  and at.is_active=true ") ;
			
			List qprlist=dao.findAllByNativeQuery(query.toString(), null);
			
			if(list!=null && !list.isEmpty() && qprlist!=null && !qprlist.isEmpty()) {
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
							 map.put("funds", String.valueOf(obj[5]));
							 map.put("No_of_Units_Filled", String.valueOf(obj11[1]));
							 map.put("expenditure_incurred", String.valueOf(obj11[2]));
							 map.put("additional_requirement", obj11[3].toString());
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
			query.append(" select id.activty_name ,di.district_name_english ,COALESCE(id.funds_required,0) funds_required ,COALESCE(ied.expenditure_incurred ,0) expenditure_incurred, COALESCE(qie.additional_requirement,0) additional_requirement  from rgsa.income_enhancement_activity ia ,"
					+ " rgsa.income_enhancement_details id,rgsa.qpr_income_enhancement_details  ied , rgsa.qpr_income_enhancement qie , lgd.district di  where ia.state_code = "+statecode+" and ia.year_id ="+ yearId +" and ia.user_type = '"+UserType+"'  and qie.qtr_id="+quarterId+" " 
					+ " and ia.income_enhancement_id = id.income_enhancement_id and ia.is_active = True "
					+ " and id.is_active = True and id.income_enhancement_details_id = ied.income_enhancement_details_id and ied.qpr_income_enhancement_id = qie.qpr_income_enhancement_id  and di.district_code=id.district_code ;  ");
			 
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
					 map.put("additional_requirement", obj[4].toString());
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
			query.append(" select  sl.satcom_level_name,sm.satcom_master_name,COALESCE(sad.no_of_units,0) no_of_units,COALESCE(sad.unit_cost,0) unit_cost,COALESCE(sad.funds,0) funds, COALESCE(sdp.no_of_units_completed,0) no_of_units_completed ,COALESCE(sdp.expenditure_incurred,0) expenditure_incurred ,COALESCE(sapr.additional_requirement,0) additional_requirement from rgsa.satcom_activity sa   ");
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
							 map.put("additional_requirement", String.valueOf(obj[8]));
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
			query.append("  select  tit.training_institue_type_name,d.district_name_english,iss.inst_infra_status_name,idd.work_type,COALESCE(idd.fund_sanctioned,0) fund_sanctioned ,COALESCE(qd.expenditure_incurred,0) expenditure_incurred ,COALESCE(qi.additional_requirement,0) additional_requirement ,COALESCE(qi.additional_requirement_dprc,0) additional_requirement_dprc  \r\n" + 
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
							 if(obj[3]!=null) {
							 map.put("work_type", String.valueOf(obj[3]) );
							}else {
								 map.put("work_type","NA"  ); 
				 			}
							if (obj[2] != null) {
								map.put("inst_infra_status_name", String.valueOf(obj[2]));
							} else {
								map.put("inst_infra_status_name", "NA");
							}
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
	
	 
	public List fetchQprInnovativeActive(String statecode,String yearId,String UserType,String quarterId) {
		List  datalist=new LinkedList();
		try {
			StringBuilder query=new StringBuilder();
			query.append(" select ids.activity_name,COALESCE(ids.funds_name,0) funds ,COALESCE(qid.expenditure_incurred,0) expenditure_incurred,COALESCE(qi.additional_requirement,0) additional_requirement from rgsa.innovative_activity i  ");
			query.append(" inner join rgsa.innovative_activity_details ids on ids.innovative_activity_id=i.innovative_activity_id ");
			query.append(" inner join rgsa.qpr_ia qi on qi.innovative_activity_id=i.innovative_activity_id ");
			query.append(" inner join rgsa.qpr_ia_details qid on qid.qpr_ia_id=qi.qpr_ia_id ");
			query.append(" where i.state_code="+statecode+" and i.year_id="+yearId+" and i.user_type='"+UserType+"' and qi.qtr_id="+quarterId+" and qi.is_freeze and i.is_active ");
			List  list=dao.findAllByNativeQuery(query.toString(), null);
			if(list!=null && !list.isEmpty()) {
				 for(Iterator itr=list.iterator(); itr.hasNext();)
				 {
					 Object []  obj=(Object [])itr.next();
						 
							 Map <String,String> map=new LinkedHashMap<>();
							 map.put("activity_name", String.valueOf(obj[0])); 
							 map.put("funds_name", String.valueOf(obj[1]));
							 map.put("expenditure_incurred", String.valueOf(obj[2]));
							 map.put("additional_requirement", String.valueOf(obj[3]));
							 datalist.add(map); 
				 }
			}
			
		}catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return datalist;	
	}
	
	public List fetchQpradminFinancial(String statecode,String yearId,String UserType,String quarterId) {
		List  datalist=new LinkedList();
		int index1=0;
		try {
			StringBuilder query=new StringBuilder();
			query.append("  select pt.pmu_type_name,pa.pmu_activity_type_name,COALESCE(ad.no_of_staffs_proposed,0) no_of_staffs_proposed ,COALESCE(ad.unit_cost,0) unit_cost ,COALESCE(ad.funds,0) funds from  rgsa.pmu_type pt  ");
			query.append(" inner join rgsa.pmu_activity_type pa on pt.pmu_type_id = pa.pmu_type_id ");
			query.append(" inner join rgsa.admin_financial_data_cell_activity_details ad on pa.pmu_activity_type_id = ad.pmu_activity_type_id ");
			query.append(" inner join  rgsa.admin_financial_data_cell_activity aa on ad.admin_financial_data_cell_activity_id = aa.admin_financial_data_cell_activity_id ");
			query.append(" where  aa.state_code = "+statecode+" and aa.year_id = "+yearId+" and aa.user_type = '"+UserType+"'  and aa.is_active  order by ad.admin_financial_data_cell_activity_detail_id  ");
			List  list=dao.findAllByNativeQuery(query.toString(), null);
			
			query=new StringBuilder();
			query.append(" select COALESCE(qd.no_of_units_filled,0) no_of_units_filled ,COALESCE(qd.expenditure_incurred,0) expenditure_incurred ,COALESCE(qa.additional_requirement ,0) additional_requirement from rgsa.qpr_afp_details qd ");
			query.append(" inner join rgsa.qpr_afp qa on qa.qpr_afp_id = qd.qpr_afp_id ");
			query.append(" inner join rgsa.admin_financial_data_cell_activity aa on aa.admin_financial_data_cell_activity_id = qa.admin_financial_data_cell_activity_id ");
			query.append(" where aa.state_code = "+statecode+" and aa.year_id = "+yearId+" and aa.user_type = '"+UserType+"' and qa.qtr_id = "+quarterId+" and aa.is_active and qa.is_freeze = True order by qpr_afp_details_id ") ;
			
			List qprlist=dao.findAllByNativeQuery(query.toString(), null);

			
			if(list!=null && !list.isEmpty() && qprlist!=null && !qprlist.isEmpty()) {
				 for(Iterator itr=list.iterator(); itr.hasNext();)
				 {
					 Object []  obj=(Object [])itr.next();
					 	index1++;
						int index2=0;
					 for(Iterator qitr=qprlist.iterator(); qitr.hasNext();)
					 {
						 Object [] qob =(Object[]) qitr.next();
						 index2++;
						 if(index1==index2) {
								 Map <String,String> map=new LinkedHashMap<>();
								 map.put("center", String.valueOf(obj[0])); 
								 map.put("domain_experts", String.valueOf(obj[1]));
								 map.put("approved_no_of_staff", String.valueOf(obj[2]));
								 map.put("approved_unit_cost", String.valueOf(obj[3]));
								 map.put("fund", String.valueOf(obj[4]));
								 map.put("no_of_units_filled", String.valueOf(qob[0]));
								 map.put("expenditure_incurred", String.valueOf(qob[1]));
								 map.put("additional_requirement", String.valueOf(qob[2]));
								 datalist.add(map); 
								 break;
						 }
					 }
				 }
			}
		}catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return datalist;	
	}
	

	public List<FinYear> fetchTwoFinYear()
	{
		return dao.fetchTwoFinYear("FETCH_ALL_FIN_YEAR",null);
	}
	
//Added by sushma singh for new report
	
	@Override
	public List fetchTrainingActivityListYearWiseNew(String statecode, String yearId, String UserType,String quarterId) {
		List  datalist=new LinkedList();
		int index2=0;
		
		try {
			StringBuilder query=new StringBuilder();
			query.append(" select cm.cb_name as activity, COALESCE(cad.no_of_days,0) no_of_days ,COALESCE(cad.no_of_units,0) no_of_units,COALESCE(cad.unit_cost,0)as unit_cost,COALESCE(cad.funds,0) funds_proposed ,COALESCE(qad.expenditure_incurred,0 )as funds_utilized , cad.collab_institute as collaboration_with_institute , cad.remarks from  rgsa.qpr_cb_activity_details qad ");
			query.append(" inner join   rgsa.qpr_cb_activity qca on qad.qpr_cb_activity_id = qca.qpr_cb_activity_id   ");
			query.append("inner join rgsa.cb_activity ca on qca.cb_activity_id = ca.cb_activity_id  ");
			query.append("inner join rgsa.cb_activity_details cad on cad.cb_activity_id=ca.cb_activity_id  ");
		    query.append(" inner join rgsa.cb_master cm on cm.cb_master_id=cad.cb_master_id");
			query.append(" where qad.cb_activity_detail_id = cad.cb_activity_detail_id and  qca.qtr_id="+quarterId+" and ca.state_code="+statecode+" and ca.user_type='"+UserType+"' and ca.year_id="+yearId+" and ca.is_active  order by 1");
			
			List actionlist=dao.findAllByNativeQuery(query.toString(), null);
			
				 for(Iterator ditr=actionlist.iterator(); ditr.hasNext();)
				 {
					 Object []  obj=(Object []) ditr.next();
					 index2++;
					
						 Map <String,String> map=new LinkedHashMap<>();
						 map.put("activity", obj[0].toString()); 
						 map.put("no_of_days", obj[1].toString());
						 map.put("no_of_units", obj[2].toString());
						 map.put("unit_cost", obj[3].toString());
						 map.put("funds_proposed", obj[4].toString());
						 map.put("expenditure_incurred", obj[5].toString());
						 if(obj[6]!=null) {
						map.put("collaboration_with_institute", obj[6].toString());
						 }else {
							 map.put("collaboration_with_institute","");  
						 }
						 
						 if(obj[7]!=null) {
							 map.put("remarks", obj[7].toString());
								 }else {
									 map.put("remarks","");  
								 }
						 
						 
						 datalist.add(map);
						 break;
						
					  }
			 
		 
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return datalist;
	}

	@Override
	public List fetchQprTrainingDetailsYearWiseNew(String statecode, String yearId, String UserType, String quarterId) {
		List  datalist=new LinkedList();
		try {
			
			StringBuilder query=new StringBuilder();
			query.append(" select (select cast(array_to_string(array(select tc.training_category_name from rgsa.training_wise_category twc  "); 
			query.append("  inner join rgsa.training_categories tc on twc.training_category_id=tc.training_category_id where twc.training_id =tad.training_id), ',') as char varying)) as training_category,  ");
			query.append("  (select cast(array_to_string(array(select subject_name from rgsa.training_subjects ts   ");
			query.append("  inner join rgsa.subjects s on ts.subject_id=s.subject_id");
			query.append("  where ts.training_id =tad.training_id),',') as char varying)) as training_subjects, (select cast(array_to_string(array(select target_group_master_name from rgsa.training_target_groups ttg ");
			query.append("  inner join rgsa.target_group_master tgm on ttg.target_group_master_id= tgm.target_group_master_id where ttg.training_id =tad.training_id),',') as char varying)  ");
			query.append("  target_group_master_name ) as training_target_group,tvl.training_venue_level_name as venue_level,tm.training_mode_name as mode_of_training, ");
			query.append(" COALESCE(tad.no_of_participants ,0) as no_of_participants, COALESCE(tad.funds ,0) as funds_approved,COALESCE(qtd.expenditure_incurred,0) as funds_utilized ,(select ");
			query.append(" sum( COALESCE(qtb.sc_males,0)+COALESCE(qtb.sc_females,0)+COALESCE(qtb.st_males,0)+COALESCE(qtb.st_females,0)+COALESCE(qtb.others_males,0)+COALESCE(qtb.others_females,0) ) )  as participants_trained ,COALESCE( tad.remarks ,'N/A') remarks from rgsa.training_activity_details tad inner join rgsa.training_activity ta on ta.training_activity_id =tad.training_activity_id ");
			query.append("  inner join  rgsa.qpr_trainings qt on ta.training_activity_id = qt.training_activity_id  ");
		    query.append(" inner join  rgsa.qpr_trainings_details qtd on qt.qpr_trainings_id=qtd.qpr_trainings_id ");
			query.append(" inner join rgsa.qpr_training_breakup qtb on qtb.qpr_trainings_details_id=qtd.qpr_trainings_details_id");
			query.append(" inner join rgsa.training_venue_level tvl on tad.training_venue_level_id = tvl.training_venue_level_id ");
		    query.append(" inner join rgsa.training_mode tm on tad.training_mode_id=tm.training_mode_id ");
			query.append(" where tad.training_id = qtd.training_activity_details_id  and  ta.state_code ="+statecode+"and ta.year_id="+yearId+" and qt.qtr_id ="+quarterId+" and ta.user_type='"+UserType+"' and tad.is_active=true and ta.is_active group by 1,2,3,4,5,6,7,8,10 order by 1");
			 
			List list=dao.findAllByNativeQuery(query.toString(), null);
			if(list!=null && !list.isEmpty()) {
				 for(Iterator itr=list.iterator(); itr.hasNext();)
				 {
					 Object []  obj=(Object [])itr.next();
					 Map <String,String> map=new LinkedHashMap<>();
					 map.put("training_category_name", obj[0].toString()); 
					 map.put("subject_name", obj[1].toString());
					 map.put("target_group_master_name", obj[2].toString());
					 map.put("training_venue_level_name", obj[3].toString());
					 map.put("training_mode", obj[4].toString());
                     map.put("no_of_participants", obj[5].toString()); 
					 map.put("funds", obj[6].toString());
					 map.put("expenditure_incurred", obj[7].toString());
					 map.put("participants_trained", obj[8].toString());
					 map.put("remarks", obj[9].toString()); 
					 datalist.add(map);
					 
					 
					 
				 }
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return datalist;
		
	}

	@Override
	public List fetchQprHRsupportSprcDprcYearWiseNew(String statecode, String yearId, String UserType,
			String quarterId) {
		List  datalist=new LinkedList();
		try {
			StringBuilder query=new StringBuilder();
			query.append(" select tit.training_institue_type_name, iht.institue_infra_hr_activity_type_name as faculty_and_staff,COALESCE(iihd.no_of_units,0) no_of_units,iihd.funds,qihd.expenditure_incurred as funds_utilized ,iihd.remarks  from rgsa.institue_infra_hr_activity_details iihd ");
			query.append(" inner join rgsa.institue_infra_hr_activity iha on iha.institue_infra_hr_activity_id=iihd.institue_infra_hr_activity_id ");
			query.append("  inner join  rgsa.qpr_inst_infra_hr qih on iha.institue_infra_hr_activity_id=qih.institue_infra_hr_activity_id ");
			query.append("  inner join  rgsa.qpr_inst_infra_hr_details qihd on qih.qpr_inst_infra_hr_id=qihd.qpr_inst_infra_hr_id ");
			query.append("  inner join rgsa.institue_infra_hr_activity_type iht on iht.institue_infra_hr_activity_type_id=iihd.institue_infra_hr_activity_type_id  ");
			query.append("  inner join rgsa.training_institue_type tit on tit.training_institue_type_id=iht.training_institue_type_id    ");
            query.append("  where state_code="+statecode+"and user_type='"+UserType+"' and iha.is_active and year_id="+yearId+" and qih.qtr_id="+quarterId+" and iihd.institue_infra_hr_activity_type_id=qihd.institue_infra_hr_activity_type_id group by 1,2,3,4,5,6 order by 1");
			 
			List list=dao.findAllByNativeQuery(query.toString(), null);
			
			
					 
					 for(Iterator datItr=list.iterator(); datItr.hasNext();)
					 {
						 Object []  obj11=(Object [])datItr.next();
						
							 Map <String,String> map=new LinkedHashMap<>();
							 map.put("training_institue_type_name", String.valueOf(obj11[0])); 
							 map.put("institue_infra_hr_activity_type_name", String.valueOf(obj11[1]));
							 map.put("no_of_units", String.valueOf(obj11[2]) );
							 map.put("funds", String.valueOf(obj11[3]));
							 map.put("expenditure_incurred", String.valueOf(obj11[4]));
							 map.put("remark", obj11[5].toString());
							
							 datalist.add(map); 
				 }
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return datalist;
	}

	@Override
	public List fetchQprEgovProgressReportYearWiseNew(String statecode, String yearId, String UserType,
			String quarterId) {

		List  datalist=new LinkedList();
		try {
			
			 
			StringBuilder query=new StringBuilder();
			query.append(" SELECT   epl.egov_post_level_name as level , ep.egov_post_name designation ,   COALESCE(esad.no_of_units, 0) as no_of_post_proposed,  COALESCE(esad.unit_cost, 0) as unit_cost  , esad.funds as funds_approved,  COALESCE(qed.expenditure_incurred, 0) as funds_utilized , esad.remarks FROM rgsa.egov_support_activity esa  ");
			query.append(" inner join  rgsa.egov_support_activity_details esad ON esad.egov_support_activity_id = esa.egov_support_activity_id  ");
			query.append(" inner join rgsa.egov_post ep ON ep.egov_post_id = esad.egov_post_id ");
			query.append(" inner join rgsa.egov_post_level epl ON ep.egov_post_level_id = epl.egov_post_level_id ");
			query.append(" inner join rgsa.qpr_egov qe ON esa.egov_support_activity_id = qe.egov_support_activity_id AND qe.qtr_id ="+quarterId+"");
			query.append(" inner join rgsa.qpr_egov_details qed ON qe.qpr_egov_id = qed.qpr_egov_id AND qed.egov_post_id = esad.egov_post_id ");
			query.append("  WHERE esa.user_type ='"+UserType+"' AND esa.state_code="+statecode+" and esa.year_id="+yearId+" ORDER BY 1,2 ");
			List list=dao.findAllByNativeQuery(query.toString(), null);
			if(list!=null && !list.isEmpty()) {
				 for(Iterator itr=list.iterator(); itr.hasNext();)
				 {
					 Object []  obj=(Object [])itr.next();
					 Map <String,String> map=new LinkedHashMap<>();
					 map.put("egov_post_level_name", obj[0].toString()); 
					 map.put("egov_post_name", obj[1].toString());
					 map.put("no_of_units", obj[2].toString());
					 map.put("unit_cost", obj[3].toString());
					 map.put("funds", obj[4].toString());
					 map.put("expenditure_incurred", obj[5].toString());
					 if(obj[6]!=null) {
						 map.put("remarks", obj[6].toString());
							 }else {
								 map.put("remarks","");  
							 }
					 datalist.add(map);
				 }
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return datalist;
	}

	@Override
	public List fetchQprEenablementProgressReportYearWiseNew(String statecode, String yearId, String UserType,
			String quarterId) {
		List  datalist=new LinkedList();
		try { 
			StringBuilder query=new StringBuilder();
			query.append(" select   eed.no_of_units,eed.unit_cost,eed.funds,qed.local_body_code,lb.local_body_name_english ,COALESCE(qed.expenditure_incurred,0) expenditure_incurred, em.ee_name,COALESCE(qe.additional_requirement,0) additional_requirement from rgsa.e_enablement ee ");
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
					 if(obj[6]!=null) {
						 map.put("Status", obj[6].toString()); 
					 }else {
						 map.put("Status","");  
					 }
					 map.put("expenditure_incurred", obj[5].toString());
					 map.put("additional_requirement", obj[7].toString());
					 datalist.add(map);
				 }
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return datalist;
	}

	@Override
	public List fetchQprPesaReportYearWiseNew(String statecode, String yearId, String UserType, String quarterId) {
		List  datalist=new LinkedList();
		try {
			 Map<String, Object> qParams = new HashMap<>();
		        qParams.put("quarterId", Integer.parseInt(quarterId));
		        qParams.put("stateCode", Integer.parseInt(statecode));
		        qParams.put("yearId", Integer.parseInt(yearId));
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
					 map.put("additional_requirement", String.valueOf( obj.getAdditionalRequirement()) );
					 datalist.add(map);
				 }
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return datalist;
	}

	@Override
	public List fetchQprIncomeEnhancementYearWiseNew(String statecode, String yearId, String UserType,
			String quarterId) {
		
		List  datalist=new LinkedList();
		try {
			StringBuilder query=new StringBuilder();
			query.append(" select id.activty_name as  name_of_activity,'RASHTRIYA GRAM SWARAJ YOJANA' as select_scheme ,di.district_name_english as district_name,b.block_name_english as block_name,"
					+ " id.total_no_of_gp_covered ,id.no_of_aspirational_gp,id.year_from,id.year_to,id.total_cost_of_project,COALESCE(id.funds_required,0) funds_proposed_in_current_year,id.brief_about_activity,ied.expenditure_incurred as funds_utilized,id.remarks from rgsa.income_enhancement_activity ia , rgsa.income_enhancement_details id, " 
					+ " rgsa.qpr_income_enhancement_details  ied , rgsa.qpr_income_enhancement qie , lgd.district di,lgd.block b  where ia.state_code = "+statecode+" and ia.year_id ="+yearId+" and ia.user_type ='"+UserType+"'"
					+ " and qie.qtr_id="+quarterId+"  and ia.income_enhancement_id = id.income_enhancement_id and ia.is_active = True  and id.is_active = True and id.income_enhancement_details_id = ied.income_enhancement_details_id and ied.qpr_income_enhancement_id = qie.qpr_income_enhancement_id  and di.district_code=id.district_code and id.block_code = b.block_code and di.isactive and b.isactive");
			 
			List list=dao.findAllByNativeQuery(query.toString(), null);
			if(list!=null && !list.isEmpty()) 
			{
				 for(Iterator itr=list.iterator(); itr.hasNext();)
				 {
					 Object []  obj=(Object [])itr.next();
					 Map <String,String> map=new LinkedHashMap<>();
					 map.put("activty_name", obj[0].toString()); 
					 map.put("select_scheme", obj[1].toString());
					 map.put("district_name_english", obj[2].toString());
					 map.put("block_name_english", obj[3].toString());
					 map.put("total_no_of_gp_covered", obj[4].toString());
					 map.put("no_of_aspirational_gp", obj[5].toString()); 
					 map.put("year_from", obj[6].toString());
					 map.put("year_to", obj[7].toString());
					 map.put("total_cost_of_project", obj[8].toString());
					 map.put("funds_required", obj[9].toString());
					 map.put("brief_about_activity", obj[10].toString());
					 map.put("remarks", obj[11].toString());
					 datalist.add(map);
				 }
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return datalist;
		
	}

	@Override
	public List fetchQprIECYearWiseNew(String statecode, String yearId, String UserType, String quarterId) {
		List  datalist=new LinkedList();
		try {
			StringBuilder query=new StringBuilder();
			query.append(" select (select string_agg(   iac.nature_iec_activity , ',' ) ase from rgsa.iec_details_dropdown idd ");
			query.append("  inner join rgsa.iec_activity_dropdown  iac on iac.iec_id=idd.iec_activity_dropdown_id ");
			query.append("  inner join  rgsa.iec_activity_details iec on iec.iec_activity_details_id=idd.iec_activity_details_id  ");
			query.append("  inner join rgsa.iec_activity  ia on iec.iec_activity_id=ia.id ");
			query.append(" where ia.state_code="+statecode+" and ia.user_type='"+UserType+"' and ia.year_id="+yearId+" and ia.is_active ) nature ");
			query.append(",COALESCE(iad.total_amount_proposed,0) amount_proposed , COALESCE(qid.expenditure_incurred,0) funds_utilized ,iad.remarks from rgsa.iec_activity ia  ");
			query.append(" inner join rgsa.iec_activity_details iad on iad.iec_activity_id=ia.id ");
			query.append(" inner join  rgsa.qpr_iec qi on qi.id=ia.id  ");
            query.append(" inner join rgsa.qpr_iec_details qid on qid.qpr_iec_id=qi.qpr_iec_id  where ia.state_code="+statecode+" and ia.user_type='"+UserType+"' and ia.year_id="+yearId+" and qi.qtr_id="+quarterId+" group by iad.total_amount_proposed,qid.expenditure_incurred ,iad.remarks ");

			List list=dao.findAllByNativeQuery(query.toString(), null);
			if(list!=null && !list.isEmpty()) {
				 for(Iterator itr=list.iterator(); itr.hasNext();)
				 {
					 Object []  obj=(Object [])itr.next();
					 Map <String,String> map=new LinkedHashMap<>();
					 map.put("nature_iec_activity", obj[0].toString()); 
					 map.put("total_amount_proposed", obj[1].toString());
					 map.put("expenditure_incurred", obj[2].toString());
					 if(obj[3]!=null) {
						 map.put("remarks", obj[3].toString());
							 }else {
								 map.put("remarks","");  
							 }
					 datalist.add(map);
				 }
			}
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return datalist;
	}

	@Override
	public List fetchQprPMUYearWiseNew(String statecode, String yearId, String UserType, String quarterId) {
List  datalist=new LinkedList();
		
		try {
			StringBuilder query=new StringBuilder();
	        query.append(" select pt.pmu_type_name, pat.pmu_activity_type_name ,COALESCE(pad.no_of_units,0) no_of_units ,COALESCE(pad.funds,0) funds ,COALESCE(qpd.expenditure_incurred,0) as funds_utilized ,pad.remarks  from rgsa.pmu_activity pa  ");
			query.append(" inner join rgsa.pmu_activity_details pad on pad.pmu_activity_id=pa.pmu_activity_id ");
			query.append("inner join rgsa.qpr_pmu qp on pa.pmu_activity_id=qp.pmu_activity_id  ");
			query.append("inner join rgsa.qpr_pmu_details qpd  on qpd.qpr_pmu_id=qp.qpr_pmu_id  ");
			query.append("inner join rgsa.pmu_activity_type pat on pat.pmu_activity_type_id = pad.pmu_activity_type_id   ");
			query.append("inner join rgsa.pmu_type pt on pt.pmu_type_id=pat.pmu_type_id ");
		   query.append(" where pa.state_code="+statecode+" and pa.user_type='"+UserType+"' and pa.year_id="+yearId+" and qp.qtr_id="+quarterId+" and pa.is_active  group by 1,2,3,4,5,6 order by 1,2 ");
			
			List qtlist=dao.findAllByNativeQuery(query.toString(), null);
			 int index2=0;
				  
					 for(Iterator qitr=qtlist.iterator(); qitr.hasNext();)
					 {
						 Object []  qb=(Object [])qitr.next();
						 index2++;
						
						 Map <String,String> map=new LinkedHashMap<>();
						  
						 map.put("pmu_type_name", qb[0].toString());
						 map.put("pmu_activity_type_name", qb[1].toString());
						 map.put("no_of_units", qb[2].toString());
						 map.put("funds", qb[3].toString());
						 map.put("expenditure_incurred", qb[4].toString());
						 if(qb[5]!=null) {
							 map.put("remarks", qb[5].toString());
								 }else {
									 map.put("remarks","");  
								 }
						 datalist.add(map);
						 break;
					  
				 }
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return datalist;
	}

	@Override
	public List fetchQprAdministrativeAndTechnicalSupportYearWiseNew(String statecode, String yearId, String UserType,
			String quarterId) {
		List  datalist=new LinkedList();
		try {
			StringBuilder query=new StringBuilder();
			query.append(" select atsd.post_id,ptm.post_type_name,   pt.post_name,  COALESCE(atsd.no_of_units,0) no_of_units, COALESCE(atsd.unit_cost,0) unit_cost  ,  COALESCE(atsd.funds,0) funds ");
			query.append(" from  rgsa.administrative_technical_support at right outer join rgsa.administrative_technical_support_details atsd  on at.administrative_technical_support_id=atsd.administrative_technical_support_id ");
			query.append("  inner join rgsa.post_type pt on pt.post_id=atsd.post_id ");
			query.append("  inner join rgsa.post_type_master ptm  on pt.post_type_id=ptm.post_type_id ");
			query.append(" where at.year_id="+yearId+"  and at.user_type='"+UserType+"'  and at.state_code="+statecode+"  and at.is_active=true ");
			 
			List list=dao.findAllByNativeQuery(query.toString(), null);
			
		    query=new StringBuilder();
			query.append("  select qad.post_id, COALESCE(qad.no_of_units_filled,0) no_of_units_filled , COALESCE(qad.expenditure_incurred,0) expenditure_incurred  , COALESCE(qa.additional_requirement,0 ) additional_requirement from rgsa.qpr_ats qa   ");
			query.append("  inner join rgsa.administrative_technical_support at  on qa.administrative_technical_support_id = at.administrative_technical_support_id ");
			query.append("  inner join rgsa.qpr_ats_details qad on qad.qpr_ats_id=qa.qpr_ats_id ");
			query.append(" where at.year_id="+yearId+"  and at.user_type='"+UserType+"'  and qtr_id="+quarterId+" and at.state_code="+statecode+"  and at.is_active=true ") ;
			
			List qprlist=dao.findAllByNativeQuery(query.toString(), null);
			
			if(list!=null && !list.isEmpty() && qprlist!=null && !qprlist.isEmpty()) {
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
							 map.put("funds", String.valueOf(obj[5]));
							 map.put("No_of_Units_Filled", String.valueOf(obj11[1]));
							 map.put("expenditure_incurred", String.valueOf(obj11[2]));
							 map.put("additional_requirement", obj11[3].toString());
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

	@Override
	public List fetchQprPanchayatBhawanYearWiseNew(String statecode, String yearId, String UserType, String quarterId) {
		List  datalist=new LinkedList();
		try {
			StringBuilder query=new StringBuilder();
			query.append(" select  cast(case when ga.activity_id < 4 then   CONCAT(ga.activity_name, ' ', '(New Building)')  else  CONCAT(ga.activity_name, ' ', '(Carry Forward)')  END as varchar)activities, no_of_gps, COALESCE(pad.aspirational_gps,0) no_of_aspirational_gps_selected,  COALESCE(pad.unit_cost,0) unit_cost, COALESCE(pad.funds,0) funds_approved, COALESCE(qpd.expenditure_incurred,0) funds_utilized , pad.remarks from rgsa.panhcayat_bhawan_activity pa  ");
			query.append(" inner join rgsa.panhcayat_bhawan_activity_details pad on pa.panhcayat_bhawan_activity_id = pad.panhcayat_bhawan_activity_id ");
			query.append(" inner join rgsa.qpr_panhcayat_bhawan qp on pa.panhcayat_bhawan_activity_id = qp.panhcayat_bhawan_activity_id  ");
			query.append(" inner join rgsa.qpr_panhcayat_bhawan_details qpd on qp.qpr_panhcayat_bhawan_id = qpd.qpr_panhcayat_bhawan_id   ");
			query.append(" left join rgsa.gps_activity ga on ga.activity_id = pad.activity_id  where pad.id = qpd.panhcayat_bhawan_activity_details_id and");
			query.append(" pa.user_type ='"+UserType+"' and  qp.qtr_id ="+quarterId+" and pa.state_code ="+statecode+" and pa.year_id = "+yearId+" and pa.is_active =True group by ga.activity_id , pad.no_of_gps ,pad.aspirational_gps ,pad.unit_cost, pad,funds,qpd.expenditure_incurred  ,pad.remarks  ");
			List list=dao.findAllByNativeQuery(query.toString(), null);
			if(list!=null && !list.isEmpty()) 
			{
				 for(Iterator itr=list.iterator(); itr.hasNext();)
				 {
					 Object []  obj=(Object [])itr.next();
					 Map <String,String> map=new LinkedHashMap<>();
					 map.put("activity_name", obj[0].toString()); 
					 map.put("no_of_gps", obj[1].toString());
					 map.put("no_of_aspirational_gps_selected", obj[2].toString());
					 map.put("unit_cost", obj[3].toString());
					 map.put("funds", obj[4].toString());
					 map.put("expenditure_incurred", obj[5].toString());
					 map.put("remarks", obj[6].toString());
					 datalist.add(map);
				 }
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return datalist;
	}

	@Override
	public List fetchQprSATCOMYearWiseNew(String statecode, String yearId, String UserType, String quarterId) {
		List  datalist=new LinkedList();
		try {
			StringBuilder query=new StringBuilder();
			query.append(" select  sl.satcom_level_name,sm.satcom_master_name,COALESCE(sad.no_of_units,0) no_of_units,COALESCE(sad.unit_cost,0) unit_cost,COALESCE(sad.funds,0) funds, COALESCE(sdp.no_of_units_completed,0) no_of_units_completed ,COALESCE(sdp.expenditure_incurred,0) expenditure_incurred ,COALESCE(sapr.additional_requirement,0) additional_requirement from rgsa.satcom_activity sa   ");
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
							 map.put("additional_requirement", String.valueOf(obj[8]));
							 datalist.add(map); 
				 }
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return datalist;
	}

	@Override
	public List fetchQprInstitutionalInfrastructureYearWiseNew(String statecode, String yearId, String UserType,
			String quarterId) {
		List  datalist=new LinkedList();
		try {
			StringBuilder query=new StringBuilder();
			query.append("  select  tit.training_institue_type_name,d.district_name_english,iss.inst_infra_status_name,idd.work_type,COALESCE(idd.fund_sanctioned,0) fund_sanctioned ,COALESCE(qd.expenditure_incurred,0) expenditure_incurred ,COALESCE(qi.additional_requirement,0) additional_requirement ,COALESCE(qi.additional_requirement_dprc,0) additional_requirement_dprc  \r\n" + 
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
							 if(obj[3]!=null) {
							 map.put("work_type", String.valueOf(obj[3]) );
							}else {
								 map.put("work_type","NA"  ); 
				 			}
							if (obj[2] != null) {
								map.put("inst_infra_status_name", String.valueOf(obj[2]));
							} else {
								map.put("inst_infra_status_name", "NA");
							}
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

	@Override
	public List fetchQprInnovativeActiveYearWiseNew(String statecode, String yearId, String UserType,
			String quarterId) {
		List  datalist=new LinkedList();
		try {
			StringBuilder query=new StringBuilder();
			query.append(" select ids.activity_name as name_of_activity,COALESCE(ids.funds_name,0) funds ,ids.about_activity as brief_about_activity,ids.year_from as from ,ids.year_to as to,COALESCE(qid.expenditure_incurred,0) funds_utilized from rgsa.innovative_activity i   ");
			query.append(" inner join rgsa.innovative_activity_details ids on ids.innovative_activity_id =i.innovative_activity_id  ");
			query.append(" inner join rgsa.qpr_ia qi on qi.innovative_activity_id=i.innovative_activity_id ");
			query.append(" inner join rgsa.qpr_ia_details qid on qid.qpr_ia_id=qi.qpr_ia_id   ");
			query.append(" where i.state_code="+statecode+" and i.year_id="+yearId+" and i.user_type='"+UserType+"' and qi.qtr_id="+quarterId+" and qi.is_freeze and i.is_active ");
			List  list=dao.findAllByNativeQuery(query.toString(), null);
			if(list!=null && !list.isEmpty()) {
				 for(Iterator itr=list.iterator(); itr.hasNext();)
				 {
					 Object []  obj=(Object [])itr.next();
						 
							 Map <String,String> map=new LinkedHashMap<>();
							 map.put("activity_name", String.valueOf(obj[0])); 
							 map.put("funds_name", String.valueOf(obj[1]));
							 map.put("about_activity", String.valueOf(obj[2]));
							 map.put("year_from", String.valueOf(obj[3]));
							 map.put("year_to", String.valueOf(obj[4]));
							 map.put("expenditure_incurred", String.valueOf(obj[5]));
							 
							 datalist.add(map); 
				 }
			}
			
		}catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return datalist;	
	}

	@Override
	public List fetchQpradminFinancialYearWiseNew(String statecode, String yearId, String UserType, String quarterId) {
		List  datalist=new LinkedList();
		int index1=0;
		try {
			StringBuilder query=new StringBuilder();
			query.append("  select pt.pmu_type_name,pa.pmu_activity_type_name,COALESCE(ad.no_of_staffs_proposed,0) no_of_staffs_proposed ,COALESCE(ad.unit_cost,0) unit_cost ,COALESCE(ad.funds,0) funds from  rgsa.pmu_type pt  ");
			query.append(" inner join rgsa.pmu_activity_type pa on pt.pmu_type_id = pa.pmu_type_id ");
			query.append(" inner join rgsa.admin_financial_data_cell_activity_details ad on pa.pmu_activity_type_id = ad.pmu_activity_type_id ");
			query.append(" inner join  rgsa.admin_financial_data_cell_activity aa on ad.admin_financial_data_cell_activity_id = aa.admin_financial_data_cell_activity_id ");
			query.append(" where  aa.state_code = "+statecode+" and aa.year_id = "+yearId+" and aa.user_type = '"+UserType+"'  and aa.is_active  order by ad.admin_financial_data_cell_activity_detail_id  ");
			List  list=dao.findAllByNativeQuery(query.toString(), null);
			
			query=new StringBuilder();
			query.append(" select COALESCE(qd.no_of_units_filled,0) no_of_units_filled ,COALESCE(qd.expenditure_incurred,0) expenditure_incurred ,COALESCE(qa.additional_requirement ,0) additional_requirement from rgsa.qpr_afp_details qd ");
			query.append(" inner join rgsa.qpr_afp qa on qa.qpr_afp_id = qd.qpr_afp_id ");
			query.append(" inner join rgsa.admin_financial_data_cell_activity aa on aa.admin_financial_data_cell_activity_id = qa.admin_financial_data_cell_activity_id ");
			query.append(" where aa.state_code = "+statecode+" and aa.year_id = "+yearId+" and aa.user_type = '"+UserType+"' and qa.qtr_id = "+quarterId+" and aa.is_active and qa.is_freeze = True order by qpr_afp_details_id ") ;
			
			List qprlist=dao.findAllByNativeQuery(query.toString(), null);

			
			if(list!=null && !list.isEmpty() && qprlist!=null && !qprlist.isEmpty()) {
				 for(Iterator itr=list.iterator(); itr.hasNext();)
				 {
					 Object []  obj=(Object [])itr.next();
					 	index1++;
						int index2=0;
					 for(Iterator qitr=qprlist.iterator(); qitr.hasNext();)
					 {
						 Object [] qob =(Object[]) qitr.next();
						 index2++;
						 if(index1==index2) {
								 Map <String,String> map=new LinkedHashMap<>();
								 map.put("center", String.valueOf(obj[0])); 
								 map.put("domain_experts", String.valueOf(obj[1]));
								 map.put("approved_no_of_staff", String.valueOf(obj[2]));
								 map.put("approved_unit_cost", String.valueOf(obj[3]));
								 map.put("fund", String.valueOf(obj[4]));
								 map.put("no_of_units_filled", String.valueOf(qob[0]));
								 map.put("expenditure_incurred", String.valueOf(qob[1]));
								 map.put("additional_requirement", String.valueOf(qob[2]));
								 datalist.add(map); 
								 break;
						 }
					 }
				 }
			}
		}catch(Exception ex)
		{
			ex.printStackTrace();
		}
		return datalist;
	}

	
	
	
	
	
	
	
}
