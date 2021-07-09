package it.unisa.phonetastic.model.bean;

import java.io.Serializable;
import java.sql.Date;

public class PaymentMethodBean implements Serializable {

	private static final long serialVersionUID = 1L;

	private int userId;
	private int paymentMethodId;
	private String cardNumber;
	private Date expiryDate;
	private int cvv;
	
	public PaymentMethodBean() {
		userId = -1;
		paymentMethodId = -1;
		cardNumber = null;
		expiryDate = null;
		cvv = -1;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getPaymentMethodId() {
		return paymentMethodId;
	}

	public void setPaymentMethodId(int paymentMethodId) {
		this.paymentMethodId = paymentMethodId;
	}

	public String getCardNumber() {
		return cardNumber;
	}

	public void setCardNumber(String cardNumber) {
		this.cardNumber = cardNumber;
	}

	public Date getExpiryDate() {
		return expiryDate;
	}

	public void setExpiryDate(Date expiryDate) {
		this.expiryDate = expiryDate;
	}

	public int getCvv() {
		return cvv;
	}

	public void setCvv(int cvv) {
		this.cvv = cvv;
	}
	
}
