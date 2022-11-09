package com.putupiron.pufe.service;

import java.util.List;

import com.putupiron.pufe.dto.MachineDto;

public interface MachineService {

	List<MachineDto> getList() throws Exception;

}