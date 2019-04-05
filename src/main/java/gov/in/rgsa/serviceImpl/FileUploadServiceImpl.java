package gov.in.rgsa.serviceImpl;

import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.stream.Collectors;

import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.imageio.stream.ImageOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.google.gson.Gson;

import gov.in.rgsa.dao.CommonRepository;
import gov.in.rgsa.entity.FileUpload;
import gov.in.rgsa.entity.StatewiseEntitiesCount;
import gov.in.rgsa.entity.UploadDocument;
import gov.in.rgsa.entity.ViewImage;
import gov.in.rgsa.model.FileUploadModel;
import gov.in.rgsa.service.FileUploadService;
import gov.in.rgsa.validater.CommonValidatorUtil;



@Service
public class FileUploadServiceImpl implements FileUploadService {

	@Autowired
	private CommonRepository dao;
/*
	@Autowired
	private UserPreference userPreference;*/

	private static String FILE_LOCATION; // = ResourceBundle.getBundle("application").getString("upload.file.location").trim();
	private static String FILE_LOCATION_JSON; // = ResourceBundle.getBundle("application").getString("homepage.json.data.file").trim();
	CommonValidatorUtil validatorUtil = new CommonValidatorUtil();



	@Value(value="${upload.file.location.officeorder}")
	public void setOfficeOrderUploadLocation(String fileLocation) {
		FILE_LOCATION = fileLocation;
	}

	@Value(value="${homepage.json.data.file}")
	public void setFileLocationJson(String fileLocation) {
		FILE_LOCATION_JSON = fileLocation;
	}

	@Override
	public Integer uploadFile(FileUploadModel file) throws Exception {

		FileUpload fileUpload = new FileUpload();
		String fileName = "image_"+(new Date().getTime())+"."+file.getFileExt();

		String directoryName = FILE_LOCATION + File.separator + file.getStateCode();

		File directory = new File(directoryName);
		if (!directory.exists()) {
			directory.mkdir();
		}

		directoryName = FILE_LOCATION + File.separator + file.getStateCode() + File.separator + "images";
		directory = new File(directoryName);
		if (!directory.exists()) {
			directory.mkdir();
		}

		if (!(validatorUtil.validateAlphaNumericForFilePath(directoryName)
				&& validatorUtil.validateAlphaNumericForFileName(fileName))) {
			throw new Exception("Error in file name or file path");
		}

		byte[] data = Base64.getMimeDecoder().decode(file.getFile());
		ByteArrayInputStream bis = new ByteArrayInputStream(data);
		BufferedImage bImage = ImageIO.read(bis);
		ImageIO.write(bImage, file.getFileContentType(), new File(directoryName + File.separatorChar + fileName));

		fileUpload.setFileName(fileName);
		fileUpload.setFileContentType(file.getFileContentType());
		fileUpload.setFileLocation(directoryName);
		fileUpload.setRemarks(file.getRemarks());
		fileUpload.setTestimonials(file.getTestimonials());
		fileUpload.setStateCode(file.getStateCode());
		fileUpload.setLocalBodyCode(file.getLocalBodyCode());
		fileUpload.setLatitude(file.getLatitude());
		fileUpload.setLongitude(file.getLongitude());
		fileUpload.setImeiNumber(file.getImeiNumber());
		fileUpload.setMobileNo(file.getMobileNo());
		fileUpload.setEmailId(file.getEmailId());
		fileUpload.setCreatedBy(file.getCreatedBy());
		fileUpload.setCreatedOn(new Date());
		fileUpload.setLastUpdatedBy(file.getCreatedBy());
		fileUpload.setLastUpdatedOn(new Date());
		fileUpload.setIsApproved(false);
		if (file.getCreatedBy() != null && file.getCreatedBy() > 0) {
			fileUpload.setIsApproved(true);
		}
		fileUpload.setUploadType(file.getUploadType().toString());
		fileUpload.setBpCode(file.getBpCode());
		fileUpload.setGpCode(file.getGpCode());
		fileUpload.setCategory(file.getCategory());

		FileUpload fileUpload2 = dao.update(fileUpload);
		return fileUpload2.getUploadFileId();

	}
	
	
	@Override
	public void uploadFileService(FileUploadModel file) throws Exception {

		String directoryName = FILE_LOCATION + File.separator + file.getStateCode();

		File directory = new File(directoryName);
		if (!directory.exists()) {
			directory.mkdir();
		}

		directoryName = FILE_LOCATION + File.separator + file.getStateCode() + File.separator + "images";
		directory = new File(directoryName);
		if (!directory.exists()) {
			directory.mkdir();
		}
		
		FileUpload fileUpload = new FileUpload();
		for (FileUploadModel model : file.getFileList()) {
			String fileName = "image_"+(new Date().getTime())+"."+model.getFileExt();
			

			

			if (!(validatorUtil.validateAlphaNumericForFilePath(directoryName)
					&& validatorUtil.validateAlphaNumericForFileName(fileName))) {
				throw new Exception("Error in file name or file path");
			}

			byte[] data = Base64.getMimeDecoder().decode(model.getFile());
			ByteArrayInputStream bis = new ByteArrayInputStream(data);
			BufferedImage bImage = ImageIO.read(bis);
			ImageIO.write(bImage, model.getFileContentType(), new File(directoryName + File.separatorChar + fileName));

			fileUpload.setFileName(fileName);
			fileUpload.setFileContentType(model.getFileContentType());
			fileUpload.setFileLocation(directoryName);
			fileUpload.setRemarks(file.getRemarks());
			fileUpload.setTestimonials(file.getTestimonials());
			fileUpload.setStateCode(file.getStateCode());
			fileUpload.setLocalBodyCode(file.getLocalBodyCode());
			fileUpload.setLatitude(file.getLatitude());
			fileUpload.setLongitude(file.getLongitude());
			fileUpload.setImeiNumber(file.getImeiNumber());
			
			fileUpload.setMobileNo(file.getMobileNo());
			fileUpload.setEmailId(file.getEmailId());
			fileUpload.setCreatedBy(file.getCreatedBy());
			fileUpload.setCreatedOn(new Date());
			fileUpload.setLastUpdatedBy(file.getCreatedBy());
			fileUpload.setLastUpdatedOn(new Date());
			fileUpload.setIsApproved(false);
			if (file.getCreatedBy() != null && file.getCreatedBy() > 0) {
				fileUpload.setIsApproved(true);
			}
			fileUpload.setUploadType(file.getUploadType().toString());
			fileUpload.setBpCode(file.getBpCode());
			fileUpload.setGpCode(file.getGpCode());
			fileUpload.setCategory(file.getCategory());
			
			

			dao.update(fileUpload);
		}
		

	}
	

