package it.unisa.phonetastic.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import it.unisa.phonetastic.model.bean.PaymentMethodBean;

public class MySqlPaymentMethodDAO implements PaymentMethodDAO{

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

	private static final String TABLE_NAME = "payment_method";
	
	public void insertPaymentMethod(PaymentMethodBean paymentMethod) throws SQLException {
		
		String paymentMethodInsertSQL = "INSERT INTO " + TABLE_NAME
			 	 + "(user_id, p_method_id, card_number, expiry_date, cvv) VALUES (?, ?, ?, ?, ?)";
		
		String getNewPaymentMethodIdSQL = "SELECT COUNT(*) AS last_id FROM " + TABLE_NAME + " WHERE user_id = ?";
		
		try (Connection conn = ds.getConnection()) {
			
			// TODO Should do that for each method
			conn.setAutoCommit(false);
			
			int paymentMethodId = -1;
			
			try (PreparedStatement ps = conn.prepareStatement(getNewPaymentMethodIdSQL)) {
				ps.setInt(1, paymentMethod.getUserId());
				
				ResultSet rs = ps.executeQuery();
				if(rs.next()) {	
					paymentMethodId = rs.getInt("last_id") + 1;
				}
			}
			
			try (PreparedStatement ps = conn.prepareStatement(paymentMethodInsertSQL)) {
				ps.setInt(1, paymentMethod.getUserId());
				ps.setInt(2, paymentMethodId);    
				ps.setString(3, paymentMethod.getCardNumber());
				ps.setDate(4, paymentMethod.getExpiryDate());
				ps.setInt(5, paymentMethod.getCvv());
				
				ps.executeUpdate();
							
				conn.commit();
			}
		}
	}

	public boolean deletePaymentMethod(int userId, int paymentMethodId) throws SQLException {
		int result = 0;
		
		String deleteSQL = "DELETE FROM " + TABLE_NAME + " WHERE user_id = ? AND p_method_id = ?";
		
		try(Connection conn = ds.getConnection()){
			try(PreparedStatement ps = conn.prepareStatement(deleteSQL)){
				ps.setInt(1, userId);
				ps.setInt(2, paymentMethodId);
				result = ps.executeUpdate();
			}
		}	
		return (result != 0);	
	}

	public PaymentMethodBean retrievePaymentMethodByID(int userId, int paymentMethodId) throws SQLException {
		
		PaymentMethodBean bean = new PaymentMethodBean();	
		
		String selectSQL = "SELECT * FROM " + TABLE_NAME + " WHERE user_id = ? AND p_method_id = ?";
		
		try(Connection conn = ds.getConnection()){
			try(PreparedStatement ps = conn.prepareStatement(selectSQL)){
				
				ps.setInt(1, userId);
				ps.setInt(2, paymentMethodId);
				
				ResultSet rs = ps.executeQuery();
				
				if(rs.next()) {	
					bean.setUserId(rs.getInt("user_id"));
					bean.setPaymentMethodId(rs.getInt("p_method_id"));
					bean.setCardNumber(rs.getString("card_number"));
					bean.setExpiryDate(rs.getDate("expiry_date"));
					bean.setCvv(rs.getInt("cvv"));
				}
			}
		}
		return bean;
	}

	public Collection<PaymentMethodBean> retrievePaymentMethodsByUserID(int userId) throws SQLException {
		
		ArrayList<PaymentMethodBean> paymentMethods = new ArrayList<>();
		
		String selectSQL = "SELECT * FROM " + TABLE_NAME + " WHERE user_id = ?";
		
		try(Connection conn = ds.getConnection()){
			try(PreparedStatement ps = conn.prepareStatement(selectSQL)){
				ps.setInt(1, userId);
				
				ResultSet rs = ps.executeQuery();
				PaymentMethodBean bean = null;
				
				while(rs.next()) {
					bean = new PaymentMethodBean();
					
					bean.setUserId(rs.getInt("user_id"));
					bean.setPaymentMethodId(rs.getInt("p_method_id"));
					bean.setCardNumber(rs.getString("card_number"));
					bean.setExpiryDate(rs.getDate("expiry_date"));
					bean.setCvv(rs.getInt("cvv"));
					
					paymentMethods.add(bean);  
				}	
			}
		}
		return paymentMethods;
	}

}
