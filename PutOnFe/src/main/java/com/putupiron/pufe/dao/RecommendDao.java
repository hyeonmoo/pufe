package com.putupiron.pufe.dao;

import java.util.List;

import com.putupiron.pufe.dto.Recommend;
import com.putupiron.pufe.vo.SearchCondition;

public interface RecommendDao {

	Recommend read(Integer rec_num) throws Exception;

	int write(Recommend recommend) throws Exception;

	int modify(Recommend recommend) throws Exception;

	int remove(Integer rec_num, String user_email) throws Exception;

	List<Recommend> indexrec() throws Exception;

	List<Recommend> search(SearchCondition sc) throws Exception;

	int searchCnt(SearchCondition sc) throws Exception;

	int updateCommentCnt(Integer rec_num, Integer comment_cnt)throws Exception;

}