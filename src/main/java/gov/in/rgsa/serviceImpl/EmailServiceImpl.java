package gov.in.rgsa.serviceImpl;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import gov.in.rgsa.dto.EmaiSendDto;
import gov.in.rgsa.service.EmailService;

@Service
public class EmailServiceImpl implements EmailService
{

	@Autowired
	JavaMailSender  javaMailSender ;
	
	@Value("${spring.sendTo}")
	private String sendFrom;
	
	@Override
	public void sendMessage(EmaiSendDto emaiSendDto)
	{
		SimpleMailMessage  mailMessage = new SimpleMailMessage();
		String [] mail = emaiSendDto.getSendTo().split(",");
		for (int i = 0; i < mail.length; i++)
		{
			mailMessage.setTo(mail[i]);
			mailMessage.setFrom(sendFrom);
			mailMessage.setSubject(emaiSendDto.getBody());
			mailMessage.setText(emaiSendDto.getText());
			mailMessage.setSentDate(new Date());
			
			
			
		}
		javaMailSender.send(mailMessage);
	}

}
