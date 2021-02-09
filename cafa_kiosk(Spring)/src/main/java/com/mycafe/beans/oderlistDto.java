package com.mycafe.beans;

import java.util.ArrayList;

public class oderlistDto {
	private String odernum;
	private ArrayList<oderDto> oderDtos = new ArrayList<oderDto>();
	private String oderdate;
	private String sum;
	private String status;

//	public oderlistDto(String odernum, ArrayList<oderDto> oderDtos, String oderdate, String sum, String status) {
//		this.odernum = odernum;
//		this.oderDtos = oderDtos;
//		this.oderdate = oderdate;
//		this.sum = sum;
//		this.status = status;
//	}
	public oderlistDto() {

	}

	public void setOdernum(String odernum) {
		this.odernum = odernum;
	}

	public void setOderDtos(ArrayList<oderDto> oderDtos) {
		this.oderDtos = oderDtos;
	}

	public void setOderdate(String oderdate) {
		this.oderdate = oderdate;
	}

	public void setSum(String sum) {
		this.sum = sum;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getOdernum() {
		return odernum;
	}

	public ArrayList<oderDto> getOderDtos() {
		return oderDtos;
	}

	public String getOderdate() {
		return oderdate;
	}

	public String getSum() {
		return sum;
	}

	public String getStatus() {
		return status;
	}

}
