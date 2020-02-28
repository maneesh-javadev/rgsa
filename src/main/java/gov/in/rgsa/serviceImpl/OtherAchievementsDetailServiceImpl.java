package gov.in.rgsa.serviceImpl;

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
import gov.in.rgsa.service.OtherAchievementsDetailService;

@Service
public class OtherAchievementsDetailServiceImpl implements OtherAchievementsDetailService
{

	@Autowired
	private CommonRepository commonRepository;

	
	
	public List<FinYear> fetchFinYearList()
	{
		return commonRepository.findAll("FETCH_ALL_FIN_YEAR", null);
	}

	public List<State> fetchStateList()
	{
		return commonRepository.findAll("GET_ALL_STATE_LIST", null);
	}

	public Object fetchfindQuaterList()
	{
		return commonRepository.findAll("GET_ALL_STATE_LIST", null);
	}

	public List<QuarterDuration> fetchQuarterList()
	{

		return commonRepository.findAll("FETCH_QUARTER_DURATION", null);
	}
	
	
	@Override
	public String basicOrientationTrainingofER(Integer trCategory)
	{

		String data = null;
		try
		{
			StringBuilder query = new StringBuilder();
			query.append(" select sum( COALESCE(qtb.sc_males,0)+COALESCE(qtb.sc_females,0)+COALESCE(qtb.st_males,0)+COALESCE(qtb.st_females,0)+COALESCE(qtb.others_males,0)+COALESCE(qtb.others_females,0) ) from rgsa.qpr_training_breakup qtb ");
			query.append(" inner join rgsa.qpr_trainings_details qtd on qtb.qpr_trainings_details_id=qtd.qpr_trainings_details_id");
			query.append(" inner join rgsa.training_wise_category twc on  qtd.training_activity_details_id=twc.training_id");
			query.append(" inner join rgsa.qpr_trainings qt on qt.qpr_trainings_id=qtd.qpr_trainings_id ");
			query.append(" where qt.is_freeze=true and twc.training_category_id=" + trCategory + " ");

			if (trCategory == 2 || trCategory == 3)
			{
				query.append(" and qtb.target_group_master_id in(1,3,5,14,16,40,41) ");
			}

			List<Object> list = commonRepository.findAllByNativeQuery(query.toString(), null);
			if (list.get(0) != null && !"null".equals(list.get(0)))
			{
				data = String.valueOf(list.get(0));
			} else
			{
				data = "0";
			}

		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return data;
	}

	public String enablementsOfPanchat(Integer levelId)
	{
		String data = null;
		try
		{
			StringBuilder query = new StringBuilder();
			query.append("SELECT  sum(COALESCE(qed.no_of_units_filled,0) )  FROM  rgsa.qpr_egov qe , rgsa.qpr_egov_details qed , rgsa.egov_post ep , rgsa.egov_post_level el ");
			query.append(" where  qe.qpr_egov_id = qed.qpr_egov_id and  qed.egov_post_id=ep.egov_post_id  and ep.egov_post_level_id = el.egov_post_level_id ");
			query.append(" and qe.is_freeze = True and ep.egov_post_level_id =  " + levelId);
			List<Object> list = commonRepository.findAllByNativeQuery(query.toString(), null);
			if (list.get(0) != null && !"null".equals(list.get(0)))
			{
				data = String.valueOf(list.get(0));
			} else
			{
				data = "0";
			}
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}
		return data;
	}

	public String enablementsOfPanchyatComputerization(Integer masterId)
	{

		String data = null;
		try
		{
			/*
			 * StringBuilder query = new StringBuilder(); query.
			 * append(" select sum(COALESCE(count_gp,0)) from (SELECT  count(qed.local_body_code )count_gp  from  rgsa.e_enablement_master em,rgsa.e_enablement_details ed,rgsa.qpr_e_enablement qe,rgsa.qpr_e_enablement_details qed "
			 * ); query.
			 * append(" where em.ee__master_id = ed.ee_master_id and ed.e_enablement_id = qe.e_enablement_id and qe.qpr_e_enablement_id = qed.qpr_e_enablement_id and qe.is_freez =  True and ed.ee_master_id = "
			 * + masterId + " )t; ");
			 */
			String query="select sum(COALESCE(count_gp,0)) from (SELECT  count(qed.local_body_code )count_gp  from  rgsa.e_enablement_master em,rgsa.e_enablement_details ed,rgsa.qpr_e_enablement qe,		rgsa.qpr_e_enablement_details qed  \r\n" + 
					"	    where qed.qpr_status=em.ee__master_id   and ed.e_enablement_id = qe.e_enablement_id and qe.qpr_e_enablement_id = qed.qpr_e_enablement_id and qe.is_freez =  True \r\n" + 
					"	    and ed.ee_master_id = "+masterId+ " )t;  ";
			List<Object> list = commonRepository.findAllByNativeQuery(query.toString(), null);
			if (list.get(0) != null && !"null".equals(list.get(0)))
			{
				data = String.valueOf(list.get(0));
			} else
			{
				data = "0";
			}
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}
		return data;
	}

	public String exposureVisit(Integer cbMasterId)
	{
		String data = null;
		try
		{
			StringBuilder query = new StringBuilder();
			query.append(" SELECT  sum(COALESCE(qcd.no_of_units_completed,0))  ");
			query.append(" from rgsa.qpr_cb_activity qc ,rgsa.qpr_cb_activity_details qcd, rgsa.cb_activity_details cad,rgsa.cb_master cm where qc.qpr_cb_activity_id = qcd.qpr_cb_activity_id and qcd.cb_activity_detail_id = cad.cb_activity_detail_id and cad.cb_master_id = cm.cb_master_id and cad.is_approved = True  ");
			query.append(" and cad.cb_master_id = " + cbMasterId);
			List<Object> list = commonRepository.findAllByNativeQuery(query.toString(), null);
			if (list.get(0) != null && !"null".equals(list.get(0)))
			{
				data = String.valueOf(list.get(0));
			} else
			{
				data = "0";
			}
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}
		return data;
	}

	public String supportForPanchayatAsset(String bhawanStatus, String activityId)
	{

		String data = null;
		try
		{
			StringBuilder query = new StringBuilder();
			query.append(" select sum(count_gp) from (select count(qpd.local_body_code)as count_gp  from  rgsa.qpr_panhcayat_bhawan qp ,rgsa.qpr_panhcayat_bhawan_details qpd , ");
			query.append(" rgsa.gp_bhawan_status qs where qp.qpr_panhcayat_bhawan_id = qpd.qpr_panhcayat_bhawan_id and qpd.gp_bhawan_status_id = qs.gp_bhawan_status_id and qp.is_freeze = True  ");
			query.append(" and  qs.gp_bhawan_status_id = " + bhawanStatus + " and qs.activity_id = " + activityId + ")t ");
			List<Object> list = commonRepository.findAllByNativeQuery(query.toString(), null);
			if (list.get(0) != null && !"null".equals(list.get(0)))
			{
				data = String.valueOf(list.get(0));
			} else
			{
				data = "0";
			}
		} catch (Exception ex)
		{
			ex.printStackTrace();
		}
		return data;
	}

	public String panchyatStakehlderTrained()
	{

		String data = null;
		try
		{
			StringBuilder query = new StringBuilder();
			query.append(" select sum( COALESCE(qtb.sc_males,0)+COALESCE(qtb.sc_females,0)+COALESCE(qtb.st_males,0)+COALESCE(qtb.st_females,0)+COALESCE(qtb.others_males,0)+COALESCE(qtb.others_females,0) ) from rgsa.qpr_training_breakup qtb ");
			query.append(" inner join rgsa.qpr_trainings_details qtd on qtb.qpr_trainings_details_id=qtd.qpr_trainings_details_id");
			query.append(" inner join rgsa.training_target_groups ttg  on  qtb.target_group_master_id=ttg.training_wise_target_group_id ");
			query.append(" inner join rgsa.qpr_trainings qt on qt.qpr_trainings_id=qtd.qpr_trainings_id ");
			query.append(" where qt.is_freeze=true and ttg.target_group_master_id in (7,8,9,10,11,12,13,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39) ");
			List<Object> list = commonRepository.findAllByNativeQuery(query.toString(), null);
			if (list.get(0) != null && !"null".equals(list.get(0)))
			{
				data = String.valueOf(list.get(0));
			} else
			{
				data = "0";
			}

		} catch (Exception e)
		{
			e.printStackTrace();
		} 

		return data;
	}

 
	public List fetchQprEenablementProgressReport() {
		List  datalist=new LinkedList();
		try {
			StringBuilder query=new StringBuilder();
 
			query.append(" SELECT  distinct s.state_name_english,count( lb.local_body_name_english),string_agg(  lb.local_body_name_english ,','),em.ee_name,fn.finyear    from  rgsa.qpr_e_enablement_status_master em,rgsa.e_enablement_details ed, \r\n" + 
					"rgsa.qpr_e_enablement qe, rgsa.qpr_e_enablement_details qed , lgd.localbody lb,lgd.state s,rgsa.e_enablement ee, rgsa.fin_Year fn \r\n" + 
					"where em.ee__master_id = qed.qpr_status and ed.e_enablement_id = qe.e_enablement_id and qe.qpr_e_enablement_id = qed.qpr_e_enablement_id  \r\n" + 
					"and lb.local_body_code=qed.local_body_code and s.state_code=ee.state_code and qe.e_enablement_id=ee.e_enablement_id   \r\n" + 
					"and fn.year_id=ee.year_id  and qe.is_freez =  True and qed.qpr_status = 1 and lb.isactive  and qe.is_freez group by s.state_name_english,em.ee_name,fn.finyear  order by s.state_name_english ");
			List list= commonRepository.findAllByNativeQuery(query.toString(), null);
			if(list!=null && !list.isEmpty()) {
				 for(Iterator itr=list.iterator(); itr.hasNext();)
				 {
					 Object []  obj=(Object [])itr.next();
					 Map <String,String> map=new LinkedHashMap<>();
					 map.put("State", obj[0].toString()); 
					 map.put("GP_Count", obj[1].toString());
					 map.put("GP_Name", obj[2].toString()); 
					 map.put("status", obj[3].toString());
					 map.put("finyear", obj[4].toString());
					 datalist.add(map);
				 }
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
			 
			return datalist;
	}
	
	
	public List fetchEspmu(String kpiName) {
		List  datalist=new LinkedList();
		try {
			StringBuilder query=new StringBuilder();
			String type = new String();
			if(("eSPMUId").equals(kpiName)) {
				 type= "1";
			}else if(("eDPMUId").equals(kpiName)) {
				 type= "2";
			}
			query.append("select * from rgsa.get_no_eSpmu(");
			query.append(type);
			query.append(");");
				List list=commonRepository.findAllByNativeQuery(query.toString(), null);
				if(list!=null && !list.isEmpty()) {
					 for(Iterator itr=list.iterator(); itr.hasNext();)
					 {
						 Object []  obj=(Object [])itr.next();
						 Map <String,String> map=new LinkedHashMap<>();
						 map.put("stateName", obj[0].toString()); 
						 map.put("NoOfUnit", obj[1].toString());
						 
						 map.put("NoOfUnitFilled", obj[2].toString());
						 map.put("FinYear", obj[3].toString());
						 
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
