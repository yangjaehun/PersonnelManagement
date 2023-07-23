<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath=request.getContextPath(); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<jsp:include page="leaveCategory.jsp" />
    
<style type="text/css">
	
	div#tableDiv {
		width: 90%;
		margin: 10px auto;
	}
	
	table {
		margin-top : 10px;
		width: 100%;
		text-align: center;
	}
	
	tr {
		height: 40px;
		cursor: pointer;
	}
	
	th {
		vertical-align: middle;
	}
	
	td.promotionLeave:hover {
		cursor: pointer; 
		background-color: #9d9d9d;
	}
	
	div.tableProf {
		display : inline-block;
		width: 40px; 
		height: 40px; 
		border-radius: 40%; 
		background-color: #239afe;
		color: white;
		text-align: center;
		padding-top: 8px;
		border: 1px solid #ccced0;
		font-weight: bold;
		font-size: 13px;
		margin: auto 10px auto 5px;;
	}
	
	td.patop {
		padding-top: 20px;
	} 
	
	td {
		font-size: 11pt;
	}
	
	.head {
		width: 150px;
	}
	
	span.tableTitle {
		display: block;
		font-size: 12pt;
	}
	
	span.badge {
		font-size: 10pt;
	}
	
	button.approve {
		height: 30px;
		font-size: 10pt;
		font-weight: bold;
		border-radius: 1rem;
		margin-top: 5px;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		$("span#empLeave").css("color", "#494949");
		$("span.headerTitle2").show();
		$("span#empLeaveSubmit").css("color", "#494949");
		$("div#underBar1").css("display", "block");
		
	});

	
</script>	


<div id="tableDiv">
	<table class="table table-bordered table-hover ">
		<thead>
		    <tr>
		      <th class="head"><span class="tableTitle">이름</span></th>
		      <th><span class="tableTitle">사번</span></th>
		      <th><span class="tableTitle">직급</span></th>
		      <th><span class="tableTitle">기간</span></th>
		      <th><span class="tableTitle">항목</span></th>
		      <th><span class="tableTitle">사용기간</span></th>
		      <th><span class="tableTitle">증명자료</span></th>
		      <th><span class="tableTitle">승인</span></th>
		    </tr>
		</thead>
		<tbody>
			<c:forEach items="${requestLeaveList }" var="requestLeave">
				<tr onclick="openLeaveDetail('${requestLeave.pk_request_leaveno }')"  data-toggle="modal" data-target="#leaveDetail">
			      <td><div class="tableProf" style="background-color: ${requestLeave.profile_color }">${requestLeave.nickname }</div>${requestLeave.name }</td>
			      <td class="patop">${requestLeave.fk_empno }</td>
			      <td class="patop">${requestLeave.position }</td>
			      <td class="patop">${requestLeave.start_day } ${requestLeave.start_name } ~ ${requestLeave.end_day } ${requestLeave.end_name }</td>
			      <td class="patop">${requestLeave.leave_name }</td>
			      <td class="patop">${requestLeave.use_days }일</td>
			      <c:if test="${requestLeave.add_file eq 1 and not empty requestLeave.filename }">
			      	<td class="patop"><span class="badge badge-success rounded-pill">제출완료</span></td>
			      </c:if>
			      <c:if test="${requestLeave.add_file eq 1 and empty requestLeave.filename }">
			      	<td class="patop"><span class="badge badge-warning rounded-pill">미제출</span></td>
			      </c:if>
			      <c:if test="${requestLeave.add_file eq 0}">
			      	<td class="patop"></td>
			      </c:if>
			      
			      <c:if test="${requestLeave.opproval_status eq 0}">
			      	<td><button type="button" class="btn btn-outline-secondary btn-sm approve">승인 / 반려</button></td>
			      </c:if>
			      <c:if test="${requestLeave.opproval_status eq 1}">
			      	<td class="patop" style="font-weight: bold; color: blue;">승인 완료</td>
			      </c:if>
			      <c:if test="${requestLeave.opproval_status eq 2}">
			      	<td class="patop" style="font-weight: bold; color: red;">취소</td>
			      </c:if>
			      
			    </tr>
			</c:forEach>
		    <!-- <tr>
		      <td><div class="tableProf">지현</div>김지현</td>
		      <td class="patop">103</td>
		      <td class="patop">대리</td>
		      <td class="patop">2022.11.11(금) ~ 2022.11.11(금)</td>
		      <td class="patop">연차</td>
		      <td class="patop">오후</td>
		      <td class="patop"></td>
		      <td><button type="button" class="btn btn-outline-secondary btn-sm approve">승인 / 취소</button></td>
		    </tr> -->
		    
	    </tbody>
	</table>
	
	<!-- 휴가 상세 모달 -->
	<%@ include file="modal/requestLeaveDetailModal.jsp" %>
</div>
