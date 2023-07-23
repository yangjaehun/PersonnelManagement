package com.project.pm.employee.service;

import java.io.File;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.pm.common.ExcelRead;
import com.project.pm.common.ExcelReadOption;
import com.project.pm.employee.model.EmpDAO;

@Service
public class EmpServiceImp implements EmpService{
	
	@Autowired
	private EmpDAO dao;

	@Override
	public List<Map<String, String>> getEmpList(Map<String, String> empMap) {
		String pattern = "^[0-9]*$"; // 숫자만 등장하는지
		String str = empMap.get("keyword"); 
		
		boolean result = Pattern.matches(pattern, str);
		
		String searchType = "";
		if(str != "") {
			if(result) {
				searchType = "empno";
			}
			if(!result){
				searchType = "name";
			}
		}
		
		empMap.put("searchType", searchType);
		
		List<Map<String, String>> empList = dao.getEmpList(empMap);
		
		
		return empList;
	}

	// 사원 번호를 전달받아 사원 한명의 정보를 조회해오는 메소드
	@Override
	public Map<String, String> getEmpOne(Map<String, String> empnoMap) {
		Map<String, String> employeeMap = dao.getEmpOne(empnoMap);
		return employeeMap;
	}

	// 시작일, 종료일, 사원번호, 메모, 사원번호를 Map 으로 전달받아 휴직테이블에 insert 후 
	// 사원 테이블에 status 컬럼 "휴직" 으로 update 하는 메소드 (트랜잭션)
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int insertLeave(Map<String, String> leaveMap) {
		
		int leaveInsert = 0, leaveUpdate = 0, result =0;
		leaveInsert = dao.insertLeave(leaveMap);
		
		// 현재 날짜와 휴직 시작일 비교, 휴직 시작일이 작은 경우 휴직처리 
        LocalDate now = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String formatedNow = now.format(formatter);
        
        int dateResult = leaveMap.get("startdate").compareTo(formatedNow);
		
        if(dateResult == 0 || dateResult < 0) {// 휴직 신청 날짜가 같은 경우  또는 이후 날짜인 경우 
			if(leaveInsert == 1) {
				leaveUpdate = dao.updateLeave(leaveMap);
			}
        }
        if(leaveUpdate == 1) {
        	result = 1;
        }
		return leaveInsert;
	}
	
	// 재직 -> 휴직, 휴직 -> 재직 스케줄러로 처리 (매일 오전 06시)
	@Override
//	@Scheduled(cron="0 0 6 * * *")
	public void updateLeaveStatus() {
		
		// 재직 처리해야 할 사원들의 목록을 조회하는 메소드  
		List<Map<String, String>> leaveEmpList = dao.getLeaveEmpList();
		// 휴직 처리해야할 사원들의 목록을 조회하는 메소드 
		List<Map<String, String>> leaveStartEmpList = dao.getLeaveStartEmpList();
		
		// 휴직중인 사원의 목록을 전달받아 배열로 변환 후 재직 상태로 update 하는 메소드
		if(leaveEmpList != null && leaveEmpList.size() > 0) {
	    	String[] arr_leaveEmp = new String[leaveEmpList.size()];
	    	
	    	for(int i=0; i<leaveEmpList.size(); i++) {
	    		arr_leaveEmp[i] = leaveEmpList.get(i).get("empno");
	    	}
	    	
	    	Map<String,String[]> paraMap = new HashMap<String, String[]>();
	    	paraMap.put("arr_leaveEmp", arr_leaveEmp);
	    	
	    	dao.updateLeaveEmp(paraMap);
		}
		
		// 재직중인 사원의 목록을 전달받아 배열로 변환 후 휴직 상태로 update 하는 메소드 
		if(leaveStartEmpList != null && leaveStartEmpList.size() > 0) {
	    	String[] arr_leaveStartEmp = new String[leaveStartEmpList.size()];
	    	
	    	for(int i=0; i<leaveStartEmpList.size(); i++) {
	    		arr_leaveStartEmp[i] = leaveStartEmpList.get(i).get("empno");
	    	}
	    	
	    	Map<String,String[]> paraMap = new HashMap<String, String[]>();
	    	paraMap.put("arr_leaveStartEmp", arr_leaveStartEmp);
	    	
	    	dao.updateLeaveStartEmp(paraMap);
		}
		
	
	}

	// 전체 부서 조회하기 
	@Override
	public List<Map<String, String>> getDeptList() {
		List<Map<String, String>> deptList = dao.getDeptList();
		return deptList;
	}

