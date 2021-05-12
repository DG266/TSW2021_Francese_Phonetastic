package it.unisa.phonetastic.model.dao;

public class MySqlDAOFactory extends DAOFactory{

	// TODO I think it's a good idea to include some sort of "getConnection" method
	
	public ProductDAO getProductDAO() {
		return new MySqlProductDAO();
	}
	
	public UserDAO getUserDAO() {
		return new MySqlUserDAO();
	}
	
	public OrderDAO getOrderDAO() {
		return new MySqlOrderDAO();
	}
}
