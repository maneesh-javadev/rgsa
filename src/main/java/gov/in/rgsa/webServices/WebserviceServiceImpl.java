package gov.in.rgsa.webServices;

import gov.in.rgsa.entity.CapacityBuildingErForOoms;
import java.util.ArrayList;
import gov.in.rgsa.dto.HundredDaysWebServiceDTO;
import gov.in.rgsa.dto.ERRepresentativeHundredDayProgStateWise;
import gov.in.rgsa.dto.ERRepresentativeHundredDayProgLastWeekWise;
import java.util.Date;
import java.text.SimpleDateFormat;
import gov.in.rgsa.dto.ERRepresentativeHundredDayProg;
import gov.in.rgsa.dto.StatewiseNoOfParticipants;
import java.math.BigInteger;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import gov.in.rgsa.entity.FetchPlanStatusCount;
import org.springframework.beans.factory.annotation.Autowired;
import gov.in.rgsa.dao.CommonRepository;
import org.springframework.stereotype.Service;

@Service
public class WebserviceServiceImpl implements WebserviceService
{
    @Autowired
    private CommonRepository commonRepository;
    
    @Override
    public FetchPlanStatusCount fetchPlanSubmitedAndApproved(final String fin_year) {
        FetchPlanStatusCount fetchPlanStatusCount = null;
        final Map<String, Object> params = new HashMap<String, Object>();
        params.put("fin_year", fin_year);
        final List<FetchPlanStatusCount> fetchPlanStatusCountList = (List<FetchPlanStatusCount>)this.commonRepository.findAll("FETCH_PLAN_STAUS_COUNT", (Map)params);
        if (fetchPlanStatusCountList != null && !fetchPlanStatusCountList.isEmpty()) {
            fetchPlanStatusCount = fetchPlanStatusCountList.get(0);
        }
        return fetchPlanStatusCount;
    }
    
    @Override
    public Integer fetchNoOfParticipantsIndia(final String fin_year) {
        try {
            final Map<String, Object> params = new HashMap<String, Object>();
            params.put("fin_year", fin_year);
            params.put("isactive", true);
            final String squery = "select (coalesce(sum(no_of_participants_sc),0)+coalesce(sum(no_of_participants_st),0)+coalesce(sum(no_of_participants_woman),0)+coalesce(sum(no_of_participants_others),0))no_of_participants   from rgsa.trg_details_of_hundred_days_program td inner join rgsa.fin_year  fy  on td.year_id =fy.year_id where   td.isactive=:isactive and fy.finyear = :fin_year";
            final BigInteger countbig = (BigInteger)this.commonRepository.findByNativeQuery(squery, (Map)params);
            return countbig.intValue();
        }
        catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }
    
