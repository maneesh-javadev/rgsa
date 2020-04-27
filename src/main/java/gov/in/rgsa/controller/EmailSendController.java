package gov.in.rgsa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import gov.in.rgsa.dto.EmaiSendDto;
import gov.in.rgsa.service.EmailService;
import io.micrometer.core.ipc.http.HttpSender.Request;

@RestController
public class EmailSendController
{
@Autowired
private EmailService emailService;
	
	@RequestMapping(value="sentEmail" , method=RequestMethod.GET)
	public void sentMessage(Model model){
		
		String sentTo="prajeev77@gmail.com ,rajeevkumarp806@gmail.com";
		String text ="Hii this is dummy message";
		String body ="This message service is created by rajeev to send email";
		EmaiSendDto emaiSendDto  = new EmaiSendDto();
		emaiSendDto.setSendTo(sentTo);
		emaiSendDto.setBody(body);
		emaiSendDto.setText(text);
		emailService.sendMessage(emaiSendDto);
	}
}
