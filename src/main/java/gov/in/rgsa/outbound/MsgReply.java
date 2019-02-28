package gov.in.rgsa.outbound;

import org.springframework.http.HttpStatus;

public class MsgReply<T> {
	int statusCode;
	String statusText;
	boolean success;
	String message = "Ok";
	T data = null;
	
	public MsgReply(boolean success, String message, T data, HttpStatus httpStatus) {
		this.statusCode = httpStatus.value();
		this.statusText = httpStatus.getReasonPhrase();
		this.message = message;
		this.data = data;
	}

	public MsgReply() {
		// TODO Auto-generated constructor stub
	}

	public int getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(int statusCode) {
		this.statusCode = statusCode;
	}

	public String getStatusText() {
		return statusText;
	}

	public void setStatusText(String statusText) {
		this.statusText = statusText;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}
	
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public T getData() {
		return data;
	}

	public void setData(T data) {
		this.data = data;
	}

	public static <T> MsgReply<T> okMessage(T data) {
		MsgReply<T> msg = new MsgReply<T>();
		msg.setData(data);
		msg.setStatusCode(HttpStatus.OK.value());
		msg.setStatusText(HttpStatus.OK.getReasonPhrase());
		msg.setSuccess(true);
		return msg;
	}
	
	public static <T> MsgReply<T> failMessage(String message) {
		MsgReply<T> msg = new MsgReply<T>();
		msg.setMessage(message);
		msg.setSuccess(false);
		msg.setStatusCode(HttpStatus.BAD_REQUEST.value());
		msg.setStatusText(HttpStatus.BAD_REQUEST.getReasonPhrase());
		return msg;
	}
	
	
	
}
