package it.unisa.phonetastic.model.dao;

import java.sql.SQLException;

import it.unisa.phonetastic.model.beans.OrderBean;

public interface OrderDAO {

	public void insertOrder(OrderBean order) throws SQLException;
	
	public boolean deleteOrder(int id) throws SQLException;
	
	public OrderBean retrieveOrderByID(int id) throws SQLException;
}