package gov.in.rgsa.controller;

import java.io.File;
import java.io.InputStream;

import javax.persistence.NoResultException;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.NumberUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import gov.in.rgsa.entity.FileUpload;
import gov.in.rgsa.service.FileUploadService;

@RestController(value = "/file/")
public class ImageRestController {
	
	@Autowired
	FileUploadService service;
	
	@RequestMapping(value = "image/{id}", method = RequestMethod.GET, produces = { MediaType.IMAGE_JPEG_VALUE,
			MediaType.APPLICATION_JSON_VALUE })
	public byte[] downloadImage(@PathVariable(value = "id") String id) {

		try {

			if (NumberUtils.isNumber(id)) {
				FileUpload fileUpload = service.findFileDetails(Integer.parseInt(id));
				File initialFile = new File(fileUpload.getFileLocation() + File.separator + fileUpload.getFileName());
				if (initialFile.exists()) {
					InputStream in = FileUtils.openInputStream(initialFile);
					byte[] b= IOUtils.toByteArray(in);
					return b;
				} else
					return null;
			} else {
				return null;
			}

		} catch (Exception e) {
			if (e instanceof NoResultException) {
				return null;
			}
			e.printStackTrace();

			return null;
		}

	}
}