	// 해당부서 팀 구해오기
	@Override
	public List<Map<String, String>> getTeam(Map<String, String> deptMap) {
		List<Map<String, String>> teamList = dao.getTeam(deptMap);
		return teamList;
	}

	// 페이징 처리를 위해 총 사원 수 구해오기 
	@Override
	public int getTotalCount(Map<String, Object> empMap) {
		
		String pattern = "^[0-9]*$"; // 숫자만 등장하는지
		String str = (String) empMap.get("keyword"); 
		
		boolean result = Pattern.matches(pattern, str);
		
		String searchType = "";
		if(str != "") {
			if(result) {
				searchType = "empno";
			}
			if(!result){
				searchType = "name";
			}
		}
		empMap.put("searchType", searchType);
		
		int totalCount = dao.getTotalCount(empMap);
		return totalCount;
	}

	// 페이징 처리한 글목록 가져오기 (검색이 있든지, 검색이 없든지 모두 다 포함한 것)
	@Override
	public List<Map<String, String>> empListSearchWithPaging(Map<String, Object> pageMap) {
		
		String pattern = "^[0-9]*$"; // 숫자만 등장하는지
		String str = (String) pageMap.get("keyword"); 
		
		boolean result = Pattern.matches(pattern, str);
		
		String searchType = "";
		if(str != "") {
			if(result) {
				searchType = "empno";
			}
			if(!result){
				searchType = "name";
			}
		}
		pageMap.put("searchType", searchType);
		List<Map<String, String>> empListPaging = dao.empListSearchWithPaging(pageMap);
		return empListPaging;
	}

	// 페이징 처리를 위한 총 페이지 수 구해오기
	@Override
	public int getTotalPage(Map<String, Object> pageMap) {
		
		String pattern = "^[0-9]*$"; // 숫자만 등장하는지
		String str = (String) pageMap.get("keyword"); 
		
		boolean result = Pattern.matches(pattern, str);
		
		String searchType = "";
		if(str != "") {
			if(result) {
				searchType = "empno";
			}
			if(!result){
				searchType = "name";
			}
		}
		pageMap.put("searchType", searchType);
		
		int totalPage = dao.getTotalPage(pageMap);
		return totalPage;
	}

	// rno 에 해당하는 사원 목록 가져오기 
	@Override
	public List<Map<String, String>> empListWithRno(Map<String, String> pageMap) {
		
		List<Map<String, String>> empList = dao.empListWithRno(pageMap);
		return empList;
	}

	// 신규 사원 등록하기 
	@Override
	public int registEployee(Map<String, Object> paraMap) {
		
		String position = (String) paraMap.get("position");
		
		// 프로필 색상 랜덤 지정하기 
		Random rand = new Random();
		String[] arr_profile_color = {"#FFADC5","#CCD1FF","#A8C8F9","#B8F3B8","#FFDDA6","#FFA9B0","#FFCCCC","#C3C95E","#FC9EBD"};
		
		paraMap.put("profile_color", arr_profile_color[rand.nextInt(9)]);
		
		int registResult = dao.registEployee(paraMap);
		
		if("팀장".equals("position") || "부서장".equals(position)) {
			
			Map<String,String> emailMap = dao.getEmpno(paraMap);
			
			paraMap.put("empno", emailMap.get("empno"));
			
			dao.updateManagerEmpnoRegist(paraMap);
		}
		
		return registResult;
	}

