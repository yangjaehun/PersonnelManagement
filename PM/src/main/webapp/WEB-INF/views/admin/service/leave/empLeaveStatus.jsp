<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath=request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<jsp:include page="leaveCategory.jsp" />
    
<style type="text/css">
	
	div#tableDiv {
		width: 96%;
		margin: 30px auto;
	}
	
	table {
		margin-top : 10px;
		width: 100%;
		text-align: center;
	}
	
	tr {
		height: 40px;
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
	
	td.head:hover {
		cursor: pointer;
		font-weight: bold;
		color: red;
	}
	
	span.tableTitle {
		display: block;
		font-size: 12pt;
	}
	
	span.tableTitle2 {
		font-size: 11pt;
		font-weight: normal;
		color: gray;
	}
	

</style>

<%-- 말풍선 --%>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<script type="text/javascript">

	$(document).ready(function () {
		
		$("span#empLeave").css("color", "#494949");
		$("span.headerTitle2").show();
		$("span#empLeaveStatus").css("color", "#494949");
		$("div#underBar2").css("display", "block");
		
		$('[data-toggle="tooltip"]').tooltip();
	});
	
	function promotionLeave(empno, name){
		
		$.ajax({
	    	url : "<%=ctxPath%>/leave/promoteAnnual.pm",
	    	data : {'empno' : empno},
			success: function(){

				toastr.success(name+'님에게<br>연차촉진 알림을 보냈습니다.');
			},
			error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		}); // end of ajax
		
		
		
	}

	
</script>	    

<%-- 구성원 휴가 보유 현황 시작 --%>

<div id="tableDiv">
	<table class="table table-bordered table-hover ">
		<thead>
		    <tr>
		      <th class="head"><span class="tableTitle">이름</span></th>
		      <th><span class="tableTitle">사번</span></th>
		      <th><span class="tableTitle">부서</span></th>
		      <th><span class="tableTitle">직급</span></th>
		      <th><span class="tableTitle">잔여연차</span><span class="tableTitle2">매년 지급(15일)</span></th>
		      <th><span class="tableTitle">잔여반차</span><span class="tableTitle2">매년 지급(30번)</span></th>
		      <th><span class="tableTitle">잔여병가</span><span class="tableTitle2">기본 90일까지</span></th>
		      <th><span class="tableTitle">잔여여름휴가</span><span class="tableTitle2">매년 지급(4일)</span></th>
		      <th><span class="tableTitle">조의사용</span><span class="tableTitle2">신청시 지급(5일/3일)</span></th>
		      <th><span class="tableTitle">결혼사용</span><span class="tableTitle2">신청시 지급(2일/1일)</span></th>
		      <th><span class="tableTitle">긴급사용</span><span class="tableTitle2">신청시 지급(1일)</span></th>
		      <th><span class="tableTitle">기타사용</span><span class="tableTitle2">신청시 지급(1일)</span></th>
		    </tr>
		</thead>
		<tbody>
			<c:forEach items="${leaveStatusList }" var="leaveStatus">
				<tr>
			      <td class="head" data-toggle="tooltip" data-placement="top" title="해당 사원 휴가보기" onclick="javascript:location.href='<%= ctxPath%>/leave/specificEmpLeave.pm?empno=${leaveStatus.empno }&name=${leaveStatus.name }'" >
			      		<div class="tableProf"  style="background-color: ${leaveStatus.profile_color }">${leaveStatus.nickname }</div>${leaveStatus.name }
			      </td>
			      <td class="patop">${leaveStatus.empno }</td>
			      <td class="patop">${leaveStatus.deptname }</td>
			      <td class="patop">${leaveStatus.position }</td>
			      <td class="promotionLeave patop" data-toggle="tooltip" data-placement="top" title="연차촉진하기" onclick="promotionLeave('${leaveStatus.empno }', '${leaveStatus.name }')">${leaveStatus.annual }</td>
			      <td class="patop">${leaveStatus.half_annual }</td>
			      <td class="patop">${leaveStatus.sick }</td>
			      <td class="patop">${leaveStatus.summer }</td>
			      <td class="patop">${leaveStatus.condolence }</td>
			      <td class="patop">${leaveStatus.marrige }</td>
			      <td class="patop">${leaveStatus.emergency }</td>
			      <td class="patop">${leaveStatus.etc }</td>
			    </tr>
			</c:forEach>
		    
		    <!-- <tr>
		      <td class="head"><div class="tableProf">지현</div>김지현</td>
		      <td class="patop">103</td>
		      <td class="promotionLeave patop" data-toggle="tooltip" data-placement="top" title="연차촉진하기" onclick="promotionLeave()">12</td>
		      <td class="patop">25</td>
		      <td class="patop">90</td>
		      <td class="patop">4</td>
		      <td class="patop">0</td>
		      <td class="patop">0</td>
		      <td class="patop">0</td>
		      <td class="patop">0</td>
		    </tr>
		    <tr>
		      <td class="head"><div class="tableProf">지현</div>김지현</td>
		      <td class="patop">103</td>
		      <td class="promotionLeave patop" data-toggle="tooltip" data-placement="top" title="연차촉진하기" onclick="promotionLeave()">12</td>
		      <td class="patop">25</td>
		      <td class="patop">90</td>
		      <td class="patop">4</td>
		      <td class="patop">0</td>
		      <td class="patop">0</td>
		      <td class="patop">0</td>
		      <td class="patop">0</td>
		    </tr>
		    <tr>
		      <td class="head"><div class="tableProf">지현</div>김지현</td>
		      <td class="patop">103</td>
		      <td class="promotionLeave patop" data-toggle="tooltip" data-placement="top" title="연차촉진하기" onclick="promotionLeave()">12</td>
		      <td class="patop">25</td>
		      <td class="patop">90</td>
		      <td class="patop">4</td>
		      <td class="patop">0</td>
		      <td class="patop">0</td>
		      <td class="patop">0</td>
		      <td class="patop">0</td>
		    </tr>
		    <tr>
		      <td class="head"><div class="tableProf">지현</div>김지현</td>
		      <td class="patop">103</td>
		      <td class="promotionLeave patop" data-toggle="tooltip" data-placement="top" title="연차촉진하기" onclick="promotionLeave()">12</td>
		      <td class="patop">25</td>
		      <td class="patop">90</td>
		      <td class="patop">4</td>
		      <td class="patop">0</td>
		      <td class="patop">0</td>
		      <td class="patop">0</td>
		      <td class="patop">0</td> -->
		    </tr>
	    </tbody>
	</table>
</div>

<%-- 구성원 휴가 보유 현황  끝 --%>		
	