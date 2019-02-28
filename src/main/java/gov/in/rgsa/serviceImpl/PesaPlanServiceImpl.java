package gov.in.rgsa.serviceImpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.PesaPlan;
import gov.in.rgsa.entity.PesaPlanDetails;
import gov.in.rgsa.entity.PesaPost;
import gov.in.rgsa.service.FacadeService;
import gov.in.rgsa.service.PesaPlanService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
public class PesaPlanServiceImpl implements PesaPlanService {

	@PersistenceContext
	private EntityManager entityManager;
	
	@Autowired
	private CommonRepository commonRepository;
	
	@Autowired
	private UserPreference userPreference;
	

	@Autowired
	private FacadeService facadeService;
	

	@Override
	public List<PesaPlanDetails> fetchPesaDetails(Integer pesaPlanId) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pesaPlanId", pesaPlanId);
		List<PesaPlanDetails> PesaPlanDetails = commonRepository.findAll("FETCH_PESA_DETAILS",params);
		return PesaPlanDetails;
	}

	@Override
	public List<PesaPost> fetchPesaPost() {
		Query query = entityManager.createNamedQuery("FETCH_PESA_POST");
		List<PesaPost> pesaPosts = query.getResultList();
		return pesaPosts;
	}
	
	@Override
	public List<PesaPlan> fetchPesaPlan(final Character userType) {
		Map<String, Object> params = new HashMap<String, Object>();
		List<PesaPlan> pesaPlan = new ArrayList<PesaPlan>();
		params.put("yearId", userPreference.getFinYearId());
		params.put("stateCode", userPreference.getStateCode());
		if(userType == null){
			params.put("userType", userPreference.getUserType().charAt(0));
		}
		else{
			params.put("userType", userType);
		}
		pesaPlan = commonRepository.findAll("FETCH_PESA_PLAN",params);
		
		if (userPreference.getUserType().equalsIgnoreCase("M") && CollectionUtils.isEmpty(pesaPlan)) {
			params.put("userType", 'S');
			pesaPlan = commonRepository.findAll("FETCH_PESA_PLAN",params);
		}
		
		if (userPreference.getUserType().equalsIgnoreCase("C") && CollectionUtils.isEmpty(pesaPlan)) {
			params.put("userType", 'S');
			pesaPlan = commonRepository.findAll("FETCH_PESA_PLAN",params);
			pesaPlan.get(0).setIsFreez(false);
		}
		if (!CollectionUtils.isEmpty(pesaPlan)) {
			return pesaPlan;
		} else {
			return null;
		}	
		
	}
	
	@Override
	public void savePesaPlan(PesaPlan pesaPlan) {
		if(userPreference.getUserType().equalsIgnoreCase('s'+"")){
			savePesaPlanForState(pesaPlan);
		}else{
			if(pesaPlan.getUserType() == 'S'){
				savePesaPlanForMopr(pesaPlan);
			}else{
				commonRepository.update(pesaPlan);
				List<PesaPlanDetails> pesaPlanDetails = pesaPlan.getPesaPlanDetails();
				for (PesaPlanDetails planDetails : pesaPlanDetails) {
					planDetails.setPesaPlanId(pesaPlan.getPesaPlanId());
					commonRepository.update(planDetails);
				}
			}
		}
		
	}
	
	/*@Override
	public void savePesaPlanForCEC(final PesaPlan pesaPlan){
		savePesaPlanForState(pesaPlan);
	}*/
	
	private void savePesaPlanForMopr(PesaPlan pesaPlan){
		pesaPlan.setPesaPlanId(null);
		
		pesaPlan = setPesaPlanObject(pesaPlan);
		
		List<PesaPlanDetails> pesaPlanDetails = pesaPlan.getPesaPlanDetails();
		
		List<PesaPost> pesaPostList = fetchPesaPost();
		for (int i = 0; i < pesaPlanDetails.size(); i++) {
			if(pesaPlanDetails.get(i) != null) {
				pesaPlanDetails.get(i).setPesaPostId(pesaPostList.get(i).getPesaPostId());
			}
		}
		
		if(pesaPlan.getPesaPlanId() == null || pesaPlan.getPesaPlanId() == 0) {

			commonRepository.save(pesaPlan);
			
			for (PesaPlanDetails planDetails : pesaPlanDetails) {
				if(planDetails != null) {
					planDetails.setPesaPlanDetailsId(null);
					planDetails.setPesaPlanId(pesaPlan.getPesaPlanId());
					commonRepository.save(planDetails);
				}
			}
		}
	}
	
	private void savePesaPlanForState(PesaPlan pesaPlan){
		
		pesaPlan = setPesaPlanObject(pesaPlan);
		
		List<PesaPlanDetails> pesaPlanDetails = pesaPlan.getPesaPlanDetails();
		
		List<PesaPost> pesaPostList = fetchPesaPost();
		for (int i = 0; i < pesaPlanDetails.size(); i++) {
			if(pesaPlanDetails.get(i) != null) {
				pesaPlanDetails.get(i).setPesaPostId(pesaPostList.get(i).getPesaPostId());
			}
		}
		
		if(pesaPlan.getPesaPlanId() == null || pesaPlan.getPesaPlanId() == 0) {

			commonRepository.save(pesaPlan);
			
			for (PesaPlanDetails planDetails : pesaPlanDetails) {
				if(planDetails != null) {
					planDetails.setPesaPlanId(pesaPlan.getPesaPlanId());
					commonRepository.save(planDetails);
				}
			}
		}else{
			commonRepository.update(pesaPlan);
			for (PesaPlanDetails planDetails : pesaPlanDetails) {
				planDetails.setPesaPlanId(pesaPlan.getPesaPlanId());
				commonRepository.update(planDetails);
			}
		}
	}
	
	@Override
	public PesaPlan feezUnFreezPesaPlan(PesaPlan pesaPlan) {
		pesaPlan = setPesaPlanObject(pesaPlan);
		commonRepository.update(pesaPlan);
		if(pesaPlan.getIsFreez()) {
			facadeService.populateStateFunds("6");	
		}
		return pesaPlan;
	}
	
	private PesaPlan setPesaPlanObject(final PesaPlan pesaPlan) {
		Integer userId = userPreference.getUserId();
		Integer stateCode = userPreference.getStateCode();
		Integer yearId = userPreference.getFinYearId();
		pesaPlan.setCreatedBy(userId);
		pesaPlan.setLastUpdatedBy(userId);
		pesaPlan.setStateCode(stateCode);
		pesaPlan.setYearId(yearId);
		pesaPlan.setVersionNo(1);
		pesaPlan.setMenuId(userPreference.getMenuId());
		pesaPlan.setUserType(userPreference.getUserType().charAt(0));
		return pesaPlan;
	}
}
