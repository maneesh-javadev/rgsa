package gov.in.rgsa.service;

import gov.in.rgsa.dto.EmaiSendDto;

public interface EmailService
{

	public void sendMessage(EmaiSendDto emaiSendDto);
}
