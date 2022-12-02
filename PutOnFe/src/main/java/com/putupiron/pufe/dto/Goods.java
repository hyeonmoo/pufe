package com.putupiron.pufe.dto;

import lombok.Data;

@Data
public class Goods {
	private Integer	goods_no;
	private String	goods_name;
	private	Integer	period;
	private	Integer	PT;
	private	Integer times;
	private	Integer	price;
	
	
	public boolean getPT() {
		if(PT==null) PT=0;
		return PT==1;
	}
}
