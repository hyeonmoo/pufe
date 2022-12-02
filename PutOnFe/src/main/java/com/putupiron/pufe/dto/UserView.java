package com.putupiron.pufe.dto;

import java.time.LocalDate;

import lombok.Data;

@Data
public class UserView {
	private	String		user_email;
	private String		user_name;
	private	String		gender;
	private	String		user_tel;
	private	String		prod_name;
	private	LocalDate	buy_date;
	private LocalDate	end_date;
	private	Integer		remain;
	private	String		trainer;
	private	String		trainer_name;
	private	Integer		days;
	private Integer		pt_times;
	private	Integer		big3;
}
