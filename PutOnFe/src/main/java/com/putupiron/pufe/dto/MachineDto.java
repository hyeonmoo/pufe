package com.putupiron.pufe.dto;

import java.util.Date;

public class MachineDto {
private int mch_num;
private String mch_name;
private String mch_img;
private int mch_serial;
private Date mch_date;
private String mch_info;
private String mch_detail;
@Override
public String toString() {
	return "MachineDto [mch_num=" + mch_num + ", mch_name=" + mch_name + ", mch_img=" + mch_img + ", mch_serial="
			+ mch_serial + ", mch_date=" + mch_date + ", mch_info=" + mch_info + ", mch_detail=" + mch_detail + "]";
}
public MachineDto() {
	super();
	// TODO Auto-generated constructor stub
}
public MachineDto(int mch_num, String mch_name, String mch_img, int mch_serial, Date mch_date, String mch_info,
		String mch_detail) {
	super();
	this.mch_num = mch_num;
	this.mch_name = mch_name;
	this.mch_img = mch_img;
	this.mch_serial = mch_serial;
	this.mch_date = mch_date;
	this.mch_info = mch_info;
	this.mch_detail = mch_detail;
}
public int getMch_num() {
	return mch_num;
}
public void setMch_num(int mch_num) {
	this.mch_num = mch_num;
}
public String getMch_name() {
	return mch_name;
}
public void setMch_name(String mch_name) {
	this.mch_name = mch_name;
}
public String getMch_img() {
	return mch_img;
}
public void setMch_img(String mch_img) {
	this.mch_img = mch_img;
}
public int getMch_serial() {
	return mch_serial;
}
public void setMch_serial(int mch_serial) {
	this.mch_serial = mch_serial;
}
public Date getMch_date() {
	return mch_date;
}
public void setMch_date(Date mch_date) {
	this.mch_date = mch_date;
}
public String getMch_info() {
	return mch_info;
}
public void setMch_info(String mch_info) {
	this.mch_info = mch_info;
}
public String getMch_detail() {
	return mch_detail;
}
public void setMch_detail(String mch_detail) {
	this.mch_detail = mch_detail;
}
}
