package com.shine.framework.test.entity;

import com.shine.framework.entity.BaseEntity;

public class TestUser implements BaseEntity{
	private String host;
	private String name;
	
	public String getHost() {
		return host;
	}
	public void setHost(String host) {
		this.host = host;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
}