	@Override
	public Integer uploadFile(CommonsMultipartFile multipartFile, FileUploadModel model) throws Exception {

	/*	String directoryName = FILE_LOCATION + File.separatorChar + userPreference.getStateCode();

		File directory = new File(directoryName);
		if (!directory.exists()) {
			directory.mkdir();
		}

		directoryName = FILE_LOCATION + File.separator + userPreference.getStateCode() + File.separator + "images";
		directory = new File(directoryName);
		if (!directory.exists()) {
			directory.mkdir();
		}

		String fileNameOriginal = multipartFile.getOriginalFilename();
		StringBuilder filePath = new StringBuilder();
		StringBuffer uploadFileName = new StringBuffer();
		Integer indexOfDot = fileNameOriginal.lastIndexOf(".");
		String fileExtension = fileNameOriginal.substring(indexOfDot, fileNameOriginal.length());
		uploadFileName.append("image_"+(new Date().getTime())+fileExtension);

		filePath.append(directoryName).append(File.separator).append(uploadFileName.toString());

		File serverFile = new File(filePath.toString());

		multipartFile.transferTo(serverFile);
		serverFile = new File(filePath.toString());
		File input = serverFile;
		String newImage=uploadFileName.toString();
//compress code
		if(!(fileExtension.contains("png") || fileExtension.contains("PNG"))){
			newImage="imagec_"+(new Date().getTime())+fileExtension;
			BufferedImage image = ImageIO.read(input);
			
		    File compressedImageFile = new File(directoryName+File.separator+newImage);
		    OutputStream os = new FileOutputStream(compressedImageFile);

		    Iterator<ImageWriter> iter = null;
		    
		      iter = ImageIO.getImageWritersByFormatName("jpg");
		    

		    final ImageWriter writer = iter.next();
		    
		    ImageOutputStream ios = ImageIO.createImageOutputStream(os);
		    writer.setOutput(ios);

		    ImageWriteParam param = writer.getDefaultWriteParam();

		    param.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
		    param.setCompressionQuality(0.5f);  // Change the quality value you prefer
		    writer.write(null, new IIOImage(image, null, null), param);

		    os.close();
		    ios.close();
		    writer.dispose();
		    
		    File deleteFile = new File(filePath.toString());
		    if(deleteFile.exists())
		    	deleteFile.delete();
		    
		}
	//end compress	
		
		FileUpload fileUpload = new FileUpload();
		fileUpload.setFileName(newImage);
		fileUpload.setFileContentType(multipartFile.getContentType());
		fileUpload.setFileLocation(directoryName);
		fileUpload.setCreatedBy(model.getCreatedBy());
		fileUpload.setCreatedOn(new Date());
		fileUpload.setLastUpdatedBy(model.getCreatedBy());
		fileUpload.setLastUpdatedOn(new Date());
		fileUpload.setIsApproved(true);
		fileUpload.setUploadType(model.getUploadType().toString());
		fileUpload.setCategory(model.getCategory());
		fileUpload.setStateCode(model.getStateCode());
		fileUpload.setLocalBodyCode(model.getLocalBodyCode());
		fileUpload.setGpCode(model.getGpCode());
		
		FileUpload fileUpload2 = dao.update(fileUpload);
		return fileUpload2.getUploadFileId();*/
		
		return null;
	}
	
