package it.unisa.phonetastic.model.dao;

import java.sql.SQLException;
import java.util.Collection;

import it.unisa.phonetastic.model.bean.PaymentMethodBean;

public interface PaymentMethodDAO {
	
	public void insertPaymentMethod(PaymentMethodBean paymentMethod) throws SQLException;
	
	public boolean deletePaymentMethod(int userId, int paymentMethodId) throws SQLException;
	
	public PaymentMethodBean retrievePaymentMethodByID(int userId, int paymentMethodId) throws SQLException;
	
	public Collection<PaymentMethodBean> retrievePaymentMethodsByUserID(int userId) throws SQLException;
}
