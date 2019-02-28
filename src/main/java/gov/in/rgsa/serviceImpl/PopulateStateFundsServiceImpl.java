/*
 * package gov.in.rgsa.serviceImpl;
 * 
 * import java.util.HashMap; import java.util.List; import java.util.Map;
 * 
 * import org.apache.commons.collections.CollectionUtils; import
 * org.springframework.beans.factory.annotation.Autowired; import
 * org.springframework.stereotype.Service;
 * 
 * import gov.in.rgsa.dao.CommonRepository; import gov.in.rgsa.entity.Plan;
 * import gov.in.rgsa.service.PopulateStateFundsService; import
 * gov.in.rgsa.user.preference.UserPreference;
 * 
 * @Service public class PopulateStateFundsServiceImpl implements
 * PopulateStateFundsService{
 * 
 * @Autowired private CommonRepository commonRepository;
 * 
 * 
 * @Autowired private UserPreference userPreference;
 * 
 * @Override public Boolean handelDataForMOPR(){ Map<String, Object> parameter =
 * new HashMap<String, Object>(); parameter.put("subcomponentId",2);
 * parameter.put("stateCode", userPreference.getStateCode());
 * parameter.put("yearId", userPreference.getFinYearId()); List<Plan>
 * planForwardedByState=commonRepository.findAll("PLAN_STATUS", parameter);
 * if(!CollectionUtils.isEmpty(planForwardedByState)) {
 * 
 * 
 * 
 * }
 */