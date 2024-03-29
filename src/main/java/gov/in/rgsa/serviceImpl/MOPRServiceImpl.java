package gov.in.rgsa.serviceImpl;

import java.io.File;
import java.io.FileOutputStream;
import java.math.BigInteger;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.dto.KpiWebServiceDTO;
import gov.in.rgsa.entity.KpiWebService;
import gov.in.rgsa.entity.Plan;
import gov.in.rgsa.entity.ReleaseIntallment;
import gov.in.rgsa.entity.SanctionOrder;
import gov.in.rgsa.entity.SanctionOrderCompomentAmount;
import gov.in.rgsa.entity.SanctionOrderComponent;
import gov.in.rgsa.entity.State;
import gov.in.rgsa.model.Response;
import gov.in.rgsa.model.SnactionOrderModel;
import gov.in.rgsa.service.MOPRService;


@Service
public class MOPRServiceImpl implements MOPRService {
	
	@Autowired
	private CommonRepository commonRepository;
	
	
	
	@Override
	public List<State> getStateListApprovedbyCEC(Integer yearId) {
		List<State> stateList=null;
		Map<String, Object> params=new HashMap<>();
		params.put("yearId", yearId);
		stateList = commonRepository.findAll("CEC_APPROVED_STATE",params);
		 return stateList;
	}
	
	@Override
	public List<SanctionOrderComponent> fetchAllSanctionOrderComponent() {
		List<SanctionOrderComponent> sanctionOrderComponentList=null;
		sanctionOrderComponentList = commonRepository.findAll("FIND_ALL_SANCTION_ORDER_COMPONENT",null);
		 return sanctionOrderComponentList;
	}
	
	@Override
	public String saveAttachment( MultipartFile mFile, String uploadLocation)  {
		String fileName="";
	    boolean isSaveFile=true; 
	    DateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		Date date = new Date();
		String fileNameArr[]=mFile.getOriginalFilename().split("\\.");
		fileName=fileNameArr[0]+ dateFormat.format(date)+"."+fileNameArr[1];
		String filePath = uploadLocation + File.separator +fileName;
	      
	      File dir = new File(uploadLocation);
	      if (!dir.exists()) {
	        dir.mkdir();
	        try {
	          FileOutputStream fos = new FileOutputStream(filePath);
	          fos.write(mFile.getBytes(), 0, (int)mFile.getSize());
	          fos.flush();
	          fos.close();
	        } catch (Exception e) {
	        	isSaveFile=false;
	        }
	      }
	      else {
	        try {
	          FileOutputStream fos = new FileOutputStream(filePath);
	          fos.write(mFile.getBytes(), 0, (int)mFile.getSize());
	          fos.flush();
	          fos.close();
	        } catch (Exception e) {
	        	isSaveFile=false;
	        }
	      }
	    
		if(isSaveFile) {
			return	fileName+"@Sucess";
		}else {
			return fileName+"@Unsucess";
		}
	    
	  }
	
	
	@Override
	public List<SanctionOrderCompomentAmount>  fetchAllSanctionOrderCompomentAmount(Integer planCode ,Integer installmentNo){
		Map<String, Object> params=new HashMap<>();
		params.put("planCode", planCode);
		params.put("installmentNo", installmentNo);		
		List<SanctionOrderCompomentAmount> soCompomentAmountList = null;
		
				soCompomentAmountList=	commonRepository.findAll("alreadySanctionComponentAmount",params);
				if(soCompomentAmountList.size()==0) {
				soCompomentAmountList=	commonRepository.findAll("soComponentAmount",null);
				}
		
				return soCompomentAmountList;
	}
	
	
	
	
	
	public Boolean saveSanctionOrderDetails(SnactionOrderModel snactionOrderModel) {
		Response response1=new Response();
		Boolean flag =false;
		try {
		Map<String, Object> params=new HashMap<>();
		params.put("yearId", snactionOrderModel.getYearId());
		params.put("planCode", snactionOrderModel.getPlanCode());
		params.put("planStatusId", 5);
		List<Plan> planList = commonRepository.findAll("CURRENT_PLAN_STATUS_BY_PLANCODE",params);
		 
		if(planList!=null && !planList.isEmpty()) {
			 
			Plan plan=planList.get(0);
			params=new HashMap<>();
			DateFormat formater = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date d = formater.parse(snactionOrderModel.getSactionDate());
			java.sql.Date sd = new java.sql.Date(d.getTime());
			Double statusCentralShare=releaseShareCalculation(plan.getCentralShare());
			Double statusStateShare=releaseShareCalculation(plan.getStateShare());
			
			
			Integer releaseIntallmentSno=snactionOrderModel.getReleaseIntallmentSno();
			
			ReleaseIntallment releaseIntallment=new ReleaseIntallment();
			if(releaseIntallmentSno!=null){
				releaseIntallment.setReleaseIntallmentSno(releaseIntallmentSno);
			}
			releaseIntallment.setPlanCode(plan.getPlanCode());
			releaseIntallment.setInstallmentNo(snactionOrderModel.getInstallmentNo());
			releaseIntallment.setStatusCentralShare(statusCentralShare);
			releaseIntallment.setStatusStateShare(statusStateShare);
			releaseIntallment.setReleaseDate(sd);
			if(snactionOrderModel.getOrigin().equalsIgnoreCase("freeze")) {
				releaseIntallment.setStatus(true);
			}else {
			releaseIntallment.setStatus(false);
			}
			if(releaseIntallmentSno!=null){
				commonRepository.update(releaseIntallment);
			}else
			{
				commonRepository.save(releaseIntallment);
			}
			releaseIntallmentSno=releaseIntallment.getReleaseIntallmentSno();
			
			for(SanctionOrderCompomentAmount obj: snactionOrderModel.getSanctionOrderCompomentAmountList())
			{
				SanctionOrder sanctionOrder=new SanctionOrder();
				if(obj.getSanctionOrderSno()!=null){
					sanctionOrder.setSanctionOrderSno(obj.getSanctionOrderSno());
				}
				sanctionOrder.setReleaseIntallmentSno(releaseIntallmentSno);
				sanctionOrder.setSoComponentId(obj.getComponentId());
				sanctionOrder.setFilePath(obj.getFilePath());
				sanctionOrder.setAmountUnderComponent(obj.getComponentAmount());
				sanctionOrder.setPlanCode(plan.getPlanCode());
				sanctionOrder.setInstallmentNo(snactionOrderModel.getInstallmentNo());
				if(obj.getSanctionOrderSno()!=null){
					commonRepository.update(sanctionOrder);
				}else{
					commonRepository.save(sanctionOrder);
				}
				
				
			}
			
			flag =true;
			
		}/*else {
			response1.setResponseMessage("Saction Order Plan not ready");
			response1.setResponseCode(500);
		}*/
		}catch(Exception e) {
			e.printStackTrace();
			response1.setResponseMessage(e.getMessage());
			response1.setResponseCode(500);
		}
		return flag;
	}
	
