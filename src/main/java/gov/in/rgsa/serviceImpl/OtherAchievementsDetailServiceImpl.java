package gov.in.rgsa.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.service.OtherAchievementsDetailService;


@Service
public class OtherAchievementsDetailServiceImpl implements OtherAchievementsDetailService {

	 @Autowired
	    private
	    CommonRepository commonRepository;
	
	@Override
	public String basicOrientationTrainingofER(Integer trCategory) {
		 
		// List<DataRender> list =null;
		 String data=null;
		try {
		   StringBuilder  query=new StringBuilder();
		   query.append(" select sum(qtb.sc_males+qtb.sc_females+qtb.st_males+qtb.st_females+qtb.others_males+qtb.others_females ) from rgsa.qpr_training_breakup qtb ");
		   query.append(" inner join rgsa.qpr_trainings_details qtd on qtb.qpr_trainings_details_id=qtd.qpr_trainings_details_id");
		   query.append(" inner join rgsa.training_wise_category twc on  qtd.training_activity_details_id=twc.training_id"	   );
		   query.append(" inner join rgsa.qpr_trainings qt on qt.qpr_trainings_id=qtd.qpr_trainings_id ");
		   query.append(" where qt.is_freeze=true and twc.training_category_id="+trCategory+" ");
		   
		   if(trCategory==2 && trCategory==3) {
			   query.append(" and qtb.target_group_master_id in(1,3,5,14,16,40,41) ");
		   }
		   
		   
		
		  List<Object> list= commonRepository.findAllByNativeQuery(query.toString(), null);
		  if( list.get(0)!=null && !"null".equals(list.get(0)) )
		  {
			  data= String.valueOf(list.get(0));
		  }else {
			  data="0";
		  }
		  
		 
			 
		}catch(Exception e) {e.printStackTrace(); }
		
		return data;
	}

	 

}
