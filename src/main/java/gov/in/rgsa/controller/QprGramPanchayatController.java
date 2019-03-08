package gov.in.rgsa.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import gov.in.rgsa.dto.GramPanchayatProgressReportDTO;
import gov.in.rgsa.dto.InstitutionalInfraProgressReportDTO;
import gov.in.rgsa.entity.AttachmentMaster;
import gov.in.rgsa.entity.GPBhawanStatus;
import gov.in.rgsa.entity.IncomeEnhancementActivity;
import gov.in.rgsa.entity.QprIncomeEnhancement;
import gov.in.rgsa.entity.QprIncomeEnhancementDetails;
import gov.in.rgsa.entity.QprPanchayatBhawan;
import gov.in.rgsa.entity.QprPanhcayatBhawanDetails;
import gov.in.rgsa.service.IncomeEnhancementService;
import gov.in.rgsa.service.LGDService;
import gov.in.rgsa.service.PanchayatBhawanService;
import gov.in.rgsa.service.ProgressReportService;
import gov.in.rgsa.user.preference.UserPreference;
import gov.in.rgsa.utils.Message;

@Controller
public class QprGramPanchayatController {
	
	@Autowired
	private PanchayatBhawanService panchayatBhawanService;
	
	@Autowired
	private ProgressReportService progressReportService;
	
	@Autowired
	private UserPreference userPreference;
	
	
	public static final String GRAM_PANCHAYAT_PROGRESS_REPORT = "panchayatBhawanQuaterlyReport";
	
	public static final String REDIRECT_GRAM_PANCHAYAT_PROGRESS_REPORT = "redirect:panchayatBhawanQuaterlyReport.html";
	
	
	@Autowired
	private LGDService lgdService;
	
	@Autowired
	private IncomeEnhancementService enhancementService;
	
	
	
	@RequestMapping(value="panchayatBhawanQuaterlyReport",method = RequestMethod.GET)
	public String getQprgGramPanchayat(@ModelAttribute("QPR_PANCHAYAT_BHAWAN") QprPanchayatBhawan qprPanchayatBhawan ,Model model,HttpServletResponse httpResponse)
	{
		
		model.addAttribute("quarterDuration", progressReportService.getQuarterDurations());
		model.addAttribute("panchayatActivity", panchayatBhawanService.fetchPanchayatBhawanActivity());
		model.addAttribute("districtList", lgdService.getAllDistrictBasedOnState(userPreference.getStateCode()));
		
		return GRAM_PANCHAYAT_PROGRESS_REPORT;
	}
	
	@RequestMapping(value = "panchayatBhawanQuaterlyReportOnQtr", method = RequestMethod.POST)
	private String getQprgGramPanchayatActivity(@ModelAttribute("QPR_PANCHAYAT_BHAWAN") QprPanchayatBhawan qprPanchayatBhawan , Model model) {
		int quatorId =qprPanchayatBhawan.getQuaterId();
		int PanchayatBhawanActvityId =qprPanchayatBhawan.getActivityId1();
		int districtCode =qprPanchayatBhawan.getSelectDistrictId();
		int localBodyCode=0;
		int panchayatBhawanActivityId =0;
		Set <GramPanchayatProgressReportDTO> set =new HashSet<>();
		List<GramPanchayatProgressReportDTO> gramPanchayatProgressReportDTO =panchayatBhawanService.fetchGPBhawanData(PanchayatBhawanActvityId,districtCode);

		Iterator itr= gramPanchayatProgressReportDTO.iterator(); 
		while(itr.hasNext())
		{
			
			GramPanchayatProgressReportDTO obj=(GramPanchayatProgressReportDTO) itr.next();
		
			if(obj!=null)
			{
				set.add(obj);
				
			}
			panchayatBhawanActivityId =obj.getPanchayatBhawanActivityId();
			localBodyCode=obj.getLocalBodyCode();
		}
		
		
		
		List<QprPanchayatBhawan> QprPanchayatBhawan = panchayatBhawanService.fetchDataAccordingToQuator(quatorId,panchayatBhawanActivityId,districtCode);
		if(QprPanchayatBhawan !=null && QprPanchayatBhawan.size() !=0)
		{
			if(PanchayatBhawanActvityId==QprPanchayatBhawan.get(0).getActivityId())
			{
				model.addAttribute("QPRPANCHAYATBHAWAN", QprPanchayatBhawan.get(0));
				List<QprPanhcayatBhawanDetails> qprPanhcayatBhawanDetails =QprPanchayatBhawan.get(0).getQprPanhcayatBhawanDetails();
				model.addAttribute("QPRPANHCAYATBHAWANDETAILS", qprPanhcayatBhawanDetails);

			}
			
			
		}
		//Collections.sort(QprPanchayatBhawan.get(0).getQprPanhcayatBhawanDetails(), Comparator.comparing(QprPanhcayatBhawanDetails::getQprPanhcayatBhawanDetailsId));
		
		/*List<IncomeEnhancementActivity> dbActivitiesList = enhancementService.fetchAllIncmEnhncmntActvty(userPreference.getUserType().charAt(0));
		if(!CollectionUtils.isEmpty(dbActivitiesList)) {
			model.addAttribute("dbActivitiesList", dbActivitiesList.get(0));
			}*/
			model.addAttribute("QprPanchayatBhawanDto", set);
			model.addAttribute("panchayatBhawanActivityId", panchayatBhawanActivityId);
			 model.addAttribute("localBodyCode", localBodyCode);
		model.addAttribute("GPBhawanStatus", panchayatBhawanService.fetchGPBhawanStatus(PanchayatBhawanActvityId));

		model.addAttribute("quarterDuration", progressReportService.getQuarterDurations());
		model.addAttribute("panchayatActivity", panchayatBhawanService.fetchPanchayatBhawanActivity());
				model.addAttribute("districtList", lgdService.getAllDistrictBasedOnState(userPreference.getStateCode()));
		model.addAttribute("SetActivityId", qprPanchayatBhawan.getActivityId1());
		model.addAttribute("SetDistrict", qprPanchayatBhawan.getSelectDistrictId());
		model.addAttribute("SetQuaterId", qprPanchayatBhawan.getQuaterId());

		return GRAM_PANCHAYAT_PROGRESS_REPORT;
	}
	
	
	@RequestMapping(value="qprgGramPanchayatDistrict",method = RequestMethod.POST)
	public String getQprgGramPanchayatDistrict()
	{
		return GRAM_PANCHAYAT_PROGRESS_REPORT;
	}
	@RequestMapping(value="qprgGramPanchayatReport",method = RequestMethod.POST)
	public String getQprgGramPanchayatReport()
	{
		return GRAM_PANCHAYAT_PROGRESS_REPORT;
	}
	
