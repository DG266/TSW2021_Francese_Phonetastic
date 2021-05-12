package it.unisa.phonetastic.model.beans;

import java.io.Serializable;
import java.math.BigDecimal;

public class OrderCompositionBean implements Serializable{

	private static final long serialVersionUID = 1L;

	//private int order_id;      Not needed (check OrderBean)
	private int product_id;
	private int quantity;
	private BigDecimal price;
	private BigDecimal iva;
	private BigDecimal discount;
	
	public OrderCompositionBean() {
		product_id = -1;
		quantity = 0;
		price = new BigDecimal(0);
		iva = new BigDecimal(0);
		discount = new BigDecimal(0);
	}

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
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
	
}
