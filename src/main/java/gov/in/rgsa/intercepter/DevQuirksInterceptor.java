package gov.in.rgsa.intercepter;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.Users;
import gov.in.rgsa.model.FacadeModel;
import gov.in.rgsa.service.BasicInfoService;
import gov.in.rgsa.service.FacadeService;
import gov.in.rgsa.user.preference.UserPreference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class DevQuirksInterceptor extends HandlerInterceptorAdapter {

    static Logger logger = LoggerFactory.getLogger(DevQuirksInterceptor.class);

    @Value("${rgsa.dev.user.auto_inject:false}")
    private Boolean devUserAutoInject;

    @Value("${rgsa.dev.user.username:null}")
    String injectedUser;

    @Autowired
    private UserPreference userPreference;

    @Autowired
    private CommonRepository commonRepository;

    @Autowired
    private FacadeService facadeService;

    @Autowired
    BasicInfoService basicInfoService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if(!devUserAutoInject || injectedUser == null)
            return true;
        if( userPreference == null )
            userPreference = new UserPreference();
        if(userPreference.getUserId() == null) {
            String hitAt = request.getRequestURI();
            if(hitAt.endsWith("logout.html") || hitAt.endsWith("login.html")) {
                logger.info("Skipping user injection for path: " + hitAt);
                return true;
            }
            letUserLogin();
            checkFillBasicInfo();
        } else {
            logger.info(String.format("UserPreference => Type: %s, Id: %s, Year: %s", userPreference.getUserType(), userPreference.getUserId(), userPreference.getFinYear()) );
        }
        return true;

    }

    private void letUserLogin(){
        logger.info("User  is null, need to set something here.");
        Map<String, Object> userMap = new HashMap<>(2);
        userMap.put("userName", injectedUser);
        Users user = commonRepository.find(Users.class, userMap);
        FacadeModel facadeModel = new FacadeModel();
        facadeModel.setLoginId(user.getUserName());
        facadeModel.setPassword(user.getPassword());
        UserPreference facadeServiceUser =facadeService.findUser(facadeModel);
        setPreference(facadeServiceUser);
        logger.info("Using account: " + userPreference.getUserName());
    }

    private void checkFillBasicInfo(){
        switch (basicInfoService.fillFirstBasicInfo()){
            case "create":
                logger.info("Automatically filling basic info....");
                // basicInfoService.save(fillBasicInfo());
                break;
            default:
                break;
        }
    }


    private void setPreference(UserPreference passedUserPreference) {
    	userPreference.setIsNodalFilled(true);
        userPreference.setUserId(passedUserPreference.getUserId());
        userPreference.setUserName(passedUserPreference.getUserName());
        userPreference.setFinYear(passedUserPreference.getFinYear());
        userPreference.setUserType(passedUserPreference.getUserType());
        userPreference.setStateCode(passedUserPreference.getStateCode());
        userPreference.setDistrictcode(passedUserPreference.getDistrictcode());
        userPreference.setMenus(passedUserPreference.getMenus());
        userPreference.setFinYearId(passedUserPreference.getFinYearId());
        userPreference.setFinYear(passedUserPreference.getFinYear());
        userPreference.setActivityPlanStatus(passedUserPreference.getActivityPlanStatus());
        userPreference.setPlanComponents((passedUserPreference.getPlanComponents()));

        userPreference.setPlanCode(passedUserPreference.getPlanCode());
        userPreference.setPlanStatus(passedUserPreference.getPlanStatus());
        userPreference.setPlanVersion(passedUserPreference.getPlanVersion());

        userPreference.setStatePlanComponentsFunds(passedUserPreference.getStatePlanComponentsFunds());
        userPreference.setPlansAreFreezed(passedUserPreference.isPlansAreFreezed());
        userPreference.setCountPlanSubmittedByState(passedUserPreference.getCountPlanSubmittedByState());
        userPreference.setCountPlanSubmittedByMOPR(passedUserPreference.getCountPlanSubmittedByMOPR());
    }
}
