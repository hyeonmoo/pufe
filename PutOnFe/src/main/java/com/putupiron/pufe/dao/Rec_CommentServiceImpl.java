package com.putupiron.pufe.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.putupiron.pufe.dto.Rec_Comment;

@Service
public class Rec_CommentServiceImpl implements Rec_CommentService {
	/*
	 * @Autowired RecommendDao recommendDao;
	 * 
	 * @Autowired Rec_CommentDao rec_commentDao;
	 */
	
	private  RecommendDao recommendDao;
	private Rec_CommentDao rec_commentDao;
	public Rec_CommentServiceImpl() {}
	
	// 인스턴스 변수로 2개씩 주입 받는 것보다, 생성자로 주입받는 것이 오류 위험이 낮아서 더 좋음
	@Autowired 
	public Rec_CommentServiceImpl(RecommendDao recommendDao, Rec_CommentDao rec_commentDao) {
		super();
		this.recommendDao = recommendDao;
		this.rec_commentDao = rec_commentDao;
	}

    @Override
	public int getCount(Integer rec_num) throws Exception {
        return rec_commentDao.count(rec_num);
    }

    // 삭제되면 댓글 삭제 + 댓글 개수도 -1 감소해야 하므로 
    @Override
	public int remove(Integer rec_com_num, Integer rec_num, String user_email) throws Exception {
        int rowCnt = recommendDao.updateCommentCnt(rec_num, -1);
        System.out.println("updateCommentCnt - rowCnt = " + rowCnt);
        
        rowCnt = rec_commentDao.delete(rec_com_num, user_email);
        System.out.println("rec_com_num="+rec_com_num+", user_email=" + user_email);
        System.out.println("rowCnt = " + rowCnt);
        return rowCnt;
    }


    @Override
	public int write(Rec_Comment rec_comment) throws Exception {

    	int rowCnt =  rec_commentDao.insert(rec_comment);
        if(rowCnt==1)
        	recommendDao.updateCommentCnt(rec_comment.getRec_num(), 1);
        
        return rowCnt;
    }


    @Override
	public List<Rec_Comment> getList(Integer rec_num) throws Exception {
        //throw new Exception();
    	return rec_commentDao.selectAll(rec_num);
    }


    @Override
	public Rec_Comment read(Integer rec_com_num) throws Exception {
        return rec_commentDao.select(rec_com_num);
    }
 

  	
}
