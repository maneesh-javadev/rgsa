package gov.in.rgsa.controller;

import gov.in.rgsa.entity.ExtentOfCoverage;
import gov.in.rgsa.entity.QuaterWiseFund;
import gov.in.rgsa.entity.StateAllocation;
import gov.in.rgsa.inbound.QprQuartReply;
import gov.in.rgsa.outbound.MsgReply;
import gov.in.rgsa.service.PesaQtlService;
import gov.in.rgsa.service.ProgressReportService;

import org.apache.tiles.request.collection.CollectionUtil;
import org.owasp.esapi.util.CollectionsUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
public class PesaPlanQuarterly {

	private static final String Pesa_Plan_Quarterly ="pesaPlanQuaterly";
	
	@Autowired
	private ProgressReportService progressReportService;

	@Autowired
	PesaQtlService pesaQtlService;

	@RequestMapping(value="pesaPlanQuaterly" , method=RequestMethod.GET)
	public String qprGetFormpesaPlanQuarterly(@ModelAttribute("ADMIN_QUADERLY") ExtentOfCoverage extentOfCoverage, Model model) {		
		model.addAttribute("quarter_duration", progressReportService.getQuarterDurations());
		return Pesa_Plan_Quarterly;
	}
	
	// Loads asynchronously
	
	@ResponseBody
	@RequestMapping(value="fetchQuartExp", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_VALUE)
	public MsgReply<Object> getQuartExp(@RequestParam("qid") Integer quarterId) {
		try {
			Map<String, Object> response = pesaQtlService.getPesaFormMap(quarterId);
			return MsgReply.okMessage(response);
		}catch(Exception e) {
			return MsgReply.failMessage(e.getMessage());
		}
	}
	
	@ResponseBody
	@RequestMapping(value="postQuartExp", method=RequestMethod.POST,consumes=MediaType.APPLICATION_JSON_VALUE, produces=MediaType.APPLICATION_JSON_VALUE)
	private  MsgReply<Object> postQuartExp(@RequestBody QprQuartReply qprQuartReply) {
		try {
			switch(qprQuartReply.getAction()) {
				case "save":
					return this.save(qprQuartReply);
				case "freeze":
					if(qprQuartReply.getQprPesaId()==-1) {
						MsgReply<Object> result = this.save(qprQuartReply);
						if(!result.isSuccess())
							return result;
					}
					return this.freeze(qprQuartReply);
				case "unfreeze":
					return this.unFreeze(qprQuartReply);
				}
		}catch(Exception e) {
			return MsgReply.failMessage(e.getMessage()); // new MsgReply<String>(false, e.getMessage(), httpStatus);
		}
		return MsgReply.failMessage("Unknown command");	
	}
	
	private MsgReply<Object> save(QprQuartReply qprQuartReply) {
			pesaQtlService.save(qprQuartReply);
			return getQuartExp(qprQuartReply.getQuarterId());
		
	}
	
	private MsgReply<Object> freeze(QprQuartReply qprQuartReply) {
		pesaQtlService.freeze(qprQuartReply);
		return getQuartExp(qprQuartReply.getQuarterId());
	}
	
	private MsgReply<Object> unFreeze(QprQuartReply qprQuartReply) {
		pesaQtlService.unFreeze(qprQuartReply);
		return getQuartExp(qprQuartReply.getQuarterId());
	}
}
