<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>

<style>


.tui-datepicker-input.tui-has-focus {
	margin-top : 10px;
	margin-right: 5px;
}	

div#peopleContent {
	margin-right: 10px;
}

div#header {
	border-bottom: solid 1px #d9d9d9;
	display: flex;
	justify-content: space-between;
}

span.title {
	font-size: 28px;
	margin-right: 20px;
	font-weight: 700;
	letter-spacing: -1.12px;
}

div#header_title, div#button_title {
	margin: 35px 20px 20px 20px;
}

button#registMember {
	background: linear-gradient( to left ,#5bd3ff, #88eb1e );
	color: white;
}

tr {
	font-size: 10pt;
}

.th_200 {
	width: 200px;
}

.th_150 {
	width: 150px;
}

.th_100 {
	width: 100px;
}

.th_50 {
	width: 50px;
}

.th_20 {
	width: 20px;
}

<%-- 상세 조회 아이콘 css --%> div.profile_icon {
	width: 30px;
	height: 30px;
	border-radius: 40%;
	/* background-color: #239afe; */
	color: white;
	text-align: center;
	padding-top: 6px;
	border: 1px solid #ccced0;
	font-weight: bold;
	margin: auto 8px;
	font-size: 5pt;
}

<%-- 간단조회 아이콘 css --%> div.profile_icon2 {
	width: 50px;
	height: 50px;
	border-radius: 40%;
	background-color: #239afe;
	color: white;
	text-align: center;
	padding-top: 6px;
	border: 1px solid #ccced0;
	font-weight: bold;
	margin: auto 8px;
	font-size: 15px;
}

div.profile_icon2>div {
	margin-top: 3px;
}

div.profile, div.profile2 {
	display: flex;
	justify-content: start;
}

<%-- 검색버튼, 조직도 버튼, 다운로드 버튼 css --%> 
div#search_buttons {
	display: flex;
	justify-content: end;
	border-bottom: solid 1px #d9d9d9;
	padding: 10px 20px;
}

button.btn_search:hover {
	background-color: #ebebeb;
}

div#div_toggle_buttons {
	background-color: #ebebeb;
	padding: 3px;
	border-radius: 5px;
}

button.btn_view_style:focus {
	outline: none;
}

<%--
검색바 input 태그 css --%> input.input_search {
	border: none;
	border-top-right-radius: 10px;
	border-bottom-right-radius: 10px;
}

input.input_search:focus {
	outline: none;
}

div#div_search {
	border: solid 2px #07B419;
	border-radius: 10px;
	height: 30px;
	padding-left: 3px;
	margin-top: 8px;
	position: relative;
	left: 38px;
	display: none;
}

.hidden {
	opacity: 0;
	pointer-events: none;
}

div.dept_position {
	background-color: #F8F9FA;
	padding: 10px;
	border-radius: 10px;
	margin-top: 3px;
}

div.dept_position>span {
	color: #556372;
}

div.dept_position>span:nth-child(2) {
	color: #CDD2D6;
}

div.div_name2 {
	font-size: 20px;
	font-weight: 500;
	color: #242A30;
	line-height: 14px;
	margin-top: 15px;
}

div.div_empInfo:hover {
	background-color: #F8F9FA;
}

#search_result > table > tbody > tr > td{
	height: 55px;
	padding: 0;
	vertical-align: middle;
}

<%-- 조직도 상단 조직도 펼치기, 수정 버튼 css --%> 
button.org_btn:hover {
	background-color: #ebebeb;
}

<%--
조직도에 버튼 오른쪽 끝으로 정렬 --%> 
div#org_buttons {
	display: flex;
	justify-content: flex-end;
}

<%--
회원 가입 모달 css 시작  --%> <%-- 구성원 초대하기 버튼 css --%> 
button#regist_member_btn {
	height: 50px;
	width: 100%;
	border-radius: 10px;
	color: white;
	background-color: #07B419;
}

div#title {
	font-size: 20pt;
	font-weight: 600;
	text-align: center;
	margin: 100px 0 50px 0px;
}

input.input_modal, button.choice_type {
	width: 100%;
	line-height: 30px;
	border-radius: 10px;
	padding: 5px;
	border: solid 1px #d9d9d9;
}

input.input_modal:focus {
	outline-color: #07B419;
}

button.choice_type:active, button.choice_type:focus {
	border: solid 1px #07B419;
}

button#regist_member_btn>i {
	padding-right: 10px;
}

