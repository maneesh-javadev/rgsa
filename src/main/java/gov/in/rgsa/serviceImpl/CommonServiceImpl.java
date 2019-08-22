package gov.in.rgsa.serviceImpl;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.ErrorLog;
import gov.in.rgsa.entity.FinYear;
import gov.in.rgsa.entity.MenuProfile;
import gov.in.rgsa.service.CommonService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
public class CommonServiceImpl implements CommonService {

	@Autowired
	private CommonRepository dao;
	
	@Autowired
	private UserPreference user;

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

	@Override
	public List<ErrorLog> saveErrorLog(RuntimeException err,HttpServletRequest request) {
		ErrorLog errorLog = new ErrorLog();
		errorLog.setStateCode(user.getStateCode());
		errorLog.setUserId(user.getUserId());
		errorLog.setIpAddress(request.getRemoteAddr());
		errorLog.setRequestUri(request.getRequestURI());
		errorLog.setRequestUrl(String.valueOf(request.getRequestURL()));
		errorLog.setMethodType(request.getMethod());
		StringWriter errors = new StringWriter();
		err.printStackTrace(new PrintWriter(errors));
		String error = errors.toString();
		errorLog.setErrorDescription(error);
		dao.save(errorLog);
		return null;
	}

}
