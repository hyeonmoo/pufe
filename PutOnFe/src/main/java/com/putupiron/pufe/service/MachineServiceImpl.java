package com.putupiron.pufe.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.putupiron.pufe.dao.MachineDao;
import com.putupiron.pufe.dto.MachineDto;

@Service
public class MachineServiceImpl implements MachineService {
	@Autowired
	MachineDao machineDao;
	
	 
	@Override
	public List<MachineDto> getList() throws Exception {
	        return machineDao.selectMachine();
	    }
}
