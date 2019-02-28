package gov.in.rgsa.service;

import java.util.List;

import gov.in.rgsa.entity.FinYear;
import gov.in.rgsa.entity.MenuProfile;

public interface CommonService {

	public List<FinYear> findAllFinYear();

	public FinYear findFinYearById(Integer finYearId);
	public FinYear findActiveFinYear();
	public List<MenuProfile> findMenuByParentId(Integer parentId);
}
