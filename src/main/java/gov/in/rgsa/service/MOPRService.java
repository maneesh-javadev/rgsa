package gov.in.rgsa.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import gov.in.rgsa.dto.KpiWebServiceDTO;
import gov.in.rgsa.entity.KpiWebService;
import gov.in.rgsa.entity.ReleaseIntallment;
import gov.in.rgsa.entity.SanctionOrderCompomentAmount;
import gov.in.rgsa.entity.SanctionOrderComponent;
import gov.in.rgsa.entity.State;
import gov.in.rgsa.model.Response;
import gov.in.rgsa.model.SnactionOrderModel;


public interface MOPRService {
	
	public List<State> getStateListApprovedbyCEC(Integer yearId);
	public List<SanctionOrderComponent> fetchAllSanctionOrderComponent();
	public String saveAttachment( MultipartFile mFile, String uploadLocation) ;
	public Boolean saveSanctionOrderDetails(SnactionOrderModel snactionOrderModel);
	public List<SanctionOrderCompomentAmount>  fetchAllSanctionOrderCompomentAmount(Integer planCode ,Integer installmentNo);
	public SnactionOrderModel fetchSanctionOrderData(Integer planCode,Integer installmentNo);
	public List<ReleaseIntallment> fetchReleaseIntallment(Integer planCode,Integer installmentNo);
	 List<Object[]> getTableColumnDetails(String tableName);
	 List<Object[]> getTableDataDetail(String queryName);
	 Integer fetchUpdateTableQuery(String queryName);
	 List<KpiWebServiceDTO> fetchKpisRecord(Integer yr,Integer installmentNo);

}
