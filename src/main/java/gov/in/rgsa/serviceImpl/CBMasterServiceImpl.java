package gov.in.rgsa.serviceImpl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.CBMaster;
import gov.in.rgsa.service.CBMasterService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
public class CBMasterServiceImpl implements CBMasterService{
	
	@Autowired
	private CommonRepository commonRepository;
	
	@Autowired
	UserPreference userPreference;
	
	@PersistenceContext
	private EntityManager entityManager;

	@Override
	public List<CBMaster> fetchCBMasters() {
		return commonRepository.findAll("FETCH_CB_MASTERS", null);
	}

	
}
