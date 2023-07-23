package com.project.pm.employee.model;

import java.util.List;
import java.util.Map;

public interface EmpDAO {
	
	// 전체 사원을 조회해오는 메소드 
	List<Map<String, String>> getEmpList(Map<String, String> empMap);

	// 사원 번호를 전달받아 사원 한명의 정보를 조회해오는 메소드
	Map<String, String> getEmpOne(Map<String, String> empnoMap);

	// 시작일, 종료일, 사원번호, 메모, 사원번호를 Map 으로 전달받아 휴직테이블에 insert 하는 메소드
	int insertLeave(Map<String, String> leaveMap);

	// 사원번호를 Map 으로 전달받아 휴직 상태로 update 하는 메소드 
	int updateLeave(Map<String, String> leaveMap);

	// 사원번호, 휴직시작일,휴직종료일을 Map 으로 전달받아 가능한 기간인지 조회하는 메소드
	int checkLeave(Map<String, String> leaveCheckMap);
	
	// 재직 처리해야 할 사원들의 목록을 조회하는 메소드  
	List<Map<String, String>> getLeaveEmpList();

	// 휴직 처리해야할 사원들의 목록을 조회하는 메소드 
	List<Map<String, String>> getLeaveStartEmpList();

	// 휴직중인 사원의 목록을 전달받아 배열로 변환 후 재직 상태로 update 하는 메소드
	void updateLeaveEmp(Map<String, String[]> paraMap);

	// 재직중인 사원의 목록을 전달받아 배열로 변환 후 휴직 상태로 update 하는 메소드
	void updateLeaveStartEmp(Map<String, String[]> paraMap);

	// 전체 부서번호, 부서명 조회하는 메소드 
	List<Map<String, String>> getDeptList();

	// 해당부서 팀 구해오기
	List<Map<String, String>> getTeam(Map<String, String> deptMap);

	// 페이징 처리를 위해 총 사원 수 구해오기 
	int getTotalCount(Map<String, Object> empMap);

	// 페이징 처리한 글목록 가져오기 (검색이 있든지, 검색이 없든지 모두 다 포함한 것)
	List<Map<String, String>> empListSearchWithPaging(Map<String, Object> pageMap);

	// 페이징 처리를 위해 총 페이지 수 구해오기 
	int getTotalPage(Map<String, Object> pageMap);

	// rno 에 해당하는 사원 목록 가져오기 
	List<Map<String, String>> empListWithRno(Map<String, String> pageMap);

	// 회원가입시 이메일 중복 여부 확인 
	int checkDuplicateEmail(Map<String, Object> paraMap);

	// 신규 사원 등록 
	int registEployee(Map<String, Object> paraMap);

	/** 사원번호, 월요일(날짜), 금요일(날짜) 를 전달받아 한 주의 총 근무시간 구해오기 */
	String getWorkTime(Map<String, Object> workTimeMap);

	/** 부서 번호를 전달받아 해당 부서에 부서장/팀장이 존재하는지 구해오기 */
	int getManagerEmpno(Map<String, Object> paraMap);

	/** 인사발령 기록 테이블에 insert */
	int insertPsa(Map<String, Object> paraMap);

	/** 인사발령 기록 테이블 insert 후 사원 테이블 update */
	int updatePsa(Map<String, Object> paraMap);

	/** 인사발령  (부서장/ 팀장으로 바뀌는 경우 update)*/
	int updateManagerEmpno(Map<String, Object> paraMap);

	/** 사원번호를 전달받아 해당 사원의 인사발령 기록 조회  */
	List<Map<String, String>> getPsaHistory(Map<String, Object> paraMap);

	/** 사원번호를 전달받아 해당 사원의 휴직이력  조회  */
	List<Map<String, String>> getLeaveAbsence(Map<String, Object> paraMap);

	/** 사원 개인정보 변경 메소드  */
	int changePsInfo(Map<String, Object> psInfoMap);

	/** 인사발령내역조회 페이지 총 페이지수 구해오기  */
	int getTotalPsaPage(Map<String, Object> pageMap);

	/** 인사발령 페이징처리 (글 목록 가져오기) */
	List<Map<String, String>> psaListSearchWithPaging(Map<String, Object> pageMap);

	/** 사원 첨부파일 저장 */
	void addFile(Map<String, Object> fileMap);

	/** 사원번호를 전달받아 첨부파일을 가져오는 메소드  */
	List<Map<String, String>> getFile(Map<String, Object> paraMap);

	/** 엑셀로 저장을 위해 사원 목록 조회하기 */
	List<Map<String, String>> empListDownloadExcel(Map<String, Object> searchMap);

	/** 엑셀로 insert */
	void insertExcel(Map<String, Object> paramMap);

	/** 인사발령 메모 수정  
	 * @param psaMap */
	void changePsaMemo(Map<String, Object> psaMap);

	/** 휴직 상태인 경우 활성화된 휴직정보 가져오기  */
	Map<String, String> getLeaveInfo(Map<String, String> leaveMap);

	/** 기존에 있는 휴직 내용 변경  */
	int updateLeaveDate(Map<String, String> leaveMap);

	/** 휴직 취소  */
	int cancelLeave(Map<String, Object> paraMap);

	/** tbl_employeees 테이블 휴직 -> 재직으로 변경 */
	int updateLeaveStatus(Map<String, Object> paraMap);

	void updateLeavejae(Map<String, String> leaveMap);

	/** 사원 퇴직 처리 */
	void retirement(Map<String, Object> empMap);

	/** 남아있는 결재 문서 검색 */
	int checkApproval(Map<String, Object> paraMap);

	/** 사원 상태 퇴직으로 update */
	int updateRetirement(Map<String, Object> paraMap);

	int getManagerEmpnoRegist(Map<String, Object> paraMap);

	/** 이메일을 전달받아 해당하는 사원의 사번 알아오기 */
	Map<String, String> getEmpno(Map<String, Object> paraMap);
	
	/** 구성원 등록시 팀장 또는 부서장이 변경되는 경우  */
	void updateManagerEmpnoRegist(Map<String, Object> paraMap);

	/** 구성원 전체 성비 */
	List<Map<String, Object>> genderRate();

	/** 부서별 구성원 인원수 */
	List<Map<String, Object>> empCntDept();

	/** 구성원 잔여 연차 구하기  
	 * @param paraMap */
	Map<String, String> getAnnualLeaveCnt(Map<String, String> paraMap);

	/** 구성원 등록시 연차 등록 */
	void insertAnnualLeave(Map<String, Object> paraMap);

	/** 인사발령 내역 총 건수  */
	int getTotalCnt(Map<String, Object> pageMap);

}