	@RequestMapping(value="saveQprPanchayatBhawanData1" , method=RequestMethod.POST)
	private String saveQprPanchayatBhawanData(@ModelAttribute("QPR_GRAM_PANCHAYAT") QprPanchayatBhawan qprPanchayatBhawan,Model model ,RedirectAttributes redirectAttributes) throws IOException{
		
		for(int i=0; i<qprPanchayatBhawan.getQprPanhcayatBhawanDetails().size();i++) {
			if(qprPanchayatBhawan.getQprPanhcayatBhawanDetails().get(i).getFile() != null && qprPanchayatBhawan.getQprPanhcayatBhawanDetails().get(i).getFile().getSize()!=0) {
				
				MultipartFile file = qprPanchayatBhawan.getQprPanhcayatBhawanDetails().get(i).getFile();
				
				String filename = file.getOriginalFilename();
				String filenameWithoutExtnsn = FilenameUtils.removeExtension(filename); 
				String extnsn = FilenameUtils.getExtension(filename);
				
				AttachmentMaster attachmentMaster = enhancementService.findDetailsofAttachmentMaster();
				
				String path = attachmentMaster.getFileLocation();
				
				if(file.isEmpty()) {
					redirectAttributes.addFlashAttribute(Message.ERROR_KEY,"File Upload Required");
					return REDIRECT_GRAM_PANCHAYAT_PROGRESS_REPORT;
				}
				else if(!file.getContentType().equals("application/pdf")) {
					redirectAttributes.addFlashAttribute(Message.ERROR_KEY,"File Upload Type Required(Pdf)");
					return REDIRECT_GRAM_PANCHAYAT_PROGRESS_REPORT;
				}
				else if(file.getSize() > 2097152) {
					redirectAttributes.addFlashAttribute(Message.ERROR_KEY,"Max File Size is 2MB");
					return REDIRECT_GRAM_PANCHAYAT_PROGRESS_REPORT;
				}
				
				Date date = new Date() ;
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss") ;
				String newFilename = filenameWithoutExtnsn + "_" + dateFormat.format(date) + "." + extnsn;
				
				/*......................File Delete code.................*/
				
				File deleteFile = new File(qprPanchayatBhawan.getPath() + "/" + qprPanchayatBhawan.getDbFileName() );
					if(deleteFile.exists()) {
						deleteFile.delete();
					}
					/*......................File Delete code.................*/
					
				byte[] bytes = file.getBytes();
				File dir = new File(path + File.separator + "PanchayatBhawan");
				
				BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(dir+"/"+newFilename));
				stream.write(bytes);
				stream.close();
				
				qprPanchayatBhawan.getQprPanhcayatBhawanDetails().get(i).setFileContentType(file.getContentType());
				qprPanchayatBhawan.getQprPanhcayatBhawanDetails().get(i).setFileLocation(path);
				qprPanchayatBhawan.getQprPanhcayatBhawanDetails().get(i).setFileName(newFilename);
			}
		}
		panchayatBhawanService.saveQprPanchayatBhawanData(qprPanchayatBhawan);
		redirectAttributes.addFlashAttribute(Message.SUCCESS_KEY, Message.SAVE_SUCCESS);

		
		 return REDIRECT_GRAM_PANCHAYAT_PROGRESS_REPORT;
	}
	
	

}
