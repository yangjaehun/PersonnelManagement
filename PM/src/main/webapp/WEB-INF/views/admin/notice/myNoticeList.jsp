<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 


<jsp:include page="listnav.jsp" />

<style type="text/css">
	
	/* nav 시작 */
	
	#cate1, #cate2 {
		color: #d1d3d1;
	}
	
	/* nav 끝 */
	
	div#boardList{
		height: 100%;
		width: 99%;
	}
	
	
	div.listRow {
		border: 1px solid #f9fafa; 
		min-height: 110px;
		width: 99.9%;
	}
	
	
	div.listRowInside {
		/* border: 1px solid black; */
		width: 97%;
		min-height: 90px;
		margin: 10px auto;
		display: flex;
  		align-items: center;
  		padding-right: 10px;
	}
	
	span.spanBlock {
		display: block;
		font-size: 11pt;
	}
	
	div.listcontent1:hover {
		cursor: pointer;
	}
	
	/* span.spanBlock:hover {
		cursor: pointer;
	} */
	
	button.listBnt {
		width: 100px;
		height: 40px;
		border: 1px solid #07b419;
		border-radius: 0.5rem;
		margin-right: 15px;
		font-weight: bold;
		font-size : 11pt;
		background-color: #07b419;
		color: white;
		display: none;
	}
	
	 button.listBnt:hover {
		filter: brightness(90%);
	}  
	
	
	/* 게시물 한 개 사이드 모달  */
	
	.modal.right .modal-dialog {
		position: fixed;
		margin: auto;
		width: 100%;
		height: 100%;
		-webkit-transform: translate3d(0%, 0, 0);
		    -ms-transform: translate3d(0%, 0, 0);
		     -o-transform: translate3d(0%, 0, 0);
		        transform: translate3d(0%, 0, 0);
	}

	.modal.right .modal-content {
		height: 100%;
	/* 	overflow-y: auto; */
	}
	
	.modal.right .modal-body {
	 /* padding: 15px 15px 80px;  */
	 	width: 100%; 
	}
	
	.modal.right.fade .modal-dialog {
		right: 0;
		-webkit-transition: opacity 0.3s linear, right 0.3s ease-out;
		   -moz-transition: opacity 0.3s linear, right 0.3s ease-out;
		     -o-transition: opacity 0.3s linear, right 0.3s ease-out;
		        transition: opacity 0.3s linear, right 0.3s ease-out;
	}
	
	.modal.right.fade.in .modal-dialog {
		right: 0;
	}
	
	.modal-header {
		border-bottom-color: #EEEEEE;
		background-color: #FAFAFA;
	}
	

	/* 페이징 처리 */	
	
	
	a{
	  text-decoration: none;
	}
	
	p, li, a{
	  font-size: 14px;
	}
	
	.container{
	  width: 50%;
	  margin: 0 auto;
	  position: relative;
	  text-align: center;
	}
	
	
	.pagination{
	  padding: 30px 0;
	}
	
	.pagination ul{
	  margin: 0;
	  padding: 0;
	  list-style-type: none;
	}
	
	.pagination a{
	  display: inline-block;
	  width: 40px;
	  height: 40px;
	  text-align: center;
	  padding-top: 7px;
	  color: #2ecc71;
	  font-weight: bold;
	}
	
	
	.p12 a.last{
		border: 2px solid #2ecc71;
	  	background-color: #2ecc71;
	  	color: #fff;
	  	font-weight: bold;
	  	border-radius: 50%;
	}
	
	.p12 .is-active{
		border: 2px solid #2ecc71;
	  	background-color: #2ecc71;
	  	color: #fff;
	  	font-weight: bold;
	  	border-radius: 50%;
	}
	
	.p12 a.box {
		border: 2px solid #2ecc71;
		color : #2ecc71;
		width: 100px;
		font-weight: bold;
		border-radius: 1.8rem;
		margin-left: 5px;
		margin-right: 5px;
	}
	
	
	
