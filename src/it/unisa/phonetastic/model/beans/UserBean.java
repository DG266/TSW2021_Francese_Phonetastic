package it.unisa.phonetastic.model.beans;

import java.io.Serializable;
import java.sql.Date;

public class UserBean implements Serializable{

	private static final long serialVersionUID = 1L;

	private int id;
	private String email;
	private String password;
	private String firstName;
	private String lastName;
	private Date birthDate;
	private char sex;
	private String phoneNumber;
	
	private boolean valid;
	
	public UserBean() {
		id = -1;
		email = null;
		password = null;
		firstName = null;
		lastName = null;
		birthDate = null;
		sex = '\u0000';
		phoneNumber = null;
		valid = false;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public Date getBirthDate() {
		return birthDate;
	}

	public void setBirthDate(Date birthDate) {
		this.birthDate = birthDate;
	}

	public char getSex() {
		return sex;
	}

	public void setSex(char sex) {
		this.sex = sex;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public boolean isValid() {
		return valid;
	}

	public void setValid(boolean valid) {
		this.valid = valid;
	}

}
