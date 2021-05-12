package it.unisa.phonetastic.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import it.unisa.phonetastic.model.beans.OrderBean;
import it.unisa.phonetastic.model.beans.OrderCompositionBean;

public class MySqlOrderDAO implements OrderDAO{

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
	
	// Maybe a 1-to-1 (1 DAO - 1 table) approach would be better/more "correct".
	// In this case, I'm using 1 DAO for 2 (related) tables --> should make my life easier.
	private static final String TABLE_NAME = "order_info";
	private static final String AUX_TABLE_NAME = "order_composition";
	
	public synchronized void insertOrder(OrderBean order) throws SQLException{
		
		String orderInsertSQL = "INSERT INTO " + MySqlOrderDAO.TABLE_NAME
						 + "(coupon_id, state, creation_date, last_update_date, customer_id) VALUES (?, ?, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), ?)";
		
		String orderDetailsInsertSQL = "INSERT INTO " + MySqlOrderDAO.AUX_TABLE_NAME 
				 					 + "(order_id, product_id, quantity, price, iva, discount) VALUES (?, ?, ?, ?, ?, ?)";
		
		try(Connection conn = ds.getConnection()){
			// TODO Should do that for each method
			conn.setAutoCommit(false);
			
			Long orderId = (long) -1;
			
			try(PreparedStatement ps = conn.prepareStatement(orderInsertSQL, Statement.RETURN_GENERATED_KEYS)){
				ps.setString(1, order.getCoupon_id());
				ps.setString(2, String.valueOf(order.getState()));
				ps.setInt(3, order.getCustomer_id());
				
				ps.executeUpdate();
				
				// Retrieve the auto-generated order PK (useful in the next insert)
				ResultSet rs = ps.getGeneratedKeys();
				if(rs.next()) {
					orderId = rs.getLong(1);
				}

				// TODO Add an exception if something goes wrong while retrieving the id?
				
				conn.commit();
			}
			
			ArrayList<OrderCompositionBean> elements = (ArrayList<OrderCompositionBean>) order.getElements();

			try(PreparedStatement ps = conn.prepareStatement(orderDetailsInsertSQL)){
				for(OrderCompositionBean c : elements) {
					ps.setLong(1, orderId);
					ps.setInt(2, c.getProduct_id());
					ps.setInt(3, c.getQuantity());
					ps.setBigDecimal(4, c.getPrice());
					ps.setBigDecimal(5, c.getIva());
					ps.setBigDecimal(6, c.getDiscount());
					
					ps.executeUpdate();
					
					conn.commit();
				}
			}
		}
	}
	
	public boolean deleteOrder(int id) throws SQLException{
		
		int result = 0;
		
		String deleteSQL = "DELETE FROM " + MySqlOrderDAO.TABLE_NAME + " WHERE order_id = ?";
		
		// IMPORTANT: associated products will be automatically deleted (look at the db script)
		
		try(Connection conn = ds.getConnection()){
			try(PreparedStatement ps = conn.prepareStatement(deleteSQL)){
				ps.setInt(1, id);
				result = ps.executeUpdate();
			}
		}	
		return (result != 0);	
	}
	
	public OrderBean retrieveOrderByID(int id) throws SQLException{
		
		OrderBean bean = new OrderBean();
		boolean orderInfoSet = false;
		
		// Maybe 2 queries would have been better: in this way I create a large table which 
		// contains order_info stuff + order_composition stuff
		// I need to save just one time the order_info stuff (it's repeated in all the rows)
		
		String selectSQL = "SELECT O1.order_id, coupon_id, state, creation_date, last_update_date, customer_id, product_id, quantity, price, iva, discount "
						 + "FROM " + MySqlOrderDAO.TABLE_NAME + " O1 JOIN " + MySqlOrderDAO.AUX_TABLE_NAME + " O2 ON O1.order_id = O2.order_id "
						 + "WHERE O1.order_id = ?";
		
		try(Connection conn = ds.getConnection()){
			try(PreparedStatement ps = conn.prepareStatement(selectSQL)){
				ps.setInt(1, id);
				
				ResultSet rs = ps.executeQuery();
				
				ArrayList<OrderCompositionBean> elements = new ArrayList<OrderCompositionBean>();
				
				while(rs.next()) {
					// This single query retrieves all info regarding a specific order in one shot.
					// Considering that, I need to save "order_info" stuff during the first iteration,
					// after that, I can simply consider all the other columns (the composition of the specific order).
					if(!orderInfoSet) {
						bean.setId(rs.getInt("order_id"));
						bean.setCoupon_id(rs.getString("coupon_id"));
						bean.setState(rs.getString("state").charAt(0));
						bean.setCreationDate(rs.getTimestamp("creation_date"));
						bean.setLastUpdateDate(rs.getTimestamp("creation_date"));
						bean.setCustomer_id(rs.getInt("customer_id"));
						bean.setElements(elements);
						
						orderInfoSet = true;
					}
					OrderCompositionBean c = new OrderCompositionBean();
					c.setProduct_id(rs.getInt("product_id"));
					c.setQuantity(rs.getInt("quantity"));
					c.setPrice(rs.getBigDecimal("price"));
					c.setIva(rs.getBigDecimal("iva"));
					c.setDiscount(rs.getBigDecimal("discount"));
					elements.add(c);
				}	
			}
		}
		return bean;
	}
}
