package model;

public class Product {
	String product_name, brand, category;
	double price;
	int quantity, sold;
	
	public Product(String product_name, String brand, String category, double price, int quantity, int sold) {
		this.product_name = product_name;
		this.brand = brand;
		this.category = category;
		this.price = price;
		this.quantity = quantity;
		this.sold = sold;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getSold() {
		return sold;
	}

	public void setSold(int sold) {
		this.sold = sold;
	}
}
