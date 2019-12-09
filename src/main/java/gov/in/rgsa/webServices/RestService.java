package gov.in.rgsa.webServices;


import java.awt.PageAttributes.MediaType;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
 

import org.codehaus.jettison.json.JSONException;
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
import com.sun.mail.iap.Response;

import gov.in.rgsa.dto.ERRepresentativeHundredDayProg;
import gov.in.rgsa.dto.ERRepresentativeHundredDayProgLastWeekWise;
import gov.in.rgsa.dto.ERRepresentativeHundredDayProgStateWise;
import gov.in.rgsa.dto.HundredDaysWebServiceDTO;
import gov.in.rgsa.dto.StatewiseNoOfParticipants;
import gov.in.rgsa.dto.WebServiceOoms;
import gov.in.rgsa.entity.CapacityBuildingErForOoms;
import gov.in.rgsa.entity.FetchPlanStatusCount;



 

public class RestService {
	
	/*
	 * @Autowired private WebserviceService webserviceService;
	 * 
	 * @GetMapping("/webService/noOfParticipantsAllIndia/{finYear}") public Integer
	 * noOfParticipantsAllIndia(@PathVariable String finYear,HttpServletResponse
	 * response,HttpServletRequest request) {
	 * response.setHeader("Access-Control-Allow-Origin", "*");
	 * response.setHeader("Access-Control-Allow-Headers",
	 * request.getHeader("Access-Control-Request-Headers"));
	 * response.setHeader("Access-Control-Allow-Methods",
	 * request.getHeader("Access-Control-Request-Method")); return
	 * webserviceService.fetchNoOfParticipantsIndia(finYear); }
	 * 
	 * @GetMapping("/webService/fetchHundredDayWSData/{fieldType}") public
	 * List<HundredDaysWebServiceDTO> fetchHundredDayWSData(@PathVariable String
	 * fieldType,HttpServletResponse response,HttpServletRequest request) {
	 * response.setHeader("Access-Control-Allow-Origin", "*");
	 * response.setHeader("Access-Control-Allow-Headers",
	 * request.getHeader("Access-Control-Request-Headers"));
	 * response.setHeader("Access-Control-Allow-Methods",
	 * request.getHeader("Access-Control-Request-Method")); return
	 * webserviceService.fetchHundredDayWSData(fieldType); }
	 * 
	 * 
	 * @GetMapping("/webService/noOfParticipantsStatewise/{finYear}") public
	 * List<StatewiseNoOfParticipants> noOfParticipantsStatewise(@PathVariable
	 * String finYear,HttpServletResponse response,HttpServletRequest request) {
	 * response.setHeader("Access-Control-Allow-Origin", "*");
	 * response.setHeader("Access-Control-Allow-Headers",
	 * request.getHeader("Access-Control-Request-Headers"));
	 * response.setHeader("Access-Control-Allow-Methods",
	 * request.getHeader("Access-Control-Request-Method")); return
	 * webserviceService.fetchNoOfParticipantsStateWise(finYear); }
	 * 
	 * 
	 * @GetMapping("/webService/totalERRepresentativeDetails/{finYear}") public
	 * List<ERRepresentativeHundredDayProg>
	 * totalERRepresentativeDetails(@PathVariable String finYear,HttpServletResponse
	 * response,HttpServletRequest request) {
	 * response.setHeader("Access-Control-Allow-Origin", "*");
	 * response.setHeader("Access-Control-Allow-Headers",
	 * request.getHeader("Access-Control-Request-Headers"));
	 * response.setHeader("Access-Control-Allow-Methods",
	 * request.getHeader("Access-Control-Request-Method")); return
	 * webserviceService.fetchERRepresentativeHundredDayProg(finYear,null,null); }
	 * 
	 * @GetMapping(
	 * "/webService/totalERRepresentativeDetailsDateWise/{stDate}/{endDate}") public
	 * List<ERRepresentativeHundredDayProg>
	 * totalERRepresentativeDetailsDateWise(@PathVariable String
	 * stDate,@PathVariable String endDate,HttpServletResponse
	 * response,HttpServletRequest request) {
	 * response.setHeader("Access-Control-Allow-Origin", "*");
	 * response.setHeader("Access-Control-Allow-Headers",
	 * request.getHeader("Access-Control-Request-Headers"));
	 * response.setHeader("Access-Control-Allow-Methods",
	 * request.getHeader("Access-Control-Request-Method")); return
	 * webserviceService.fetchERRepresentativeHundredDayProg(null,stDate,endDate); }
	 * 
	 * @GetMapping(
	 * "/webService/totalERRepresentativeDetailsStateWise/{stDate}/{endDate}")
	 * public List<ERRepresentativeHundredDayProgStateWise>
	 * totalERRepresentativeDetailsStateWise(@PathVariable String
	 * stDate,@PathVariable String endDate,HttpServletResponse
	 * response,HttpServletRequest request) {
	 * response.setHeader("Access-Control-Allow-Origin", "*");
	 * response.setHeader("Access-Control-Allow-Headers",
	 * request.getHeader("Access-Control-Request-Headers"));
	 * response.setHeader("Access-Control-Allow-Methods",
	 * request.getHeader("Access-Control-Request-Method")); return
	 * webserviceService.fetchERRepresentativeHundredDayProgStateWise(null, stDate,
	 * endDate); }
	 * 
	 * @GetMapping("/webService/totalERRepresentativeDetailsLastWeekWise") public
	 * List<ERRepresentativeHundredDayProgLastWeekWise>
	 * totalERRepresentativeDetailsLastWeekWise(HttpServletResponse
	 * response,HttpServletRequest request) {
	 * response.setHeader("Access-Control-Allow-Origin", "*");
	 * response.setHeader("Access-Control-Allow-Headers",
	 * request.getHeader("Access-Control-Request-Headers"));
	 * response.setHeader("Access-Control-Allow-Methods",
	 * request.getHeader("Access-Control-Request-Method"));
	 * List<ERRepresentativeHundredDayProgLastWeekWise> list =
	 * webserviceService.fetchERRepresentativeHundredDayProgLASTWEEKWISE(); int
	 * total=0; for (ERRepresentativeHundredDayProgLastWeekWise detail : list) {
	 * if(detail.getTotalERTrained() != 0) { total = detail.getTotalERTrained(); }
	 * 
	 * if(detail.getTotalERTrained() == 0) { detail.setTotalERTrained(total); } }
	 * return list; }
	 */
	