	@Override
	public int checkManager(Map<String, Object> paraMap) {
		
		int manager_yn = 0;// 팀장 부서장 여부  1:있음  0:없음
		
		String position = (String) paraMap.get("position");
		
		// 1. 직위가 부서장/팀장으로 들어온 경우 해당 부서의  부서장/팀장 존재 여부 알아오기 
		if( (position != null || "".equals(position)) && ( "부서장".equals(position) || "팀장".equals(position) ) ) {
			manager_yn = dao.getManagerEmpno(paraMap);
		}
		
		return manager_yn;
	}
	
	
	@Override
	public int personnelAppointment(Map<String, Object> paraMap) {
		
		int insert_psa = 0 ,
			update_dept_mapping =0,
			update_emp = 0 ;  
		
		// 1. 인사발령 테이블에 insert
		insert_psa = dao.insertPsa(paraMap);
		
		String position = (String) paraMap.get("position");
		String deptno = (String) paraMap.get("deptno");
		String teamno = (String) paraMap.get("teamno");
		
		// 2. 사원 테이블 update 
		String updateQuery = ""; 
		if(insert_psa == 1) {
			
			// 1. 부서번호만 들어온 경우 (position == null)
			if(deptno != "" && teamno == "" && position == "") {
				updateQuery = "update tbl_employees set fk_deptno =  "+paraMap.get("deptno") +" where empno = " +paraMap.get("empno");
			}
			// 2. 부서번호,팀번호 들어온 경우 (position == null)
			else if(deptno != "" && teamno != "" && position == "") {
				updateQuery = "update tbl_employees set fk_deptno =  "+paraMap.get("teamno") +" where empno = " +paraMap.get("empno");
			}
			// 3. 부서번호, 직위 들어온 경우 
			else if(deptno != "" && teamno == "" && position != "") {
				updateQuery = "update tbl_employees set fk_deptno = "+paraMap.get("deptno")+" ,position = '"+paraMap.get("position") +"' where empno = " +paraMap.get("empno");
			}
			// 4. 직위만  들어온 경우 (deptno == null && teamno == null) (O)
			else if(deptno == "" && teamno == "" && position != "") {
				updateQuery = "update tbl_employees set position = '"+paraMap.get("position") +"' where empno = " +paraMap.get("empno");
			}
			// 5. 부서번호, 팀번호, 직위 모두 들어온 경우 (O)
			else if(deptno != "" && teamno != "" && position != "") {
				updateQuery = "update tbl_employees set fk_deptno = "+paraMap.get("teamno")+" ,position = '"+paraMap.get("position") +"' where empno = " +paraMap.get("empno");
			}

				
				
			paraMap.put("updateQuery", updateQuery);
			update_emp = dao.updatePsa(paraMap);
		}
		
		if(update_emp == 1) {
			// 3. 부서 매핑 테이블 update (팀장 또는 부서장인 경우)
			if( (position != null || "".equals(position)) && ( "부서장".equals(position) || "팀장".equals(position) ) ) {
				update_dept_mapping = dao.updateManagerEmpno(paraMap);
				return update_dept_mapping;
			}
		}
		
		// 4. 공지 작성 
		
		return update_emp;
	
	}

	@Override
	public int changePsInfo(Map<String, Object> psInfoMap) {

		StringBuilder sql =  new StringBuilder();
		String address = (String) psInfoMap.get("address");
		String detailAddress = (String) psInfoMap.get("detailAddress");
		
		if(!"".equals(detailAddress)) {
			address += " "+detailAddress;
			psInfoMap.put("address", address);
		}
		sql.append(" update tbl_employees set ");
		
		for(String key : psInfoMap.keySet()){
            if(!"".equals(psInfoMap.get(key)) && !"detailAddress".equals(key) && !key.contains("attach")) {
    			sql.append(key + " = '" +psInfoMap.get(key)+"',");
    		}
        }
		
		String str_sql = sql.substring(0, sql.length()-1).toString();
		sql.setLength(0);
		sql.append(str_sql);
		
		sql.append(" where empno = "+psInfoMap.get("empno"));
		
//		System.out.println("확인용 sql : "+ sql.toString());
		psInfoMap.put("sql", sql);
		
		int result = dao.changePsInfo(psInfoMap);
		return result;
	}

	@Override
	public int getTotalPsaPage(Map<String, Object> pageMap) {
		String pattern = "^[0-9]*$"; // 숫자만 등장하는지
		String str = (String) pageMap.get("keyword"); 
		boolean result = false;
		if(str != null) {
			result = Pattern.matches(pattern, str);
		}
		String searchType = "";
		if(str != "") {
			if(result) {
				searchType = "empno";
			}
			if(!result){
				searchType = "name";
			}
		}
		pageMap.put("searchType", searchType);
		
		int totalCount = dao.getTotalPsaPage(pageMap);
		return totalCount;
	}

	@Override
	public List<Map<String, String>> psaListSearchWithPaging(Map<String, Object> pageMap) {
		String pattern = "^[0-9]*$"; // 숫자만 등장하는지
		String str = (String) pageMap.get("keyword"); 
		
		boolean result = Pattern.matches(pattern, str);
		
		String searchType = "";
		if(str != "") {
			if(result) {
				searchType = "empno";
			}
			if(!result){
				searchType = "name";
			}
		}
		pageMap.put("searchType", searchType);
		List<Map<String, String>> psaListPaging = dao.psaListSearchWithPaging(pageMap);
		return psaListPaging;
	}

