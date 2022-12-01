package com.putupiron.pufe.dto;

import java.time.LocalDate;
import java.time.LocalTime;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class HealthMate_Post {
	private	Integer		post_no;
	private	String		poster;
	private	String		poster_name;
	private	String		poster_gender;
	private	Integer		poster_big3;
	private	String		part;
	@JsonFormat(pattern="yyyy-MM-dd")
	private	LocalDate	date;
	@JsonFormat(pattern="HH:mm")
	private	LocalTime	time;
	private	String		partner;
	private String		partner_name;
	private	Integer		requests;
	private	Integer		join_no;
	private	String		requester;
	private	String		status;

}