</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		$("div.listRow").hover(function(){
			$(this).css("background-color","#f9fafa");
			$(this).find("button").css("display","block")
		}
		, function(){
			$(this).css("background-color","");
			$(this).find("button").css("display","")
		});
		
		// 모달 바깥영역 누르면 닫히는거
		$('#myListModal_outside').on('click', function () {
			closemyListModal();
		});
		
		// 모달 닫기 x 자 누르면 닫히는거
		$("button.close").on('click', function () {
			closemyListModal();
		});
		
		
		
		// 공지 수정하기 버튼 클릭 이벤트
		$("button.EditBnt").click(function(){
		
			let notino = $(this).parent().find($("input#notino")).val();
			let fk_senderno = $(this).parent().find($("input#fk_senderno")).val();
			let empno = ${sessionScope.loginuser.empno}
			
			// console.log(notino);
			// console.log(fk_senderno);
			// console.log(empno);
			//	alert('수정 버튼 클릭!');
			
			if( empno == fk_senderno || empno == '9999' ){
				openNoticeEditModal(notino);
				// $("#noticeEditModal").modal('hide');
			}
			else{
				alert('작성자만 수정 가능합니다.');
				// $('div.noticeEditModal').modal('hide');
				// $('div.noticeEditModal').trigger('hide');
				$(this).attr("disabled", true);
			//	window.location.reload();
				top.document.location.reload(); 
			}
			
		}); // end of 공지 수정하기 버튼 클릭 이벤트
		
		
		
		// 공지글 삭제하기 버튼 클릭시 
      	$(document).on("click","button.DeleteBnt",function(){
	         const notino = $(this).next().find("#notino").val();
	         const fk_senderno = $(this).next().find("#fk_senderno").val();
	       	 
	         
	   //    console.log("삭제할 공지 번호 : "+ notino);
	   //  	 console.log("공지 작성자 사원번호 : "+ fk_senderno);
	      
	         
          	 $.ajax({
	             url:"<%= request.getContextPath() %>/notice/deleteMyNoticeEnd.pm",
	             type : "POST",
	             data : {"notino" : notino,
	            	 	 "fk_senderno" : fk_senderno},
	            	
	             dataType: "JSON",
	             success: function(json){
					  
	            //	  json.result; // 컨트롤러에서 넣은 json값 가져오기
	            //	  console.log(json.result);
	            	 if(json.result == 0 ){
	            		 alert(json.message);
	            	 }	
	            	 else{
	            		 alert(json.message);
	            	 }
	            	// console.log(result);
	               	 location.reload();
	                
	               },
	               error: function(request, status, error){
	                      alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	               }
	               
	           });// end of $.ajax()--------------------------------
      });//end of $(document).on("click","button.DeleteBnt",function(){}-------------------------
		
		
		
		
	}); // end of $(document).ready(function() ------

	
	// 모달 열기 (notino 로 해당 공지 내용 Ajax로 가져오기 ( 내가 쓴 공지글 1개 조회에 대한 상세 모달) )
	function openmyListModal(notino){
		
	//	console.log("확인용 공지번호 "+notino);
		
		$.ajax({
	    	url : "<%= request.getContextPath() %>/notice/getMyOneNoticeContent.pm",
	    	type: 'POST',
	    	data : {"notino" : notino},
	    	dataType: "JSON",
			success: function(json){
			//	console.log(json);
				$("#myListModal span#prof").text(json.nickname);
				$("#myListModal span#prof").css("background-color", json.profile_color);
				$("#myListModal span#name").text(json.name + " · " + json.position + " · " +  json.deptname + " ▶ " + json.showDept);
				$("#myListModal span#writedate").text(json.writedate);
				$("#myListModal span#subject").text(json.subject);
				
				$("#myListModal span#noticeFile").text(json.orgFilename);
				$("#myListModal input#file_notino").val(json.notino);
			
				$("#myListModal span#content").text(json.content);
				$("#myListModal input#notino").val(json.notino);
				$("#myListModal input#fk_notino").val(json.notino);
			
				
				// 첨부 파일을 구해오는 ajax
				if(json.fileName != null){
					
					console.log(json.fileName);
						
					 const file_notino = $("#myListModal input#file_notino").val();
					 console.log(file_notino);
					
					 
					 $.ajax({
					    	url : "<%= request.getContextPath() %>/notice/getMyFile.pm",
					    	data : {"notino" : file_notino},
					    	dataType: "JSON",
							success: function(json2){
								
							//	console.log(json2);
							//	json2.notino;
							//	cosole.log(json2.notino);
								let html = "";
								if(json2.length>0){
									let html = '<dic class="filedownload">[첨부파일]</div>';
									$.each(json2, function(index2, item2){
										html+='<span style="font-size: 10pt; color: gray;"><i class="fas fa-solid fa-paperclip ml-3 mr-1"></i></span>'+
								        	'<span id="notifile" style="cursor:pointer;" onclick="javascript:location.href=\'<%= request.getContextPath() %>/notice/downloadMyFile.pm?fileName='+item2.fileName+'&orgFilename='+item2.orgFilename+'\'" >'+item2.orgFilename+'</span><br>';
									});
									
									$("span#noticeFile").html(html);
								}
							},
							error: function(request, status, error){
				                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				            }
						}); // end of 첨부파일 ajax
			} else {
				$("div#mailAttachArea").html('');
			}
			
				goReadComment(notino); // 댓글 조회하는 function
				
			},
			error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		}); // end of jax
		
		$('#myListModal').addClass('active');
	    $('#myListModal_outside').fadeIn();
		
	}
	
	// 모달 닫기
	function closemyListModal(){
		$('#myListModal').removeClass('active');
	    $('#myListModal_outside').fadeOut();
	}

	
	
	// 공지 리스트 수정
	function openNoticeEditModal(notino) {
		
		$.ajax({
	    	url : "<%= request.getContextPath() %>/notice/getMyNoticeContent.pm",
	    	type: 'POST',
	    	data : {"notino" : notino},
	    	dataType: "JSON",
			success: function(json){
			//	console.log(json);
				
				$("input#editsubject").val(json.subject);
				$("textarea#editContent").text(json.content);               
				$("input#hidden_notino").val(json.notino);
			},
			error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		}); // end of 첨부파일 ajax

	}
	
