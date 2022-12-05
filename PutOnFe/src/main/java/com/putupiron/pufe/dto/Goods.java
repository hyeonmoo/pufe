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
	
//	MySQL은 논리타입을 TINYINT(1) 0/1로 취급하기에 GETTER의 리턴을 BOOLEAN으로 명시
	public boolean getPT() {
		if(PT==null) PT=0;
		return PT==1;
	}
}
