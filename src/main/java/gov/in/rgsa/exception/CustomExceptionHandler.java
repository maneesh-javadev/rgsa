package gov.in.rgsa.exception;

import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;

import org.springframework.stereotype.Component;

@Component("CustomExceptionHandler")
public class CustomExceptionHandler {

	private static final String COUSE = "Some things went wrong.";
	private static final String NO_SINGAL_RESULT = "Some things went wrong.Result set not found.";
	private static final String MULTIPAL_RESULT_SET = "Getting duplicate resultSet from data source.";

	public String findCouse(RuntimeException e) {

		if (e instanceof NoResultException) {
			return NO_SINGAL_RESULT;
		} else if (e instanceof RGSAException) {
			if (e.getMessage() != null)
				return e.getMessage();
			else
				return COUSE;
		} else if (e instanceof NonUniqueResultException) {
			return MULTIPAL_RESULT_SET;
		} else {
			return null;
		}
	}

}
