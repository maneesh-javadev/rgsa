package gov.in.rgsa.serviceImpl;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import gov.in.rgsa.entity.State;
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
	private CommonRepository commonRepository;
	
	@Autowired
	private UserPreference user;

	@Override
	public List<FinYear> findAllFinYear() {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("active", true);

		return commonRepository.findAll("FIND_ALL_FIN_YEARS", params);
	}

	@Override
	public FinYear findFinYearById(Integer finYearId) {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("yearId", finYearId);

		return commonRepository.find("FIND_ALL_FIN_YEAR_BY_ID", params);
	}

	@Override
	public FinYear findActiveFinYear() {

		return commonRepository.find("FIND_ACTIVE_FIN_YEAR", null);
	}

	@Override
	public List<MenuProfile> findMenuByParentId(Integer parentId) {

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("parentId", parentId);
		param.put("active",true);

		return commonRepository.findAll("FIND_MENU_PARENT_ID", param);
	}

	@Override
	public List<State> getStateListApprovedByCEC(Integer yearId) {
		Map<String, Object> params=new HashMap<>();
		params.put("yearId", yearId);
		return commonRepository.findAll("CEC_APPROVED_STATE",params);
	}

	@Override
	public Map<Integer, String> getYearMap() {
		Map<Integer, String> yearMap = new HashMap<>();
		yearMap.put(0, " --- Select --- ");
		for (FinYear finYear : commonRepository.findAll(FinYear.class)) {
			yearMap.put(finYear.getYearId(), finYear.getFinYear());
		}
		return yearMap;
	}

	@Override
	public Long saveErrorLog(RuntimeException err,HttpServletRequest request) {
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
		commonRepository.save(errorLog);
		return errorLog.getErrorLogId();
	}

}
