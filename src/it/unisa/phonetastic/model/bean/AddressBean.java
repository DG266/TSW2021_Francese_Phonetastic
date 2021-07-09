package it.unisa.phonetastic.model.bean;

import java.io.Serializable;

public class AddressBean implements Serializable {

	private static final long serialVersionUID = 1L;

	private int userId;
	private int addressId;
	private String state;
	private String city;
	private String province;
	private String cap;
	private String address;
	
	public AddressBean() {
		userId = -1;
		addressId = -1;
		state = null;
		city = null;
		province = null;
		cap = null;
		address = null;
	}
	
	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getAddressId() {
		return addressId;
	}

	public void setAddressId(int addressId) {
		this.addressId = addressId;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCap() {
		return cap;
	}

	public void setCap(String cap) {
		this.cap = cap;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
	@Override
	public String toString() {
		return "AddressBean [userId=" + userId + ", addressId=" + addressId + ", state=" + state + ", city=" + city
				+ ", province=" + province + ", cap=" + cap + ", address=" + address + "]";
	}
}
