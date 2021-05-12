package it.unisa.phonetastic.model.dao;

import java.sql.SQLException;

import it.unisa.phonetastic.model.beans.UserBean;

public interface UserDAO {

	public void insertUser(UserBean user) throws SQLException;
	
	public boolean deleteUser(int id) throws SQLException;
	
	public UserBean retrieveUserByID(int id) throws SQLException;
	
	public UserBean retrieveUserByEmailPwd(String email, String pwd) throws SQLException;
	
	public void updateUser(UserBean user) throws SQLException;
}
