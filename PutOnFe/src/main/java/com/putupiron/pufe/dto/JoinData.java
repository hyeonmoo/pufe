package com.putupiron.pufe.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor 
@AllArgsConstructor
public class JoinData{
	private	String	user_email;
	private	String	user_pw;
	private	String	pw_confirm;
	private String	user_name;
	private	String	gender;
	private String	user_tel;
	private	String	terms_user;
	private	String	terms_club;
}
