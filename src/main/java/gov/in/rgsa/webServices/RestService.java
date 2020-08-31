package gov.in.rgsa.webServices;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;

import org.apache.commons.codec.binary.Base64;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;

import gov.in.rgsa.dto.ERRepresentativeHundredDayProg;
import gov.in.rgsa.dto.ERRepresentativeHundredDayProgLastWeekWise;
import gov.in.rgsa.dto.ERRepresentativeHundredDayProgStateWise;
import gov.in.rgsa.dto.HundredDaysWebServiceDTO;
import gov.in.rgsa.dto.KpiWebServiceParam;
import gov.in.rgsa.dto.KpiWebServiceRecord;
import gov.in.rgsa.dto.OomsWebService;
import gov.in.rgsa.dto.StatewiseNoOfParticipants;
import gov.in.rgsa.dto.WebServiceOoms;
import gov.in.rgsa.entity.AttachmentMaster;
import gov.in.rgsa.entity.CapacityBuildingErForOoms;
import gov.in.rgsa.entity.FetchPlanStatusCount;
import gov.in.rgsa.entity.KpiWebService;
import gov.in.rgsa.service.InnovativeActivityService;

@CrossOrigin(origins = { "*" }, allowedHeaders = { "*" })
@RestController
public class RestService {
	@Autowired
	private WebserviceService webserviceService;
	
	@Autowired
	private InnovativeActivityService innovativeActivityService;
	
	public static final Integer DARPAN_KEY_FILE_LOC_ID =3;

	@GetMapping({ "/webService/noOfParticipantsAllIndia/{finYear}" })
	public Integer noOfParticipantsAllIndia(@PathVariable final String finYear, final HttpServletResponse response,
			final HttpServletRequest request) {
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Headers", request.getHeader("Access-Control-Request-Headers"));
		response.setHeader("Access-Control-Allow-Methods", request.getHeader("Access-Control-Request-Method"));
		return this.webserviceService.fetchNoOfParticipantsIndia(finYear);
	}

	@GetMapping({ "/webService/fetchHundredDayWSData/{fieldType}" })
	public List<HundredDaysWebServiceDTO> fetchHundredDayWSData(@PathVariable final String fieldType,
			final HttpServletResponse response, final HttpServletRequest request) {
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Headers", request.getHeader("Access-Control-Request-Headers"));
		response.setHeader("Access-Control-Allow-Methods", request.getHeader("Access-Control-Request-Method"));
		return (List<HundredDaysWebServiceDTO>) this.webserviceService.fetchHundredDayWSData(fieldType);
	}

	@GetMapping({ "/webService/noOfParticipantsStatewise/{finYear}" })
	public List<StatewiseNoOfParticipants> noOfParticipantsStatewise(@PathVariable final String finYear,
			final HttpServletResponse response, final HttpServletRequest request) {
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Headers", request.getHeader("Access-Control-Request-Headers"));
		response.setHeader("Access-Control-Allow-Methods", request.getHeader("Access-Control-Request-Method"));
		return (List<StatewiseNoOfParticipants>) this.webserviceService.fetchNoOfParticipantsStateWise(finYear);
	}

	@GetMapping({ "/webService/totalERRepresentativeDetails/{finYear}" })
	public List<ERRepresentativeHundredDayProg> totalERRepresentativeDetails(@PathVariable final String finYear,
			final HttpServletResponse response, final HttpServletRequest request) {  
		
		
		
		  
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Headers", request.getHeader("Access-Control-Request-Headers"));
		response.setHeader("Access-Control-Allow-Methods", request.getHeader("Access-Control-Request-Method"));
		return (List<ERRepresentativeHundredDayProg>) this.webserviceService
				.fetchERRepresentativeHundredDayProg(finYear, (String) null, (String) null);
	}

	@GetMapping({ "/webService/totalERRepresentativeDetailsDateWise/{stDate}/{endDate}" })
	public List<ERRepresentativeHundredDayProg> totalERRepresentativeDetailsDateWise(@PathVariable final String stDate,
			@PathVariable final String endDate, final HttpServletResponse response, final HttpServletRequest request) {  
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Headers", request.getHeader("Access-Control-Request-Headers"));
		response.setHeader("Access-Control-Allow-Methods", request.getHeader("Access-Control-Request-Method"));
		return (List<ERRepresentativeHundredDayProg>) this.webserviceService
				.fetchERRepresentativeHundredDayProg((String) null, stDate, endDate);
	}

