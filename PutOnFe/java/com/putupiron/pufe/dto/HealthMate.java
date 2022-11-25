package com.putupiron.pufe.dto;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class HealthMate {
	private	Integer	no;
	private	String	poster;
	private	String	part;
	private	Date	date;
	private	Timestamp time;
	private	Integer	status;
	private	String	partner;
}
