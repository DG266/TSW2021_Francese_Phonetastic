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

import it.unisa.phonetastic.model.bean.AddressBean;

public class MySqlAddressDAO implements AddressDAO{
	
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

	private static final String TABLE_NAME = "user_address";

	public synchronized void insertAddress(AddressBean address) throws SQLException {
		
		String addressInsertSQL = "INSERT INTO " + TABLE_NAME
			 	 + "(user_id, address_id, state, city, province, cap, address) VALUES (?, ?, ?, ?, ?, ?, ?)";
		
		String getNewAddressIdSQL = "SELECT COUNT(*) AS last_id FROM " + TABLE_NAME + " WHERE user_id = ?";
		
		try (Connection conn = ds.getConnection()) {
			
			// TODO Should do that for each method
			conn.setAutoCommit(false);
			
			int addressId = -1;
			
			try (PreparedStatement ps = conn.prepareStatement(getNewAddressIdSQL)) {
				ps.setInt(1, address.getUserId());
				
				ResultSet rs = ps.executeQuery();
				if(rs.next()) {	
					addressId = rs.getInt("last_id") + 1;
				}
			}
			
			try (PreparedStatement ps = conn.prepareStatement(addressInsertSQL)) {
				ps.setInt(1, address.getUserId());
				ps.setInt(2, addressId);    
				ps.setString(3, address.getState());
				ps.setString(4, address.getCity());
				ps.setString(5, address.getProvince());
				ps.setString(6, address.getCap());
				ps.setString(7, address.getAddress());
				
				ps.executeUpdate();
							
				conn.commit();
			}
		}
	}
	
	public synchronized boolean deleteAddress(int userId, int addressId) throws SQLException {
		int result = 0;
		
		String deleteSQL = "DELETE FROM " + TABLE_NAME + " WHERE user_id = ? AND address_id = ?";
		
		try(Connection conn = ds.getConnection()){
			try(PreparedStatement ps = conn.prepareStatement(deleteSQL)){
				ps.setInt(1, userId);
				ps.setInt(2, addressId);
				result = ps.executeUpdate();
			}
		}	
		return (result != 0);	
	}
	
	public synchronized AddressBean retrieveAddressByID(int userId, int addressId) throws SQLException {
		
		AddressBean bean = new AddressBean();	
		
		String selectSQL = "SELECT * FROM " + TABLE_NAME + " WHERE user_id = ? AND address_id = ?";
		
		try(Connection conn = ds.getConnection()){
			try(PreparedStatement ps = conn.prepareStatement(selectSQL)){
				
				ps.setInt(1, userId);
				ps.setInt(2, addressId);
				
				ResultSet rs = ps.executeQuery();
				
				if(rs.next()) {	
					bean.setUserId(rs.getInt("user_id"));
					bean.setAddressId(rs.getInt("address_id"));
					bean.setState(rs.getString("state"));
					bean.setCity(rs.getString("city"));
					bean.setProvince(rs.getString("province"));
					bean.setCap(rs.getString("cap"));
					bean.setAddress(rs.getString("address"));
				}
			}
		}
		return bean;
	}
	
	public synchronized Collection<AddressBean> retrieveAddressesByUserID(int userId) throws SQLException{
		
		ArrayList<AddressBean> addresses = new ArrayList<>();
		
		String selectSQL = "SELECT * FROM " + TABLE_NAME + " WHERE user_id = ?";
		
		try(Connection conn = ds.getConnection()){
			try(PreparedStatement ps = conn.prepareStatement(selectSQL)){
				ps.setInt(1, userId);
				
				ResultSet rs = ps.executeQuery();
				AddressBean bean = null;
				
				while(rs.next()) {
					bean = new AddressBean();
					
					bean.setUserId(rs.getInt("user_id"));
					bean.setAddressId(rs.getInt("address_id"));
					bean.setState(rs.getString("state"));
					bean.setCity(rs.getString("city"));
					bean.setProvince(rs.getString("province"));
					bean.setCap(rs.getString("cap"));
					bean.setAddress(rs.getString("address"));
					
					addresses.add(bean);  
				}	
			}
		}
		return addresses;
	}
}
