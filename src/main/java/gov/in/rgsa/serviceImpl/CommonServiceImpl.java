package gov.in.rgsa.serviceImpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.FinYear;
import gov.in.rgsa.entity.MenuProfile;
import gov.in.rgsa.service.CommonService;

@Service
public class CommonServiceImpl implements CommonService {

	@Autowired
	private CommonRepository dao;

	@Override
	public List<FinYear> findAllFinYear() {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("active", true);

		return dao.findAll("FIND_ALL_FIN_YEARS", params);
	}

	@Override
	public FinYear findFinYearById(Integer finYearId) {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("yearId", finYearId);

		return dao.find("FIND_ALL_FIN_YEAR_BY_ID", params);
	}

	@Override
	public FinYear findActiveFinYear() {

		return dao.find("FIND_ACTIVE_FIN_YEAR", null);
	}

	@Override
	public List<MenuProfile> findMenuByParentId(Integer parentId) {

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("parentId", parentId);
		param.put("active",true);

		return dao.findAll("FIND_MENU_PARENT_ID", param);
	}

}
