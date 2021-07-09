package it.unisa.phonetastic.model.bean;

import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;

public class UserBean implements Serializable {

	private static final long serialVersionUID = 1L;

	private int id;
	private String email;
	private String password;
	private String firstName;
	private String lastName;
	private Date birthDate;
	private String sex;
	private String phoneNumber;
	private ArrayList<String> roles;
	
	private boolean valid;
	
	public UserBean() {
		id = -1;
		email = null;
		password = null;
		firstName = null;
		lastName = null;
		birthDate = null;
		sex = null;
		phoneNumber = null;
		valid = false;
		roles = new ArrayList<>();
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

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
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

	public ArrayList<String> getRoles() {
		return roles;
	}

	public void setRoles(ArrayList<String> roles) {
		this.roles = roles;
	}
	
	public boolean isAdmin() {
		return this.roles.contains("Admin");
	}
	
	@Override
	public String toString() {
		return "UserBean [id=" + id + ", email=" + email + ", password=" + password + ", firstName=" + firstName
				+ ", lastName=" + lastName + ", birthDate=" + birthDate + ", sex=" + sex + ", phoneNumber="
				+ phoneNumber + ", roles=" + roles + ", valid=" + valid + "]";
	}
}
