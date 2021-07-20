package it.unisa.phonetastic.model.cart;

import java.math.BigDecimal;
import java.util.ArrayList;

import it.unisa.phonetastic.model.bean.ProductBean;

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
	
	public int getOrderedProductQuantity(int id) {
		for(CartItem p : products) {
			if(p.getProduct().getId() == id) {
				return p.getQuantity();
			}
		}
		return 0;
	}
	
	public BigDecimal getTotalWithIva() {
		
		BigDecimal total = new BigDecimal(0);
		for(CartItem item : products) {
			ProductBean product = item.getProduct();
			int quantity = item.getQuantity();
			total = total.add(product.getPriceWithIva().multiply(new BigDecimal(quantity)));
		}
		return total;
	}
	
	public BigDecimal getTotalWithDiscountAndIva() {
		
		BigDecimal total = new BigDecimal(0);
		for(CartItem item : products) {
			ProductBean product = item.getProduct();
			int quantity = item.getQuantity();
			total = total.add(product.getPriceWithDiscountAndIva().multiply(new BigDecimal(quantity)));
		}
		return total;
	}
	
	public BigDecimal getTotalDiscount() {
		BigDecimal totalDiscount = new BigDecimal(0);
		for(CartItem item : products) {
			ProductBean product = item.getProduct();
			if(product.getDiscount().compareTo(new BigDecimal(0)) > 0) {
				int quantity = item.getQuantity();
				BigDecimal discount = product.getPriceWithIva().subtract(product.getPriceWithDiscountAndIva());
				totalDiscount = totalDiscount.add(discount.multiply(new BigDecimal(quantity)));
			}	
		}
		return totalDiscount;
	}
	
	public void emptyCart() {
		products.clear();
	}
	
	public ArrayList<CartItem> getProducts(){
		return products;
	}
}
