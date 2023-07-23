package com.project.pm.notice.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDAOImp implements NoticeDAO{

	@Resource
	private SqlSessionTemplate sqlsession;

	// 전체부서 조회하기
	@Override
	public List<Map<String, String>> getDeptList() {
		String deptno = "1";
		List<Map<String, String>> deptList = sqlsession.selectList("notice.selectDept", deptno);
		return deptList;
	}
	
	// 체크된 부서 유저 목록 가져오기
	@Override
	public List<Map<String, String>> getChooseDept(String str_empno) {
		List<Map<String, String>> deptList  = sqlsession.selectList("notice.selectChooseEmp", str_empno);
		return deptList;
	}

	
	
	
	// 공지글 작성하기
	@Override
	public void getSenNotice(NoticeVO noticevo) {
		
		sqlsession.insert("notice.insertSendNotice", noticevo);		
		
	}

	
	
	/////// 전체 공지 ////////
	// 전체 공지 리스트 전체 보여주기 (select)
	/*
	@Override
	public List<Map<String, String>> getAllNoticeList(String empno) {
		List<Map<String, String>> allNoticeList = sqlsession.selectList("notice.allNoticeList", empno);
		return allNoticeList;
	}
	*/

	// 페이징 처리 한 전체 공지 리스트
	@Override
	public List<Map<String, String>> getAllNoticeList(Map<String, String> paraMap) {
		List<Map<String, String>> allNoticeList = sqlsession.selectList("notice.allNoticeList", paraMap);
		return allNoticeList;
	}
	
	
	// 전체 공지사항 공지글 1개 보여주기(ajax)
	@Override
	public Map<String, String> showNoticeContent(String notino) {
		Map<String, String> noticeContent = sqlsession.selectOne("notice.showNoticeContent", notino);
		return noticeContent;
	}
	
	
	// 공지 작성시 해당 공지 받는 사원 번호 알아오기
	@Override
	public List<String> getEmpnoList(String fk_deptno) {
		List<String> empnoList = sqlsession.selectList("notice.empnoList", fk_deptno);
		return empnoList;

	}

	// seq 최신 공지번호 알아오기
	@Override
	public String getSeqNotino(String empno) {
		String seqNotino =  sqlsession.selectOne("notice.seqNotino", empno);
		return seqNotino;
	}
	
	
	// 공지글 수정을 위한 원래 공지글 조회하기
	@Override
	public Map<String, String> showEditNoticeContent(String notino) {
		Map<String, String> showEditNoticeContent = sqlsession.selectOne("notice.getEditNotice" ,notino);
		return showEditNoticeContent;
	}

	// 공지글 수정 완료 폼 요청
	@Override
	public int editNotice(NoticeVO noticevo) {
		int result = sqlsession.update("notice.editNotice", noticevo);	
		return result;
	}

	// 공지 삭제 요청하기 (글 1개 조회)
	@Override
	public int delNoticeEnd(Map<String, String> paraMap) {
		int result = sqlsession.update("notice.delNotice", paraMap); 
		return result;
	}

	//댓글쓰기(tbl_comment 테이블에 insert)
	@Override
	public int addComment(CommentVO commentvo) {
		int n = sqlsession.insert("notice.addComment", commentvo);
		return n;
	}

	//원게시물  컬럼 1 증가 시키기(update)
	@Override
	public int updateCommentCount(String fk_notino) {
		int n = sqlsession.update("notice.updateCommentCount", fk_notino);
		return n;
	}

	// 원공지글에 해당하는 댓글 조회하기
	@Override
	public List<Map<String, String>> getCommentList(String fk_notino) {
		List<Map<String, String>> cmtList = sqlsession.selectList("notice.getCommentList", fk_notino);
		return cmtList;
	}

	// 댓글 수정
	@Override
	public int showEditComment(Map<String, String> paraMap) {
		int result = sqlsession.update("notice.editComment", paraMap);
		return result;
	}
	
	// 댓글 삭제
	@Override
	public int delComment(Map<String, String> paraMap) {
		int result = sqlsession.delete("notice.delComment", paraMap);
		return result;
	}
	
	// 댓글 삭제수 카운터
	@Override
	public void delCmtCount(Map<String, String> paraMap) {
		sqlsession.delete("notice.delCount", paraMap);
		
	}
	
	
	// 총 게시물 건수 (페이징 처리)
	@Override
	public int getTotalCount(Map<String, String> paraMap) {
		int totalCount = sqlsession.selectOne("notice.getTotalCount", paraMap);
		return totalCount;
	}
	
	// 첨부파일 조회하기
	@Override
	public List<NoticeVO> getFileList(String notino) {
		List<NoticeVO> filevo = sqlsession.selectList("notice.file", notino);
		return filevo;
	}
	
	
	
	
	/////// 부서 공지 ////////
	// 부서의 해당 공지 리스트 보여주기
	@Override
	public List<Map<String, String>> depNoticeList(Map<String, String> paraMap) {
		List<Map<String, String>> deptNoticeList = sqlsession.selectList("notice.deptNoticeList", paraMap);
		return deptNoticeList;
	}

	// 부서 공지리스트 공지 1개 내용 조회하기(ajax)
	@Override
	public Map<String, String> showDeptNoticeContent(String notino) {
		Map<String, String> deptNoticeContent = sqlsession.selectOne("notice.deptNoticeContent" ,notino);
		return deptNoticeContent;
	}

	// 부서 공지 수정을 위해 해당 공지번호 글 하나만 가져오기
	@Override
	public NoticeVO showEditDepNoticeContent(String notino) {
		NoticeVO showEditDepNoticeContent =  sqlsession.selectOne("notice.showEditDepNoticeContent",notino);
		return showEditDepNoticeContent;
	}

	// 부서 공지글 1개 삭제  요청
	@Override
	public int delDepNoticeEnd(Map<String, String> paraMap) {
		int result = sqlsession.update("notice.delDepNotice", paraMap); 
		return result;
	}

	// 부서 공지 댓글 작성하기
	//댓글쓰기(tbl_comment 테이블에 insert)
	@Override
	public int addDepComment(CommentVO commentvo) {
		int n = sqlsession.insert("notice.addDepComment", commentvo);
		return n;
	}
	
	//원게시물 commentCount 컬럼 증가
	@Override
	public int updateDepCommentCount(String fk_notino) {
		int n = sqlsession.update("notice.updateDepCommentCount", fk_notino);
		return n;
	}
	

	// 부서 공지 댓글 조회하기
	@Override
	public List<Map<String, String>> getDepCommentList(String fk_notino) {
		List<Map<String, String>> cmtList = sqlsession.selectList("notice.getDepCommentList", fk_notino);
		return cmtList;
	}
	
	// 부서 공지 댓글 수정하기
	@Override
	public int showEditDepComment(Map<String, String> paraMap) {
		int result = sqlsession.update("notice.editDepComment", paraMap);
		return result;
	}

	// 댓글 삭제
	@Override
	public int delDepComment(Map<String, String> paraMap) {
		int result = sqlsession.delete("notice.delDepComment", paraMap);
		return result;
	}

	// 총 게시물수
	@Override
	public int getDepTotalCount(Map<String, String> paraMap) {
		int depTotalCount =  sqlsession.selectOne("notice.getDepTotalCount", paraMap);
		return depTotalCount;
	}
	

	// 첨부파일 조회하기
	@Override
	public List<NoticeVO> getDepFile(String notino) {
		List<NoticeVO> depFile = sqlsession.selectList("notice.depFile", notino);
		return depFile;
	}

	
	
		
		
	
	
	
	/////// 내가 쓴 공지 ////////
	// 내가 쓴 공지리스트 가져오기
	@Override
	public List<Map<String, String>> getMyNoticeList(String empno) {
		List<Map<String, String>> myNoticeList =  sqlsession.selectList("notice.myNoticeList", empno);
		return myNoticeList;
	}

	// 내가 쓴 공지사항 공지글 1개 보여주기(ajax)
	@Override
	public Map<String, String> showMyNoticeContent(String notino) {
		Map<String, String> myNoticeContent = sqlsession.selectOne("notice.showMyNoticeContent", notino);
		return myNoticeContent;
	}

	// 내가 쓴 공지리스트 수정
	@Override
	public NoticeVO showEditMyNoticeContent(String notino) {
		NoticeVO showEditMyNoticeContent =  sqlsession.selectOne("notice.showEditMyNoticeContent",notino);
		return showEditMyNoticeContent;
	}

	// 내가 쓴 공지글 1개 삭제  요청
	@Override
	public int delMyNoticeEnd(Map<String, String> paraMap) {
		int result = sqlsession.update("notice.delMyDepNotice", paraMap); 
		return result;
	}
	
	//댓글쓰기(tbl_comment 테이블에 insert)
	@Override
	public int addMyComment(CommentVO commentvo) {
		int n = sqlsession.insert("notice.addMyComment", commentvo);
		return n;
	}
	
	//원게시물 commentCount 컬럼 증가
	@Override
	public int updateMyCommentCount(String fk_notino) {
		int n = sqlsession.update("notice.updateMyCommentCount", fk_notino);
		return n;
	}

	// 원공지글에 해당하는 댓글 조회하기
	@Override
	public List<Map<String, String>> getMyCommentList(String fk_notino) {
		List<Map<String, String>> cmtList = sqlsession.selectList("notice.getMyCommentList", fk_notino);
		return cmtList;
	}

	// 댓글 수정
	@Override
	public int showEditMyComment(Map<String, String> paraMap) {
		int result = sqlsession.update("notice.editMyComment", paraMap);
		return result;
	}

	// 댓글 삭제
	@Override
	public int delMyComment(Map<String, String> paraMap) {
		int result = sqlsession.delete("notice.delMyComment", paraMap);
		return result;
	}

	// 총 게시물수
	@Override
	public int getMyTotalCount(Map<String, String> paraMap) {
		int myTotalCount =  sqlsession.selectOne("notice.getMyTotalCount", paraMap);
		return myTotalCount;
	}

	// 페이징 처리한 공지 리스트
	@Override
	public List<Map<String, String>> getMyNoticeList(Map<String, String> paraMap) {
		List<Map<String, String>> myNoticeList = sqlsession.selectList("notice.myNoticeList", paraMap);
		return myNoticeList;
	}

	// 첨부 파일 조회
	@Override
	public List<NoticeVO> getMyFile(String notino) {
		List<NoticeVO> myFile = sqlsession.selectList("notice.myFile", notino);
		return myFile;
	}

	
	// 첨부파일 없는 글쓰기
	@Override
	public void sendNotice_noFile(NoticeVO noticevo) {
		sqlsession.insert("notice.sendNotice_noFile", noticevo);
	}

	// 첨부파일 있는 글쓰기
	@Override
	public void sendMotice_withFile(NoticeVO noticevo) {
		 sqlsession.insert("notice.sendMotice_withFile", noticevo);
	}

}
