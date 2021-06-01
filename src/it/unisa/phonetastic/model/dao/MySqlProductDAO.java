package it.unisa.phonetastic.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import it.unisa.phonetastic.model.bean.ProductBean;

public class MySqlProductDAO implements ProductDAO{

	private static DataSource ds;

	static {
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context) initCtx.lookup("java:comp/env");

			ds = (DataSource) envCtx.lookup("jdbc/phonetastic_db");

		} catch (NamingException e) {
			System.out.println("Error:" + e.getMessage());
		}
	}
	
	private static final String TABLE_NAME = "product";

	// TODO Should I use synchronized?
	
	public synchronized void insertProduct(ProductBean product) throws SQLException {
		
		String insertSQL = "INSERT INTO " + TABLE_NAME
						 + " (product_name, product_description, quantity, price, iva, discount, image_path) VALUES (?, ?, ?, ?, ?, ?, ?)";
		
		try(Connection conn = ds.getConnection()){
			// TODO Should do that for each method
			conn.setAutoCommit(false);
			try(PreparedStatement ps = conn.prepareStatement(insertSQL)){
				ps.setString(1, product.getName());
				ps.setString(2, product.getDescription());
				ps.setInt(3, product.getQuantity());
				ps.setBigDecimal(4, product.getPrice());
				ps.setBigDecimal(5, product.getIva());
				ps.setBigDecimal(6, product.getDiscount());
				ps.setString(7, product.getImagePath());
				
				ps.executeUpdate();
				
				conn.commit();
			}
		}		
	}

	public synchronized boolean deleteProduct(int id) throws SQLException {
		
		int result = 0;
		
		String deleteSQL = "DELETE FROM " + TABLE_NAME + " WHERE product_id = ?";
		
		try(Connection conn = ds.getConnection()){
			try(PreparedStatement ps = conn.prepareStatement(deleteSQL)){
				ps.setInt(1, id);
				result = ps.executeUpdate();
			}
		}	
		return (result != 0);	
	}

	public synchronized ProductBean retrieveProductByID(int id) throws SQLException {

		ProductBean bean = new ProductBean();

		String selectSQL = "SELECT * FROM " + TABLE_NAME + " WHERE product_id = ?";
		
		try(Connection conn = ds.getConnection()){
			try(PreparedStatement ps = conn.prepareStatement(selectSQL)){
				
				ps.setInt(1, id);
				
				ResultSet rs = ps.executeQuery();
				
				if(rs.next()) {
					bean.setId(rs.getInt("product_id"));
					bean.setName(rs.getString("product_name"));
					bean.setDescription(rs.getString("product_description"));
					bean.setQuantity(rs.getInt("quantity"));
					bean.setPrice(rs.getBigDecimal("price"));
					bean.setIva(rs.getBigDecimal("iva"));
					bean.setDiscount(rs.getBigDecimal("discount"));
					bean.setImagePath(rs.getString("image_path"));
				}
			}
		}
		return bean;
	}

	public synchronized Collection<ProductBean> retrieveAllProducts(String order) throws SQLException {
		
		Collection<ProductBean> products = new LinkedList<ProductBean>();

		String selectSQL = "SELECT * FROM " + TABLE_NAME;
		
		
		if (order != null && !order.equals("")) {
			
			if(order.equalsIgnoreCase("id")) {
				order = "product_id";
			}
			else if(order.equalsIgnoreCase("name")) {
				order = "product_name";
			}
			else if(order.equalsIgnoreCase("description")) {
				order = "product_description";
			}
			selectSQL += " ORDER BY " + order;
		}
		
		try(Connection conn = ds.getConnection()){
			try(PreparedStatement ps = conn.prepareStatement(selectSQL)){
				ResultSet rs = ps.executeQuery();
				
				while(rs.next()) {
					ProductBean bean = new ProductBean();
					
					bean.setId(rs.getInt("product_id"));
					bean.setName(rs.getString("product_name"));
					bean.setDescription(rs.getString("product_description"));
					bean.setQuantity(rs.getInt("quantity"));
					bean.setPrice(rs.getBigDecimal("price"));
					bean.setIva(rs.getBigDecimal("iva"));
					bean.setDiscount(rs.getBigDecimal("discount"));
					bean.setImagePath(rs.getString("image_path"));
					
					products.add(bean);
				}
			}
		}
		return products;
	}

	public void updateProduct(ProductBean product) throws SQLException {
		
		String updateSQL = "UPDATE " + TABLE_NAME + " "
  	 	  		 		 + "SET product_name = ?, product_description = ?, quantity = ?, price = ?, iva = ?, discount = ?, image_path = ? "
  	 	  		 		 + "WHERE product_id = ?"; 
		
		try(Connection conn = ds.getConnection()){
			conn.setAutoCommit(false);
			try(PreparedStatement ps = conn.prepareStatement(updateSQL)){
				
				ps.setString(1, product.getName());
				ps.setString(2, product.getDescription());
				ps.setInt(3, product.getQuantity());
				ps.setBigDecimal(4, product.getPrice());
				ps.setBigDecimal(5, product.getIva());
				ps.setBigDecimal(6, product.getDiscount());
				ps.setString(7, product.getImagePath());
				
				ps.setInt(8, product.getId());
				
				ps.executeUpdate();
				
				conn.commit();
			}
		}
	}
}