	@Override
	public void uploadFileWeb(FileUploadModel model) throws Exception {

		
		String directoryName = FILE_LOCATION + File.separatorChar + model.getStateCode();

		File directory = new File(directoryName);
		if (!directory.exists()) {
			directory.mkdir();
		}

		directoryName = FILE_LOCATION + File.separator + model.getStateCode() + File.separator + "images";
		directory = new File(directoryName);
		if (!directory.exists()) {
			directory.mkdir();
		}
		Integer index=0;
		for (CommonsMultipartFile  multipartFile : model.getPibImageId()) {
			if(!multipartFile.isEmpty()){
				String fileNameOriginal = multipartFile.getOriginalFilename();
				StringBuilder filePath = new StringBuilder();
				StringBuffer uploadFileName = new StringBuffer();
				Integer indexOfDot = fileNameOriginal.lastIndexOf(".");
				String fileExtension = fileNameOriginal.substring(indexOfDot, fileNameOriginal.length());
				uploadFileName.append("image_"+(new Date().getTime())+fileExtension);

				filePath.append(directoryName).append(File.separator).append(uploadFileName.toString());

				File serverFile = new File(filePath.toString());

				multipartFile.transferTo(serverFile);
				serverFile = new File(filePath.toString());
				File input = serverFile;
				String newImage=uploadFileName.toString();
//compress code
				if(!(fileExtension.contains("png") || fileExtension.contains("PNG"))){
					newImage="imagec_"+(new Date().getTime())+fileExtension;
					BufferedImage image = ImageIO.read(input);
					
				    File compressedImageFile = new File(directoryName+File.separator+newImage);
				    OutputStream os = new FileOutputStream(compressedImageFile);
	
				    Iterator<ImageWriter> iter = null;
				    
				      iter = ImageIO.getImageWritersByFormatName("jpg");
				    
	
				    final ImageWriter writer = iter.next();
				    
				    ImageOutputStream ios = ImageIO.createImageOutputStream(os);
				    writer.setOutput(ios);
	
				    ImageWriteParam param = writer.getDefaultWriteParam();
	
				    param.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
				    param.setCompressionQuality(0.5f);  // Change the quality value you prefer
				    writer.write(null, new IIOImage(image, null, null), param);
	
				    os.close();
				    ios.close();
				    writer.dispose();
				    
				    File deleteFile = new File(filePath.toString());
				    if(deleteFile.exists())
				    	deleteFile.delete();
				    
				}
			//end compress	

				FileUpload fileUpload = new FileUpload();
				fileUpload.setFileName(newImage);
				fileUpload.setFileContentType(multipartFile.getContentType());
				fileUpload.setFileLocation(directoryName);
				fileUpload.setCreatedBy(model.getCreatedBy());
				fileUpload.setCreatedOn(new Date());
				fileUpload.setLastUpdatedBy(model.getCreatedBy());
				fileUpload.setLastUpdatedOn(new Date());
				fileUpload.setIsApproved(true);
				fileUpload.setUploadType(model.getUploadType().toString());
				fileUpload.setCategory(model.getCategory());
				fileUpload.setStateCode(model.getStateCode());
				fileUpload.setLocalBodyCode(model.getLocalBodyCode());
				fileUpload.setBpCode(model.getBpCode());
				fileUpload.setGpCode(model.getGpCode());
				if(model.getWebRemarks()!=null && !model.getWebRemarks().isEmpty())
					if(model.getWebRemarks().get(index)!=null && !model.getWebRemarks().get(index).trim().equals(""))
						fileUpload.setRemarks(model.getWebRemarks().get(index));
				if(model.getWebTestimonials()!=null && !model.getWebTestimonials().isEmpty())
					if(model.getWebTestimonials().get(index)!=null && !model.getWebTestimonials().get(index).trim().equals(""))
						fileUpload.setTestimonials(model.getWebTestimonials().get(index));
				
				dao.update(fileUpload);
			}
			index++;
		}
		
	}

