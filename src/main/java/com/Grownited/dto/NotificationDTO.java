package com.Grownited.dto;

public class NotificationDTO {

    private Integer id;
    private String message;
    private String formattedDate;
    private boolean read;
    private String redirectUrl;
    private String type;

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getFormattedDate() {
		return formattedDate;
	}
	public void setFormattedDate(String formattedDate) {
		this.formattedDate = formattedDate;
	}
	public boolean isRead() {
		return read;
	}
	public void setRead(boolean read) {
		this.read = read;
	}
	public String getRedirectUrl() {
		return redirectUrl;
	}
	public void setRedirectUrl(String redirectUrl) {
		this.redirectUrl = redirectUrl;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}

    
    // getters + setters
    
    
}