	private Double releaseShareCalculation(Double totalEntityShare) {
		return (totalEntityShare/2);
	}
	
	@Override
	public SnactionOrderModel fetchSanctionOrderData(Integer planCode,Integer installmentNo) {
		
		 SnactionOrderModel snactionOrderModel=new SnactionOrderModel();
		try {
		
		List<ReleaseIntallment> releaseIntallmentList = this.fetchReleaseIntallment(planCode, installmentNo);
		
		if(releaseIntallmentList!=null && !releaseIntallmentList.isEmpty()) {
			
			ReleaseIntallment releaseIntallment=releaseIntallmentList.get(0);
			Integer releaseIntallmentSno=releaseIntallment.getReleaseIntallmentSno();
			Map<String, Object> params=new HashMap<>();
			 params=new HashMap<>();
			 params.put("releaseIntallmentSno",releaseIntallmentSno);
			 List<SanctionOrder> sanctionOrderList = commonRepository.findAll("FETCH_SanctionOrder_LIST",params);
			
			 snactionOrderModel.setReleaseIntallment(releaseIntallment);
			 snactionOrderModel.setSanctionOrderList(sanctionOrderList);
		}
		
		}catch(Exception e) {
			e.printStackTrace();
		}
		return snactionOrderModel;

	}
	
	@Override
	public List<ReleaseIntallment> fetchReleaseIntallment(Integer planCode,Integer installmentNo){
		Map<String, Object> params=new HashMap<>();
		params.put("planCode",planCode);
		params.put("installmentNo",installmentNo);
		List<ReleaseIntallment> releaseIntallmentList = commonRepository.findAll("FETCH_ReleaseIntallment_DATA",params);
		return releaseIntallmentList;
	}
	
	@Override
	public List<Object[]> getTableColumnDetails(String tableName) {
		
		List<Object[]> tableColumnDetList = null;
		
			Map<String, Object> params=new HashMap<>();
			if(tableName.length()>0 && tableName.indexOf("(")>-1 && tableName.indexOf(")")>-1) {
				tableName=tableName.substring(0, tableName.indexOf("("));
				tableName=tableName.replaceAll("rgsa.", "");
				params.put("tableName", tableName);
				String rowDataStr = commonRepository.findByNativeQuery("\r\n" + 
						"SELECT  substring((replace(cast(( proargnames) as varchar),'\\\\\\\"','')),2,length(cast(proargnames as varchar) )-2)  from pg_proc where proname ilike :tableName limit 1", params);
				params=new HashMap<>();
				params.put("rowDataStr", rowDataStr);
				tableColumnDetList=commonRepository.findAllByNativeQuery("SELECT  unnest(string_to_array(:rowDataStr,',')) ",params);
			}else {
				tableName=tableName.replaceAll("rgsa.", "");
				params.put("tableName", tableName);
				tableColumnDetList = commonRepository.findAllByNativeQuery("SELECT column_name||' '||data_type FROM information_schema.columns WHERE table_schema = 'rgsa' "
						+ " AND table_name   = :tableName", params);
		}
	return tableColumnDetList;
	}
	
	@Override
	public List<Object[]> getTableDataDetail(String queryName){
		List<Object[]> tableColumnDetList = commonRepository.findAllByNativeQuery(queryName, null);
		return tableColumnDetList;
	}
	
	@Override
	public Integer fetchUpdateTableQuery(String queryName){
		 commonRepository.excuteUpdateNativeQuery(queryName, null);
		return 0;
	}
	
	@Override
	public List<KpiWebServiceDTO> fetchKpisRecord(Integer yr,Integer installmentNo){
		Map<String, Object> params=new HashMap<>();
		params.put("yr",yr);
		List<KpiWebServiceDTO> kpiWebServiceList=null;
		if(installmentNo==1)
		{
		kpiWebServiceList = commonRepository.findAll("FETCH_KPI_RECORD_YEARWISE",params);
		}
		else if(installmentNo==2)
		{
		kpiWebServiceList = commonRepository.findAll("FETCH_KPI_RECORD_INSTALLMENTWISE",params);
		}
		return kpiWebServiceList;
	}

}
