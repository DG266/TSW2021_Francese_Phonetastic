package it.unisa.phonetastic.model.bean;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class OrderBean implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private int id;
	private BigDecimal total;
	private String coupon_id;
	//private char state;
	private Timestamp creationDate;
	private Timestamp lastUpdateDate;
	private int customer_id;
	private List<OrderCompositionBean> elements;

	public OrderBean() {
		id = -1;
		total = null;
		coupon_id = null;
		//state = '\u0000';
		creationDate = null;
		lastUpdateDate = null;
		customer_id = -1;
		elements = new ArrayList<OrderCompositionBean>();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	public BigDecimal getTotal() {
		return total;
	}

	public void setTotal(BigDecimal total) {
		this.total = total;
	}

	public String getCoupon_id() {
		return coupon_id;
	}

	public void setCoupon_id(String coupon_id) {
		this.coupon_id = coupon_id;
	}

/*
	public char getState() {
		return state;
	}

	public void setState(char state) {
		this.state = state;
	}
*/
	public Timestamp getCreationDate() {
		return creationDate;
	}

	public void setCreationDate(Timestamp creationDate) {
		this.creationDate = creationDate;
	}

	public Timestamp getLastUpdateDate() {
		return lastUpdateDate;
	}

	public void setLastUpdateDate(Timestamp lastUpdateDate) {
		this.lastUpdateDate = lastUpdateDate;
	}

	public int getCustomer_id() {
		return customer_id;
	}

	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}

	public List<OrderCompositionBean> getElements() {
		return elements;
	}

	public void setElements(List<OrderCompositionBean> elements) {
		this.elements = elements;
	}
	
}
