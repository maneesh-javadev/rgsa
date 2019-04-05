package gov.in.rgsa.schedular;

import java.io.File;
import java.io.FileWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.ResourceBundle;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.servlet.ServletContext;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.Gson;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.StatewiseEntitiesCount;
import gov.in.rgsa.service.FileUploadService;




@EnableScheduling
public class RGSAJsonFileShedularImpl implements RGSAJsonFileShedular {
	
	private static final Logger log = Logger.getLogger(RGSAJsonFileShedularImpl.class);
	
	@Autowired
	private FileUploadService fileUploadService;
	
	@Autowired
	ServletContext servletContext;

	@PersistenceContext
	private EntityManager entityManager;

	private static final String FILE_LOCATION = ResourceBundle.getBundle("application").getString("homepage.json.data.file").trim();
	
	//private static final String EMAIL_IDS = ResourceBundle.getBundle("application").getString("lgd.json.scheduler.mailids").trim();
	
	
	@Scheduled(cron ="${json.file.scheduler.cron.time}")
	@Override
	public void processSchedular() {
		try{
		
			DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			Date d=new Date();
			log.info("RGSA entity detail scheduler start at-"+dateFormat.format(d));
			
				 File dir = new File(FILE_LOCATION);
				 if(!dir.exists()){
				    	dir.mkdirs();
				}
				 setHomePageEntitiesCount(dir.getAbsolutePath());
			
		}catch(Exception e){
			schedulerNotify(e);
			log.error("Exception while executing RGSA json scheduler-->",e);
		}
		
	}


public void setHomePageEntitiesCount(String fullpath)throws Exception{
	    File file=new File(fullpath + File.separator +"rgsa_entity_count.json");  
		 if(file.exists()){
			 List<StatewiseEntitiesCount> lgdEntitiesCount =fileUploadService.rgsaEntitiesCountFn(Boolean.TRUE);
			 if(lgdEntitiesCount!=null && !lgdEntitiesCount.isEmpty()){
				 FileWriter fileWriter = new FileWriter(file);  
				 Gson gson = new Gson();
				 gson.toJson(lgdEntitiesCount.get(0), fileWriter);
				
	            fileWriter.flush();  
	            fileWriter.close(); 
			}
		}
}

public void setStatewiseEntitiesCount(String fullpath)throws Exception{
	 File file=new File(fullpath + File.separator +"rgsa_statewise_entities_count.json"); 
	  if(file.exists()){
			 List<StatewiseEntitiesCount> lgdEntitiesCount =fileUploadService.rgsaEntitiesCountFn(Boolean.FALSE);
			 if(lgdEntitiesCount!=null && !lgdEntitiesCount.isEmpty()){
				 FileWriter fileWriter = new FileWriter(file);  
				 Gson gson = new Gson();
				 gson.toJson(lgdEntitiesCount, fileWriter);
				/* for(StatewiseEntitiesCount statewiseEntitiesCount:lgdEntitiesCount){
				 gson.toJson(statewiseEntitiesCount, fileWriter);
				 }*/
	            fileWriter.flush();  
	            fileWriter.close(); 
			}
		}
}

	public void schedulerNotify(Exception errorObj) {
		/*try {
			Date d = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
			String strDate = formatter.format(d);
			String title = "Exception while executing LGD Json Scheduler on " + strDate;
			MailService mailService = new MailService();
			StringBuilder mailDescription = new StringBuilder();
			mailDescription.append("<h1>" + title + "</h1><br>");
			mailDescription.append(errorObj.getMessage());
			mailService.sendMail(EMAIL_IDS, title, mailDescription.toString());
		} catch (Exception e) {
			log.info("mail server not present in this server", e);
		}*/
	}
	
	@Scheduled(cron ="${scheduler.cron.time.dashboard_updater}")	
    public boolean runDashboardUpdater() {
    	String[] functionNames = {
    			"rgsa.populate_dashboard_basic_info",
    			// "rgsa.populate_dashboard_cb_activity",
    			"rgsa.populate_dashboard_e_enablement",
    			"rgsa.populate_dashboard_institutional_infra_activity",
    			"rgsa.populate_dashboard_pesa_plan",
    			"rgsa.populate_dashboard_iec_activity"
    			};
    	boolean allGood = true;
    	for (String functionName : functionNames) {
    		String queryString = String.format("SELECT 0 FROM %s();", functionName);
    		boolean result = executeDashFun(queryString);
    		allGood &= result;
    	}
    	return allGood;
    }
	
	@Transactional
	protected boolean executeDashFun(String queryString) {
		try {
			entityManager.createNativeQuery(queryString).getSingleResult();
		} 
		catch(NoResultException noResultException) {
			// All ok
			log.info(queryString + " executed successfully");
			return true;
		}
		catch (Exception exception) {
			this.schedulerNotify(exception);
			log.error("Exception while executing RGSA json scheduler--> ",exception);
			return false;
		}
		return true;
	} 
	
}
	

