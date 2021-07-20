package it.unisa.phonetastic.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import it.unisa.phonetastic.model.bean.CategoryBean;
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
		
		String insertSQL = "INSERT INTO " + TABLE_NAME + " "
						 + "(product_name, product_manufacturer, product_description, quantity, price, iva, discount, "
						 + "insertion_date, last_update_date, image_path, is_deleted) "
						 + "VALUES (?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), ?, ?)";
		
		try(Connection conn = ds.getConnection()){
			// TODO Should do that for each method
			conn.setAutoCommit(false);
			try(PreparedStatement ps = conn.prepareStatement(insertSQL)){
				ps.setString(1, product.getName());
				ps.setString(2, product.getManufacturer());
				ps.setString(3, product.getDescription());
				ps.setInt(4, product.getQuantity());
				ps.setBigDecimal(5, product.getPrice());
				ps.setBigDecimal(6, product.getIva());
				ps.setBigDecimal(7, product.getDiscount());
				ps.setString(8, product.getImagePath());
				ps.setBoolean(9, false);
				
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
					bean.setManufacturer(rs.getString("product_manufacturer"));
					bean.setDescription(rs.getString("product_description"));
					bean.setQuantity(rs.getInt("quantity"));
					bean.setPrice(rs.getBigDecimal("price"));
					bean.setIva(rs.getBigDecimal("iva"));
					bean.setDiscount(rs.getBigDecimal("discount"));
					bean.setInsertionDate(rs.getTimestamp("insertion_date"));
					bean.setLastUpdateDate(rs.getTimestamp("last_update_date"));
					bean.setImagePath(rs.getString("image_path"));
					bean.setDeleted(rs.getBoolean("is_deleted"));
				}
			}
		}
		return bean;
	}

	public synchronized Collection<ProductBean> retrieveAllProducts(String sort) throws SQLException {
		
		Collection<ProductBean> products = new LinkedList<ProductBean>();

		String selectSQL = "SELECT * FROM " + TABLE_NAME;
		
		
		if (sort != null && !sort.equals("")) {
			
			if(sort.equalsIgnoreCase("id")) {
				sort = "product_id";
			}
			else if(sort.equalsIgnoreCase("name")) {
				sort = "product_name";
			}
			else if(sort.equalsIgnoreCase("description")) {
				sort = "product_description";
			}
			selectSQL += " ORDER BY " + sort;
		}
		
		try(Connection conn = ds.getConnection()){
			try(Statement s = conn.createStatement()){
				ResultSet rs = s.executeQuery(selectSQL);
				
				while(rs.next()) {
					ProductBean bean = new ProductBean();
					
					bean.setId(rs.getInt("product_id"));
					bean.setName(rs.getString("product_name"));
					bean.setManufacturer(rs.getString("product_manufacturer"));
					bean.setDescription(rs.getString("product_description"));
					bean.setQuantity(rs.getInt("quantity"));
					bean.setPrice(rs.getBigDecimal("price"));
					bean.setIva(rs.getBigDecimal("iva"));
					bean.setDiscount(rs.getBigDecimal("discount"));
					bean.setInsertionDate(rs.getTimestamp("insertion_date"));
					bean.setLastUpdateDate(rs.getTimestamp("last_update_date"));
					bean.setImagePath(rs.getString("image_path"));
					bean.setDeleted(rs.getBoolean("is_deleted"));
					
					products.add(bean);
				}
			}
		}
		return products;
	}

	public synchronized void updateProduct(ProductBean product) throws SQLException {
		
		String updateSQL = "UPDATE " + TABLE_NAME + " "
  	 	  		 		 + "SET product_name = ?, product_manufacturer = ?, product_description = ?, "
  	 	  		 		 + "quantity = ?, price = ?, iva = ?, discount = ?, insertion_date = ?, last_update_date = CURRENT_TIMESTAMP(), "
  	 	  		 		 + "image_path = ?, is_deleted = ? "
  	 	  		 		 + "WHERE product_id = ?"; 
		
		try(Connection conn = ds.getConnection()){
			conn.setAutoCommit(false);
			try(PreparedStatement ps = conn.prepareStatement(updateSQL)){
				
				ps.setString(1, product.getName());
				ps.setString(2, product.getManufacturer());
				ps.setString(3, product.getDescription());
				ps.setInt(4, product.getQuantity());
				ps.setBigDecimal(5, product.getPrice());
				ps.setBigDecimal(6, product.getIva());
				ps.setBigDecimal(7, product.getDiscount());
				ps.setTimestamp(8, product.getInsertionDate());
				ps.setString(9, product.getImagePath());
				ps.setBoolean(10, product.isDeleted());
				
				ps.setInt(11, product.getId());
				
				ps.executeUpdate();
				
				conn.commit();
			}
		}
	}
	
	public synchronized Collection<ProductBean> retrieveDiscountedProducts() throws SQLException {
		Collection<ProductBean> products = new LinkedList<ProductBean>();

		String selectSQL = "SELECT * FROM " + TABLE_NAME + "WHERE discount > 0";
		
		try(Connection conn = ds.getConnection()){
			try(Statement s = conn.createStatement()){
				ResultSet rs = s.executeQuery(selectSQL);
				
				while(rs.next()) {
					ProductBean bean = new ProductBean();
					
					bean.setId(rs.getInt("product_id"));
					bean.setName(rs.getString("product_name"));
					bean.setManufacturer(rs.getString("product_manufacturer"));
					bean.setDescription(rs.getString("product_description"));
					bean.setQuantity(rs.getInt("quantity"));
					bean.setPrice(rs.getBigDecimal("price"));
					bean.setIva(rs.getBigDecimal("iva"));
					bean.setDiscount(rs.getBigDecimal("discount"));
					bean.setInsertionDate(rs.getTimestamp("insertion_date"));
					bean.setLastUpdateDate(rs.getTimestamp("last_update_date"));
					bean.setImagePath(rs.getString("image_path"));
					bean.setDeleted(rs.getBoolean("is_deleted"));
					
					products.add(bean);
				}
			}
		}
		return products;
	}
	
	public synchronized Collection<ProductBean> retrieveProductsByManufacturer(String manufacturer) throws SQLException {
		
		Collection<ProductBean> products = new LinkedList<ProductBean>();

		String selectSQL = "SELECT * FROM " + TABLE_NAME + " WHERE product_manufacturer = ?";
		
		try(Connection conn = ds.getConnection()){
			try(PreparedStatement ps = conn.prepareStatement(selectSQL)){
				
				ps.setString(1, manufacturer);	
				
				ResultSet rs = ps.executeQuery();
				
				while(rs.next()) {
					ProductBean bean = new ProductBean();
					
					bean.setId(rs.getInt("product_id"));
					bean.setName(rs.getString("product_name"));
					bean.setManufacturer(rs.getString("product_manufacturer"));
					bean.setDescription(rs.getString("product_description"));
					bean.setQuantity(rs.getInt("quantity"));
					bean.setPrice(rs.getBigDecimal("price"));
					bean.setIva(rs.getBigDecimal("iva"));
					bean.setDiscount(rs.getBigDecimal("discount"));
					bean.setInsertionDate(rs.getTimestamp("insertion_date"));
					bean.setLastUpdateDate(rs.getTimestamp("last_update_date"));
					bean.setImagePath(rs.getString("image_path"));
					bean.setDeleted(rs.getBoolean("is_deleted"));
					
					products.add(bean);
				}
			}
		}
		
		return products;
	}
	
	public synchronized Collection<ProductBean> retrieveProductsByPartialName(String query) throws SQLException {
		
		Collection<ProductBean> products = new LinkedList<ProductBean>();

		String selectSQL = "SELECT * FROM " + TABLE_NAME + " WHERE product_name LIKE ?";
		
		try(Connection conn = ds.getConnection()){
			try(PreparedStatement ps = conn.prepareStatement(selectSQL)){
				
				ps.setString(1, "%" + query + "%");	// Need this to create a query similar to SELECT * FROM table WHERE name LIKE %a%
				
				ResultSet rs = ps.executeQuery();
				
				while(rs.next()) {
					ProductBean bean = new ProductBean();
					
					bean.setId(rs.getInt("product_id"));
					bean.setName(rs.getString("product_name"));
					bean.setManufacturer(rs.getString("product_manufacturer"));
					bean.setDescription(rs.getString("product_description"));
					bean.setQuantity(rs.getInt("quantity"));
					bean.setPrice(rs.getBigDecimal("price"));
					bean.setIva(rs.getBigDecimal("iva"));
					bean.setDiscount(rs.getBigDecimal("discount"));
					bean.setInsertionDate(rs.getTimestamp("insertion_date"));
					bean.setLastUpdateDate(rs.getTimestamp("last_update_date"));
					bean.setImagePath(rs.getString("image_path"));
					bean.setDeleted(rs.getBoolean("is_deleted"));
					
					products.add(bean);
				}
			}
		}
		
		return products;
	}
	
	public synchronized Collection<ProductBean> retrieveNewestProducts() throws SQLException {
		
		Collection<ProductBean> products = new LinkedList<ProductBean>();

		String selectSQL = "SELECT * FROM " + TABLE_NAME + " ORDER BY insertion_date DESC LIMIT 8";
		
		try(Connection conn = ds.getConnection()){
			try(Statement s = conn.createStatement()){
				ResultSet rs = s.executeQuery(selectSQL);
				
				while(rs.next()) {
					ProductBean bean = new ProductBean();
					
					bean.setId(rs.getInt("product_id"));
					bean.setName(rs.getString("product_name"));
					bean.setManufacturer(rs.getString("product_manufacturer"));
					bean.setDescription(rs.getString("product_description"));
					bean.setQuantity(rs.getInt("quantity"));
					bean.setPrice(rs.getBigDecimal("price"));
					bean.setIva(rs.getBigDecimal("iva"));
					bean.setDiscount(rs.getBigDecimal("discount"));
					bean.setInsertionDate(rs.getTimestamp("insertion_date"));
					bean.setLastUpdateDate(rs.getTimestamp("last_update_date"));
					bean.setImagePath(rs.getString("image_path"));
					bean.setDeleted(rs.getBoolean("is_deleted"));
					
					products.add(bean);
				}
			}
		}
		
		return products;
	}
	
	public synchronized Collection<ProductBean> retrieveAllProductsWithCategories() throws SQLException {
		
		Collection<ProductBean> products = new LinkedList<ProductBean>();
		int lastProductId = -1;
		
		String selectSQL = "SELECT P.product_id, product_name, product_manufacturer, product_description, quantity, price, iva, discount, "
						 + "insertion_date, last_update_date, image_path, is_deleted, "
						 + "C.cat_id, cat_name, superior_cat " 
						 + "FROM  product P, product_categories PC, category C "
						 + "WHERE P.product_id = PC.product_id AND PC.cat_id = C.cat_id";
		
		try(Connection conn = ds.getConnection()){
			try(Statement s = conn.createStatement()){
				
				ResultSet rs = s.executeQuery(selectSQL);
				ProductBean product = null;
				ArrayList<CategoryBean> categories = null;
				
				while(rs.next()) {
					if(rs.getInt("product_id") != lastProductId) {
						product = new ProductBean();
						categories = new ArrayList<>();
						
						product.setId(rs.getInt("product_id"));
						product.setName(rs.getString("product_name"));
						product.setManufacturer(rs.getString("product_manufacturer"));
						product.setDescription(rs.getString("product_description"));
						product.setQuantity(rs.getInt("quantity"));
						product.setPrice(rs.getBigDecimal("price"));
						product.setIva(rs.getBigDecimal("iva"));
						product.setDiscount(rs.getBigDecimal("discount"));
						product.setInsertionDate(rs.getTimestamp("insertion_date"));
						product.setLastUpdateDate(rs.getTimestamp("last_update_date"));
						product.setImagePath(rs.getString("image_path"));
						product.setDeleted(rs.getBoolean("is_deleted"));
						product.setCategories(categories);
						
						products.add(product);
						
						lastProductId = rs.getInt("product_id");
					}
					
					CategoryBean category = new CategoryBean();
					category.setCategoryId(rs.getInt("cat_id"));
					category.setCategoryName(rs.getString("cat_name"));
					category.setSuperiorCategoryId(rs.getInt("superior_cat"));
				}
				
			}
		}

		return products;
	}
	
	public synchronized Collection<ProductBean> retrieveProductsByCategoryName(String catName) throws SQLException {
		
		Collection<ProductBean> products = new LinkedList<ProductBean>();
		int lastProductId = -1;
		
		String selectSQL = "SELECT P.product_id, product_name, product_manufacturer, product_description, quantity, price, iva, discount, "
						 + "insertion_date, last_update_date, image_path, is_deleted, "
						 + "C.cat_id, cat_name, superior_cat " 
						 + "FROM  product P, product_categories PC, category C "
						 + "WHERE P.product_id = PC.product_id AND PC.cat_id = C.cat_id AND cat_name = ?";
		
		try(Connection conn = ds.getConnection()){
			try(PreparedStatement ps = conn.prepareStatement(selectSQL)){
				
				ps.setString(1, catName);
				
				ResultSet rs = ps.executeQuery();
				ProductBean product = null;
				ArrayList<CategoryBean> categories = null;
				
				while(rs.next()) {
					if(rs.getInt("product_id") != lastProductId) {
						product = new ProductBean();
						categories = new ArrayList<>();
						
						product.setId(rs.getInt("product_id"));
						product.setName(rs.getString("product_name"));
						product.setManufacturer(rs.getString("product_manufacturer"));
						product.setDescription(rs.getString("product_description"));
						product.setQuantity(rs.getInt("quantity"));
						product.setPrice(rs.getBigDecimal("price"));
						product.setIva(rs.getBigDecimal("iva"));
						product.setDiscount(rs.getBigDecimal("discount"));
						product.setInsertionDate(rs.getTimestamp("insertion_date"));
						product.setLastUpdateDate(rs.getTimestamp("last_update_date"));
						product.setImagePath(rs.getString("image_path"));
						product.setDeleted(rs.getBoolean("is_deleted"));
						product.setCategories(categories);
						
						products.add(product);
						
						lastProductId = rs.getInt("product_id");
					}
					
					CategoryBean category = new CategoryBean();
					category.setCategoryId(rs.getInt("cat_id"));
					category.setCategoryName(rs.getString("cat_name"));
					category.setSuperiorCategoryId(rs.getInt("superior_cat"));
				}
			}
		}

		return products;
	}
	
	public synchronized Collection<ProductBean> retrieveProductsByCategoryAndManufacturer(String catName, String manufacturer) throws SQLException {
		
		Collection<ProductBean> products = new LinkedList<ProductBean>();
		int lastProductId = -1;
		
		String selectSQL = "SELECT P.product_id, product_name, product_manufacturer, product_description, quantity, price, iva, discount, "
						 + "insertion_date, last_update_date, image_path, is_deleted, "
						 + "C.cat_id, cat_name, superior_cat " 
						 + "FROM  product P, product_categories PC, category C "
						 + "WHERE P.product_id = PC.product_id AND PC.cat_id = C.cat_id AND cat_name = ? AND product_manufacturer = ?";
		
		try(Connection conn = ds.getConnection()){
			try(PreparedStatement ps = conn.prepareStatement(selectSQL)){
				
				ps.setString(1, catName);
				ps.setString(2, manufacturer);
				
				ResultSet rs = ps.executeQuery();
				ProductBean product = null;
				ArrayList<CategoryBean> categories = null;
				
				while(rs.next()) {
					if(rs.getInt("product_id") != lastProductId) {
						product = new ProductBean();
						categories = new ArrayList<>();
						
						product.setId(rs.getInt("product_id"));
						product.setName(rs.getString("product_name"));
						product.setManufacturer(rs.getString("product_manufacturer"));
						product.setDescription(rs.getString("product_description"));
						product.setQuantity(rs.getInt("quantity"));
						product.setPrice(rs.getBigDecimal("price"));
						product.setIva(rs.getBigDecimal("iva"));
						product.setDiscount(rs.getBigDecimal("discount"));
						product.setInsertionDate(rs.getTimestamp("insertion_date"));
						product.setLastUpdateDate(rs.getTimestamp("last_update_date"));
						product.setImagePath(rs.getString("image_path"));
						product.setDeleted(rs.getBoolean("is_deleted"));
						product.setCategories(categories);
						
						products.add(product);
						
						lastProductId = rs.getInt("product_id");
					}
					
					CategoryBean category = new CategoryBean();
					category.setCategoryId(rs.getInt("cat_id"));
					category.setCategoryName(rs.getString("cat_name"));
					category.setSuperiorCategoryId(rs.getInt("superior_cat"));
				}
			}
		}

		return products;
	}
}
