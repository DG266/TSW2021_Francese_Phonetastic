package it.unisa.phonetastic.model;

import java.util.ArrayList;

import it.unisa.phonetastic.model.beans.ProductBean;

public class Cart {

	private ArrayList<CartItem> products;
	
	public Cart() {
		products = new ArrayList<CartItem>();
	}
	
	public void addProduct(ProductBean product) {
		
		boolean found = false;
		
		for(CartItem p : products) {
			if(p.getProduct().getId() == product.getId()) {
				p.incrementQuantity();
				found = true;
			}
		}
		if(!found) {
			products.add(new CartItem(product));
		}
	}
	
	public void setQuantity(int id, int quantity) {
		for(int i = 0; i < products.size(); i++) {
			CartItem item = products.get(i);
			if(item.getProduct().getId() == id) {
				if(quantity <= 0) {
					products.remove(item);
				}
				else {
					item.setQuantity(quantity);
				}
			}
		}
	}
	
	public void deleteProduct(ProductBean product) {
		for(CartItem p : products) {
			if(p.getProduct().getId() == product.getId()) {
				products.remove(p);
				break;
			}
		}
	}
	
	public void emptyCart() {
		products.clear();
	}
	
	public ArrayList<CartItem> getProducts(){
		return products;
	}
}
