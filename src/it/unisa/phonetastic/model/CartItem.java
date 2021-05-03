package it.unisa.phonetastic.model;

public class CartItem {

	private ProductBean product;
	private int quantity;
	
	public CartItem(ProductBean product) {
		this.product = product;
		quantity = 1;
	}

	public ProductBean getProduct() {
		return product;
	}

	public void setProduct(ProductBean product) {
		this.product = product;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	public void incrementQuantity() {
		quantity++;
	}
	
	public void decrementQuantity() {
		quantity--;
	}
}
