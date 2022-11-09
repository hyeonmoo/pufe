package com.putupiron.pufe.dao;

import java.util.List;
import java.util.Map;

import com.putupiron.pufe.SearchCondition;
import com.putupiron.pufe.dto.BoardDto;

public interface BoardDao {

	int deleteAll();

	int delete(Integer bno, String writer) throws Exception;

	int insert(BoardDto dto) throws Exception;

	List<BoardDto> selectAll() throws Exception;

	BoardDto select(int bno) throws Exception;

	int increaseViewCnt(Integer bno) throws Exception;

	int count() throws Exception;

	int update(BoardDto dto) throws Exception;

	List<BoardDto> selectPage(Map map) throws Exception;

	List<BoardDto> searchSelectPage(SearchCondition sc) throws Exception; // List<E> selectList(String statement, Object parameter)

	int searchResultCnt(SearchCondition sc) throws Exception; // T selectOne(String statement)

	int updateCommentCnt(Integer bno, Integer comment_cnt);

}