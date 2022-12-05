package com.putupiron.pufe.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.putupiron.pufe.dto.Goods;

@Repository
public class GoodsDao_imp implements GoodsDao {
	@Autowired	SqlSession session;
	String namespace="com.putupiron.goods.";
	
	@Override
	public List<Goods> allGoods(String option) throws Exception{
		return session.selectList(namespace+"allGoods",option);
	}
	@Override
	public List<Goods> Goodscor() throws Exception{
		return session.selectList(namespace+"allGoods");
	}
	@Override
	public int purchase(String email, String goods_name) throws Exception {
		Map<String,String> map = new HashMap<>();
		map.put("email", email);
		map.put("goods_name", goods_name);
		if(goods_name.contains("PT")) map.put("option","yesPT");
		else map.put("option", "noPT");
		return session.update(namespace+"purchase",map);
	}
	@Override
	public int modifygoods(Goods goods) throws Exception{
		return session.update(namespace+"modifygoods",goods);
	}
	@Override
	public int write(Goods goods) throws Exception{
		return session.insert(namespace+"write",goods);
	}
	@Override
	public int remove(Integer goods_no) throws Exception{
		Map<String,Object> map = new HashMap<>();
		map.put("goods_no", goods_no);
		
		return session.delete(namespace+"remove",map);
	}
}
