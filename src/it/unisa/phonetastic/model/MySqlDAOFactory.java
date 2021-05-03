package it.unisa.phonetastic.model;

public class MySqlDAOFactory extends DAOFactory{

	public ProductDAO getProductDAO() {
		return new MySqlProductDAO();
	}
}
