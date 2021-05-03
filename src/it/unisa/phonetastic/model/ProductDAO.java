package it.unisa.phonetastic.model;

import java.sql.SQLException;
import java.util.Collection;

public interface ProductDAO {

	public void doSave(ProductBean product) throws SQLException;

	public boolean doDelete(int id) throws SQLException;

	public ProductBean doRetrieveByKey(int id) throws SQLException;
	
	public Collection<ProductBean> doRetrieveAll(String order) throws SQLException;
	
}
