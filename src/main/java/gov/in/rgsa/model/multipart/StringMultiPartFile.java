package gov.in.rgsa.model.multipart;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

public class StringMultiPartFile extends BareMultiPartFile<String> {
	
	public StringMultiPartFile(String name, String content, String contentType, String originalName) {
		this.name = name;
		this.content = content;
		this.contentType = contentType;
		this.originalName = originalName;
		this.size = content.length();
	}

	@Override
	public InputStream getInputStream() {
		return new ByteArrayInputStream(content.getBytes(StandardCharsets.UTF_8));
	}

	@Override
	public byte[] getBytes() {
		return content.getBytes();
	}
	
	@Override
	public boolean isEmpty() {
		return content.isEmpty();
	}

	@Override
	public void transferTo(File arg0) {
		
	}
	
	public static StringMultiPartFile createMultiPartFile(String name, String content) {
		return createMultiPartFile(name, content, "text/plain", name);
	}
	
	public static StringMultiPartFile createMultiPartFile(String name, String content, String contentType) {
		return createMultiPartFile(name, content, contentType, name);
	}
	
	public static StringMultiPartFile createMultiPartFile(String name, String content, String contentType, String originalName) {
		return new StringMultiPartFile(name, content, contentType, originalName);
	}

}