	@GetMapping({ "/webService/totalERRepresentativeDetailsStateWise/{stDate}/{endDate}" })
	public List<ERRepresentativeHundredDayProgStateWise> totalERRepresentativeDetailsStateWise(
			@PathVariable final String stDate, @PathVariable final String endDate, final HttpServletResponse response,
			final HttpServletRequest request) {
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Headers", request.getHeader("Access-Control-Request-Headers"));
		response.setHeader("Access-Control-Allow-Methods", request.getHeader("Access-Control-Request-Method"));
		return (List<ERRepresentativeHundredDayProgStateWise>) this.webserviceService
				.fetchERRepresentativeHundredDayProgStateWise((String) null, stDate, endDate);
	}

	@GetMapping({ "/webService/totalERRepresentativeDetailsLastWeekWise" })
	public List<ERRepresentativeHundredDayProgLastWeekWise> totalERRepresentativeDetailsLastWeekWise(
			final HttpServletResponse response, final HttpServletRequest request) {
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Headers", request.getHeader("Access-Control-Request-Headers"));
		response.setHeader("Access-Control-Allow-Methods", request.getHeader("Access-Control-Request-Method"));
		final List<ERRepresentativeHundredDayProgLastWeekWise> list = (List<ERRepresentativeHundredDayProgLastWeekWise>) this.webserviceService
				.fetchERRepresentativeHundredDayProgLASTWEEKWISE();
		int total = 0;
		for (final ERRepresentativeHundredDayProgLastWeekWise detail : list) {
			if (detail.getTotalERTrained() != 0) {
				total = detail.getTotalERTrained();
			}
			if (detail.getTotalERTrained() == 0) {
				detail.setTotalERTrained(Integer.valueOf(total));
			}
		}
		return list;
	}

	@GET
	@Path("/TESTHI")
	@Produces({ "application/xml" })
	public Response getTotalSubmittedPlans(@Context final ServletContext servletContext) {
		final Response response = null;
		final ApplicationContext ctx = (ApplicationContext) WebApplicationContextUtils
				.getWebApplicationContext(servletContext);
		this.webserviceService = (WebserviceService) ctx.getBean((Class) WebserviceService.class);
		final StringBuilder sw = new StringBuilder("<xml>\n<status>HI HOW R U\n");
		sw.append("\n</status>\n</xml>");
		return response;
	}

	@GET
	@Path("/totalNumberOfSubmittedStatePlans")
	@Produces({ "application/xml" })
	public Response getTotalSubmittedPlans(@Context final ServletContext servletContext,
			@QueryParam("finYear") final String finYear) throws Exception {
		Response response = null;
		try {
			System.out.println("1");
			if (finYear != null) {
				final ApplicationContext ctx = (ApplicationContext) WebApplicationContextUtils
						.getWebApplicationContext(servletContext);
				this.webserviceService = (WebserviceService) ctx.getBean((Class) WebserviceService.class);
				System.out.println("2");
				final FetchPlanStatusCount fetchPlanStatusCount = this.webserviceService
						.fetchPlanSubmitedAndApproved(finYear);
				final StringBuilder sw = new StringBuilder("<xml>\n<status>\n");
				if (fetchPlanStatusCount != null) {
					sw.append("States submitted RGSA plans-:" + fetchPlanStatusCount.getPlanSumitCount()).append(";");
					sw.append("Plans approved-:" + fetchPlanStatusCount.getPlanApprovedCount()).append(";");
					sw.append("Meetings of CEC held year-wise-:" + fetchPlanStatusCount.getCecMettingCount())
							.append(";");
					sw.append("\n</status>\n</xml>");
					response = Response.ok().type("application/xml").entity((Object) sw.toString().getBytes("UTF-8"))
							.build();
				} else {
					response = Response.serverError()
							.entity((Object) "No plan is submitted or approved in this particular fin year.").build();
				}
			} else {
				response = Response.serverError().entity((Object) "No input parameter").build();
			}
		} catch (Exception e) {
			final StringBuilder sw2 = new StringBuilder("<xml>\n<error>\n");
			sw2.append(e);
			sw2.append("\n</error>\n</xml>");
			response = Response.serverError().type("application/xml").entity((Object) sw2.toString().getBytes("UTF-8"))
					.build();
			e.printStackTrace();
		}
		return response;
	}

