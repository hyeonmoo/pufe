package com.putupiron.pufe.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.putupiron.pufe.dto.MachineDto;

@Repository
public class MachineDaoImpl implements MachineDao {
	@Autowired
	SqlSession session;
	String namespace="com.putupiron.machine.";
	
	 @Override
	public List<MachineDto> selectMachine() throws Exception {
         return session.selectList(namespace+"selectMachine");
     }
}
