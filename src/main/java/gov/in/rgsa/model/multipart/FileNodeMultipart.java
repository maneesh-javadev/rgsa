package gov.in.rgsa.model.multipart;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import gov.in.rgsa.entity.FileNode;

public class FileNodeMultipart extends BareMultiPartFile<byte[]> {
	private final String filePath;
	
	public FileNodeMultipart(FileNode fileNode) {
		this.name = fileNode.getFileName();
		this.contentType = fileNode.getFileMime();
		this.originalName = fileNode.getUploadName();
		this.size = fileNode.getFileSize();
		this.filePath = fileNode.getFilePath();
	}

	@Override
	public byte[] getBytes() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public InputStream getInputStream() {
		try {
			return new FileInputStream(getFile());
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public void transferTo(File arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public byte[] getContent() {
		if(this.content == null) {
			try {
				this.content = Files.readAllBytes(getFullPath());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return this.content;
	}

	@Override
	public void setContent(byte[] content) {
		this.content = content;
	}
	
	public Path getFullPath() {
		return Paths.get(filePath, name);
	}
	
	public File getFile() {
		return getFullPath().toFile();
	}
	
}
