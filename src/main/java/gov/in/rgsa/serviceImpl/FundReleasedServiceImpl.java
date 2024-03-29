package gov.in.rgsa.serviceImpl;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.tiles.request.collection.CollectionUtil;
import org.hibernate.mapping.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.FileNode;
import gov.in.rgsa.entity.FundReleased;
import gov.in.rgsa.entity.FundReleasedDetails;
import gov.in.rgsa.entity.Plan;
import gov.in.rgsa.entity.ReleaseIntallment;
import gov.in.rgsa.service.FundReleasedService;
import gov.in.rgsa.service.MOPRService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
public class FundReleasedServiceImpl implements FundReleasedService {

	@Autowired
	private CommonRepository commonRepository;
	
	@Autowired
	private  MOPRService moprService;
	
	@Autowired
	private UserPreference userPreference;
	
	@Override
	public ReleaseIntallment validateReleaseInstallment(Integer stateCode, Integer finYearId) {
		java.util.Map<String, Object> params=new HashMap<String, Object>();
		params.put("stateCode" , stateCode);
		params.put("yearId" , finYearId);
		params.put("planStatusId", 5);
		List<Plan> planList = commonRepository.findAll("CURRENT_PLAN_STATUS",params);
		List<ReleaseIntallment> releaseInstallment=moprService.fetchReleaseIntallment(planList.get(0).getPlanCode(), 1);
		if(!releaseInstallment.isEmpty()) {
			return releaseInstallment.get(0);
		}else {
			return null;
		}
	}
	
	@Override
	public FileNode loadFileNode(Integer fileNodeId) {
		return commonRepository.find(FileNode.class, fileNodeId);
	}

	@Override
	public void save(FundReleased fundReleased) {
		fundReleased.setCreatedBy(userPreference.getUserId());
		fundReleased.setLastUpdatedBy(userPreference.getUserId());
		fundReleased.getFundReleasedDetails().forEach(obj ->{
			 Date originalDate = null;
			  DateFormat date = new SimpleDateFormat("dd-MM-yyyy");
			  try {
				  if(obj.getDemoDate() != null)
					 originalDate = date.parse(obj.getDemoDate());
				} catch (ParseException e) {
					e.printStackTrace();
				}
			  obj.setCentralShareDate(originalDate);
			obj.setFundReleased(fundReleased);
		});
		if(fundReleased.getFundReleasedId() == null) {
			commonRepository.save(fundReleased);
		}else {
			commonRepository.update(fundReleased);
		}
		
	}

	@Override
	public FundReleased fetchData(Integer planCode) {
		java.util.Map<String , Object> map=new HashMap<String , Object>();
		map.put("planCode",planCode);
		List<FundReleased> returnedList =commonRepository.findAll("FETCH_FUND_RELEASE_DATA", map);
		if(returnedList.isEmpty()) {
			return null;
		}else {
			return returnedList.get(0);
		}
	}

	@Override
	public FundReleasedDetails fetchFundReleasedDetailByInstallmentNo(Integer installmentNo) {
		java.util.Map<String , Object> map=new HashMap<String , Object>();
		map.put("installmentNo", installmentNo);
		map.put("planCode", userPreference.getPlanCode());
		List<FundReleasedDetails> details = commonRepository.findAll("FETCH_DETAIL_BY_INSTALLMENT_NO", map);
		if(details.isEmpty()) {
			return new FundReleasedDetails();
		}else {
			return details.get(0);
		}
	}

}