	@Override
	public List<Map<String, String>> empListDownloadExcel(Map<String, Object> searchMap) {
		String pattern = "^[0-9]*$"; // 숫자만 등장하는지
		String str = (String) searchMap.get("keyword"); 
		
		boolean result = Pattern.matches(pattern, str);
		
		String searchType = "";
		if(str != "") {
			if(result) {
				searchType = "empno";
			}
			if(!result){
				searchType = "name";
			}
		}
		searchMap.put("searchType", searchType);
		List<Map<String, String>> empListPaging = dao.empListDownloadExcel(searchMap);
		return empListPaging;
	}

	/*******excel upload*********/
	/*
	 * @Override public void excelUpload(File destFile) {
	 * 
	 * ExcelReadOption excelReadOption = new ExcelReadOption();
	 * 
	 * //파일경로 추가 excelReadOption.setFilePath(destFile.getAbsolutePath());
	 * 
	 * //추출할 컬럼명 추가 excelReadOption.setOutputColumns("A", "B", "C", "D", "E","F");
	 * 
	 * //시작행 excelReadOption.setStartRow(2);
	 * 
	 * List<Map<String, String>>excelContent = ExcelRead.read(excelReadOption);
	 * 
	 * Map<String, Object> paramMap = new HashMap<String, Object>();
	 * paramMap.put("excelContent", excelContent);
	 * 
	 * System.out.println("확인용 : "+excelContent);
	 * 
	 * try { dao.insertExcel(paramMap); }catch(Exception e) { e.printStackTrace(); }
	 * }
	 */

	@Override
	public int updateLeave(Map<String, String> leaveMap) {
		
		StringBuilder sql =  new StringBuilder();
		
		sql.append(" update tbl_leave_absence set ");
		
		for(String key : leaveMap.keySet()){
            if(!"".equals(leaveMap.get(key)) && !"empno".equals(key) && !"leaveno".equals(key)) {
    			sql.append(key + " = '" +leaveMap.get(key)+"',");
    		}
        }
		
		String str_sql = sql.substring(0, sql.length()-1).toString();
		sql.setLength(0);
		sql.append(str_sql);
		
		sql.append(" where leaveno = "+leaveMap.get("leaveno"));
		leaveMap.put("sql", sql.toString());
		
		int leaveUpdateResult = dao.updateLeaveDate(leaveMap);
		
		// 현재 날짜와 휴직 시작일 비교, 휴직 시작일이 작은 경우 휴직처리 
        LocalDate now = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String formatedNow = now.format(formatter);
        
        int dateResult = leaveMap.get("startdate").compareTo(formatedNow);
		
        if(dateResult == 0 || dateResult < 0) {// 휴직 신청 날짜가 같은 경우  또는 이후 날짜인 경우 
			if(leaveUpdateResult == 1) {
				
				leaveUpdateResult = dao.updateLeave(leaveMap);
			}
        }
        else {
        	dao.updateLeavejae(leaveMap);
        }
        
		return leaveUpdateResult;
	}

	@Override
	public int cancelLeave(Map<String, Object> paraMap) {
		
		int result = dao.cancelLeave(paraMap);
		
		if(result == 1) {
			result = dao.updateLeaveStatus(paraMap);
		}
		
		return result;
	}

	@Override
	public int registCheckManager(Map<String, Object> paraMap) {
		int manager_yn = 0;// 팀장 부서장 여부  1:있음  0:없음
		
		manager_yn = dao.getManagerEmpnoRegist(paraMap);
		
		return manager_yn;
	}

	@Override
	public int getTotalCnt(Map<String, Object> pageMap) {
		String pattern = "^[0-9]*$"; // 숫자만 등장하는지
		String str = (String) pageMap.get("keyword"); 
		boolean result = false;
		if(str != null) {
			result = Pattern.matches(pattern, str);
		}
		String searchType = "";
		if(str != "") {
			if(result) {
				searchType = "empno";
			}
			if(!result){
				searchType = "name";
			}
		}
		pageMap.put("searchType", searchType);
		
		int cnt = dao.getTotalCnt(pageMap);
		return cnt;

	}

	@Override
    public void excelUpload(File destFile) {
        
        ExcelReadOption excelReadOption = new ExcelReadOption();
        
        //파일경로 추가
        excelReadOption.setFilePath(destFile.getAbsolutePath());
        
        //추출할 컬럼명 추가
        excelReadOption.setOutputColumns("A", "B", "C", "D", "E","F");
        
        //시작행
        excelReadOption.setStartRow(2);
        
        List<Map<String, String>>excelContent  = ExcelRead.read(excelReadOption);
        
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("excelContent", excelContent);
        
        System.out.println("확인용 : "+excelContent);
        
        try {
            dao.insertExcel(paramMap);
        }catch(Exception e) {
            e.printStackTrace();
        }
    }

}
