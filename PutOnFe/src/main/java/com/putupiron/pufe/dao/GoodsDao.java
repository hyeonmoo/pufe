package com.putupiron.pufe.dao;

import java.util.List;

import com.putupiron.pufe.dto.Goods;

public interface GoodsDao {

	List<Goods> allGoods(String option) throws Exception;
	int purchase(String user_email, String prod_name) throws Exception;
}