div.regitst_title {
	padding: 0 0 3px 5px;
}

a { text-decoration:none !important }
    a:hover { text-decoration:none !important }

    nav.top-nav {
        padding-top: 30px;
        padding-left: 40px;
        padding-right: 40px;
        display: flex;
        align-items: center;
    }

    div#category {
        margin-top: 8px;
        padding-left: 40px;
        padding-right: 40px;
    }

    a.detail-category {
        background-color: var(--colors-white);
        height: 56px;
        padding-left: 8px;
        padding-right: 8px;
        margin-left: -8px;
        display: flex;
        align-items: center;
        font-size: 15px;
        font-weight: 600;
        cursor: pointer;
    }
    
    input:focus{
      outline-color: #07B419;
    }	
    
    .form-control:focus {
	   box-shadow:none;
	   border: 2px solid #07B419;
	}
	
	.select2-container--bootstrap4.select2-container--focus .select2-selection {
		box-shadow: none;
		border: 2px solid #07B419;
	}
	
	.select2-container--bootstrap4 .select2-selection--multiple .select2-search__field {
		width: 80% !important;
	}
	
	.green_bottom {
		border-bottom: 2px solid #07B419 !important;
	}

<%--
form#regist_frm  div.show {
	top: 0px;
	left: 10px;
	will-change: transform;
	border-radius: 10px;
	width: 458px;
}
--%>
<%-- 회원 가입 모달 css 끝 --%>

<%-- header a태그 css  --%>
a.a_title{
	font-size: 28px;
	font-weight: 700;
	letter-spacing: -1.12px;
	text-decoration: none solid rgb(60, 70, 81);
	word-spacing: 0px;
	color: #cdd2d6;
}
<%-- color : #3C4651; --%>
a.a_title:hover{
	text-decoration: none;
	color: #9e9e9e;
}
a.a_title:link, a.a_title:visited, a.a_title:active {
	text-decoration: none;
	color: #9e9e9e;
}
a.current,a.current:hover {
	text-decoration: none;
	color : #3C4651;
}
div#search_result{
	width: 95%;
	margin: 0 auto;
}

th,td{
	text-align: center;
	font-size: 14px;	
}

<%-- 검색태그 div css --%>
div#div_searchTag{

	border-bottom: solid 1px #d9d9d9;
	padding: 10px 16px;
	display: flex;
	justify-content: space-between;
	
}

div#serchTag_content{
	display: flex;
    align-items: center;
}

<%-- 필터초기화 버튼 css --%>
button.filter_clear{
	color:#3C4651;
	font-weight:700;
	font-size:13px;
	background-color: #ebebeb;
}
<%-- 필터 추가 버튼 css --%>
button#add_searchTag{
	border: solid 1px #d9d9d9;
	padding: 0 5px 0 0 ;
    color: #9e9e9e;
}

span#result_cnt{
	margin-right:10px;
}

<%-- dropdown level 2 css (검색조건 필터) --%>
.dropdown-menu li {
position: relative;
}
.dropdown-menu .dropdown-submenu {
display: none;
position: absolute;
left: 100%;
top: -7px;
}
.dropdown-menu .dropdown-submenu-left {
right: 100%;
left: auto;
}
.dropdown-menu > li:hover > .dropdown-submenu {
display: block;
}

<%-- 검색 필터 span 태그 css --%>
span.span_tag{
    border : solid 1px #d9d9d9;
    padding: 3px;
    border-radius: 5px;
    color: #9e9e9e;
    margin-right: 5px;
}
button.closeTag{
	background-color: transparent;
    border: none;
}


<%-- 페이지바 css 시작 --%>
ul.ul_pagebar{
	list-style:none; 
	margin:0 auto;
	width:700px;
	display: flex;
	align-items: baseline;
	padding: 0;
	justify-content: center;
}


li.li_pagebar{
	display: inline-block;
    padding-top: 9px;
    width: 40px;
    height: 40px;
    text-align: center;
    font-weight: 700;
}

li.li_pagebar > a{
	text-decoration: none;
	font-size: 14px;
	color:#2ecc71;
}

li.li_currentpage{
	background-color: #2ecc71;
    color: white;
    font-weight: 700;

    display: inline-block;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    text-align: center;
    vertical-align: middle;
    padding-top: 9px;
}

.dropdown-toggle::after {
    display: none;
    margin-left: 0.255em;
    vertical-align: 0.255em;
    content: "";
    border-top: 0.3em solid;
    border-right: 0.3em solid transparent;
    border-bottom: 0;
    border-left: 0.3em solid transparent;
}

