package com.putupiron.pufe.dto;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class HealthMate_Post {
	private	Integer	post_no;
	private	String	poster;
	private	String	poster_name;
	private	String	poster_gender;
	private	Integer	poster_big3;
	private	String	part;
	private	Date	date;
	private	Timestamp time;
	private	String	partner;
	private	Integer	requests;
}
