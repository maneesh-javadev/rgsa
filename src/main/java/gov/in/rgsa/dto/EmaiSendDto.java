package gov.in.rgsa.dto;

public class EmaiSendDto
{

	private String sendTo;
	
	private String text;
	
	private String body;

	public String getSendTo()
	{
		return sendTo;
	}

	public void setSendTo(String sendTo)
	{
		this.sendTo = sendTo;
	}

	public String getText()
	{
		return text;
	}

	public void setText(String text)
	{
		this.text = text;
	}

	public String getBody()
	{
		return body;
	}

	public void setBody(String body)
	{
		this.body = body;
	}
	
	
}
