package gov.in.rgsa.serviceImpl;

import java.util.HashMap;
import java.util.Map;

import org.apache.catalina.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.Users;
import gov.in.rgsa.model.ChangePasswordModel;
import gov.in.rgsa.service.ChangePasswordService;
import gov.in.rgsa.user.preference.UserPreference;

@Service
public class ChangePasswordServiceImpl implements ChangePasswordService {

	@Autowired
	private CommonRepository dao;
	
	@Autowired
	private UserPreference userPreference;

	@Override
	public String changePassword(ChangePasswordModel model) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userPreference.getUserId());
		Users user= (Users) dao.find("FETCH_USER_CREDENTAILS", params);
		if(user.getUserPassword().equals(model.getOldPassword())) {
			params.put("password", model.getConfirmPassword());
			int updateValue=dao.excuteUpdate("CHANGE_PASSWORD_BY_USER_ID", params);
			if(updateValue > 0) {
				return "updated";
			}else {
				return "error";
			}
		}else {
			return "passwordNotMatch";
		}
	}

}
