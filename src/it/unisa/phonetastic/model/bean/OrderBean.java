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
	private String couponId;
	//private char state;
	private Timestamp creationDate;
	private Timestamp lastUpdateDate;
	private int customerId;
	private List<OrderCompositionBean> elements;

	public OrderBean() {
		id = -1;
		total = null;
		couponId = null;
		//state = '\u0000';
		creationDate = null;
		lastUpdateDate = null;
		customerId = -1;
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

	public String getCouponId() {
		return couponId;
	}

	public void setCouponId(String couponId) {
		this.couponId = couponId;
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

	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

	public List<OrderCompositionBean> getElements() {
		return elements;
	}

	public void setElements(List<OrderCompositionBean> elements) {
		this.elements = elements;
	}

	@Override
	public String toString() {
		return "OrderBean [id=" + id + ", total=" + total + ", couponId=" + couponId + ", creationDate="
				+ creationDate + ", lastUpdateDate=" + lastUpdateDate + ", customer_id=" + customerId + ", elements="
				+ elements + "]";
	}
}
