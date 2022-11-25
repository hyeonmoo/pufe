package com.putupiron.pufe.dto;

import java.util.Date;
import java.util.Objects;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
@NoArgsConstructor
@AllArgsConstructor 
public class Recommend {
	private Integer	rec_num;
	private String	rec_title;
	private	String	user_email;
	private	String	user_name;
	private String	rec_content;
	private	int		views;
	private	int		rec_comments;
	private	Date	rec_date;
	private int comment_cnt;
	
	public Recommend(String rec_title, String user_email, String rec_content) {
		super();
		this.rec_title = rec_title;
		this.user_email = user_email;
		this.rec_content = rec_content;
	}

	@Override
	public int hashCode() {
		return Objects.hash(rec_num, rec_content, rec_title, user_email);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Recommend other = (Recommend) obj;
		return Objects.equals(rec_content, other.rec_content) && Objects.equals(rec_num, other.rec_num)
				&& Objects.equals(rec_title, other.rec_title) && Objects.equals(user_email, other.user_email);
	}
}
