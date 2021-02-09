package com.mycafe.beans;

import java.io.Serializable;

public class oderDto implements Serializable {

	private static final long serialVersionUID = 1L;
	String menu;
	String quantity;
	String price;

	public oderDto(String menu, String quantity, String price) {
		this.menu = menu;
		this.quantity = quantity;
		this.price = price;
	}

	public String getMenu() {
		return menu;
	}

	public String getQuantity() {
		return quantity;
	}

	public String getPrice() {
		return price;
	}

}