	@PostMapping({ "/webService/noOfCapacityBuilding" })
	@Produces({ "application/json" })
	public String getTotalSubmittedPlan(@QueryParam("finYear") final String finYear,
			@RequestParam("frequencyCode") final String freqCode,
			@RequestParam("measurementAreaCode") final String measureAreaCode,
			@RequestParam("indicatorCode") final String indicatorCode,
			@RequestParam("schemeCode") final String schemeCode) throws JsonProcessingException {
		List<CapacityBuildingErForOoms> capacityBuildingErForOomsList = null;
		final String type = "CB";
		String capacityBuildingList = null;
		if ("FR01".equals(freqCode) && !"".equals(freqCode) && "AR002".equals(measureAreaCode)
				&& !"".equals(measureAreaCode) && "PR01".equals(indicatorCode) && !"".equals(indicatorCode)
				&& "PR1624".equals(schemeCode) && !"".equals(schemeCode) && finYear != null && !"".equals(finYear)) {
			capacityBuildingErForOomsList = (List<CapacityBuildingErForOoms>) this.webserviceService
					.fetchCapacityBuildingErForOoms(finYear, "CB");
			capacityBuildingErForOomsList.stream().forEach(u -> {
				u.setValue(u.getFieldGenricName());
				u.setFieldGenricName((String) null);
				return;
			});
			final ObjectMapper mapper = new ObjectMapper();
			mapper.enable(SerializationFeature.INDENT_OUTPUT);
			capacityBuildingList = mapper.writeValueAsString((Object) capacityBuildingErForOomsList);
		}
		return capacityBuildingList;
	}

	@PostMapping({ "/webService/noOfTraining" })
	@Produces({ "application/json" })
	public String noOfTraining(@QueryParam("finYear") final String finYear,
			@RequestParam("frequencyCode") final String freqCode,
			@RequestParam("measurementAreaCode") final String measureAreaCode,
			@RequestParam("indicatorCode") final String indicatorCode,
			@RequestParam("schemeCode") final String schemeCode) throws JsonProcessingException {
		List<CapacityBuildingErForOoms> capacityBuildingErForOomsList = null;
		final String type = "NT";
		String capacityBuildingList = null;
		if ("FR01".equals(freqCode) && !"".equals(freqCode) && "AR002".equals(measureAreaCode)
				&& !"".equals(measureAreaCode) && "PR02".equals(indicatorCode) && !"".equals(indicatorCode)
				&& "PR1624".equals(schemeCode) && !"".equals(schemeCode) && finYear != null && !"".equals(finYear)) {
			capacityBuildingErForOomsList = (List<CapacityBuildingErForOoms>) this.webserviceService
					.fetchCapacityBuildingErForOoms(finYear, "NT");
			capacityBuildingErForOomsList.stream().forEach(u -> {
				u.setNoOfTraining(u.getFieldGenricName());
				u.setFieldGenricName((String) null);
				return;
			});
			final ObjectMapper mapper = new ObjectMapper();
			mapper.enable(SerializationFeature.INDENT_OUTPUT);
			capacityBuildingList = mapper.writeValueAsString((Object) capacityBuildingErForOomsList);
		}
		return capacityBuildingList;
	}

	@PostMapping({ "/webService/noOfExposureView" })
	@Produces({ "application/json" })
	public OomsWebService noOfExposureView(@RequestBody final WebServiceOoms capacityBuildingErForOoms, @RequestHeader("username") final String username, @RequestHeader("password") final String password
			)
			throws JsonProcessingException {
		List<CapacityBuildingErForOoms> capacityBuildingErForOomsList = null;
		final OomsWebService oomsWebService = new OomsWebService();
		final String type = "EV";
		if ("RGSA_NITIAYOG".equals(username) && "NITIAYOG@123456".equals(password)) {
			oomsWebService.setStatus(Boolean.valueOf(true));
			oomsWebService.setStatuscode(Integer.valueOf(1));
			if ("FR01".equals(capacityBuildingErForOoms.getFrequencyCode())
					&& !"".equals(capacityBuildingErForOoms.getFrequencyCode())
					&& "AR002".equals(capacityBuildingErForOoms.getMeasurementAreaCode())
					&& !"".equals(capacityBuildingErForOoms.getMeasurementAreaCode())
					&& "PR04".equals(capacityBuildingErForOoms.getIndicatorCode())
					&& !"".equals(capacityBuildingErForOoms.getIndicatorCode())
					&& "PR1624".equals(capacityBuildingErForOoms.getSchemeCode())
					&& !"".equals(capacityBuildingErForOoms.getSchemeCode())
					&& capacityBuildingErForOoms.getYear() != null && !"".equals(capacityBuildingErForOoms.getYear())) {
				capacityBuildingErForOomsList = (List<CapacityBuildingErForOoms>) this.webserviceService
						.fetchCapacityBuildingErForOoms(capacityBuildingErForOoms.getYear(), "EV");
				capacityBuildingErForOomsList.stream().forEach(u -> {
					u.setValue(u.getFieldGenricName());
					u.setFieldGenricName((String) null);
					u.setMeasurementAreaCode(capacityBuildingErForOoms.getMeasurementAreaCode());
					u.setSchemeCode(capacityBuildingErForOoms.getSchemeCode());
					u.setYear(capacityBuildingErForOoms.getYear());
					u.setIndicatorCode(capacityBuildingErForOoms.getIndicatorCode());
					u.setFrequencyCode(capacityBuildingErForOoms.getFrequencyCode());
					u.setDistrictCode("N/A");
					u.setMeasurementFreqCode("FR01_001");
					return;
				});
				oomsWebService.setValue((List) capacityBuildingErForOomsList);
			}
		} else {
			oomsWebService.setStatus(Boolean.valueOf(false));
			oomsWebService.setStatuscode(Integer.valueOf(0));
			oomsWebService.setValue((List) null);
		}
		return oomsWebService;
	}

