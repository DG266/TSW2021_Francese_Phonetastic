package it.unisa.phonetastic.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import it.unisa.phonetastic.model.beans.UserBean;

public class MySqlUserDAO implements UserDAO {

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

	private static final String TABLE_NAME = "user_info";

	public synchronized void insertUser(UserBean user) throws SQLException {
		String insertSQL = "INSERT INTO " + MySqlUserDAO.TABLE_NAME
						 + "(email, pwd, first_name, last_name, birth_date, sex, tel_number) VALUES (?, ?, ?, ?, ?, ?, ?)";

		try (Connection conn = ds.getConnection()) {
			// TODO Should do that for each method
			conn.setAutoCommit(false);
			try (PreparedStatement ps = conn.prepareStatement(insertSQL)) {
				ps.setString(1, user.getEmail());
				ps.setString(2, user.getPassword());    // TODO Fix this: not good at all
				ps.setString(3, user.getFirstName());
				ps.setString(4, user.getLastName());
				ps.setDate(5, user.getBirthDate());
				if(user.getSex() == '\u0000') {
					ps.setString(6, null);
				}
				else {
					ps.setString(6, String.valueOf(user.getSex()));
				}
				ps.setString(7, user.getPhoneNumber());
				
				ps.executeUpdate();

				conn.commit();
			}
		}
	}

	public synchronized boolean deleteUser(int id) throws SQLException {
		int result = 0;
		
		String deleteSQL = "DELETE FROM " + MySqlUserDAO.TABLE_NAME + " WHERE user_id = ?";
		
		try(Connection conn = ds.getConnection()){
			try(PreparedStatement ps = conn.prepareStatement(deleteSQL)){
				ps.setInt(1, id);
				result = ps.executeUpdate();
			}
		}	
		return (result != 0);	
	}

	public synchronized UserBean retrieveUserByID(int id) throws SQLException {
		
		UserBean bean = new UserBean();
		
		String selectSQL = "SELECT * FROM " + MySqlUserDAO.TABLE_NAME + " WHERE user_id = ?"; 
		
		try(Connection conn = ds.getConnection()){
			try(PreparedStatement ps = conn.prepareStatement(selectSQL)){
				
				ps.setInt(1, id);
				
				ResultSet rs = ps.executeQuery();
				
				if(rs.next()) {
					bean.setId(rs.getInt("user_id"));
					bean.setEmail(rs.getString("email"));
					bean.setPassword(rs.getString("pwd"));
					bean.setFirstName(rs.getString("first_name"));
					bean.setLastName(rs.getString("last_name"));
					bean.setBirthDate(rs.getDate("birth_date"));
					String sex = rs.getString("sex");
					if(sex != null) {
						bean.setSex(sex.charAt(0));
					}
					bean.setPhoneNumber(rs.getString("tel_number"));
					
					bean.setValid(true);
				}
				else {
					bean.setValid(false);
				}
			}
		}
		return bean;
	}
	
	public UserBean retrieveUserByEmailPwd(String email, String pwd) throws SQLException {
		
		UserBean bean = new UserBean();
		
		String selectSQL = "SELECT * FROM " + MySqlUserDAO.TABLE_NAME + " WHERE email = ? AND pwd = ?"; 
		
		try(Connection conn = ds.getConnection()){
			try(PreparedStatement ps = conn.prepareStatement(selectSQL)){
				
				ps.setString(1, email);
				ps.setString(2, pwd);
				
				ResultSet rs = ps.executeQuery();
				
				if(rs.next()) {
					bean.setId(rs.getInt("user_id"));
					bean.setEmail(rs.getString("email"));
					bean.setPassword(rs.getString("pwd"));
					bean.setFirstName(rs.getString("first_name"));
					bean.setLastName(rs.getString("last_name"));
					bean.setBirthDate(rs.getDate("birth_date"));
					String sex = rs.getString("sex");
					if(sex != null) {
						bean.setSex(sex.charAt(0));
					}   
					bean.setPhoneNumber(rs.getString("tel_number"));
					
					bean.setValid(true);
				}
				else {
					bean.setValid(false);
				}
			}
		}
		return bean;
	}

	public void updateUser(UserBean user) throws SQLException {
		
		String updateSQL = "UPDATE " + MySqlUserDAO.TABLE_NAME
		   	 	  		 + "SET email = ?, pwd = ?, first_name = ?, last_name = ?, birth_date = ?, sex = ?, tel_number = ?"
		   	 	  		 + "WHERE user_id = ?";
		
		try(Connection conn = ds.getConnection()){
			conn.setAutoCommit(false);
			try(PreparedStatement ps = conn.prepareStatement(updateSQL)){
				
				ps.setString(1, user.getEmail());
				ps.setString(2, user.getPassword());
				ps.setString(3, user.getFirstName());
				ps.setString(4, user.getLastName());
				ps.setDate(5, user.getBirthDate());
				ps.setString(6, String.valueOf(user.getSex()));
				ps.setString(7, user.getPhoneNumber());
				
				ps.setInt(8, user.getId());
				
				ps.executeUpdate();
				
				conn.commit();
			}
		}
	}
}
