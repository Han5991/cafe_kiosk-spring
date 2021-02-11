package com.mycafe.beans;

import java.util.ArrayList;

public class oderlistDto {
	private String odernum;
	private ArrayList<oderDto> oderDtos = new ArrayList<oderDto>();
	private String oderdate;
	private String sum;
	private String status;

	public String getOdernum() {
		return odernum;
	}

	public void setOdernum(String odernum) {
		this.odernum = odernum;
	}

	public ArrayList<oderDto> getOderDtos() {
		return oderDtos;
	}

	public void setOderDtos(ArrayList<oderDto> oderDtos) {
		this.oderDtos = oderDtos;
	}

	public String getOderdate() {
		return oderdate;
	}

	public void setOderdate(String oderdate) {
		this.oderdate = oderdate;
	}

	public String getSum() {
		return sum;
	}

	public void setSum(String sum) {
		this.sum = sum;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
