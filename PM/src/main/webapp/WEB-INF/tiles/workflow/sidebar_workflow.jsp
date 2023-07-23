<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<style type="text/css">

	* {font-family: 'Pretendard', sans-serif; !important}

	div{
		/* border: 1px solid black; */
	}
	
	div#sideBar{
		/* width: 17%; */
		height: 100%;
		background-color: #f9fafa;
	}
	
	div#sideTop{
		width: 80%;
		height: 260px;
		margin: 15px auto 0 auto;
		/* border: 1px solid black; */
	}
	
	.sideTr{
		width: 100%;
		height: 40px;
		border-radius: 0.5rem;
		display: flex;
  		align-items: center;
  		font-weight: bold;
  		color: #687482;
  		margin-top: 3px;
	}
	
	.sideTr:hover {
		background-color: #efefef;
		cursor: pointer;
	}
	
	div#prof{
		width: 50px; 
		height: 50px; 
		border-radius: 40%; 
		background-color: #239afe;
		color: white;
		text-align: center;
		padding-top: 13px;
		border: 1px solid #ccced0;
		font-weight: bold;
		margin: auto 8px;
	}
	
	div#sideMiddle{
		width: 80%;
		height:490px;
		overflow: auto;
		margin: auto;
		padding-top: 30px;
		padding-bottom: 50px;
	}
	
	#sideMiddle::-webkit-scrollbar {
    	width: 10px;
  	}
  	#sideMiddle::-webkit-scrollbar-thumb {
    	background-color: #ababab;
    	border-radius: 10px;
  	}
  	#sideMiddle::-webkit-scrollbar-track {
    	background-color: #dedfe0;
    	border-radius: 10px;
  	}
	
	div#sideBottom{
		width: 80%;
		height : 130px;
		margin: auto;
		padding-top: 30px;
		padding-bottom: 20px;
		
	}
	
	i.sideIcon{
		width: 40px;
		margin-left: 15px;
	}
	
	#start_work {
		cursor: pointer;
	}
	
	#position {
		top: -27px;
	    left: 151px;
	}
	
	
</style>


