package gov.in.rgsa.model.multipart;

import java.io.File;
import java.io.InputStream;

import org.springframework.web.multipart.MultipartFile;

public abstract class BareMultiPartFile<T> implements MultipartFile {
	
	protected String name;
	protected String originalName;
	protected String contentType;
	protected T content;
	protected long size;
	protected Object attachment;

	@Override
	public abstract byte[] getBytes();

	@Override
	public String getContentType() {
		return contentType;
	}

	@Override
	public abstract InputStream getInputStream();

	@Override
	public String getName() {
		return name;
	}

	@Override
	public String getOriginalFilename() {
		return originalName == null ? name : originalName;
	}

	@Override
	public long getSize() {
		return size;		
	}

	@Override
	public boolean isEmpty() {
		return getSize() == 0L;
	}

	@Override
	public abstract void transferTo(File arg0);

	public T getContent() {
		return content;
	}

	public void setContent(T content) {
		this.content = content;
	}

	public Object getAttachment() {
		return attachment;
	}

	public void setAttachment(Object attachment) {
		this.attachment = attachment;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setContentType(String contentType) {
		this.contentType = contentType;
	}

	public void setSize(long size) {
		this.size = size;
	}

}
