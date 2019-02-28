package gov.in.rgsa.utils;

import java.util.Arrays;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;

public class DataUtils {

	public static String getCommaSepValue(List<String> values) {

		if (CollectionUtils.isEmpty(values))
			return null;
		StringBuilder commaSepValueBuilder = new StringBuilder();

		for (int count = 0; count < values.size(); count++) {
			commaSepValueBuilder.append(values.get(count));
			if (count != values.size() - 1) {
				commaSepValueBuilder.append(",");
			}
		}
		return commaSepValueBuilder.toString();
	}

	public static List<String> getValues(String values) {

		if (StringUtils.isBlank(values))
			return null;
		else
			return Arrays.asList(values.split(","));
	}

}