	@PostMapping({ "/webService/noOfGpBuildingSupport" })
	@Produces({ "application/json" })
	public OomsWebService noOfGpBuildingSupport(@RequestBody final WebServiceOoms capacityBuildingErForOoms,
			@RequestHeader("username") final String username, @RequestHeader("password") final String password)
			throws JsonProcessingException {
		List<CapacityBuildingErForOoms> capacityBuildingErForOomsList = null;
		final OomsWebService oomsWebService = new OomsWebService();
		@SuppressWarnings("unused")
		final String type = "GP";
		if ("RGSA_NITIAYOG".equals(username) && "NITIAYOG@123456".equals(password)) {
			oomsWebService.setStatus(Boolean.valueOf(true));
			oomsWebService.setStatuscode(Integer.valueOf(1));
			if ("FR01".equals(capacityBuildingErForOoms.getFrequencyCode())
					&& !"".equals(capacityBuildingErForOoms.getFrequencyCode())
					&& "AR002".equals(capacityBuildingErForOoms.getMeasurementAreaCode())
					&& !"".equals(capacityBuildingErForOoms.getMeasurementAreaCode())
					&& "PR05".equals(capacityBuildingErForOoms.getIndicatorCode())
					&& !"".equals(capacityBuildingErForOoms.getIndicatorCode())
					&& "PR1624".equals(capacityBuildingErForOoms.getSchemeCode())
					&& !"".equals(capacityBuildingErForOoms.getSchemeCode())
					&& capacityBuildingErForOoms.getYear() != null && !"".equals(capacityBuildingErForOoms.getYear())) {
				capacityBuildingErForOomsList = (List<CapacityBuildingErForOoms>) this.webserviceService
						.fetchCapacityBuildingErForOoms(capacityBuildingErForOoms.getYear(), "GP");
				capacityBuildingErForOomsList.stream().forEach(u -> {
					u.setValue(u.getFieldGenricName());
					u.setFieldGenricName((String) null);
					u.setMeasurementAreaCode(capacityBuildingErForOoms.getMeasurementAreaCode());
					u.setSchemeCode(capacityBuildingErForOoms.getSchemeCode());
					u.setYear(capacityBuildingErForOoms.getYear());
					u.setIndicatorCode(capacityBuildingErForOoms.getIndicatorCode());
					u.setFrequencyCode(capacityBuildingErForOoms.getFrequencyCode());
					u.setDistrictCode("N/A");
					u.setMeasurementFreqCode("FR01_001");
					return;
				});
				oomsWebService.setValue((List) capacityBuildingErForOomsList);
			}
		} else {
			oomsWebService.setStatus(Boolean.valueOf(false));
			oomsWebService.setStatuscode(Integer.valueOf(0));
			oomsWebService.setValue((List) null);
		}
		return oomsWebService;
	}

