package gov.in.rgsa.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.FinYear;
import gov.in.rgsa.service.ViewReportAtMoprService;

@Service
public class ViewReportAtMoprServiceImpl implements ViewReportAtMoprService {

	@Autowired
	private CommonRepository dao;
	
	@Override
	public List<FinYear> getFinYearList() {
		return dao.findAll("FETCH_ALL_FIN_YEARS", null);
	}

}
