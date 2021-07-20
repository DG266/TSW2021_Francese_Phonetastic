package it.unisa.phonetastic.model.dao;

import java.sql.SQLException;
import java.util.Collection;

import it.unisa.phonetastic.model.bean.ProductBean;

public interface ProductDAO {

	public void insertProduct(ProductBean product) throws SQLException;

	public boolean deleteProduct(int id) throws SQLException;

	public ProductBean retrieveProductByID(int id) throws SQLException;
	
	public Collection<ProductBean> retrieveAllProducts(String order) throws SQLException;
	
	public void updateProduct(ProductBean sort) throws SQLException;
	
	public Collection<ProductBean> retrieveDiscountedProducts() throws SQLException;
	
	public Collection<ProductBean> retrieveProductsByManufacturer(String manufacturer) throws SQLException;
	
	public Collection<ProductBean> retrieveProductsByPartialName(String query) throws SQLException;
	
	public Collection<ProductBean> retrieveNewestProducts() throws SQLException;
	
	public Collection<ProductBean> retrieveAllProductsWithCategories() throws SQLException;
	
	public Collection<ProductBean> retrieveProductsByCategoryName(String catName) throws SQLException;
	
	public Collection<ProductBean> retrieveProductsByCategoryAndManufacturer(String catName, String manufacturer) throws SQLException;
	
}
