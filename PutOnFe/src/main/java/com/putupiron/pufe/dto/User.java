package com.putupiron.pufe.dto;

import java.time.LocalDate;

import lombok.Data;
 
@Data
public class User {
	private	String		user_email;
	private	String		user_pw;
	private	String		user_name;
	private	String		gender;
	private	String		user_tel;
	private	String		user_type;
	private	String		prod_name;
	private LocalDate	buy_date;
	private	String		trainer;
	private	Integer		pt_times;
	private	Integer		squat;
	private	Integer		benchpress;
	private	Integer		deadlift;
}
