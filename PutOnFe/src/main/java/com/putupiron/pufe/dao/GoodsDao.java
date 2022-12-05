package com.putupiron.pufe.dao;

import java.util.List;

import com.putupiron.pufe.dto.Goods;

public interface GoodsDao {
	//모든 상품 조회-구매페이지
	List<Goods> allGoods(String option) throws Exception;
	//상품 구입
	int purchase(String user_email, String prod_name) throws Exception;
	//상품정보 수정
	int modifygoods(Goods goods) throws Exception;
	//모든 상품 조회-관리페이지
	List<Goods> Goodscor() throws Exception;
	//신규상품 등록
	int write(Goods goods) throws Exception;
	//기존상품 삭제
	int remove(Integer goods_no) throws Exception;
}