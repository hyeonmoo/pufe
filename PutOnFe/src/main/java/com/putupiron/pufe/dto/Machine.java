package com.putupiron.pufe.dto;

import java.util.Objects;

import lombok.Data;
 
@Data
public class Machine {
	private	Integer	mch_num;
	private	String	mch_name;
	private	String	mch_img;
	private int	mch_serial;
	private	String	mch_date;
	private	String	mch_info;
	private	String	mch_detail;
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Machine other = (Machine) obj;
		return Objects.equals(mch_date, other.mch_date) && Objects.equals(mch_detail, other.mch_detail)
				&& Objects.equals(mch_img, other.mch_img) && Objects.equals(mch_info, other.mch_info)
				&& Objects.equals(mch_name, other.mch_name) && Objects.equals(mch_num, other.mch_num)
				&& mch_serial == other.mch_serial;
	}
	@Override
	public int hashCode() {
		return Objects.hash(mch_date, mch_detail, mch_img, mch_info, mch_name, mch_num, mch_serial);
	}
	
	
}