	/*
	 * @GET
	 * 
	 * @Path("/TESTHI")
	 * 
	 * @Produces(MediaType.APPLICATION_XML) public Response
	 * getTotalSubmittedPlans(@Context ServletContext servletContext){ Response
	 * response = null;
	 * 
	 * ApplicationContext ctx =
	 * WebApplicationContextUtils.getWebApplicationContext(servletContext);
	 * webserviceService =ctx.getBean(WebserviceService.class); StringBuilder sw=new
	 * StringBuilder("<xml>\n<status>HI HOW R U\n");
	 * sw.append("\n</status>\n</xml>");
	 * 
	 * 
	 * 
	 * 
	 * return response;
	 * 
	 * }
	 * 
	 * @GET
	 * 
	 * @Path("/totalNumberOfSubmittedStatePlans")
	 * 
	 * @Produces(MediaType.APPLICATION_XML) public Response
	 * getTotalSubmittedPlans(@Context ServletContext
	 * servletContext,@QueryParam(value = "finYear") String finYear) throws
	 * Exception{ Response response = null; try { System.out.println("1");
	 * 
	 * if(finYear!=null) { ApplicationContext ctx =
	 * WebApplicationContextUtils.getWebApplicationContext(servletContext);
	 * webserviceService =ctx.getBean(WebserviceService.class);
	 * System.out.println("2"); FetchPlanStatusCount fetchPlanStatusCount =
	 * webserviceService.fetchPlanSubmitedAndApproved(finYear); StringBuilder sw=new
	 * StringBuilder("<xml>\n<status>\n"); if(fetchPlanStatusCount!=null ) {
	 * sw.append("States submitted RGSA plans-:"+fetchPlanStatusCount.
	 * getPlanSumitCount()).append(";");
	 * sw.append("Plans approved-:"+fetchPlanStatusCount.getPlanApprovedCount()).
	 * append(";");
	 * sw.append("Meetings of CEC held year-wise-:"+fetchPlanStatusCount.
	 * getCecMettingCount()).append(";"); sw.append("\n</status>\n</xml>"); response
	 * =
	 * Response.ok().type(MediaType.APPLICATION_XML).entity(sw.toString().getBytes(
	 * "UTF-8")).build(); }else{ response = Response.serverError().
	 * entity("No plan is submitted or approved in this particular fin year.").build
	 * (); } }else { response =
	 * Response.serverError().entity("No input parameter").build(); }
	 * 
	 * 
	 * 
	 * } catch (Exception e) { StringBuilder sw=new
	 * StringBuilder("<xml>\n<error>\n"); sw.append(e);
	 * sw.append("\n</error>\n</xml>"); response =
	 * Response.serverError().type(MediaType.APPLICATION_XML).entity(sw.toString().
	 * getBytes("UTF-8")).build(); e.printStackTrace(); } return response;
	 * 
	 * }
	 * 
	 * 
	 * @PostMapping("/webService/noOfCapacityBuilding")
	 * 
	 * @Produces(MediaType.APPLICATION_JSON) public String
	 * getTotalSubmittedPlan(@QueryParam(value = "finYear") String finYear,
	 * 
	 * @RequestParam("frequencyCode") String
	 * freqCode,@RequestParam("measurementAreaCode") String measureAreaCode,
	 * 
	 * @RequestParam("indicatorCode") String
	 * indicatorCode,@RequestParam("schemeCode") String schemeCode) throws
	 * JsonProcessingException{ List<CapacityBuildingErForOoms>
	 * capacityBuildingErForOomsList= null; String type ="CB"; String
	 * capacityBuildingList = null ; if( ("FR01").equals(freqCode) &&
	 * !("").equals(freqCode) && ("AR002").equals(measureAreaCode) &&
	 * !("").equals(measureAreaCode) && ("PR01").equals(indicatorCode) &&
	 * !("").equals(indicatorCode) &&("PR1624").equals(schemeCode) &&
	 * !("").equals(schemeCode) && finYear !=null && !("").equals(finYear)) {
	 * capacityBuildingErForOomsList =
	 * webserviceService.fetchCapacityBuildingErForOoms(finYear,type);
	 * capacityBuildingErForOomsList.stream().forEach(u ->{
	 * u.setValue(u.getFieldGenricName()); u.setFieldGenricName(null);});
	 * ObjectMapper mapper = new ObjectMapper();
	 * mapper.enable(SerializationFeature.INDENT_OUTPUT); capacityBuildingList =
	 * mapper.writeValueAsString(capacityBuildingErForOomsList);
	 * 
	 * } return capacityBuildingList; }
	 * 
	 * 
	 * 
	 * @PostMapping("/webService/noOfTraining")
	 * 
	 * @Produces(MediaType.APPLICATION_JSON) public String
	 * noOfTraining(@QueryParam(value = "finYear") String finYear,
	 * 
	 * @RequestParam("frequencyCode") String
	 * freqCode,@RequestParam("measurementAreaCode") String measureAreaCode,
	 * 
	 * @RequestParam("indicatorCode") String
	 * indicatorCode,@RequestParam("schemeCode") String schemeCode) throws
	 * JsonProcessingException{ List<CapacityBuildingErForOoms>
	 * capacityBuildingErForOomsList= null; String type ="NT"; String
	 * capacityBuildingList = null ; if( ("FR01").equals(freqCode) &&
	 * !("").equals(freqCode) && ("AR002").equals(measureAreaCode) &&
	 * !("").equals(measureAreaCode) && ("PR02").equals(indicatorCode) &&
	 * !("").equals(indicatorCode) &&("PR1624").equals(schemeCode) &&
	 * !("").equals(schemeCode) && finYear !=null && !("").equals(finYear)) {
	 * capacityBuildingErForOomsList =
	 * webserviceService.fetchCapacityBuildingErForOoms(finYear,type);
	 * capacityBuildingErForOomsList.stream().forEach(u ->{
	 * u.setNoOfTraining(u.getFieldGenricName()); u.setFieldGenricName(null);});
	 * ObjectMapper mapper = new ObjectMapper();
	 * mapper.enable(SerializationFeature.INDENT_OUTPUT); capacityBuildingList =
	 * mapper.writeValueAsString(capacityBuildingErForOomsList); } return
	 * capacityBuildingList; }
	 * 
	 * @PostMapping("/webService/noOfExposureView")
	 * 
	 * @Produces(MediaType.APPLICATION_JSON) public StringBuffer
	 * noOfExposureView(@QueryParam(value = "finYear") String finYear,
	 * 
	 * @RequestBody WebServiceOoms capacityBuildingErForOoms
	 * , @RequestHeader("username") String username ,@RequestHeader("password")
	 * String password) throws JsonProcessingException{
	 * List<CapacityBuildingErForOoms> capacityBuildingErForOomsList= null; //
	 * WebserviceUsers fetchWebserviceUsers =
	 * webserviceService.fetchWebserviceUsers(); String type ="EV"; StringBuffer
	 * capacityBuildAppend = new StringBuffer() ; String capacityBuildingList =
	 * null; if("RGSA_NITIAYOG".equals(username) &&
	 * "NITIAYOG@123456".equals(password)) { capacityBuildAppend.append(" \n");
	 * capacityBuildAppend.append("\"status\": true,");
	 * capacityBuildAppend.append(" \n");
	 * capacityBuildAppend.append("\"statuscode\": 1,");
	 * capacityBuildAppend.append(" \n"); capacityBuildAppend.append("\"value\":");
	 * 
	 * if( ("FR01").equals(capacityBuildingErForOoms.getFrequencyCode()) &&
	 * !("").equals(capacityBuildingErForOoms.getFrequencyCode()) &&
	 * ("AR002").equals(capacityBuildingErForOoms.getMeasurementAreaCode()) &&
	 * !("").equals(capacityBuildingErForOoms.getMeasurementAreaCode()) &&
	 * ("PR04").equals(capacityBuildingErForOoms.getIndicatorCode()) &&
	 * !("").equals(capacityBuildingErForOoms.getIndicatorCode())
	 * &&("PR1624").equals(capacityBuildingErForOoms.getSchemeCode()) &&
	 * !("").equals(capacityBuildingErForOoms.getSchemeCode()) &&
	 * capacityBuildingErForOoms.getYear() !=null &&
	 * !("").equals(capacityBuildingErForOoms.getYear())) {
	 * capacityBuildingErForOomsList =
	 * webserviceService.fetchCapacityBuildingErForOoms(capacityBuildingErForOoms.
	 * getYear(),type); capacityBuildingErForOomsList.stream().forEach(u ->{
	 * u.setValue(u.getFieldGenricName()); u.setFieldGenricName(null);
	 * u.setMeasurementAreaCode(capacityBuildingErForOoms.getMeasurementAreaCode());
	 * u.setSchemeCode(capacityBuildingErForOoms.getSchemeCode());
	 * u.setYear(capacityBuildingErForOoms.getYear());
	 * u.setIndicatorCode(capacityBuildingErForOoms.getIndicatorCode());
	 * u.setFrequencyCode(capacityBuildingErForOoms.getFrequencyCode());
	 * u.setDistrictCode("N/A"); u.setMeasurementFreqCode("FR01_001");});
	 * ObjectMapper mapper = new ObjectMapper();
	 * mapper.enable(SerializationFeature.INDENT_OUTPUT); capacityBuildingList =
	 * mapper.writeValueAsString(capacityBuildingErForOomsList);
	 * capacityBuildAppend.append(capacityBuildingList);
	 * 
	 * } } return capacityBuildAppend; }
	 * 
	 * @PostMapping("/webService/noOfGpBuildingSupport")
	 * 
	 * @Produces(MediaType.APPLICATION_JSON)
	 * 
	 * public Response noOfGpBuildingSupport(
	 * 
	 * @RequestBody WebServiceOoms webServiceOoms , @RequestHeader("username")
	 * String username ,@RequestHeader("password") String password) throws
	 * IOException, JSONException{ List<CapacityBuildingErForOoms>
	 * capacityBuildingErForOomsList= null; // WebserviceUsers fetchWebserviceUsers
	 * = webserviceService.fetchWebserviceUsers(); //String str=
	 * httpEntity.getBody(); String type ="GP"; StringBuffer capacityBuildAppend =
	 * new StringBuffer() ; String str = new String(); //JsonObject objectFromString
	 * = new JsonObject() ; Response response = null;
	 * 
	 * String capacityBuildingList = null; if("RGSA_NITIAYOG".equals(username) &&
	 * "NITIAYOG@123456".equals(password)) { capacityBuildAppend.append(" \n");
	 * capacityBuildAppend.append("\"status\": true,");
	 * capacityBuildAppend.append(" \n");
	 * capacityBuildAppend.append("\"statuscode\": 1,");
	 * capacityBuildAppend.append(" \n"); capacityBuildAppend.append("\"value\":");
	 * 
	 * 
	 * if( ("FR01").equals(webServiceOoms.getFrequencyCode()) &&
	 * !("").equals(webServiceOoms.getFrequencyCode()) &&
	 * ("AR002").equals(webServiceOoms.getMeasurementAreaCode()) &&
	 * !("").equals(webServiceOoms.getMeasurementAreaCode()) &&
	 * ("PR05").equals(webServiceOoms.getIndicatorCode()) &&
	 * !("").equals(webServiceOoms.getIndicatorCode())
	 * &&("PR1624").equals(webServiceOoms.getSchemeCode()) &&
	 * !("").equals(webServiceOoms.getSchemeCode()) && webServiceOoms.getYear()
	 * !=null && !("").equals(webServiceOoms.getYear())) {
	 * capacityBuildingErForOomsList =
	 * webserviceService.fetchCapacityBuildingErForOoms(webServiceOoms.getYear(),
	 * type); capacityBuildingErForOomsList.stream().forEach(u ->{
	 * u.setValue(u.getFieldGenricName()); u.setFieldGenricName(null);
	 * u.setMeasurementAreaCode(webServiceOoms.getMeasurementAreaCode());
	 * u.setSchemeCode(webServiceOoms.getSchemeCode());
	 * u.setYear(webServiceOoms.getYear());
	 * u.setIndicatorCode(webServiceOoms.getIndicatorCode());
	 * u.setFrequencyCode(webServiceOoms.getFrequencyCode());
	 * u.setDistrictCode("N/A"); u.setMeasurementFreqCode("FR01_001");
	 * 
	 * }); ObjectMapper mapper = new ObjectMapper(); ObjectMapper mapperBuffer = new
	 * ObjectMapper(); mapper.enable(SerializationFeature.INDENT_OUTPUT);
	 * capacityBuildingList =
	 * mapper.writeValueAsString((capacityBuildingErForOomsList));
	 * capacityBuildAppend.append(capacityBuildingList);
	 * 
	 * str =capacityBuildAppend.toString();
	 * mapperBuffer.enable(SerializationFeature.INDENT_OUTPUT); response =
	 * Response.ok().type(MediaType.APPLICATION_JSON).entity(str.toString()).build()
	 * ; //objectFromString= new JSONObject(str); // mapperBuffer.readValue(str);
	 * 
	 * //JsonParser jsonParser = new JsonParser(); // gson = (Gson)
	 * jsonParser.parse(str).getAsJsonObject(); } } return response; }
	 * 
	 * @PostMapping("/webService/noOfSprcDprcSupport")
	 * 
	 * @Produces(MediaType.APPLICATION_JSON) public String
	 * noOfSprcDprcSupport(@QueryParam(value = "finYear") String finYear,
	 * 
	 * @RequestParam("frequencyCode") String
	 * freqCode,@RequestParam("measurementAreaCode") String measureAreaCode,
	 * 
	 * @RequestParam("indicatorCode") String
	 * indicatorCode,@RequestParam("schemeCode") String schemeCode) throws
	 * JsonProcessingException{ List<CapacityBuildingErForOoms>
	 * capacityBuildingErForOomsList= null; String type ="SD"; String
	 * capacityBuildingList = null ; if( ("FR01").equals(freqCode) &&
	 * !("").equals(freqCode) && ("AR002").equals(measureAreaCode) &&
	 * !("").equals(measureAreaCode) && ("PR10").equals(indicatorCode) &&
	 * !("").equals(indicatorCode) &&("PR1624").equals(schemeCode) &&
	 * !("").equals(schemeCode) && finYear !=null && !("").equals(finYear)) {
	 * capacityBuildingErForOomsList =
	 * webserviceService.fetchCapacityBuildingErForOoms(finYear,type);
	 * capacityBuildingErForOomsList.stream().forEach(u
	 * ->{u.setValue(u.getFieldGenricName().substring(0,
	 * u.getFieldGenricName().lastIndexOf(',')));
	 * u.setValue(u.getFieldGenricName().substring(
	 * u.getFieldGenricName().lastIndexOf(',')+1,u.getFieldGenricName().length()));
	 * u.setFieldGenricName(null);});
	 * 
	 * ObjectMapper mapper = new ObjectMapper();
	 * mapper.enable(SerializationFeature.INDENT_OUTPUT); capacityBuildingList =
	 * mapper.writeValueAsString(capacityBuildingErForOomsList); } return
	 * capacityBuildingList; }
	 */


}
