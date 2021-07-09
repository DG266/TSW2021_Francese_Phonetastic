package it.unisa.phonetastic.model.bean;

import java.io.Serializable;
import java.math.BigDecimal;

public class OrderCompositionBean implements Serializable{

	private static final long serialVersionUID = 1L;

	//private int order_id;      Not needed (check OrderBean)
	private int productId;
	private int quantity;
	private String productName;   // useful in case we want to print the product name in a "my-orders"-like page
	private BigDecimal price;
	private BigDecimal iva;
	private BigDecimal discount;
	
	public OrderCompositionBean() {
		productId = -1;
		quantity = 0;
		productName = null;
		price = new BigDecimal(0);
		iva = new BigDecimal(0);
		discount = new BigDecimal(0);
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int product_id) {
		this.productId = product_id;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
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

	@Override
	public String toString() {
		return "OrderCompositionBean [productId=" + productId + ", quantity=" + quantity + ", productName="
				+ productName + ", price=" + price + ", iva=" + iva + ", discount=" + discount + "]";
	}
}
