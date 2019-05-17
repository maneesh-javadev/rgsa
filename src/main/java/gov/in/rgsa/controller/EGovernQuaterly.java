package gov.in.rgsa.controller;

import java.util.Map;

import gov.in.rgsa.service.EGovQtlService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import gov.in.rgsa.entity.ExtentOfCoverage;
import gov.in.rgsa.inbound.QprEGovReq;
import gov.in.rgsa.outbound.MsgReply;
import gov.in.rgsa.service.ProgressReportService;

@Controller
public class EGovernQuaterly {

	private static final String EGovt_Quaderly ="eGovtQuaderly";
	
	@Autowired
	private ProgressReportService progressReportService;

	@Autowired
	private EGovQtlService eGovQtlService;

	@RequestMapping(value="eGovtQuaderly" , method=RequestMethod.GET)
	public String qprGetFormeGovtQuaderly(@ModelAttribute("ADMIN_QUADERLY") ExtentOfCoverage extentOfCoverage, Model model) {
		model.addAttribute("quarter_duration", progressReportService.getQuarterDurations());
		return EGovt_Quaderly;
	}
	
	@ResponseBody
	@RequestMapping(value="getPostApproveReport", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_VALUE)
	public MsgReply<Object> getPostApproveReport(@RequestParam("qid") Integer quarterId) {
		try {
			Map<String, Object> response = eGovQtlService.getEGovFormMap(quarterId);
			return MsgReply.okMessage(response);
		}catch(Exception e) {
			return MsgReply.failMessage(e.getMessage());
		}
		
	}

	@ResponseBody
	@RequestMapping(value="postPostApproveReport", method=RequestMethod.POST,consumes=MediaType.APPLICATION_JSON_VALUE, produces=MediaType.APPLICATION_JSON_VALUE)
	public   MsgReply<Object> postPostApproveReport(@RequestBody QprEGovReq qprEGovReq){
		try {
			switch(qprEGovReq.getAction()) {
				case "save":
					return this.save(qprEGovReq);
				case "freeze":
					if(qprEGovReq.getIsNew() || qprEGovReq.getQprEGovId()==-1) {
						MsgReply<Object> result = this.save(qprEGovReq);
						if(!result.isSuccess())
							return result;
					}
					return this.freeze(qprEGovReq);
				case "unfreeze":
					return this.unFreeze(qprEGovReq);
				}
		}catch(Exception e) {
			return MsgReply.failMessage(e.getMessage()); // new MsgReply<String>(false, e.getMessage(), httpStatus);
		}
		return MsgReply.failMessage("Unknown command");
	}

	private MsgReply<Object> save(QprEGovReq qprEGovReq) {
		eGovQtlService.save(qprEGovReq);
		return getPostApproveReport(qprEGovReq.getQuarterId()) ;
	}

	private MsgReply<Object> unFreeze(QprEGovReq qprEGovReq) {
		eGovQtlService.unFreeze(qprEGovReq);
		return getPostApproveReport(qprEGovReq.getQuarterId());
	}

	private MsgReply<Object> freeze(QprEGovReq qprEGovReq) {
		eGovQtlService.freeze(qprEGovReq);
		return getPostApproveReport(qprEGovReq.getQuarterId());
	}
	
}
