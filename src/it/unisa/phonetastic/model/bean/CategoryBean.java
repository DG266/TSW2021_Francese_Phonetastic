package it.unisa.phonetastic.model.bean;

import java.io.Serializable;

public class CategoryBean implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private int categoryId;
	private String categoryName;
	private int superiorCategoryId;
	
	public CategoryBean() {
		categoryId = -1;
		categoryName = null;
		superiorCategoryId = -1;
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public int getSuperiorCategoryId() {
		return superiorCategoryId;
	}

	public void setSuperiorCategoryId(int superiorCategoryId) {
		this.superiorCategoryId = superiorCategoryId;
	}

	@Override
	public String toString() {
		return "CategoryBean [categoryId=" + categoryId + ", categoryName=" + categoryName + ", superiorCategoryId="
				+ superiorCategoryId + "]";
	}
}
