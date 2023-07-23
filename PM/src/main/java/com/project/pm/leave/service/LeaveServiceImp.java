package com.project.pm.leave.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.pm.leave.model.LeaveDAO;

@Service
public class LeaveServiceImp implements LeaveService{
	
	@Autowired
	LeaveDAO ldao;

	// 휴가 종류와 남은 일수 구해오기
		@Override
		public List<Map<String, String>> getLeaveTypeList(Map<String, String> paraMap) {
			List<Map<String, String>> leaveTypeList = ldao.getLeaveTypeList(paraMap);
			return leaveTypeList;
		}

		// 모달에 들어갈 해당 휴가에 대한 상세 내용 알아오기
		@Override
		public Map<String, String> getLeaveDate(Map<String, String> paraMap) {
			Map<String, String> leaveData = ldao.getLeaveDate(paraMap);
			return leaveData;
		}

		// 휴가 신청하기
		@Override
		public void requestLeave(Map<String, String> parameterMap) {
			ldao.requestLeave(parameterMap);
			
			// 휴가 신청하면서 휴가 사용내역 같이 업데이트 해주는건데, 연차나 반차일때는 따로 식써야 함
			if(parameterMap.get("pk_leave_type").equals("annual")) {
				ldao.plusUsedLeaveAnnual(parameterMap);
			} else if (parameterMap.get("pk_leave_type").equals("half_annual")) {
				ldao.plusUsedLeaveHalf_annual(parameterMap);
			} else {
				ldao.plusUsedLeave(parameterMap);
			}
			
		}

		
		// 휴가 사용 내역 조회하기
		@Override
		public List<Map<String, String>> getLeaveRecode(Map<String, String> paraMap) {
			List<Map<String, String>> leaveRecodeList = ldao.getLeaveRecode(paraMap);
			return leaveRecodeList;
		}

		
		// 휴가 예정 내역 조회하기
		@Override
		public List<Map<String, String>> getLeavePlan(Map<String, String> paraMap) {
			List<Map<String, String>> leavePlanList = ldao.getLeavePlan(paraMap);
			return leavePlanList;
		}

		
		// 하위 부서 번호 전부 알아오기
		@Override
		public List<String> getLowerDeptnoList(String fk_deptno) {
			List<String> lowerDeptnoList = ldao.getLowerDeptnoList(fk_deptno);
			return lowerDeptnoList;
		}

		
		// 조회한 부서에 해당하는 사원들의 휴가 신청내역을 불러온다
		@Override
		public List<Map<String, String>> getRequestLeaveList(Map<String, String> paraMap) {
			List<Map<String,String>> requestLeaveList = ldao.getRequestLeaveList(paraMap);
			return requestLeaveList;
		}
		
		
		// 조회한 부서에 해당하는 사원들의 휴가 사용/잔여 내역을 불러온다
		@Override
		public List<Map<String, String>> getLeaveStatusList(String deptJoin) {
			List<Map<String,String>> leaveStatusList = ldao.getLeaveStatusList(deptJoin);
			return leaveStatusList;
		}

		
		// 관리자 사원번호 리스트 가져오기
		@Override
		public List<String> getAdminEmpnoList() {
			List<String> adminEmpnoList = ldao.getAdminEmpnoList();
			return adminEmpnoList;
		}

		
		// 휴가신청 번호로 휴가신청 상세 조회
		@Override
		public Map<String, String> getLeaveRequestDetail(String request_leaveno) {
			Map<String, String> leaveRequestDetail = ldao.getLeaveRequestDetail(request_leaveno);
			return leaveRequestDetail;
		}

		
		// 휴가신청에 파일 추가 하기
		@Override
		public void addFileToRequestLeave(Map<String, String> paraMap) {
			ldao.addFileToRequestLeave(paraMap);
		}

		
		// 휴가신청 삭제하기
		@Override
		public void deleteRequestLeave(Map<String, String> leaveRequestDetail) {
			
			ldao.deleteRequestLeave(leaveRequestDetail); 
			
			// 휴가 신청하면서 휴가 사용내역 같이 업데이트 해주는건데, 연차나 반차일때는 따로 식써야 함
			if(leaveRequestDetail.get("fk_leave_type").equals("annual")) {
				ldao.minusUsedLeaveAnnual(leaveRequestDetail);
			} else if (leaveRequestDetail.get("fk_leave_type").equals("half_annual")) {
				ldao.minusUsedLeaveHalf_annual(leaveRequestDetail);
			} else {
				ldao.minusUsedLeave(leaveRequestDetail);
			}
		}

		
		// 승인 / 반려하기 함수 
		@Override
		public void approvalRequestLevae(Map<String, String> leaveRequestDetail) {
			
			ldao.approvalRequestLevae(leaveRequestDetail);
			
			// 반려라면, 휴가 사용 내역 고쳐줘야 함
			if("2".equals(leaveRequestDetail.get("approval_status"))) {
				// 휴가 신청하면서 휴가 사용내역 같이 업데이트 해주는건데, 연차나 반차일때는 따로 식써야 함
				if(leaveRequestDetail.get("fk_leave_type").equals("annual")) {
					ldao.minusUsedLeaveAnnual(leaveRequestDetail);
				} else if (leaveRequestDetail.get("fk_leave_type").equals("half_annual")) {
					ldao.minusUsedLeaveHalf_annual(leaveRequestDetail);
				} else {
					ldao.minusUsedLeave(leaveRequestDetail);
				}
			}
			
			
		}

}
