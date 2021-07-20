package it.unisa.phonetastic.model.bean;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;

public class ProductBean implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private int id;
	private String name;
	private String manufacturer;
	private String description;
	private int quantity;
	private BigDecimal price;
	private BigDecimal iva;
	private BigDecimal discount;
	private Timestamp insertionDate;
	private Timestamp lastUpdateDate;
	private String imagePath;
	private boolean isDeleted;
	private ArrayList<CategoryBean> categories;
	
	public ProductBean() {
		id = -1;
		name = null;
		manufacturer = null;
		description = null;
		quantity = 0;
		price = new BigDecimal(0);
		iva = new BigDecimal(0);
		discount = new BigDecimal(0);
		insertionDate = null;
		lastUpdateDate = null;
		imagePath = null;
		isDeleted = false;
		categories = null;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getManufacturer() {
		return manufacturer;
	}

	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public BigDecimal getPrice() {
		return price;
	}
	
	public BigDecimal getPriceWithIva() {
		BigDecimal taxToAdd = price.multiply(iva.divide(new BigDecimal(100)));
		return price.add(taxToAdd);
	}
	
	public BigDecimal getPriceWithDiscountAndIva() {	
		BigDecimal priceDiscount = price.multiply(discount.divide(new BigDecimal(100)));
		BigDecimal priceDiscounted = price.subtract(priceDiscount);
		BigDecimal taxToAdd = priceDiscounted.multiply(iva.divide(new BigDecimal(100)));
		
		return priceDiscounted.add(taxToAdd);
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public BigDecimal getIva() {
		return iva;
	}

	public void setIva(BigDecimal iva) {
		this.iva = iva;
	}

	public BigDecimal getDiscount() {
		return discount;
	}

	public void setDiscount(BigDecimal discount) {
		this.discount = discount;
	}

	public Timestamp getInsertionDate() {
		return insertionDate;
	}

	public void setInsertionDate(Timestamp insertionDate) {
		this.insertionDate = insertionDate;
	}

	public Timestamp getLastUpdateDate() {
		return lastUpdateDate;
	}

	public void setLastUpdateDate(Timestamp lastUpdateDate) {
		this.lastUpdateDate = lastUpdateDate;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	
	public boolean isDeleted() {
		return isDeleted;
	}

	public void setDeleted(boolean isDeleted) {
		this.isDeleted = isDeleted;
	}

	public ArrayList<CategoryBean> getCategories() {
		return categories;
	}

	public void setCategories(ArrayList<CategoryBean> categories) {
		this.categories = categories;
	}

	public String toString() {
		return "ProductBean [id=" + id + ", name=" + name + ", manufacturer=" + manufacturer + ", description="
				+ description + ", quantity=" + quantity + ", price=" + price + ", iva=" + iva + ", discount="
				+ discount + ", insertionDate=" + insertionDate + ", lastUpdateDate=" + lastUpdateDate + ", imagePath="
				+ imagePath + ", isDeleted=" + isDeleted + ", categories=" + categories + "]";
	}

}
