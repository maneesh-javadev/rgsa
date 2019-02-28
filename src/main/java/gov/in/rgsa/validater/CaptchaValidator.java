package gov.in.rgsa.validater;

import javax.servlet.http.HttpSession;

import gov.in.rgsa.intercepter.Captcha;

public class CaptchaValidator {

	public boolean validateCaptcha(HttpSession session, String captchaAnswer) {
		boolean messageFlag = false;
		String captchaValue = (String) session
				.getAttribute(Captcha.CAPTCHA_KEY);
		if (captchaValue!=null && captchaValue.equals(captchaAnswer)) {
			messageFlag = true;
			session.removeAttribute(Captcha.CAPTCHA_KEY);
		}	
			
		return messageFlag;
	}
}
