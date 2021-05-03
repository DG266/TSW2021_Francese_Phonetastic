package it.unisa.phonetastic.model;

public abstract class DAOFactory {

	public static final int MYSQL = 1;
	
	public abstract ProductDAO getProductDAO();
	// if more DAOs are needed, they will be added here...
	// getUserDAO()
	// getOrderInfoDAO()
	// etc.
	
	
	public static DAOFactory getDAOFactory(int whichFactory) {
		switch(whichFactory) {
			case MYSQL: 
				return new MySqlDAOFactory();
			default:	
				return null;
		}
	}
	
}
