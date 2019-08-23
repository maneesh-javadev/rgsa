package gov.in.rgsa.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import gov.in.rgsa.entity.ErrorLog;
import gov.in.rgsa.entity.FinYear;
import gov.in.rgsa.entity.MenuProfile;

public interface CommonService {

	public List<FinYear> findAllFinYear();
	public Long saveErrorLog(RuntimeException err ,HttpServletRequest request);
	public FinYear findFinYearById(Integer finYearId);
	public FinYear findActiveFinYear();
	public List<MenuProfile> findMenuByParentId(Integer parentId);
}
