package com.putupiron.pufe.vo;

import java.time.LocalDate;
import java.time.LocalTime;

import lombok.Data;

@Data
public class MyMatch {
	private	String		poster_name;
	private	String		partner_name;
	private	LocalDate	date;
	private	LocalTime	time;
	private	String		part;
	private	String		name;
}
