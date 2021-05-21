package it.unisa.phonetastic.model.bean;

import java.io.Serializable;
import java.math.BigDecimal;

public class ProductBean implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private int id;
	private String name;
	private String description;
	private int quantity;
	private BigDecimal price;
	private BigDecimal iva;
	private BigDecimal discount;
	private String imagePath;
	
	public ProductBean() {
		id = -1;
		name = null;
		description = null;
		quantity = 0;
		price = new BigDecimal(0);
		iva = new BigDecimal(0);
		discount = new BigDecimal(0);
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

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	
}