</script>

    
<%-- 게시판 리스트 시작 --%>
<div id="boardList">
	<c:if test="${ not empty requestScope.myNoticeList}">
		<c:forEach var="myNoti" items="${requestScope.myNoticeList}">
			<div class="listRow">
				<div class="listRowInside" style="width: 100%;">
					<div id="prof" class="mt-3" style= "background-color: ${myNoti.profile_color};"> ${myNoti.nickname}</div>
					<div class="listcontent1 ml-4" style="width: 500px;" onclick="openmyListModal(${myNoti.notino})">
						<input type="hidden" id="notino" value="${myNoti.notino}">
						<input type="hidden" id="fk_senderno" value="${myNoti.fk_senderno}">
						<span style="font-weight: bold;" id="subject"><span style='font-size: 20px;'>&#128226;</span> <%-- 중요 공지사항 이모지 붙이기 --%>
						${myNoti.subject}</span>&nbsp;
						<c:if test="${myNoti.readCount ne 0 }">	
							<span id="readCount"  style="color: green;">[${myNoti.readCount}]</span>	
						</c:if>
						
						<c:if test="${ myNoti.fileName ne null}">
						<span><i class="fa fa-paperclip" aria-hidden="true"></i></span> <%-- 파일 첨부할 경우 --%>
						</c:if>
						
						<span id="writedate" style="margin-left: 20px; font-size: 10pt;">${myNoti.writedate}</span>
						<span id="name" style="display:block; font-size: 10pt;">${myNoti.name} · ${myNoti.position } · ${myNoti.deptname} ▶ ${myNoti.showDept } </span>  
						
						<c:choose>
							<c:when test="${fn:length(myNoti.content) gt 20}">
								<span id="content" class="spanBlock mt-2" style="color: gray">
									<c:out value="${fn:substring(myNoti.content,0,19)}">
									</c:out> ........
								</span>
							</c:when>
							<c:otherwise>
								<span id="content" class="spanBlock mt-2" style="color: gray">
									<c:out value="${myNoti.content}">
									</c:out>
								</span>	
							</c:otherwise>
						</c:choose>
						&nbsp;&nbsp;
						<span class="mt-2 mb-2" style="font-size: 10pt; color: gray; display: inline-block;"> <span> ┗ &nbsp;</span><span id="cmtCount" style="color: green;"> <span style='font-size:25px;'>&#128172;</span> [${myNoti.cmtCount}]  </span></span>
					</div>
					<button class="listBnt EditBnt" style="background-color: white; color: #07b419; margin-left: 620px; float: right;"  data-toggle="modal" data-target=".noticeEditModal">수정하기</button>
					
					<button type="button" class="listBnt DeleteBnt" style="float: right;" >삭제하기</button>
					<form name="delFrm" id="delFrm"> <%-- 값이 있을 때 폼태그.. --%>
					<input type="hidden" id="notino" value="${myNoti.notino}" name="notino">
					<input type="hidden" id="fk_senderno" value="${myNoti.fk_senderno}" name="fk_senderno">
					</form>
				</div>
			</div>
		</c:forEach>
	</c:if>
	
	<c:if test="${empty requestScope.myNoticeList }">
		<div class="listRow">
			<div class="listRowInside" style="width: 100%;">
				<div class="px-3">작성된 공지글이 없습니다.</div>
			</div>
		</div>
	</c:if>
	
	
	
	<%-- 페이징 처리 --%>
	<div class="container"> 
    <div class="pagination p12">
      ${requestScope.pageBar}
    </div>
  	</div>
	
	
</div>

	
<%-- 공지 리스트(boardlist) 끝 --%>

<%-- 공지 상세 모달 --%>
<%@ include file="detail/myNoticeDetail.jsp" %>

<%-- 공지 수정 모달 --%>
<%@ include file="edit/myNoticeEdit.jsp" %>


