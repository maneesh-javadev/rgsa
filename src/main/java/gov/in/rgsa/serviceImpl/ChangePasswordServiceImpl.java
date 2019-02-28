package gov.in.rgsa.serviceImpl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.model.ChangePasswordModel;
import gov.in.rgsa.service.ChangePasswordService;

@Service
public class ChangePasswordServiceImpl implements ChangePasswordService {

	@Autowired
	private CommonRepository dao;

	@Override
	public void changePassword(ChangePasswordModel model) {

		
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("password", model.getConfirmPassword());
		params.put("userId", model.getUserId());
		dao.excuteUpdate("CHANGE_PASSWORD_BY_USER_ID", params);

	}

}
