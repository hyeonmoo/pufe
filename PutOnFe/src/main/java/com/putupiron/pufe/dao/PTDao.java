package com.putupiron.pufe.dao;

import java.util.List;
import java.util.Map;

import com.putupiron.pufe.dto.PTReserv;

public interface PTDao {
	List<PTReserv> reservList(String email,String user_type) throws Exception;
	List<PTReserv> userBookList(String email) throws Exception;
	Map<String, Object> ptDateTime(Integer pt_no) throws Exception;
	int reserve(PTReserv ptr) throws Exception;
	int disable(PTReserv ptr) throws Exception;
	int cancel(Integer pt_no) throws Exception;
	int update(PTReserv ptr) throws Exception;
	int confirm(Integer pt_no) throws Exception;
}