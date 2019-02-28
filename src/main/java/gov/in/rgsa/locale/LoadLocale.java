package gov.in.rgsa.locale;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.Labels;
import gov.in.rgsa.entity.Language;
import gov.in.rgsa.exception.RGSAException;

public class LoadLocale {

	private static final String MESSAGE_LOCATION = "WEB-INF/MESSAGES";

	@Autowired
	private CommonRepository dao;

	@Autowired
	ServletContext context;

	public void init() {
		String contextPath = context.getRealPath("/");
		System.out.println("INFO : Language context path : " + contextPath);

		List<Language> languages = dao.findAll("FIND_All_LANGUAGE", null);
		if (CollectionUtils.isEmpty(languages))
			throw new RGSAException("Language not found");

		for (Language language : languages) {

			File directory = new File(contextPath + MESSAGE_LOCATION);
			if (!directory.isDirectory())
				directory.mkdir();

			FileOutputStream outPutStream = null;
			Writer writer = null;
			try {

				File file = new File(contextPath + MESSAGE_LOCATION + "/message_" + language.getLanguageIdentifier()
						+ ".properties");
				if(file.exists()){
					file.delete();
					file.createNewFile();
				}else{
					file.createNewFile();	
				}
				

				outPutStream = new FileOutputStream(file, true);
				writer = new BufferedWriter(new OutputStreamWriter(outPutStream, "UTF8"));

				Map<String, Object> params = new HashMap<>();
				params.put("languageId", language.getLanguageId());
				List<Labels> labels = dao.findAll("FIND_ALL_LABELS_BY_LANGUAGE_ID", params);
				for (Labels label : labels) {
					StringBuilder buildlable = new StringBuilder();
					buildlable.append(label.getLabelName());
					buildlable.append(" = ");
					buildlable.append(label.getLabelText()+"\n\n");

					writer.write(buildlable.toString());
				}
			} catch (IOException exp) {
				System.err.println("ERROR : Getting Exception while creating language properties file..");
			} finally {
				try {
					if (writer != null) {
						writer.flush();
						writer.close();
					}
					if (outPutStream != null)
						outPutStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

		}

	}
}
