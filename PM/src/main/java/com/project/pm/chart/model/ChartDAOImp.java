package com.project.pm.chart.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ChartDAOImp implements ChartDAO{

	@Resource
	private SqlSessionTemplate sqlsession;

	// 모든 부서 부서이름, 상위부서 번호, 부서번호를 조회해오는 메소드 
	@Override
	public List<Map<String, String>> deptName() {
		
		List<Map<String, String>> deptNameList = sqlsession.selectList("emp.deptName");
		return deptNameList;
	}

	// 부서번호를 전달받아 해당하는 팀 번호를 조회해오는 메소드
	@Override
	public List<Map<String, String>> getTeamName(Map<String, String> deptnoMap) {
		List<Map<String, String>> teamNameList = sqlsession.selectList("emp.getTeamName", deptnoMap);
		return teamNameList;
	}

	// 팀 번호를 전달 받아 해당하는 해당 팀에 존재하는 사원목록을 조회해오는 메소드
	@Override
	public List<Map<String, String>> getEmployee(Map<String, String> teamnoMap) {
		List<Map<String, String>> employeeList = sqlsession.selectList("emp.getEmployees",teamnoMap);
		return employeeList;
	} 

}
