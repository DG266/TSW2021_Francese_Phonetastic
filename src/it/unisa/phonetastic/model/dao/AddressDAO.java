package it.unisa.phonetastic.model.dao;

import java.sql.SQLException;
import java.util.Collection;

import it.unisa.phonetastic.model.bean.AddressBean;

public interface AddressDAO {
	
	public void insertAddress(AddressBean address) throws SQLException;
	
	public boolean deleteAddress(int userId, int addressId) throws SQLException;
	
	public AddressBean retrieveAddressByID(int userId, int addressId) throws SQLException;
	
	public Collection<AddressBean> retrieveAddressesByUserID(int userId) throws SQLException;
}
