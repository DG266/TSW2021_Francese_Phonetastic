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

import it.unisa.phonetastic.model.bean.UserBean;

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

	private static final String USER_TABLE_NAME = "user_info";
	private static final String USER_ROLES_TABLE_NAME = "user_roles";
	private static final String ROLES_TABLE_NAME = "roles";

	public synchronized void insertUser(UserBean user) throws SQLException {
		/*
		String userInsertSQL = "INSERT INTO " + USER_TABLE_NAME
						 	 + "(email, pwd, first_name, last_name, birth_date, sex, tel_number) VALUES (?, ?, ?, ?, ?, ?, ?)";
		*/
		
		String userInsertSQL = "INSERT INTO " + USER_TABLE_NAME
							 + "(email, pwd, first_name, last_name) VALUES (?, ?, ?, ?)";
		
		String roleInsertSQL = "INSERT INTO " + USER_ROLES_TABLE_NAME
							 + "(role_id, user_id) VALUES ((SELECT role_id FROM " + ROLES_TABLE_NAME + " WHERE role_name = ?), ?)";

		try (Connection conn = ds.getConnection()) {
			// TODO Should do that for each method
			conn.setAutoCommit(false);
			
			int userId = -1;
			
			try (PreparedStatement ps = conn.prepareStatement(userInsertSQL, Statement.RETURN_GENERATED_KEYS)) {
				ps.setString(1, user.getEmail());
				ps.setString(2, user.getPassword());    // TODO Fix this: not good at all
				ps.setString(3, user.getFirstName());
				ps.setString(4, user.getLastName());
				/*
				ps.setDate(5, user.getBirthDate());
				ps.setString(6, user.getSex());
				ps.setString(7, user.getPhoneNumber());
				*/
				
				ps.executeUpdate();
				
				// Retrieve the auto-generated order PK (useful in the next insert)
				ResultSet rs = ps.getGeneratedKeys();
				if(rs.next()) {
					userId = rs.getInt(1);
				}

				conn.commit();
			}
			
			try(PreparedStatement ps = conn.prepareStatement(roleInsertSQL)){
				for(String role : user.getRoles()) {
					ps.setString(1, role);
					ps.setInt(2, userId);
					
					ps.executeUpdate();
					
					conn.commit();
				}
			}
		}
	}

	public synchronized boolean deleteUser(int id) throws SQLException {
		int result = 0;
		
		String deleteSQL = "DELETE FROM " + USER_TABLE_NAME + " WHERE user_id = ?";
		
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
		boolean userInfoSet = false;
		
		//String selectSQL = "SELECT * FROM " + MySqlUserDAO.TABLE_NAME + " WHERE user_id = ?"; 
		
		/*
		String selectSQL = "SELECT U.user_id, U.email, U.pwd, U.first_name, U.last_name, U.birth_date, U.sex, U.tel_number, R.role_name "
				 		 + "FROM " + USER_TABLE_NAME + " U, " + USER_ROLES_TABLE_NAME + " UR, " + ROLES_TABLE_NAME + " R "
				 		 + "WHERE U.user_id = UR.user_id AND UR.role_id = R.role_id AND U.user_id = ?";
		*/
		
		String selectSQL = "SELECT U.user_id, U.email, U.pwd, U.first_name, U.last_name, R.role_name "
						 + "FROM " + USER_TABLE_NAME + " U, " + USER_ROLES_TABLE_NAME + " UR, " + ROLES_TABLE_NAME + " R "
						 + "WHERE U.user_id = UR.user_id AND UR.role_id = R.role_id AND U.user_id = ?";
		
		try(Connection conn = ds.getConnection()){
			try(PreparedStatement ps = conn.prepareStatement(selectSQL)){
				
				ps.setInt(1, id);
				
				ResultSet rs = ps.executeQuery();
				
				ArrayList<String> roles = new ArrayList<>();
				
				while(rs.next()) {	
					if(!userInfoSet) {
						bean.setId(rs.getInt("user_id"));
						bean.setEmail(rs.getString("email"));
						bean.setPassword(rs.getString("pwd"));
						bean.setFirstName(rs.getString("first_name"));
						bean.setLastName(rs.getString("last_name"));
						/*
						bean.setBirthDate(rs.getDate("birth_date"));
						bean.setSex(rs.getString("sex"));
						bean.setPhoneNumber(rs.getString("tel_number"));
						*/
						bean.setRoles(roles);
						
						bean.setValid(true);
					}
					roles.add(rs.getString("role_name"));
				}
			}
		}
		return bean;
	}
	
	public synchronized boolean isEmailPresent(String email) throws SQLException {
		
		String selectSQL = "SELECT * FROM " + USER_TABLE_NAME + " WHERE email = ?";
		boolean isPresent = false;
		
		try(Connection conn = ds.getConnection()){
			try(PreparedStatement ps = conn.prepareStatement(selectSQL)){
				ps.setString(1, email);
				
				ResultSet rs = ps.executeQuery();
				
				isPresent = rs.next();
			}
		}
		
		return isPresent;
	}
	
	public synchronized UserBean retrieveUserByEmailPwd(String email, String pwd) throws SQLException {
		
		UserBean bean = new UserBean();
		boolean userInfoSet = false;
		
		//String selectSQL = "SELECT * FROM " + MySqlUserDAO.TABLE_NAME + " WHERE email = ? AND pwd = ?";
		
		/*
		String selectSQL = "SELECT U.user_id, U.email, U.pwd, U.first_name, U.last_name, U.birth_date, U.sex, U.tel_number, R.role_name "
						 + "FROM (user_info U JOIN user_roles UR ON U.user_id = UR.user_id) JOIN roles R ON UR.role_id = R.role_id "
						 + "WHERE U.email = ? AND U.pwd = ?";
		
		
		String selectSQL = "SELECT U.user_id, U.email, U.pwd, U.first_name, U.last_name, U.birth_date, U.sex, U.tel_number, R.role_name "
						 + "FROM " + USER_TABLE_NAME + " U, " + USER_ROLES_TABLE_NAME + " UR, " + ROLES_TABLE_NAME + " R "
						 + "WHERE U.user_id = UR.user_id AND UR.role_id = R.role_id AND U.email = ? AND U.pwd = ?";
		*/
		
		String selectSQL = "SELECT U.user_id, U.email, U.pwd, U.first_name, U.last_name, R.role_name "
				 		 + "FROM " + USER_TABLE_NAME + " U, " + USER_ROLES_TABLE_NAME + " UR, " + ROLES_TABLE_NAME + " R "
				 		 + "WHERE U.user_id = UR.user_id AND UR.role_id = R.role_id AND U.email = ? AND U.pwd = ?";
		
		try(Connection conn = ds.getConnection()){
			try(PreparedStatement ps = conn.prepareStatement(selectSQL)){
				
				ps.setString(1, email);
				ps.setString(2, pwd);
				
				ResultSet rs = ps.executeQuery();
				
				ArrayList<String> roles = new ArrayList<>();
				
				while(rs.next()) {	
					if(!userInfoSet) {
						bean.setId(rs.getInt("user_id"));
						bean.setEmail(rs.getString("email"));
						bean.setPassword(rs.getString("pwd"));
						bean.setFirstName(rs.getString("first_name"));
						bean.setLastName(rs.getString("last_name"));
						/*
						bean.setBirthDate(rs.getDate("birth_date"));
						bean.setSex(rs.getString("sex"));
						bean.setPhoneNumber(rs.getString("tel_number"));
						*/
						bean.setRoles(roles);
						
						bean.setValid(true);
					}
					roles.add(rs.getString("role_name"));
				}
			}
		}
		return bean;
	}

	public synchronized void updateUser(UserBean user) throws SQLException {
		
		/*
		String updateSQL = "UPDATE " + USER_TABLE_NAME
		   	 	  		 + "SET email = ?, pwd = ?, first_name = ?, last_name = ?, birth_date = ?, sex = ?, tel_number = ?"
		   	 	  		 + "WHERE user_id = ?";
		*/
		
		String updateSQL = "UPDATE " + USER_TABLE_NAME + " "
  	 	  		 		 + "SET email = ?, pwd = ?, first_name = ?, last_name = ? "
  	 	  		 		 + "WHERE user_id = ?";
		
		try(Connection conn = ds.getConnection()){
			conn.setAutoCommit(false);
			try(PreparedStatement ps = conn.prepareStatement(updateSQL)){
				
				ps.setString(1, user.getEmail());
				ps.setString(2, user.getPassword());
				ps.setString(3, user.getFirstName());
				ps.setString(4, user.getLastName());
				/*
				ps.setDate(5, user.getBirthDate());
				ps.setString(6, user.getSex());
				ps.setString(7, user.getPhoneNumber());
				*/
				
				ps.setInt(8, user.getId());
				
				ps.executeUpdate();
				
				conn.commit();
			}
		}
	}
}
