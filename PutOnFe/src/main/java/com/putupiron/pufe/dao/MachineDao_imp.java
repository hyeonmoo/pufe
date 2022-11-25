package com.putupiron.pufe.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.putupiron.pufe.dto.Machine;
import com.putupiron.pufe.vo.SearchCondition;

@Repository
public class MachineDao_imp implements MachineDao  {
	@Autowired SqlSession session;
	String namespace="com.putupiron.machine.";
	
	@Override
	public List<Machine> selectAllMachines() throws Exception {
		return session.selectList(namespace+"selectAllMachines");
	}
	@Override
	public List<Machine> search(SearchCondition sc) throws Exception {
		return session.selectList(namespace+"search",sc);
	}
	@Override
	public Machine read(Integer mch_num) throws Exception{
		
		return session.selectOne(namespace+"read",mch_num);
	}
	@Override
	public int write(Machine machine) throws Exception{
		return session.insert(namespace+"write",machine);
	}
	@Override
	public int remove(Integer mch_num) throws Exception{
		Map<String,Object> map = new HashMap<>();
		map.put("mch_num", mch_num);
		
		return session.delete(namespace+"remove",map);
	}
	@Override
	public int modify(Machine machine) throws Exception{
		return session.update(namespace+"modify",machine);
	}
	@Override
	public int searchCnt(SearchCondition sc) throws Exception{
		return session.selectOne(namespace+"searchCnt",sc);
	}
}
