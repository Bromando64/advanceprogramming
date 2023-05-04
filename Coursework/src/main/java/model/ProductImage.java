package model;

import java.io.File;

import javax.servlet.http.Part;


import resources.MyConstants;

public class ProductImage {
	int productID;
	String imageUrl;
	
	public ProductImage(Part part, int productID) {
		this.productID = productID;
		this.imageUrl = getImageUrl(part);
	}

	public int getProductID() {
		return productID;
	}

	public void setProductID(int productID) {
		this.productID = productID;
	}

	public String getImage_url() {
		return imageUrl;
	}

	public void setImage_url(Part part) {
		this.imageUrl = getImageUrl(part);
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
