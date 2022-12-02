package com.putupiron.pufe.dto;

import java.time.LocalDate;

import lombok.Data;

@Data
public class Goods {
	private Integer		goods_no;
	private String		goods_name;
	private	Integer		period;
	private	Integer		PT;
	private	Integer		times;
	private	Integer		price;
	private LocalDate	end_date;
	
	public boolean getPT() {
		return PT==1;
	}
}