	public byte[] setGlitchQuality(byte[] inputImageBytes, int quality) throws Exception
	{
		Iterator<ImageWriter> iter = ImageIO.getImageWritersByFormatName("png");
		ImageWriter writer = (ImageWriter)iter.next();  
		ImageWriteParam iwp = writer.getDefaultWriteParam(); 
	    BufferedImage originalImage = ImageIO.read(new ByteArrayInputStream(inputImageBytes)); 
	    IIOImage image = new IIOImage(originalImage, null, null);
	    ByteArrayOutputStream out=new ByteArrayOutputStream();
	    ImageOutputStream imageOut=ImageIO.createImageOutputStream(out);
	    writer.setOutput(imageOut);  
	    writer.write(null, image, iwp);  
	    byte[] qualityImageBytes = out.toByteArray();
	    return qualityImageBytes;
	}
	 
	
	public boolean canWriteFormat(String formatName) {
	    Iterator iter = ImageIO.getImageWritersByFormatName(formatName);
	    return iter.hasNext();
	  }
	@Override
	public FileUpload findFileDetails(Integer fileId) {

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("updateFileId", fileId);

		return dao.find("FIND_UPLOAD_FILES_BY_UPLOAD_FILE_ID", param);
	}

	
	@Override
	public List<ViewImage> findLatestSixImage() {

		// List<ViewImage> list = dao.findAll("FIND_LATEST_UPLOAD_IMAGE", null);
		List<ViewImage> list = new ArrayList();
		StringBuilder sql = new StringBuilder();
		sql.append(
				"select upload_files_id from rgsa.upload_files where is_approved=true order by created_on desc limit 100 ");
		List<Integer> idies = dao.findAllByNativeQuery(sql.toString(), null);
		idies.forEach(id -> {
			ViewImage image = new ViewImage();
			image.setUploadFileId(id);
			list.add(image);
		});

		List<ViewImage> images = list.stream().collect(Collectors.collectingAndThen(Collectors.toList(), collected -> {
			Collections.shuffle(collected);
			return collected.stream();
		})).limit(6).collect(Collectors.toList());

		return images;
	}


	@Override
	public List<UploadDocument> findNew() {
		// TODO Auto-generated method stub
		return dao.findAll("GET_WHATS_NEW", null);
	}
	
	@Override
	public List<StatewiseEntitiesCount> rgsaEntitiesCountFn(boolean isCenter) {

		return dao.findAll("getIndiaLevelEnitiesCount", null);
	}
	
	@Override
	public StatewiseEntitiesCount getDataFromJsonFile() {
		StatewiseEntitiesCount statewiseEntitiesCount=null;
		try {
			Gson gson = new Gson();
			statewiseEntitiesCount = gson.fromJson(new FileReader(FILE_LOCATION_JSON + File.separator + "rgsa_entity_count.json"), StatewiseEntitiesCount.class);
			System.out.println("path-->"+FILE_LOCATION_JSON + File.separator + "rgsa_entity_count.json");
			//statewiseEntitiesCountList = gson.fromJson(	new FileReader(FILE_LOCATION_JSON + File.separator + "rgsa_entity_count.json"),new TypeToken<List<StatewiseEntitiesCount>>() {	}.getType());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return statewiseEntitiesCount;

	}
	
	@Override
    public void downloadFiles(HttpServletRequest request,HttpServletResponse response,String filePath) throws IOException {
	 
			
	try {		
	
			
File file = new File(filePath);
if(file.exists()){
		
		String mimeType= URLConnection.guessContentTypeFromName(file.getName());
		if(mimeType==null){
			System.out.println("mimetype is not detectable, will take default");
			mimeType = "application/octet-stream";
		}
		
		System.out.println("mimetype : "+mimeType);
		
        response.setContentType(mimeType);
        
        /* "Content-Disposition : inline" will show viewable types [like images/text/pdf/anything viewable by browser] right on browser 
            while others(zip e.g) will be directly downloaded [may provide save as popup, based on your browser setting.]*/
        response.setHeader("Content-Disposition", String.format("inline; filename=\"" + file.getName() +"\""));

        
        /* "Content-Disposition : attachment" will be directly download, may provide save as popup, based on your browser setting*/
        //response.setHeader("Content-Disposition", String.format("attachment; filename=\"%s\"", file.getName()));
        
        response.setContentLength((int)file.length());

		InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

        //Copy bytes from source to destination(outputstream in this example), closes both streams.
        FileCopyUtils.copy(inputStream, response.getOutputStream());
		 
		
        }else{
        	
        }
	}catch(Exception e) {
		e.printStackTrace();
	}
    }
	
	
}
