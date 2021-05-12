package it.unisa.phonetastic.model.dao;

import java.sql.SQLException;
import java.util.Collection;

import it.unisa.phonetastic.model.beans.ProductBean;

public interface ProductDAO {

	public void insertProduct(ProductBean product) throws SQLException;

	public boolean deleteProduct(int id) throws SQLException;

	public ProductBean retrieveProductByID(int id) throws SQLException;
	
	public Collection<ProductBean> retrieveAllProducts(String order) throws SQLException;
	
	public void updateProduct(ProductBean product) throws SQLException;
}
