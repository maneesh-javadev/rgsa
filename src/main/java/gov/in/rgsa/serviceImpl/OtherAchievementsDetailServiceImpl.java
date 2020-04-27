package gov.in.rgsa.serviceImpl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.dto.KpiReportDto;
import gov.in.rgsa.dto.KpiReportDtoContainer;
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
			query.append(" and qe.is_freeze = True and   qe.qtr_id=4 and  ep.egov_post_level_id =  " + levelId);
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
			
			  StringBuilder query = new StringBuilder();
			 if(3 == masterId) {
			 query.append(" select sum(COALESCE(count_gp,0)) from (SELECT  count(qed.local_body_code )count_gp  from  rgsa.e_enablement_master em,rgsa.e_enablement_details ed,rgsa.qpr_e_enablement qe,rgsa.qpr_e_enablement_details qed "
			  ); query.
			  append(" where em.ee__master_id = ed.ee_master_id and ed.e_enablement_id = qe.e_enablement_id and qe.qpr_e_enablement_id = qed.qpr_e_enablement_id and qe.is_freez =  True and ed.ee_master_id = "
			  + masterId + " )t; ");
				 
			 }else {
			 query. append("select sum(COALESCE(count_gp,0)) from (select  COALESCE( eed.no_of_units ,0) count_gp  from lgd.state s left join    rgsa.administrative_technical_support ee  on s.state_code = ee.state_code   inner join rgsa.administrative_technical_support_details eed   on ee.administrative_technical_support_id =eed.administrative_technical_support_id ,rgsa.qpr_ats_details qed inner join   rgsa.qpr_ats qe on   qe.qpr_ats_id  =qed.qpr_ats_id , rgsa.fin_year fy ,rgsa.qpr_quarter_detail qd where fy.year_id =ee.year_id  and  ee.user_type ='C'    and qe.is_freeze and  ee.administrative_technical_support_id = qe.administrative_technical_support_id and qe.qpr_ats_id = qed.qpr_ats_id and  qd.qtr_id =qe.qtr_id and qd.qtr_id =4 and eed.post_id=qed.post_id )t;");
			 
			 }
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
			query.append(" from rgsa.qpr_cb_activity qc ,rgsa.qpr_cb_activity_details qcd, rgsa.cb_activity_details cad,rgsa.cb_master cm where qc.qpr_cb_activity_id = qcd.qpr_cb_activity_id and qcd.cb_activity_detail_id = cad.cb_activity_detail_id and cad.cb_master_id = cm.cb_master_id and qc.is_freeze = True  ");
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
			query.append(" select sum(count_gp) from (select count(distinct qpd.local_body_code)as count_gp  from  rgsa.qpr_panhcayat_bhawan qp ,rgsa.qpr_panhcayat_bhawan_details qpd , ");
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
					"and fn.year_id=ee.year_id  and qe.is_freez =  True and qed.qpr_status = 3 and lb.isactive  and qe.is_freez group by s.state_name_english,em.ee_name,fn.finyear  order by s.state_name_english ");
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
	
	
	public List<KpiReportDtoContainer> fetchEspmu(String kpiName) {
		List<KpiReportDtoContainer> mapListOBJ = null;
		List<KpiReportDto> rpListDTOOBJ = null;
		int j = 0;
		try {
			StringBuilder query=new StringBuilder();
			String type = new String();
			query.append("select * from rgsa.get_no_eSpmu(");
			if(("eSPMUId").equals(kpiName)) {
			 query.append("1");
			}else if(("eDPMUId").equals(kpiName)) {
				query.append("2");
			}
			else if(("bhawanConst").equals(kpiName)) {
				query.append("3");
			}
			else if(("bhawanRepair").equals(kpiName)) {
				query.append("4");
			}
			else if(("bhawanColocate").equals(kpiName)) {
				query.append("5");
			}else if(("basicOrientationTrainErs").equals(kpiName)) {
				query.append("6");
			}else if(("refreshTrainErs").equals(kpiName)) { 
				query.append("7");
			}else if(("selfHelpGroup").equals(kpiName)) {
				query.append("8");
			}else if(("panchyatStakeholder").equals(kpiName)) {
				query.append("9");
			}
			else if(("technicalSupportGPs").equals(kpiName)) {
				query.append("10");
			}else if(("exposerVisitWithGPs").equals(kpiName)) {
				query.append("11");
			}else if(("exposerVisitWithoutGPs").equals(kpiName)) {
				query.append("12");
			}
			

			query.append(");");
			List<Object[]> dataListOBJ=commonRepository.findAllByNativeQuery(query.toString(), null);
			if(dataListOBJ!=null && !dataListOBJ.isEmpty()) {
				mapListOBJ = new ArrayList<>();
				for (int i = 0; i < dataListOBJ.size();) {
				Object[] obj = dataListOBJ.get(i);
				rpListDTOOBJ = new ArrayList<>();
				KpiReportDtoContainer containerOBJ = new KpiReportDtoContainer();
				KpiReportDto dtoOBJ = new KpiReportDto();
				boolean checkSameRp = true;
				Integer trgCount = new Integer(1);
				if ((Integer) obj[0] != null && !((Integer) obj[0]).toString().isEmpty()) {
					containerOBJ.setSlc((Integer) obj[0]);
					}
				if ((String) obj[1] != null && !((String) obj[1]).toString().isEmpty()) {
				containerOBJ.setStateName(((String) obj[1]));
				} else {
				containerOBJ.setStateName("");
				}
				if ((String) obj[2] != null && !((String) obj[2]).toString().isEmpty()) {
					containerOBJ.setNoOfPostApproved(((String) obj[2]));
				} else {
					containerOBJ.setNoOfPostApproved("");
				}
				if ((String) obj[5] != null && !((String) obj[5]).toString().isEmpty()) {
					containerOBJ.setFinYear((String) obj[5]);
				} else {
					containerOBJ.setFinYear("");
				}
				
				if(("bhawanConst").equals(kpiName) || ("bhawanRepair").equals(kpiName)  || ("bhawanColocate").equals(kpiName) ) {
					if ((String) obj[3] != null && !((String) obj[3]).toString().isEmpty()) {
						dtoOBJ.setNoOfUnitFilled((String) obj[3]);
					} else {
						dtoOBJ.setNoOfUnitFilled("");
					}
					if ((String) obj[6] != null && !((String) obj[6]).toString().isEmpty()) {
						dtoOBJ.setGp((String) obj[6]);
					} else {
						dtoOBJ.setGp("");
					}
					if ((String) obj[7] != null && !((String) obj[7]).toString().isEmpty()) {
						containerOBJ.setGpCount((String) obj[7]);
					} else {
						containerOBJ.setGpCount("");
					}
					if ((String) obj[8] != null && !((String) obj[8]).toString().isEmpty()) {
						dtoOBJ.setGpName((String) obj[8]);
					} else {
						dtoOBJ.setGpName("");
					}
					
				}else {
					if(("basicOrientationTrainErs").equals(kpiName) || ("selfHelpGroup").equals(kpiName) || ("refreshTrainErs").equals(kpiName) || ("panchyatStakeholder").equals(kpiName)) {
						if ((String) obj[6] != null && !((String) obj[6]).toString().isEmpty()) {
							dtoOBJ.setGp((String) obj[6]);
						} else {
							dtoOBJ.setGp("");
						}
						
							
					}
					if(("technicalSupportGPs").equals(kpiName)) {
						if ((String) obj[3] != null && !((String) obj[3]).toString().isEmpty()) {
							dtoOBJ.setNoOfUnitFilled((String) obj[3]);
						} else {
							dtoOBJ.setNoOfUnitFilled("");
						}
					}
					if ((String) obj[3] != null && !((String) obj[3]).toString().isEmpty()) {
						dtoOBJ.setNoOfUnitFilled((String) obj[3]);
					} else {
						dtoOBJ.setNoOfUnitFilled("");
					}
				}
				if ((String) obj[4] != null && !((String) obj[4]).toString().isEmpty()) {
					dtoOBJ.setQuater((String) obj[4]);
				} else {
					dtoOBJ.setQuater("");
				}
				if ((String) obj[5] != null && !((String) obj[5]).toString().isEmpty()) {
					dtoOBJ.setFinId((String) obj[5]);
				} else {
					dtoOBJ.setFinId("");
				}
				rpListDTOOBJ.add(dtoOBJ);
				for (j = i + 1; j < dataListOBJ.size() && checkSameRp; j++) {
					Object[] isSameRPOBJ = dataListOBJ.get(j);
					if (containerOBJ.getSlc().intValue() == (((Integer) isSameRPOBJ[0]).intValue())  && (containerOBJ.getFinYear()).equals(((String) isSameRPOBJ[5]))) {
						KpiReportDto dtoRPOBJ = new KpiReportDto();
						
						if(("bhawanConst").equals(kpiName) || ("bhawanRepair").equals(kpiName)  || ("bhawanColocate").equals(kpiName) ) {
							if ((String) obj[6] != null && !((String) obj[6]).toString().isEmpty()) {
								dtoRPOBJ.setGp((String) isSameRPOBJ[6]);
							} else {
								dtoRPOBJ.setGp("");
							}
							if ((String) obj[3] != null && !((String) obj[3]).toString().isEmpty()) {
								dtoRPOBJ.setNoOfUnitFilled((String) isSameRPOBJ[3]);
							} else {
								dtoRPOBJ.setNoOfUnitFilled("");
							}
							if ((String) obj[8] != null && !((String) obj[8]).toString().isEmpty()) {
								dtoRPOBJ.setGpName((String) isSameRPOBJ[8]);
							} else {
								dtoRPOBJ.setGpName("");
							}
							}else {
								if(("basicOrientationTrainErs").equals(kpiName) || ("selfHelpGroup").equals(kpiName) || ("refreshTrainErs").equals(kpiName) || ("panchyatStakeholder").equals(kpiName)) {
									
								
									if ((String) isSameRPOBJ[6] != null && !((String) isSameRPOBJ[6]).toString().isEmpty()) {
										dtoRPOBJ.setGp((String) isSameRPOBJ[6]);
									} else {
										dtoRPOBJ.setGp("");
									}
									}
								if(("technicalSupportGPs").equals(kpiName)) {
									if ((String) obj[3] != null && !((String) obj[3]).toString().isEmpty()) {
										dtoRPOBJ.setNoOfUnitFilled((String) isSameRPOBJ[3]);
									} else {
										dtoRPOBJ.setNoOfUnitFilled("");
									}
								}
								
								if ((String) isSameRPOBJ[3] != null && !((String) isSameRPOBJ[3]).toString().isEmpty()) {
									dtoRPOBJ.setNoOfUnitFilled((String) isSameRPOBJ[3]);
									} else {
										dtoRPOBJ.setNoOfUnitFilled("");
									}
									
							}
						if ((String) obj[4] != null && !((String) obj[4]).toString().isEmpty()) {
							dtoRPOBJ.setQuater((String) isSameRPOBJ[4]);
						} else {
							dtoRPOBJ.setQuater("");
						}
						if ((String) obj[5] != null && !((String) obj[5]).toString().isEmpty()) {
							dtoRPOBJ.setFinId((String) isSameRPOBJ[5]);
						} else {
							dtoRPOBJ.setFinId("");
						}
						trgCount++;
						rpListDTOOBJ.add(dtoRPOBJ);
					} else {
					checkSameRp = false;
				}
				}
				containerOBJ.setQdurCount(trgCount);
				containerOBJ.setKpiReportDto(rpListDTOOBJ);
				mapListOBJ.add(containerOBJ);
				rpListDTOOBJ = null;
				// setting outer loop from the last scanned position
				// If last index remained unmatched
				if (j == dataListOBJ.size() && !checkSameRp) {
				i = j - 1;
				}
				// If last index remained matched
				else if (j == dataListOBJ.size() && checkSameRp) {
				i = j;
				} // otherwise
				else {
				i = j - 1;
				}
				}
			}
	

				
				
			if(mapListOBJ != null) {
				for (int k = 0; k < mapListOBJ.size()-1; k++)
				{
					Collections.sort( (List<KpiReportDto>) mapListOBJ.get(k).getKpiReportDto());
						if(mapListOBJ.get(k).getSlc()== mapListOBJ.get(k+1).getSlc()) {
							mapListOBJ.get(k+1).setStateName(null);
						}
				}
				for (int k = 0; k < mapListOBJ.size(); k++)
				{
					Collections.sort( (List<KpiReportDto>) mapListOBJ.get(k).getKpiReportDto());
				}
			}
			
	
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return mapListOBJ;
	}
		  
	public List fetchbasicOrientationById(String id ,String kpiname) {
		List  datalist=new LinkedList();
		String tgMasterId=new String();
		try {
			 if("basicOrientationTrainErs".equalsIgnoreCase(kpiname.trim())) {
				 tgMasterId ="1,3,5,14,16,40,41 ";
			}else if("refreshTrainErs".equalsIgnoreCase(kpiname.trim())) { 
				tgMasterId="1,3,5,14,16,40,41";
			}else if("panchyatStakeholder".equalsIgnoreCase(kpiname.trim())) {
				tgMasterId="7,8,9,10,11,12,13,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39";
			}
			StringBuilder query=new StringBuilder();
			
			query.append("(with gp_data as( select tgm.target_group_master_name, sum(cast(COALESCE(qtb.sc_males ,0) as integer)) as sc_maless , \r\n" + 
					"							sum(cast(COALESCE(qtb.sc_females,0)as integer)) as sc_femaless, sum(cast(COALESCE(qtb.st_males,0)as integer)) as st_maless, \r\n" + 
					"							sum(cast(COALESCE(qtb.st_females,0)as integer)) as st_femaless ,  sum(cast(COALESCE(qtb.others_males, 0)as integer)) as others_maless , \r\n" + 
					"							sum(cast(COALESCE(qtb.others_females,0) as integer)) as others_femaless  from rgsa.qpr_training_breakup qtb \r\n" + 
					"										inner join rgsa.qpr_trainings_details qtd on qtb.qpr_trainings_details_id=qtd.qpr_trainings_details_id\r\n" + 
					"										inner join rgsa.training_target_groups ttg  on  qtb.target_group_master_id=ttg.training_wise_target_group_id \r\n" + 
					"										inner join rgsa.qpr_trainings qt on qt.qpr_trainings_id=qtd.qpr_trainings_id ,rgsa.target_group_master tgm  \r\n" + 
					"										where qt.is_freeze=true and qtb.qpr_trainings_details_id in (" + id +") and  qtb.target_group_master_id = tgm.target_group_master_id \r\n" + 
							"									");
			if(!("selfHelpGroup").equals(kpiname.trim())) {
			query.append(" and  qtb.target_group_master_id  in  (" +tgMasterId + ") ");
			}
			query.append( "group by target_group_master_name order by target_group_master_name ) select * from gp_data  where \r\n" + 
					"							 (cast(sc_maless as integer) + cast(sc_femaless as integer) + cast(st_maless as integer) + cast(st_femaless as integer ) + \r\n" + 
					"							 cast(others_maless as integer) + cast(others_femaless as integer) ) >0 )  " );
					
					List list= commonRepository.findAllByNativeQuery(query.toString(), null);
			if(list!=null && !list.isEmpty()) {
				 for(Iterator itr=list.iterator(); itr.hasNext();)
				 {
					 Object []  obj=(Object [])itr.next();
					 Map <String,String> map=new LinkedHashMap<>();
					 map.put("Er", obj[0].toString()); 
					 map.put("sc_maless", obj[1].toString()); 
					 map.put("sc_femaless", obj[2].toString());
					 map.put("st_maless", obj[3].toString()); 
					 map.put("st_femaless", obj[4].toString());
					 map.put("others_maless", obj[5].toString());
					 map.put("others_femaless", obj[6].toString());
					 datalist.add(map);
				 }
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
			 
			return datalist;
	}
	
}
