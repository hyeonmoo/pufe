package com.putupiron.pufe.dto;

import java.util.Date;

import lombok.Data;

@Data
public class TrainerInfo {
	private	String	user_name;
	private	String	gender;
	private	String	user_tel;
	private	String	user_email;
	private	String	prod_name;
	private	Date	buy_date;
	private	Date	end_date;
	private	int		pt_times;
	private	int		pt_remain;
	private	int		big3;
	private	int		squat;
	private	int		benchpress;
	private	int		deadlift;
}