<script type="text/javascript">

	let distance = 0;


	$(document).ready(function(){
		
		
		// 화면 높이만큼 body div에 height를 주겠다
		const web_browser_height = $(window).height(); 
		//$("div#sideBar").css({"height":web_browser_height-10});
		
		check_commute()
		
		setInterval("plus_time()", 60000); // 1 분마다 distance 를 1분증가시키고 찍는다
		
		// 출근하기 버튼 클릭이벤트 시작
		
		$(document).on("click","#start_work",function(){
			//alert('asd')
			Swal.fire({
				   title: '출근하시겠습니까?',
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
					   
					   let html = "";
				   
					   $.ajax({
						   url:"<%= ctxPath %>/commute/commuteStart.pm",
						   type:"POST",
						   data:{"fk_empno":'${sessionScope.loginuser.empno}'},
						   dataType:"JSON",
						   success:function(json){
							   if(json.n == 1) {
								   Swal.fire('출근처리가 완료되었습니다.','출근완료','success');
								   
								   const hour = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
								   const minute = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
								    
								   const time = hour +"시간 "+ minute +"분";
								   
								   html += "<a class='btn btn-outline-secondary dropdown-toggle' href='#' role='button' id='dropdownMenuLink' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false' style='width: 90%;margin: auto 5%;'>"+
								    		   "<small class='border rounded bg-success text-white text-sm mr-2'>근무중</small><span id='work-time'>"+time+"</span></a>"+
									  	   "<div class='dropdown-menu' aria-labelledby='dropdownMenuLink' style='width: 90%;'>"+
									  	   "<small class='text-muted ml-4'>근무 선택</small>"+
									  	   "<a class='dropdown-item' data-value='' id='kind-commute'>근무<i class='fas fa-chevron-right' style='margin-left: 130px;'></i></a>"+
									  	   "<div class='dropdown-divider'></div>"+
									    	   "<div id='start_or_end'><a class='dropdown-item' id='end_work'>퇴근하기</a></div>"+
									  	   "</div>"
									
									$("#commute-div").html(html);  	   
							   }
						   },
						   error: function(request, status, error){
					            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					       }
					   })
				   
				   }
				});
		})
		
		// 출근하기 버튼 클릭이벤트 끝 ------------------------------------------------------------------------------------------
		
		
		// 퇴근하기 버튼 클릭이벤트 
		$(document).ready("click","#end_work", function(){
			
			Swal.fire({
				   title: '퇴근하시겠습니까?',
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
					   
					  $.ajax({
						  
					  }) 
					   
				      Swal.fire('공유자에서 삭제했습니다.',text+' 삭제완료','success');
				   }
				});
			
		});// end of $(document).ready("click","#end_work", function(){}) ------------------
		
	}); // end of ready
	
	// Function Declation
	function getDateMinute() { // 현재날짜와 시간까지 가져오는 메소드
		const date = new Date();
		const year = date.getFullYear();
		const month = ('0' + (date.getMonth() + 1)).slice(-2);
		const day = ('0' + date.getDate()).slice(-2);
		const time = date.toTimeString().split(' ')[0];
		const today = year + '-' + month + '-' + day + " " + time; // 오늘 날짜를 가져옴
		
		return today;
	}
	
	
	function getDate() { // 현재날짜만 가져오는 메소드
		const date = new Date();
		const year = date.getFullYear();
		const month = ('0' + (date.getMonth() + 1)).slice(-2);
		const day = ('0' + date.getDate()).slice(-2);
		const today = year + '-' + month + '-' + day; // 오늘 날짜를 가져옴
		
		return today;
	}
	
	
	
	function check_commute() { // 오늘 출근을 했는지 확인하는 메소드
		
		$.ajax({
			url:"<%= ctxPath %>/commute/checkCommute.pm",
			data:{"fk_empno":'${sessionScope.loginuser.empno}'},
			dataType:"JSON",
			success:function(json) {
				
				let html = "";
				
				if(json.isExist) {	// 오늘날짜로 출근한 데이터가 있다면
					
					//console.log("확인용 => " + json.start_work_time)
				    //console.log("확인용 => " + getDateMinute())
				    let start_work_time = json.start_work_time
				    let sysdate = getDateMinute()
				   
				    start_work_time = new Date(start_work_time);
				    sysdate = new Date(sysdate);
				    
				    //console.log("확인용 => " + start_work_time)
				    //console.log("확인용 => " + sysdate)
				   
				    distance = sysdate - start_work_time;
				   
				    const hour = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
				    const minute = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
				    
				    const time = hour +"시간 "+ minute +"분";
					
					html += "<a class='btn btn-outline-secondary dropdown-toggle' href='#' role='button' id='dropdownMenuLink' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false' style='width: 90%;margin: auto 5%;'>"+
				    		    "<small class='border rounded bg-success text-white text-sm mr-2'>근무중</small><span id='work-time'>"+time+"</span></a>"+
					  	    "<div class='dropdown-menu' aria-labelledby='dropdownMenuLink' style='width: 90%;'>"+
					  	    "<small class='text-muted ml-4'>근무 선택</small>"+
					  	    "<a class='dropdown-item' data-value='' id='kind-commute'>근무<i class='fas fa-chevron-right' style='margin-left: 130px;'></i></a>"+
					  	    "<div class='dropdown-divider'></div>"+
					    	    "<div id='start_or_end'><a class='dropdown-item' id='end_work'>퇴근하기</a></div>"+
					  	    "</div>"
			
				   $("#commute-div").html(html);
					  	    
				   
				}
				
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});// end of $.ajax -----------------------------
		
	}// end of function check_commute() {} --------------------------------
	
	
    function plus_time() {
		distance += 60000
		
		const hour = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
	    const minute = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
	    
	    const time = hour +"시간 "+ minute +"분";
	    
	    $("#work-time").text(time);
		
	}  

</script>

		<div id="sideBar">
		
			<div id="sideTop" class="border-bottom">
				<div class="sideTr mt-2" style="height: 70px;" onclick="#">
					<div id="prof">길동</div>
					<div>
						<span class="ml-2" style="display: block; padding-top: 3px;">홍길동</span>
						<span class="ml-2" style="font-weight: normal; color: gray; font-size: 10pt;">인사 · 관리자</span>
					</div>
				</div>
				<div class="dropdown my-4" id="commute-div">
				  <a class="btn btn-outline-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="width: 90%;margin: auto 5%;">
				    출근하기
				  </a>
				  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink" style="width: 90%;">
				    <small class="text-muted ml-4">근무 선택</small>
				    <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">Dropdown Example</button>
				    <ul class="dropdown-menu dropdown-menu-right" id="position">
				      <li><a href="#">HTML</a></li>
				      <li><a href="#">CSS</a></li>
				      <li><a href="#">JavaScript</a></li>
				      <li class="divider"></li>
				      <li><a href="#">About Us</a></li>
				    </ul>
				  	<div class="dropdown-divider"></div>
				    <div id="start_or_end"><a class="dropdown-item" id="start_work">출근하기</a></div>
				  </div>
				</div>
				<div class="sideTr" onclick="javascript:location.href='<%= ctxPath%>/messenger/sendedMassage.pm'">
					<i class="fas fa-regular fa-paper-plane sideIcon"></i><span>메신저</span>
				</div>
				<div class="sideTr" onclick="#">
					<i class="fas fa-regular fa-bell sideIcon"></i><span>새로운 소식</span>
				</div>
			</div>
			
			<div id="sideMiddle" class="border-bottom">
				<div class="sideTr" onclick="#">
					<i class="fas fa-regular fa-flag sideIcon"></i><span>공지사항</span>
				</div>
				<div class="sideTr" onclick="#">
					<i class="fas fa-solid fa-users sideIcon"></i><span>구성원</span>
				</div>
				<div class="sideTr" onclick="javascript:location.href='<%= ctxPath%>/schedule/calendar.pm'">
					<i class="fas fa-regular fa-calendar-check sideIcon"></i><span>캘린더</span>
				</div>
				<div class="sideTr" onclick="javascript:location.href='<%= ctxPath%>/admin/mycommute.pm'">
					<i class="fas fa-regular fa-clock sideIcon"></i><span>출퇴근</span>
				</div>
				<div class="sideTr" onclick="javascript:location.href='<%= ctxPath%>/jinji/leaveSummary.pm'">
					<i class="fas fa-solid fa-plane sideIcon"></i><span>휴가</span>
				</div>
				<div class="sideTr" onclick="javascript:location.href='<%= request.getContextPath()%>/workflow.pm'">
					<i class="fas fa-solid fa-pen-nib sideIcon"></i><span>워크플로우</span>
				</div>
				<div class="sideTr" onclick="javascript:location.href='<%= ctxPath%>/admin/payStub.pm'">
					<i class="fas fa-solid fa-dollar-sign sideIcon"></i><span>급여</span>
				</div>
				<div class="sideTr" onclick="#">
					<i class="fas fa-solid fa-comments-dollar sideIcon"></i><span>급여정산</span>
				</div>
				<div class="sideTr" onclick="#">
					<i class="fas fa-solid fa-chart-pie sideIcon"></i><span>인사이트</span>
				</div>
			</div>
			
			<div id="sideBottom">
				<div class="sideTr mt-1" style="height: 70px;" onclick="#">
					<div id="prof" style="background-color: #d8c5e2;"><i class="fas fa-solid fa-school sideIcon" style="width: 30px; margin: auto;"></i></div>
					<span class="ml-2">PM</span>
				</div>
			</div>
			
			<!-- <div id="commute-kind-category" class="border bg-white" style="position: relative; left: 265px; top:-710px; width: 100px;">
		  		<div><span style="margin-right: 10px"><i class="fa-solid fa-building"></i></span><span>근무</span></div>
		  		<div>외근</div>
		  		<div>출장</div>
		  	</div> -->
		  	
			
		</div>