	@PostMapping({ "/webService/noOfSprcDprcSupport" })
	@Produces({ "application/json" })
	public String noOfSprcDprcSupport(@QueryParam("finYear") final String finYear,
			@RequestParam("frequencyCode") final String freqCode,
			@RequestParam("measurementAreaCode") final String measureAreaCode,
			@RequestParam("indicatorCode") final String indicatorCode,
			@RequestParam("schemeCode") final String schemeCode) throws JsonProcessingException {
		List<CapacityBuildingErForOoms> capacityBuildingErForOomsList = null;
		final String type = "SD";
		String capacityBuildingList = null;
		if ("FR01".equals(freqCode) && !"".equals(freqCode) && "AR002".equals(measureAreaCode)
				&& !"".equals(measureAreaCode) && "PR10".equals(indicatorCode) && !"".equals(indicatorCode)
				&& "PR1624".equals(schemeCode) && !"".equals(schemeCode) && finYear != null && !"".equals(finYear)) {
			capacityBuildingErForOomsList = (List<CapacityBuildingErForOoms>) this.webserviceService
					.fetchCapacityBuildingErForOoms(finYear, "SD");
			capacityBuildingErForOomsList.stream().forEach(u -> {
				u.setValue(u.getFieldGenricName().substring(0, u.getFieldGenricName().lastIndexOf(44)));
				u.setValue(u.getFieldGenricName().substring(u.getFieldGenricName().lastIndexOf(44) + 1,
						u.getFieldGenricName().length()));
				u.setFieldGenricName((String) null);
				return;
			});
			final ObjectMapper mapper = new ObjectMapper();
			mapper.enable(SerializationFeature.INDENT_OUTPUT);
			capacityBuildingList = mapper.writeValueAsString((Object) capacityBuildingErForOomsList);
		}
		return capacityBuildingList;
	}
	
	@PostMapping({ "/webService/kpiServiceData" })
	@Produces({ "application/json" })
	public KpiWebServiceRecord kpiServiceData(@RequestBody final KpiWebServiceParam kpiWebServiceParam) throws IOException {
		 List<gov.in.rgsa.entity.KpiWebService> kpiWebServiceList = null;
		 final KpiWebServiceRecord kpiWebServiceRecord = new KpiWebServiceRecord();
		   Integer yr=kpiWebServiceParam.getYr();
		   Integer mcode=kpiWebServiceParam.getmCode();
		   Integer statecode=kpiWebServiceParam.getStateCode();
		   Integer deptcode= kpiWebServiceParam.getDeptCode();
		   Integer projectcode=kpiWebServiceParam.getProjectCode();
		   Integer seccode=kpiWebServiceParam.getSecCode();
		   
		   List<KpiWebServiceParam> kpiWebServiceParamList=null;
		   List<String> list = new ArrayList<String>();
	       kpiWebServiceRecord.setMcode(mcode);
     	   kpiWebServiceRecord.setState_code(statecode);
     	   kpiWebServiceRecord.setDept_code(deptcode);
     	   kpiWebServiceRecord.setProject_code(projectcode);
     	   kpiWebServiceRecord.setSec_code(seccode);
		
			if (yr != null && mcode!=null && statecode!=null && deptcode!=null && projectcode!=null && seccode!=null ) {
				kpiWebServiceList = (List<gov.in.rgsa.entity.KpiWebService>) this.webserviceService.fetchKpiData(yr,mcode,statecode,deptcode,projectcode, seccode);
				List<String> records=new ArrayList<String>();
				  for (KpiWebService tr : kpiWebServiceList) { 
					    String enctemp=encrypt(new JSONObject(tr).toString());
					    records.add(enctemp);
                      }
				  	System.out.println(records);
				    kpiWebServiceRecord.setRecord(records);
		    	} 
		return kpiWebServiceRecord;
	}
	
	
	public  String encrypt(String value) {
		
		
		  final String initVector = "encryptionIntVec";
		   try {
				
				//FileInputStream fin =new FileInputStream(file);
		
				
				AttachmentMaster attachmentMaster = innovativeActivityService.findfilePath(DARPAN_KEY_FILE_LOC_ID);
			   // String file = attachmentMaster.getFileLocation();	
			   // file=file.replace("\\\\", "/");
				//String rootPath = file.replace("\\", "/");
				 File rootPath = new File(attachmentMaster.getFileLocation());
			    byte fileContent[] = new byte[(int)rootPath.length()];
	            final String key = new String(fileContent);
		       
				IvParameterSpec iv = new IvParameterSpec(initVector.getBytes("UTF-8"));
				SecretKeySpec skeySpec = new SecretKeySpec(key.getBytes("UTF-8"), "AES");

				Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
				cipher.init(Cipher.ENCRYPT_MODE, skeySpec, iv);

				byte[] encrypted = cipher.doFinal(value.getBytes());
				return Base64.encodeBase64String(encrypted);
			
			} 
			catch (Exception e) 
			{
				//ex.printStackTrace();
				System.out.println("Error while encrypting: " + e.toString());
			}
			return null;
		}
	
	
}