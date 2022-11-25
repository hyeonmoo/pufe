package com.putupiron.pufe.dao;

import java.util.List;

import com.putupiron.pufe.dto.Machine;
import com.putupiron.pufe.vo.SearchCondition;

public interface MachineDao {

	List<Machine> selectAllMachines() throws Exception;

	List<Machine> search(SearchCondition sc) throws Exception;

	Machine read(Integer mch_num) throws Exception;

	int write(Machine machine) throws Exception;

	int remove(Integer mch_num) throws Exception;

	int modify(Machine machine) throws Exception;

	int searchCnt(SearchCondition sc) throws Exception;

}