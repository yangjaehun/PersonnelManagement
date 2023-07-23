package com.project.pm.chart.service;

import java.util.List;
import java.util.Map;

public interface ChartService {
	/** 전체 부서명을 조회해오는 메소드 */
	List<Map<String, String>> deptName();

	/** 부서번호를 전달받아 해당하는 팀 번호를 조회해오는 메소드  */
	List<Map<String, String>> getTeamName(Map<String, String> deptnoMap);

	/** 팀 번호를 전달 받아 해당하는 해당 팀에 존재하는 사원목록을 조회해오는 메소드   */
	List<Map<String, String>> getEmployees(Map<String, String> teamnoMap);

}
