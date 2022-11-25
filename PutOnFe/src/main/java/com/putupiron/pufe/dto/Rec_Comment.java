package com.putupiron.pufe.dto;

import java.util.Date;

import lombok.Data;
@Data
public class Rec_Comment {
	private Integer rec_com_num;
	private Integer rec_num;
	private String com_text;
	private String user_email;
	private Date reg_date;
	private	String	user_name;
	
}
