package com.putupiron.pufe.dao;

import java.util.List;

import com.putupiron.pufe.dto.MachineDto;

public interface MachineDao {

	List<MachineDto> selectMachine() throws Exception;

}