package com.mycafe.beans;

import javax.websocket.Session;

public class ClientDto {
	private String name;
	private Session session;
	private static ClientDto instance = new ClientDto();

	public Session getSession() {
		return session;
	}

	public void setSession(Session session) {
		this.session = session;
	}

	public ClientDto() {
	}

	public static ClientDto getinstance() {
		return instance;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}