package gov.in.rgsa.utils;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import gov.in.rgsa.entity.FileNode;
import gov.in.rgsa.entity.FileNode.STATUS;
import gov.in.rgsa.model.multipart.FileNodeMultipart;

public class FileNodeUtils {
	public static enum UPLOAD_STATUS{
		NOT_REQUESTED,
		NEVER_DOWNLOADED,
		REQUESTED_FAILED,
		REQUESTED_SUCCESS,
		UPDATE_PROHIBITED
	}
	
	private MultipartFile multipartFile;
	private UPLOAD_STATUS uploadStatus = UPLOAD_STATUS.NOT_REQUESTED;
	private Exception lastException;
	private FileNode fileNode;
	
	public FileNodeUtils(MultipartFile multipartFile) {
		this.multipartFile = multipartFile;
		this.fileNode = new FileNode();
	}
	
	public FileNodeUtils(MultipartFile multipartFile, FileNode fileNode) {
		this.multipartFile = multipartFile;
		this.fileNode = fileNode;
	}
	
	
	public FileNodeUtils makeStructure(String uploadPath, String uploadName, STATUS status) {
		fileNode.setFileMime(this.multipartFile.getContentType());
		fileNode.setFileSize(this.multipartFile.getSize());
		fileNode.setUploadName(this.multipartFile.getOriginalFilename());
		fileNode.setFileName(uploadName);
		fileNode.setFilePath(uploadPath);
		fileNode.setStatus(status.getValue());
		return this;
	}
	
	public FileNodeUtils performUpload() {
		final STATUS currentStatus = STATUS.valueOf(fileNode.getStatus());
		try{  
	        BufferedOutputStream bout = new BufferedOutputStream(new FileOutputStream(
	        		fileNode.getFilePath()+ File.separatorChar + fileNode.getFileName()));
	        bout.write(this.multipartFile.getBytes());
	        bout.flush();
	        bout.close();
	        // Upload complete change state
	        uploadStatus = UPLOAD_STATUS.REQUESTED_SUCCESS;
	        switch(currentStatus) {
	        case MODIFIED:
	        	break;
	        case UPLOADED:
	        	fileNode.setStatus(STATUS.MODIFIED.getValue());
	        	break;
	        default:
	        	fileNode.setStatus(STATUS.UPLOADED.getValue());
	        	break;	        	
	        }
	    }catch(Exception e){
	    	// @TODO: log Error
	    	System.out.println(e);
	    	this.lastException = e;
	    	uploadStatus = UPLOAD_STATUS.REQUESTED_FAILED;
	    }
		return this;
	}


	public MultipartFile getMultipartFile() {
		return multipartFile;
	}

	public void setMultipartFile(MultipartFile multipartFile) {
		this.multipartFile = multipartFile;
	}

	public UPLOAD_STATUS getUploadStatus() {
		return uploadStatus;
	}

	public void setUploadStatus(UPLOAD_STATUS uploadStatus) {
		this.uploadStatus = uploadStatus;
	}

	public Exception getLastException() {
		return lastException;
	}

	public void setLastException(Exception lastException) {
		this.lastException = lastException;
	}
	
	public FileNode getFileNode() {
		return fileNode;
	}

	public void setFileNode(FileNode fileNode) {
		this.fileNode = fileNode;
	}
	
	public boolean hasError() {
		return lastException != null;
	}

	public static FileNodeUtils createNewFile(MultipartFile multipartFile, String uploadPath, String uploadName) {
		return createNewFile(multipartFile, uploadPath, uploadName, STATUS.PENDING);
	} 
	
	public static FileNodeUtils createNewFile(MultipartFile multipartFile, String uploadPath, String uploadName, STATUS status) {
		FileNodeUtils fileNodeUtils = new FileNodeUtils(multipartFile);
		fileNodeUtils.makeStructure(uploadPath, uploadName, status).performUpload();
		return fileNodeUtils;
	}
	
	public static FileNodeUtils updateFile(MultipartFile multipartFile, FileNode previousFileNode) {
		FileNodeUtils fileNodeUtils = new FileNodeUtils(multipartFile, previousFileNode);
		fileNodeUtils.performUpload();
		return fileNodeUtils;
	}
	
	public static boolean fileExists(String filePath, String fileName) {
		File file = new File(Paths.get(filePath, fileName).toString());
		return file.exists();
	}
	
	public static String readFile(String filePath, String fileName) throws IOException {
		return new String(Files.readAllBytes(Paths.get(filePath, fileName)));
	}
	
	public static void streamFileNode(FileNode fileNode, HttpServletResponse response) {
		streamFileNode(fileNode, response, true);
	}
	
	public static void streamFileNode(FileNode fileNode, HttpServletResponse response, boolean inline) {		
		if(fileNode == null) {
			setTextResponse("No file has been uploaded", response);
			return;
		}
		MultipartFile uploadedFile = new FileNodeMultipart(fileNode);
		response.setContentType(uploadedFile.getContentType());
		String disposition = String.format("%s; filename=\"%s\"", inline ? "inline" : "attachment", uploadedFile.getOriginalFilename());
		response.setHeader("Content-Disposition", disposition);
		response.setContentLength((int) uploadedFile.getSize());
		
		//Copy bytes from source to destination(outputstream in this example), closes both streams.
		try {
			FileCopyUtils.copy(uploadedFile.getInputStream(), response.getOutputStream());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			setTextResponse("Some error occured while reading file.", response);
		}
	}
	
	private static void setTextResponse(String content, HttpServletResponse response) {
		response.setContentType("text/plain;charset=UTF-8");
		response.setContentLength(content.length());
		response.setHeader("Content-Disposition", "inline");
        ServletOutputStream sout;
		try {
			sout = response.getOutputStream();
			sout.print(content);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}        
	}

}