li.li_moveOne{
	display: inline-block;
    width: 100px;
    font-size: 12pt;
    text-align: center;
    padding: 6px;
    border-radius: 100px;
    color: white;
    border: solid 3px #2ecc71;
    margin: 0 10px;
}

li.li_moveOne > a{
	color:#2ecc71;
	text-decoration: none;
}

li.li_moveAll{
	background-color: #2ecc71;
    font-weight: 700;
    border-radius: 50%;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    text-align: center;
    vertical-align: middle;
    padding-top: 9px;
}

li.li_moveAll > a{
	color: white;
	text-decoration: none;
	display: inline-block;
}


.badge {
		font-size: 15px;
	}
	
	td {
		vertical-align: middle !important;
	}

</style>

<script>

let currentShowPageNo = 1;
arr_position = [];
arr_dept = [];
arr_status = [];

	$(document).ready(function(){
		
		
		
		<%-- bootstrap 툴팁 --%>
		$(function () {
			$('[data-toggle="tooltip"]').tooltip();
		});
		<%-- bootstrap 드롭다운 multi level --%>
		$('.dropdown-toggle').dropdown();
		
		<%-- ===== 달력 하나만 출력 시작 =====  --%>
		$("input.daterange").daterangepicker({
            "singleDatePicker": true,
            "locale": {
                "format": "YYYY-MM-DD", // 날짜표현 형식
                "separator": " - ",
                "applyLabel": "선택",
                "cancelLabel": "취소",
                "fromLabel": "From",
                "toLabel": "To",
                "customRangeLabel": "Custom",
                "weekLabel": "W",
                "daysOfWeek": [
                    "일",
                    "월",
                    "화",
                    "수",
                    "목",
                    "금",
                    "토"
                ],
                "monthNames": [
                    "1월",
                    "2월",
                    "3월",
                    "4월",
                    "5월",
                    "6월",
                    "7월",
                    "8월",
                    "9월",
                    "10월",
                    "11월",
                    "12월"
                ],
                "firstDay": 1
            }
        });
		<%-- ===== 달력 하나만 출력 끝 =====  --%>
		
		
		// 테이블 형식 또는 리스트 형식 출력 버튼 클릭시 버튼 css 변경 
		$(document).on("click","button.btn_view_style",function(){
			$("button.btn_view_style").css("background-color","");
			$(this).css("background-color","white");
		});
		
		// 검색 버튼 클릭시 
		$(document).on("click","button#btn_search",function(){
			$("div#div_search").css("display","block");	
			$("button#btn_search").addClass("hidden");
		});
		// 검색 div 이외 영역 클릭시 값이 비어있는 경우 div 숨기기
		$('html').click(function(e) {   
			let searchWord = $("input#searchWord").val();
			if($(e.target).parents('div#div_search').length < 1 && searchWord.trim() == "" ){  
				$("div#div_search").css("display","");	
				$("button#btn_search").removeClass("hidden");
			}
		});
		// 검색버튼에서 검색어 입력시 
		$(document).on("keyup","input#searchWord",function(){
			viewEmpList(currentShowPageNo);
			
		})// end of $(document).on("keyup","input#searchWord",function(){}------
		
		
		
		// 다운로드 버튼 클릭시 
		$(document).on("click","button#btn_search",function(){
			
		});
		
		
		// 사원 관련 모든 정보 table 로 보여주는 버튼
		$(document).on("click","button#view_table",function(){
			func_getEmpList();
		});
		
		
		// 사원 관련 부서, 이름 , 직위, 아이콘만 보여주는 버튼
		$(document).on("click","button#view_list",function(){
			$("div#search_result").empty();
			let html ='<div style="display: flex; margin-top:20px;">'
						+'<div class="div_personOne" style="width:100%; padding-top: 15px;">'
							
								<%-- 반복해서 출력할 div 묶음 시작  --%>
								+'<div class="div_empInfo" style="display: flex; justify-content: space-between; margin: 10px; padding:10px;">'
								+'<div class="profile2">'
									+'<div class="profile_icon2">'
										+'<div>길동</div>'
									+'</div>'
										+'<div class="div_name2" style="padding-top:3px;">홍길동</div>'
								+'</div>'
								+'<div class="dept_position">'
									+'<span>직위&nbsp;&nbsp;</span>'
									+'<span>|</span>'
									+'<span>&nbsp;&nbsp;부서</span>'
									+'</div>'
								+'</div>'
								<%-- 반복해서 출력할 div 묶음 끝  --%>
							
						+'</div>'<%-- end of <div style="width:75%; padding-top: 15px;"> --%>
						
					+'</div>';
			$("div#search_result").html(html);
		});
		
		// 문서 로딩 시 기본값 테이블 보기로 설정
		// $("button#view_table").trigger("click");
		// $("input#searchWord").trigger("keyup");
		viewEmpList(1);
		
		// 구성원 등록 모달에서 드롭다운으로 나오는 속성 클릭 시 
		$(document).on("click","button.btn_label",function(){
			let selected = $(this).text(); // 부서, 부서장 
			let val = $(this).find("input.input_registValue").val(); // 10, 20, 부서장
			
			$(this).parent().parent().find("input").val(val); // 전송을 위해 input 태그에 값 입력
			$(this).parent().parent().find("div.regist_value").text(selected);
			
		});
		
		
		// 필터에서 종류 선택시 (필터 카테고리별로 여러개 설정 가능, 중복값은 선택 x )
		$(document).on("click","a.dropdown-item",function(e){
			
			let flag = true;
			
			let searchWord = $(e.target).text();
			let searchType = $(e.target).find("input").val();
			
			if(searchType == undefined){
				return;
			}
			
			$("span.span_tag").each(function(index,item){
				let val = $(this).text();
				if(searchType == val.substr(-2) && searchWord == val.substr(0,val.indexOf("|"))){
					flag = false;
					return;
				}
			})
			
			if(flag){
				$("button#add_searchTag").parent().find("span#span_searchTag").append("<span class='span_tag'>"+searchWord+"|<span style='color:#3C4651;'>"+searchType+"</span><button class='closeTag'><i style='color:#9e9e9e; font-size:14px;' class='fas fa-times'></i></button></span>");

				switch (searchType)
				  {
				    case "직위" :    
				    	arr_position.push(searchWord);
				      break;     

				    case "부서" :    
				    	arr_dept.push(searchWord);
				      break;  
				      
				    case "상태" :    
				    	arr_status.push(searchWord);
				      break;   
				  }
			  	
			}// end of if(flag){}-----------------------------------------
			
			viewEmpList(currentShowPageNo);
			
		});
		
		// 검색태그에 있는 닫기 버튼 클릭시(필터 삭제시)
		$(document).on("click","button.closeTag",function(e){
			let searchWord = $(this).parent().text();
			searchWord = searchWord.substr(0,searchWord.indexOf("|"));
			
			let searchType =  $(this).parent().text();
			searchType = searchType.substr(-2);
			
			switch(searchType) {
			    case "직위" :
			    	arr_position.splice(arr_position.indexOf(searchWord),1);
					// console.log(arr_position);
			      break;     

			    case "부서" :    
			    	arr_dept.splice(arr_dept.indexOf(searchWord),1);
					// console.log(arr_dept);
			      break;  
			      
			    case "상태" :    
			    	arr_status.splice(arr_status.indexOf(searchWord),1);
					// console.log(arr_status);
			      break;   
			  }
			
			$(this).parent().remove();
			
			viewEmpList(1);
		});
		
		// 필터 초기화 버튼 클릭시 
		$(document).on("click","button#filter_clear",function(){
			$("span#span_searchTag").empty();
			arr_position.length = 0;
			arr_dept.length = 0;
			arr_status.length = 0;
			
			<%-- 
			console.log(arr_position);
			console.log(arr_dept);
			console.log(arr_status);
			--%>
			
			viewEmpList(1);
			
		})// end of "click","buton.filter_clear"------------------------------------
		
		
		
		$(document).on("click","input[name='chk-all']",function(e){
			
			let bool = $(this).prop("checked");
			
			chkAllNot(bool);
			
		})// end of document.on("click","input[name='chk-all']",function()
				
				
		$(document).on("click","input[name='chk']",function(e){
			
			let bool = $(this).prop("checked");
			console.log(bool)
			
			chkClearNot(bool);
			
		})// end of document.on("click","input[name='chk']",function()	
				
		
	    $("#checkedPayment").click(function(){
	    	
	    		if(check_length() > 0) {
	    			checkedPayment();
	    		}
	    		else {
	    			toastr.error('지급할 직원에 체크를 해주세요');
	    			return;
	    		}
	    });
		
		
		$("#checkedPayment").click(function(){
	    	
	    		if(check_length() > 0) {
	    			checkedPayment();
	    		}
	    		else {
	    			toastr.error('지급할 직원에 체크를 해주세요');
	    			return;
	    		}
    		});
		
		
	});// end of $(document).ready(function(){}------------------------------------------------
	
			
			
	// 검색 조건 필터를 위해 상위부서 이름 조회하는 메소드
	function getDeptName(){
		
		let html = "";
		
		$.ajax({
			 // 부서 이름 구해오기 
			  url : "<%= ctxPath%>/getDeptList.pm",
			  dataType : "JSON",
			  success : function(json){
				  let html ='';
				  $.each(json,function(index,dept){
					  html += '<li id=li_'+dept.deptno+'><a class="dropdown-item" href="javascript:void(0);" onmouseover="getTeam('+dept.deptno+');"><input type="hidden" value="부서" />'+dept.deptname+'</a></li>'
					  
			    });// end of $.each(json,function(index,emp){}----------------------------
			    	
				$("ul#ul_dept").html(html);
				
			  },// end of success
			  error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		
		}); // end of ajax()----------------------------------------------------------------------
		
	}// end of function getDeptName(){}--------------------------------------		
			
	// 부서번호를 전달받아 팀 구해오기 
	function getTeam(deptno){
		 $.ajax({
			  url : "<%=ctxPath%>/getTeamList.pm",
			  data:{"deptno":deptno},
			  dataType : "JSON",
			  success : function(json2){
				  let html ='<ul class="dropdown-menu dropdown-submenu">';
				  
				  $.each(json2,function(index,team){
				  		html += '<li><a class="dropdown-item" href="#"><input type="hidden" value="부서" />'+team.deptname+'</a></li>';
			    	});// end of $.each(json,function(index,emp){}----------------------------
			      html += '</ul>';
			      
			      $("li#li_"+deptno).append(html);
			      
			  },// end of success
			  error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		}); // end of ajax()----------------------------------------------------------------------
	}
	
	
	// 사원 목록 페이징바 만들기 
	function makeCommentPageBar(currentShowPageNo){
		<%-- === 원글에 대한 댓글의 총 페이지수(totalPage)를 알아야 한다. === --%>
		
		let keyword = $("input#searchWord").val();
		
		$.ajax({
			url:"<%=request.getContextPath()%>/admin/getTotalPage.pm",
			data:{"sizePerPage":"10"
				 ,"keyword":keyword
				 ,"arr_position":arr_position
				 ,"arr_dept":arr_dept
				 ,"arr_status":arr_status},
			type:"GET",
			dataType:"JSON", 
			success:function(json){
				// json ==>  {"totalPage":4} 또는 {"totalPage":0}
				if(json.totalPage > 0){
					
					console.log("totalPage => " + json.totalPage)
					
					const totalPage = json.totalPage;
					
					const blockSize = 10;
					
					let loop = 1; //loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize)] 까지만 증가하는 용도이다.
			        
			        if( typeof currentShowPageNo == "string"){ // 마우스를 클릭해서 들어오는경우는 보고있는 페이지 번호가 string 타입으로 들어오므로 정수형으로 바꿔줘야 한다.
			        	currentShowPageNo = Number(currentShowPageNo);
			        }
			        
					// *** !! 다음은 currentShowPageNo 를 얻어와서 pageNo 를 구하는 공식이다. !! ***//
					let pageNo = Math.floor( (currentShowPageNo - 1)/blockSize ) * blockSize + 1;
					
					let pageBarHTML = "<ul class='ul_pagebar'>";
					
					// ==== [맨처음] [이전] 만들기 === // 
					if(pageNo != 1 ) {
						pageBarHTML +="<li class='li_moveAll li_pagebar' style='display:inline-block;'><a href='javascript:viewEmpList(\"1\")' > << </a></li>";
						pageBarHTML +="<li class='li_moveOne'><a href='javascript:viewEmpList(\""+(pageNo-1)+"\")' >Previous</a></li>";
					}
					while( !(loop > blockSize || pageNo > totalPage ) ) {
						
						if(pageNo == currentShowPageNo) { // 보고있는 페이지와 페이지바의 선택된 페이지가 같으면 링크 제거 
							pageBarHTML +="<li class='li_currentpage'>"+pageNo+"</li>";
						}
						else {
							pageBarHTML +="<li class='li_pagebar'><a href='javascript:viewEmpList(\""+pageNo+"\")' >"+pageNo+"</a></li>";
						}
						loop++;
						pageNo++;
					}// end of while()------------------------
					
					
					// ==== [다음] [마지막] 만들기 === //
					if(pageNo <= totalPage) {
						pageBarHTML +="<li class='li_moveOne'><a href='javascript:viewEmpList(\""+pageNo+"\")' >Next</a></li>";
						pageBarHTML +="<li class='li_moveAll li_pagebar'><a href='javascript:viewEmpList(\""+totalPage+"\")' > >> </a></li>";
					}
					
					pageBarHTML +="</ul>";
				
					$("div#pageBar").html(pageBarHTML);
				}// end of if(json.totalPage > 0){}----------------------------------
				
				else {
					$("div#search_result").html("<span class='mt-5' style='margin-left: 45%;'>결과가 없습니다.</span>");
					$("div#pageBar").empty();
				}
				
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
			
		});
		
	}// end of function makeCommentPageBar(currentShowPageNo){}-----------------------
	
	// 페이징 처리된 사원 출력 
	function viewEmpList(currentShowPageNo){
		
		let keyword = $("input#searchWord").val();
		
		$.ajax({
			url:"<%=request.getContextPath()%>/admin/getSeverancePayList.pm",
			data:{"currentShowPageNo":currentShowPageNo
				 ,"keyword":keyword
				 ,"arr_position":arr_position
				 ,"arr_dept":arr_dept
				 ,"arr_status":arr_status},
			dataType:"JSON",
			success:function(json){
				
				  let html ='<table class="table table-bordered table-hover" style="margin-top: 20px;">'
						+'<thead>'
							+'<tr>'
								+'<th rowspan="2" style="width:5%;"><input type="checkbox" name="chk-all" id="chk-all"/></th>'
								+'<th rowspan="2" style="vertical-align: middle; text-align:start; width:10%;">이름</th>'
								+'<th colspan=4>기본 정보</th>'
								+'<th colspan=2>인사 정보</th>'
							+'</tr>'
							+'<tr>'
								+'<th style="width:5%">상태</th>'
								+'<th style="width:7%">사번</th>'
								+'<th style="width:10%">근무개월</th>'
								+'<th style="width:10%">근무일수</th>'
								
								+'<th style="width:7%">부서</th>'
								+'<th style="width:7%">직위</th>'
								+'<th style="width:10%">예상퇴직금</th>'
								
							+'</tr>'
						+'</thead>'
						+'<tbody>';
				  $.each(json,function(index,item){
					  
					  html += '<tr class="tr_emp">'
					  			+"<td class='text-center'><input type='checkbox' name='chk' value='"+item.empno+"'/></td>"
								+'<td class="th_50">'
									+'<div class="profile">'
										+'<div class="profile_icon" style="background-color:'+item.profile_color+'"><div>'+item.name.substring(1)+'</div></div>'
										+'<div style="padding-top:3px;">'+item.name+'</div>'
									+'</div>'
								+'</td>'
								+'<td>'+item.status+'</td>'
								+'<td class="emp_empno">'+item.empno+'</td>'
								+'<td>'+item.continuousServiceMonth+'</td>'
								+'<td>'+item.workingDays+'</td>'
				
								+'<td>'+item.deptname+'</td>'
								+'<td>'+item.position+'</td>'
								+'<td><span style="font-weight: bold;" class="severance_pay">'+Number(item.severance_pay).toLocaleString("en")+'</span>원</td>'
				
							+'</tr>'
							<%-- ========================== 반복해서 출력할 부분 끝 ========== --%>
						
				    });// end of $.each(json,function(index,emp){}----------------------------
					
				    html +='</tbody>'   	
						 +'</table>';
					$("div#search_result").html(html);
				
				// 페이지바 함수 호출
				makeCommentPageBar(currentShowPageNo);
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		
		}); // end of $.ajax({})---------------------------------------
		
	}// end of function viewEmpList(currentShowPageNo){}----------------------------
		
	//null값 체크 
	function isEmpty(value){
	    if(value == null || value.length === 0) {
	           return "";
	     } else{
	            return value;
	     }
	}	
	
	
	// 신규 사원 등록하는 메소드 
	function registEmployee(){
		
		let regist_flag = true;
		
		let name = $("input[name='name']").val();
		let email = $("input[name='email']").val();
		let hire_date = $("input[name='hire_date']").val();
		let salary = $("input[name='salary']").val();
		let department = $("input[name='department']").val();
		let team = $("input[name='team']").val();
		let position = $("input[name='position']").val();
		
		
		if(name.trim() == "" || email.trim() == "" || hire_date.trim()==""|| salary.trim() == "" ||department.trim() == "" || position.trim() == "" ){
			regist_flag = false;
			alert("필수 정보를 입력해주세요");
		}
		
		let formValues = $("form[name=regist_frm]").serialize() ;
		
		if(regist_flag){ // 값이 모두 입력된 경우 
			$.ajax({
				  url : "<%= ctxPath%>/registEmployee.pm",
				  data : formValues,    
				  type : "POST",
				  dataType : "JSON",
				  success : function(json){
					  
					  if(json.duplicateEmail == 1){
						  alert('중복된 이메일입니다.');
						  return;
					  }
					  else{
						  if(json.registResult == 1){
							  alert('가입 성공!');
						  }
					  }
					  
				  },
				  error: function(request, status, error){
					  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				  }
			  }); // end of ajax{}-------------------
	  		
	  		}
			
		}
	
	// 부서 명, 부서번호 구해오는 메소드(모달용)
	function getDeptNameModal(){
		
		let html = "";
		
		$.ajax({
			 // 부서 이름 구해오기 
			  url : "<%= ctxPath%>/getDeptList.pm",
			  dataType : "JSON",
			  success : function(json){
				  let html ='';
				  $.each(json,function(index,dept){
					  html += '<button class="btn_label dropdown-item" type="button" onclick="getTeamModal('+dept.deptno+')"><input class="input_registValue" type="hidden" value='+dept.deptno+'>'+dept.deptname+'</button>';
					  
			    });// end of $.each(json,function(index,emp){}----------------------------
			    	
				$("div#div_dept").html(html);
				
			  },// end of success
			  error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		}); // end of ajax()----------------------------------------------------------------------
	}// end of function getDeptName(){}--------------------------------------	
	
	
	// 부서에 해당하는 팀 구해오는 메소드 (모달 출력용)
	function getTeamModal(deptno){
		 $.ajax({
			  url : "<%=ctxPath%>/getTeamList.pm",
			  data:{"deptno":deptno},
			  dataType : "JSON",
			  success : function(json2){
				  let html ='';
				  $.each(json2,function(index,team){
				  		html += '<button class="btn_label dropdown-item" type="button"><input class="input_registValue" type="hidden" value='+team.deptno+'>'+team.deptname+'</button>';
			    	});// end of $.each(json,function(index,emp){}----------------------------
			      
			      $("div#div_team").html(html);
			      
			  },// end of success
			  error: function(request, status, error){
				  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		}); // end of ajax()----------------------------------------------------------------------
	}
	
	
	
	function check_length() {
		return $("input[name='chk']:checked").length;
	}
    		
    function chkAllNot(bool) {
    		$("input[name='chk']").prop("checked",bool);
    }
	
	function chkClearNot(bool) {
	
		const chk = $("input[name='chk']");
		
		let flag = true
		
		if(bool == false) {
			$("input[name='chk-all']").prop("checked",bool);
		}
		else {
			$.each(chk,function(index,item){
				if(item.checked == false) {
					flag = false 
					return;
				}
			})
			
			if(flag == false) {
				$("input[name='chk-all']").prop("checked",false);
			}
			else {
				$("input[name='chk-all']").prop("checked",true);
			}
		}

	}
	
	function checkedPayment() {
		
		Swal.fire({
			   title: '퇴직금을 지급 하시겠습니까?',
			   icon: 'warning',
			   
			   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
			   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
			   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
			   confirmButtonText: '승인', // confirm 버튼 텍스트 지정
			   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
			   
			   reverseButtons: true, // 버튼 순서 거꾸로
			   
			}).then(result => {
			   // 만약 Promise리턴을 받으면,
			   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
				   
					let array = []
					
					const checked = $("input[name='chk']:checked");
					
					$("input[name='chk']:checked").each(function() {
						
						let serverance = $(this).parent().parent().find(".severance_pay").text();
						
						//console.log(serverance)
						
						serverance = serverance.substring(0,serverance.length-1).split(',').join('');
						
						let object = {"empno":$(this).val(),
								      "serverance_pay":serverance}
						
						array.push(object)
						
					});// end of $("input[name='chk']:checked").each ----
					
					//console.log(array)
					
					const jsonData = JSON.stringify(array);
					jQuery.ajaxSettings.traditional = true;
					
					$.ajax({
						url:"<%= ctxPath %>/admin/severancePayment.pm",
						type:"POST",
						data:{"jsonData":jsonData},
						dataType:"JSON",
						success:function(json) {
							
							if(json.n > 0) {
								Swal.fire('퇴직금 지급완료','지급완료','success');
								setTimeout("location.reload()", 1000);
							}
							
						},
						error: function(request, status, error){
				            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			    			}
					})
					
			   }
			   
			});
	}
	
	
</script>

<nav class="top-nav border-bottom">
        <span class="text-muted h4 font-weight-bold">퇴직금</span>
    </nav>
    <div id="pay-stub-content">
        <div id="category" class="d-flex">
            <a href="#" class="text-muted font-weight-bold mr-2 detail-category green_bottom"><span>퇴직금 조회 및 지급</span></a> <!-- border-bottom border-dark 을 사용하여 url에 따라 밑줄 생성 -->
            </div>
           
			
	<div id="search_buttons">
	
		<%-- 검색어 입력 input 태그 --%>
		<div id="div_search">
			<i class="fas fa-search"></i> <input id="searchWord" class="input_search" type="text" placeholder="검색" />
		</div>

		<%-- 검색 버튼 (클릭시 input태그 출력)  --%>
		<button type="button" id="btn_search" class="btn btn_search">
			<i class="fas fa-search"></i>
		</button>

	</div>
	
	<%-- 검색필터 추가 시작  --%>
	<div id="div_searchTag">
		<div id="serchTag_content">
			<div class="dropdown">
			<span id="span_searchTag"></span>
				
				<button id="add_searchTag" data-toggle="dropdown" type="button"
					class="btn dropdown-toggle" id="dropdownMenuButton"
					data-mdb-toggle="dropdown" aria-expanded="false">
					<i class="fas fa-plus" style="font-size: 13px; padding: 0 5px;"></i>필터 추가하기
				</button>

				<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
				<li><a class="dropdown-item" href="#">직위</a>
					<ul class="dropdown-menu dropdown-submenu">
						<li><a class="dropdown-item" data-category="직위"><input type="hidden" value="직위"/>사장</a></li>
						<li><a class="dropdown-item" data-category="직위"><input type="hidden" value="직위"/>부서장</a></li>
						<li><a class="dropdown-item" data-category="직위"><input type="hidden" value="직위"/>차장</a></li>
						<li><a class="dropdown-item" data-category="직위"><input type="hidden" value="직위"/>팀장</a></li>
						<li><a class="dropdown-item" data-category="직위"><input type="hidden" value="직위"/>대리</a></li>
						<li><a class="dropdown-item" data-category="직위"><input type="hidden" value="직위"/>사원</a></li>
					</ul>
				</li>
				<li><a class="dropdown-item" href="javascript:void(0);" onmouseover="getDeptName();">부서</a>
					<ul id="ul_dept" class="dropdown-menu dropdown-submenu"></ul>
				</li>
				<li><a class="dropdown-item" href="#">재직상태 </a>
					<ul class="dropdown-menu dropdown-submenu">
						<li><a class="dropdown-item" href="#"><input type="hidden" value="상태" />재직</a></li>
						<li><a class="dropdown-item" href="#"><input type="hidden" value="상태" />휴직</a></li>
					</ul>
				</li>
			</ul>
			</div>
			
		</div>
		
		<div id="div_search_result">
			<button id="filter_clear" type="button" class="btn filter_clear" >필터초기화</button>
		</div>		
	</div>
	<%-- 검색필터 추가 끝  --%>




	<div id="search_result"></div>
	<%-- end of  <div id="search_result">====== --%>
	
	<%-- 페이지바 출력 --%>
	<div id="pageBar" style="width: 80%; height: 100px; margin:0 auto;" ></div>
	<button type="button" class="btn btn-light btn-outline-secondary btn-sm ml-3 gopay" id="checkedPayment">체크지급</button>

</div>
<%-- end of peopleContiner div====== --%>




<div class="modal fade" id="payStubModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLongTitle">급여명세서</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
               		<table class="table">
					    <thead class="thead-dark">
	                    <tr>
	                        <th>근무기준 달</th>
	                        <th>급여</th>
	                        <th>초과근무 수당</th>
	                        <th>합계</th>
	                    </tr>
					    </thead>
					    <tbody id="data-tbody">
					    </tbody>
					  </table>
                </div>
            </div>
        </div>
    </div>



