package gov.in.rgsa.validater;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.stereotype.Component;

@Component("commonValidatorUtil")
public class CommonValidatorUtil {

	public boolean validateCharOnly(String str) {

		Pattern p = Pattern.compile("^[a-zA-Z]+$");
		Matcher m = p.matcher(str);
		return m.matches();
	}

	public boolean validateCharSomeSpecOnly(String str) {

		Pattern p = Pattern.compile("^[0-9a-zA-Z,-:_/&().''%&*@! ]+$");
		Matcher m = p.matcher(str);
		return m.matches();

	}
	
	public boolean validateCharForFullName(String arg) {
		Pattern p = Pattern.compile("^[a-zA-Z,.'' ]+$");
		Matcher m = p.matcher(arg);
		return m.matches();
	}


	public boolean validateNumberOnly(String str) {

		Pattern p = Pattern.compile("^[0-9]+$"); //T-?([0-9]*) .*[^0-9].*
		Matcher m = p.matcher(str);
		return m.matches();
	}
	
	public boolean validateNumberOnlyForList(List<String> str) {

		Pattern p = Pattern.compile("^[0-9a-zA-Z,-_. ]+$");
		Matcher m = null;
		for (String string : str) {
			 m = p.matcher(string);
		}
		if(m!=null)
		return m.matches();
		else
		return false;
	}

	public boolean validateAlphaNumeric(String arg) {
		Pattern p = Pattern.compile("^[0-9a-zA-Z]+$");
		Matcher m = p.matcher(arg);
		return m.matches();
	}

	public boolean validateAlphaNumericwithspecialchar(String arg) {
		Pattern p = Pattern.compile("^[a-z0-9A-Z,-/\\ \\']+$");
		Matcher m = p.matcher(arg);
		return m.matches();
	}

	public boolean validateAlphaNumericwithSpace(String arg) {
		Pattern p = Pattern.compile("^[0-9a-zA-Z ]+$");
		Matcher m = p.matcher(arg);
		return m.matches();
	}

	public boolean validateAlphaNumericwithSomespecialchar(String arg) {
		Pattern p = Pattern.compile("^[a-z0-9A-Z-/ ]+$");
		Matcher m = p.matcher(arg);
		return m.matches();
	}
	public boolean validateAlphaNumericForFilePath(String arg) {
		if(arg!=null && !arg.equalsIgnoreCase("")){
		if(!arg.contains("..")){
		Pattern p = Pattern.compile("^[a-z0-9A-Z-_.:/\\\\ ]+$");
		Matcher m = p.matcher(arg);
		return m.matches();
		}
		return false;
		}
		else
			return false;
	}
	

	public boolean validateAlphaNumericForFileName(String arg) {
		
		if(arg!=null && !arg.equalsIgnoreCase("")){
			if(!arg.contains("..")){
			Pattern p = Pattern.compile("^[a-z0-9A-Z-_. ]+$");
			Matcher m = p.matcher(arg);
			return m.matches();
			}
			return false;
		}
		else
			return false;
	}
	
    public boolean validateAlphaNumericForDoubleExt(String arg) {
		
		if(arg!=null && !arg.equalsIgnoreCase("")){
			if(!arg.contains("..")){
			Pattern p = Pattern.compile("^[a-z0-9A-Z-_]+$");
			Matcher m = p.matcher(arg);
			return m.matches();
			}
			return false;
		}
		else
			return false;
	}

	public boolean validateEmail(String userName) {
		Pattern emailNamePtrn = Pattern.compile(
				"^((([a-zA-Z]|\\d|[!#\\$%&'\\*\\+\\-\\/=\\?\\^_`{\\|}~]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])+(\\.([a-zA-Z]|\\d|[!#\\$%&'\\*\\+\\-\\/=\\?\\^_`{\\|}~]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])+)*)|((\\x22)((((\\x20|\\x09)*(\\x0d\\x0a))?(\\x20|\\x09)+)?(([\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x7f]|\\x21|[\\x23-\\x5b]|[\\x5d-\\x7e]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(\\\\([\\x01-\\x09\\x0b\\x0c\\x0d-\\x7f]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF]))))*(((\\x20|\\x09)*(\\x0d\\x0a))?(\\x20|\\x09)+)?(\\x22)))@((([a-zA-Z]|\\d|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(([a-zA-Z]|\\d|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])([a-zA-Z]|\\d|-|\\.|_|~|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])*([a-zA-Z]|\\d|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])))\\.)+(([a-zA-Z]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])|(([a-zA-Z]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])([a-zA-Z]|\\d|-|\\.|_|~|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])*([a-zA-Z]|[\\u00A0-\\uD7FF\\uF900-\\uFDCF\\uFDF0-\\uFFEF])))\\.?$");
		Matcher mtch = emailNamePtrn.matcher(userName);
		if (mtch.matches()) {
			return true;
		}
		return false;
	}

	public boolean validateCharNumCommonSpecialCharacters(String arg) {
		Pattern p = Pattern.compile("[^+#<><*=$/{|}~]+$");
		Matcher m = p.matcher(arg);
		return m.matches();
	}

	public boolean validateAlphaNumWithSpecial(String arg) {
		Pattern p = Pattern.compile("^[a-z0-9A-Z\\,\\/\\- ]+$");
		Matcher m = p.matcher(arg);
		return m.matches();
	}

	public boolean validateDate(String arg) {
		/*
		 * Pattern p = Pattern.compile (""); Matcher m = p.matcher(arg); return
		 * m.matches();
		 */
		Pattern pattern;
		Matcher matcher;
		pattern = Pattern.compile("(0?[1-9]|[12][0-9]|3[01])/(0?[1-9]|1[012])/((19|20)\\d\\d)");
		matcher = pattern.matcher(arg);

		if (matcher.matches()) {

			matcher.reset();

			if (matcher.find()) {

				String day = matcher.group(1);
				String month = matcher.group(2);
				int year = Integer.parseInt(matcher.group(3));

				if (day.equals("31") && (month.equals("4") || month.equals("6") || month.equals("9")
						|| month.equals("11") || month.equals("04") || month.equals("06") || month.equals("09"))) {
					return false; // only 1,3,5,7,8,10,12 has 31 days
				} else if (month.equals("2") || month.equals("02")) {
					// leap year
					if (year % 4 == 0) {
						if (day.equals("30") || day.equals("31")) {
							return false;
						} else {
							return true;
						}
					} else {
						if (day.equals("29") || day.equals("30") || day.equals("31")) {
							return false;
						} else {
							return true;
						}
					}
				} else {
					return true;
				}
			} else {
				return false;
			}
		} else {
			return false;
		}
	}
	
	
	public boolean checkDecPlaces(String dec,int decimalPlaces){
		boolean flag=true;
		try{
			Double.parseDouble(dec);
			flag=true;
		}
		catch(Exception e){
			flag=false;
		}
		try{
		if(flag && dec.contains(".")){
			String[] splittedNo=dec.split("\\.");
			if(splittedNo[1].length()>decimalPlaces){
				flag= false;
			}
		}
		}
		catch(Exception e){
			flag=false;
		}
		return flag;
	}

	public BigDecimal roundOffToDecPlaces(Double val,int decimalPlaces)
	{
		BigDecimal bd = new BigDecimal(val).setScale(decimalPlaces, RoundingMode.HALF_EVEN);
		return bd;
	}
	
	/*public static void main(String[] args) {
		String mobile = "L.YADAGIREESWARA RAO";
		CommonValidatorUtil s = new CommonValidatorUtil();
		System.out.println(s.validateCharForFullName(mobile.trim()));
		
	}*/

}
