package it.unisa.phonetastic.model;

import java.util.ArrayList;

public class Cart {

	private ArrayList<ProductBean> products;
	
	public Cart() {
		products = new ArrayList<ProductBean>();
	}
	
	public void addProduct(ProductBean product) {
		products.add(product);
	}
	
	public void deleteProduct(ProductBean product) {
		for(ProductBean p : products) {
			if(p.getId() == product.getId()) {
				products.remove(p);
				break;
			}
		}
	}
	
	public void emptyCart() {
		products.clear();
	}
	
	public ArrayList<ProductBean> getProducts(){
		return products;
	}
}
