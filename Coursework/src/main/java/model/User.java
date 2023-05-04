package model;

import java.io.File;

import javax.servlet.http.Part;

import resources.MyConstants;

public class User {
	String firstName, lastName, address, password, imageUrlFromPart, email, phoneNumber;
	
	public User(String firstName, String lastName, String address, String email, String password, String phoneNumber, Part part) {
		this.firstName = firstName;
		this.lastName = lastName;
		this.address = address;
		this.password = password;
		this.phoneNumber = phoneNumber;
		this.email = email;
		this.imageUrlFromPart = getImageUrl(part);
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getImageUrlFromPart() {
		return imageUrlFromPart;
	}

	public void setImageUrlFromPart(Part part) {
		this.imageUrlFromPart = getImageUrl(part);
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phonenumber) {
		this.phoneNumber = phonenumber;
	}
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	private String getImageUrl (Part part) {
		String savePath = MyConstants.IMAGE_DIR_SAVE_PATH;
		File fileSaveDir = new File(savePath);
		String imageUrl = null;
		if (!fileSaveDir.exists()) {
			fileSaveDir.mkdir();
		}
		String contentDisp = part.getHeader("content-disposition");
		String[] items = contentDisp.split(";");
		for (String s : items) {
			if (s.trim().startsWith("filename")) {
				imageUrl = s.substring(s.indexOf("=") + 2, s.length() - 1);
			}
		}
		if(imageUrl == null || imageUrl.isEmpty()) {
			imageUrl= "default.png";
		}
		return imageUrl;
	}

}
