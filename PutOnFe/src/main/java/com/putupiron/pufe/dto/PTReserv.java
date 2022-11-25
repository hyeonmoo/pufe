package com.putupiron.pufe.dto;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter @Setter
@NoArgsConstructor
public class PTReserv {
	private Integer pt_no;
	private	Date	pt_date;
	private Integer	pt_time;
	private	String	trainer_email;
	private	String	trainer_name;
	private	String	user_email;
	private	String	user_name;
	private	String	user_tel;
	private	String	request;
	
	public PTReserv(Date pt_date, Integer pt_time, String trainer_email, String user_email) {
		this.pt_date = pt_date;
		this.pt_time = pt_time;
		this.trainer_email = trainer_email;
		this.user_email = user_email;
	}
	public PTReserv(Date pt_date, Integer pt_time, String trainer_email) {
		this.pt_date = pt_date;
		this.pt_time = pt_time;
		this.trainer_email = trainer_email;
	}
	public String getPt_date() {
		return pt_date.toString();
	}
	public String getUser_tel() {
		if(user_tel!=null) return user_tel.substring(7);
		return user_tel;
	}
	@Override
	public String toString() {
		if(user_tel!=null) user_tel=user_tel.substring(7);
		return "{pt_no:" + pt_no + ", pt_date:'" + pt_date + "', pt_time:" + pt_time + ", trainer_email:'"
				+ trainer_email + "', trainer_name:'" + trainer_name + "', user_email:'" + user_email + "', user_name:'"
				+ user_name + "', user_tel:'" + user_tel + "', request:'" + request + "'}";
	}
}