    @Override
    public List<StatewiseNoOfParticipants> fetchNoOfParticipantsStateWise(final String fin_year) {
        List<StatewiseNoOfParticipants> statewiseNoOfParticipantsList = null;
        try {
            final Map<String, Object> params = new HashMap<String, Object>();
            params.put("fin_year", fin_year);
            statewiseNoOfParticipantsList = (List<StatewiseNoOfParticipants>)this.commonRepository.findAll("NO_OF_PARTICIPANTS_STATE_WISE", (Map)params);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return statewiseNoOfParticipantsList;
    }
    
    @Override
    public List<ERRepresentativeHundredDayProg> fetchERRepresentativeHundredDayProg(final String fin_year, final String stDate, final String endDate) {
        List<ERRepresentativeHundredDayProg> erRepresentativeHundredDayProg = null;
        try {
            final Map<String, Object> params = new HashMap<String, Object>();
            if (stDate != null && endDate != null) {
                final Date dstDate = new SimpleDateFormat("dd-MM-yyyy").parse(stDate);
                final Date dendDate = new SimpleDateFormat("dd-MM-yyyy").parse(endDate);
                params.put("stDate", dstDate);
                params.put("endDate", dendDate);
                erRepresentativeHundredDayProg = (List<ERRepresentativeHundredDayProg>)this.commonRepository.findAll("ER_Representative_Hundred_Day_Prog_DATE_WISE", (Map)params);
            }
            else {
                params.put("fin_year", fin_year);
                erRepresentativeHundredDayProg = (List<ERRepresentativeHundredDayProg>)this.commonRepository.findAll("ER_Representative_Hundred_Day_Prog", (Map)params);
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return erRepresentativeHundredDayProg;
    }
    
    @Override
    public List<ERRepresentativeHundredDayProgLastWeekWise> fetchERRepresentativeHundredDayProgLASTWEEKWISE() {
        return (List<ERRepresentativeHundredDayProgLastWeekWise>)this.commonRepository.findAll("ER_Representative_Hundred_Day_Prog_LAST_WEEK_WISE", (Map)null);
    }
    
    @Override
    public List<ERRepresentativeHundredDayProgStateWise> fetchERRepresentativeHundredDayProgStateWise(final String fin_year, final String stDate, final String endDate) {
        List<ERRepresentativeHundredDayProgStateWise> erRepresentativeHundredDayProg = null;
        try {
            final Map<String, Object> params = new HashMap<String, Object>();
            final Date dstDate = new SimpleDateFormat("dd-MM-yyyy").parse(stDate);
            final Date dendDate = new SimpleDateFormat("dd-MM-yyyy").parse(endDate);
            params.put("stDate", dstDate);
            params.put("endDate", dendDate);
            erRepresentativeHundredDayProg = (List<ERRepresentativeHundredDayProgStateWise>)this.commonRepository.findAll("ER_Representative_Hundred_Day_Prog_State_Wise", (Map)params);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return erRepresentativeHundredDayProg;
    }
    
    @Override
    public List<HundredDaysWebServiceDTO> fetchHundredDayWSData(final String fieldType) {
        List<HundredDaysWebServiceDTO> detail = new ArrayList<HundredDaysWebServiceDTO>();
        if (fieldType.equalsIgnoreCase("fetchAll")) {
            detail = (List<HundredDaysWebServiceDTO>)this.commonRepository.findAll("FETCH_ALL_STATE_DATA", (Map)null);
        }
        else {
            detail = (List<HundredDaysWebServiceDTO>)this.commonRepository.findAll("STATEWISE_DATA_FOR_ALL_FIELDS", (Map)null);
        }
        return detail;
    }
    
    @Override
    public List<CapacityBuildingErForOoms> fetchCapacityBuildingErForOoms(final String finYear, final String type) {
        List<CapacityBuildingErForOoms> capacityBuildingErForOomsList = null;
        String finYearN= null;
        if(finYear.trim() != null) {
        	 finYearN= finYear.trim().split("-")[0]+"-"+finYear.substring(0, 2)+ finYear.trim().split("-")[1];
        }
        final Map<String, Object> params = new HashMap<String, Object>();
        params.put("finYear", finYearN);
        if ("CB".equals(type)) {
            capacityBuildingErForOomsList = (List<CapacityBuildingErForOoms>)this.commonRepository.findAll("FETCH_CAPACITY_BUILDING_ER_OOMS", (Map)params);
        }
        else if ("NT".equals(type)) {
            capacityBuildingErForOomsList = (List<CapacityBuildingErForOoms>)this.commonRepository.findAll("FETCH_NO_OF_TRAINING_OOMS", (Map)params);
        }
        else if ("EV".equals(type)) {
            capacityBuildingErForOomsList = (List<CapacityBuildingErForOoms>)this.commonRepository.findAll("NO_OF_EXPOSURE_VIEW_OOMS", (Map)params);
        }
        else if ("GP".equals(type)) {
            capacityBuildingErForOomsList = (List<CapacityBuildingErForOoms>)this.commonRepository.findAll("NO_OF_GP_BUILDING_SUPPORT_OOMS", (Map)params);
        }
        else if ("SD".equals(type)) {
            capacityBuildingErForOomsList = (List<CapacityBuildingErForOoms>)this.commonRepository.findAll("NO_OF_SPRC_DPRC_SUPPORT_OOMS", (Map)params);
        }
        return capacityBuildingErForOomsList;
    }
}
