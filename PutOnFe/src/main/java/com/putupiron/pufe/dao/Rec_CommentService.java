package com.putupiron.pufe.dao;

import java.util.List;

import com.putupiron.pufe.dto.Rec_Comment;

public interface Rec_CommentService {

	int getCount(Integer rec_num) throws Exception;

	// 삭제되면 댓글 삭제 + 댓글 개수도 -1 감소해야 하므로 
	int remove(Integer rec_com_num, Integer rec_num, String user_email) throws Exception;

	int write(Rec_Comment rec_comment) throws Exception;

	List<Rec_Comment> getList(Integer rec_num) throws Exception;

	Rec_Comment read(Integer rec_com_num) throws Exception;

}