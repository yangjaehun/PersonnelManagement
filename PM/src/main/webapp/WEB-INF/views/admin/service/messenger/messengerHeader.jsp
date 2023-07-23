<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<style>

	div#messengerHeader {
		/* border: 1px solid black; */
		height: 110px;
		width: 100%;
		display: flex;
  		align-items: center;
	}
	
	span.headerTitle {
		font-weight: bold;
		font-size: 22pt;
		margin: auto 15px;
		color: #cccece;
	}
	
	span.headerTitle:hover {
		cursor: pointer;
		color: #494949;
	}
	
	button.headerBtn {
		border-radius: 0.5rem;
		border: 1px solid gray;
		background: linear-gradient( to left ,#5bd3ff, #88eb1e );
		margin-left:60%;
		width: 170px;
		height: 45px;
		border: none;
		color: white;
		font-weight: bold;
	}
	
	button.headerBtn:hover{
		 filter: brightness(90%);
	}
	
	i#icon{
		color: white;
		margin-right: 15px;
	}
	
	/* 모달창 부분 */
	div.modal{
		min-height: 700px;
		max-height: 850px;
	}
	
	input[name='subject']{
		height: 50px;
		width: 80%;
		margin: 35px 10% 15px 10%;
		font-size: 20pt;
		font-weight: bold;
		border: none;
	}
	
	input[name='subject']:focus {
		outline: none;
	}
	
	textarea[name='content'] {
		min-height: 400px;
		width: 80%;
		margin: 10px 10% 5px 10%;
		border: 1px solid #dddddd;
		border-radius: 0.4rem;
	}
	
	div#attachArea {
		width: 80%;
		margin: 0 10% 15px 10%;
	}
	
	div.filebox {
		display: flex;
		align-items: center;
	}
	
	.filebox .upload-name {
	    display: inline-block;
	    height: 35px;
	    padding: 0 10px;
	    vertical-align: middle;
	    border: 1px solid #dddddd;
	    width: 70%;
	    border-radius: 0.4rem;
	    color: #999999;
	}
	
	.filebox label {
	    display: inline-block;
	    padding: 7px 20px;
	    color: #fff;
	    vertical-align: middle;
	    text-align: center;
	    background-color: #88eb1e;
	    cursor: pointer;
	    width : 25%;
	    height: 35px;
	    margin-left: 10px;
	    margin-top: 6px;
	    border-radius: 0.4rem;
	}
	
	.filebox input[type="file"] {
	    position: absolute;
	    width: 0;
	    height: 0;
	    padding: 0;
	    overflow: hidden;
	    border: 0;
	}
	
	.modal-body::-webkit-scrollbar {
    	width: 10px;
  	}
  	.modal-body::-webkit-scrollbar-thumb {
    	background-color: #ababab;
    	border-radius: 10px;
  	}
  	.modal-body::-webkit-scrollbar-track {
    	background-color: #dedfe0;
    	border-radius: 10px;
  	}
  	
  	/* 받는 사람 드롭다운 시작 */
  	
  	div.sentPsnProf{
  		display: inline-block;
		width: 30px; 
		height: 30px; 
		border-radius: 40%; 
		text-align: center;
		background-color: #757575;
		color : white;
		font-size: 12pt;
		padding-top: 3px;
	}
	
	i.fa-user {
		margin: auto;
	}
	
	button.dropdownBtn {
		min-width: 22%;
		max-width : 100%;
		height : 40px;
		margin-left : 10%;
		display: flex;
		align-items: center;
		background-color: white;
		border-radius: 0.4rem;
		border: none;
	}
	
	button.dropdownBtn:hover {
		 background-color: #dddddd;
	}
	
	
	/* 받는 사람 팝업 */
	
	div#choosePerson {
		/* border:solid 2px green; */
		min-height: 300px;
		max-height: 400px;
		width: 500px;
		display: flex;
		position: fixed;
		top: 1000px;
		left: 0px;
		z-index: 1052;
		background: white;
		border-radius: 0.3rem;
		color: black;
		/* transition: all 0.5s; */
		padding: 10px;
	}
	
	div#choosePerson.active {
		top: 208px;
		left: 654px;
	}
	
	div#choosePerson_outside {
		position: fixed;
		top: 0px;
		left: 0px;
		width: 100%;
		height: 100%;
		background: rgba(0, 0, 0, 0.2);
		z-index: 1051;
		display: none;
	}
	
	div#leftSide {
		width: 50%;
		max-height: 390px;
		overflow: auto;
	}
	
	div#rightSide {
		width: 50%;
		display: flex;
		flex-direction: column;
	}
	
	div#rightTitle {
		width: 100%;
		height: 35px;
		padding: 3px auto;
	}
	
	div#rightUp {
	
		width: 100%;
		height: 100%;
		max-height: 390px;
		overflow: auto;
	}
	
	div#rightDown {
		width: 100%;
		height: 45px;
		padding: 3px 0px;
	}
	
	#leftSide::-webkit-scrollbar {
    	width: 7px;
  	}
  	#leftSide::-webkit-scrollbar-thumb {
    	background-color: #ababab;
    	border-radius: 10px;
  	}
  	#leftSide::-webkit-scrollbar-track {
    	background-color: #dedfe0;
    	border-radius: 10px;
  	}
  	
  	#rightUp::-webkit-scrollbar {
    	width: 7px;
  	}
  	#rightUp::-webkit-scrollbar-thumb {
    	background-color: #ababab;
    	border-radius: 10px;
  	}
  	#rightUp::-webkit-scrollbar-track {
    	background-color: #dedfe0;
    	border-radius: 10px;
  	}
  	
  	label.person {
  		font-size: 11pt;
  		margin: auto 5px;
  	}
  	
  	label.person:hover, span.arrow:hover {
  		cursor: pointer;
  	}
  	
  	button#addPersonBtn {
  		display: inline-block;
	    color: #fff;
	    font-size: 11pt;
	  	font-weight: bold;
	    vertical-align: middle;
	    text-align: center;
	    background-color: #88eb1e;
	    border: none;
	    cursor: pointer;
	    width : 70%;
	    hight : 38px;
	    margin: 3px 15%;
	    border-radius: 0.4rem;
  	}
  	
  	div.choosedPsn{
  		width: 100%;
  		border-radius: 0.4rem;
  		padding: 5px 5%;
  	}
  	
  	div.choosedPsn:hover {
		cursor: pointer;
		background-color: #f9fafa;
	}
	
	/* 첨부파일 개수용 */
	
	
</style>

<script>
	
	$(document).ready(function(){
		
	
		// 파일 선택하면 선택창 바뀌도록 
		$(document).on("change", ".file", function(){
			  var fileName = $(this).val();
			  $(this).parent().find($(".upload-name")).val(fileName.slice(fileName.lastIndexOf("\\")+1));
		});
		
		
		// 메일 보내기 창을 벗어날때 임시저장 여부 확인하는 이벤트
		$("button.my_close").on("click", function(){
			
			Swal.fire({
				   title: '메신저 보내기를 벗어납니다.',
				   text: '작성내용을 임시 저장 할까요?',
				   icon: 'warning',
				   
				   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
				   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
				   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
				   confirmButtonText: '예', // confirm 버튼 텍스트 지정
				   cancelButtonText: '아니요', // cancel 버튼 텍스트 지정
				   
				   // reverseButtons: true, // 버튼 순서 거꾸로
				   
				}).then(result => {
				   // 만약 Promise리턴을 받으면, 
				   if (!result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
					  const modal_frmArr = document.querySelectorAll("form#messengerFrm");
				  	  for(let i=0; i<modal_frmArr.length; i++) {
				  		  modal_frmArr[i].reset();
				  	  }
				 	  const modal_frmArr2 = document.querySelectorAll("form#messengerdeliverFrm");
				  	  for(let i=0; i<modal_frmArr2.length; i++) {
				  		  modal_frmArr2[i].reset();
				  	  }
				   }
				   $('button#dropdownMenuButton').find('span').text('받는 사람 선택');
				   
				});
		  	  
		}); 
		
		
		// 추가 이미지 파일에 스피너 달아주기 // 최소값 최대값
		$("input#spinnerImgQty").spinner({
			spin:function(event,ui){
	            if(ui.value > 10) {
	               $(this).spinner("value", 10);
	               return false;
	            }
	            else if(ui.value < 0) {
	               $(this).spinner("value", 0);
	               return false;
	            }
	         }
		});
		
		
		// ### 스피너의 이벤트는 클릭이 아니고 change도 아니고 "spinstop" 이다 ### //
		// 첨부파일 개수만큼 늘고 줄어들게 만들기
		$("input#spinnerImgQty").bind("spinstop", function(){

			let html = '';
			const cnt = $(this).val();
			
			//console.log(cnt);
			
			for(let i=0; i<Number(cnt); i++){
				html+= '<div class="filebox">'+
						    '<input class="upload-name" name="attachName'+i+'" value="첨부파일" placeholder="첨부파일" readonly="readonly" style="flex-grow: 1;">'+
						    '<label for="attach'+i+'">파일찾기</label>'+
						    '<input type="file" class="file" id="attach'+i+'" name="attach'+i+'">'+
						'</div>';
			}
			
			$("div#divfileattach").html(html);
			
			$("input#attachCount").val(cnt);
			
		}); // end of 첨부파일 개수만큼 늘고 줄어들게 만들기
		
		
		// 체크박스 바뀔때 효과
		$(document).on("change", "input.names", function(e){
			readChecked();
		});// end of 체크박스 바뀔때 효과
		
		
		// 전체선택
		$("input#allCheck").change(function(){
			const bool = $("input#allCheck").prop("checked");
			$("input.names").prop("checked",bool); 
			$("input.depts").prop("checked",bool); 
			readChecked();
		});
		
		
		// 부서 선택시 부서 선택되게
		$(document).on('change', "input.depts",  function (e) {
			const bool = $(e.target).prop("checked");
			$("input."+$(e.target).val()).prop("checked",bool); 
			readChecked();
		});
		
		
		// 체크박스 표시된 내역 읽기
		function readChecked(){
			ck_empno_list = [];
			$("input.names:checked").each(function(index, item){
				ck_empno_list.push($(item).val());
			});
			
			$('div#choosedPsnResult').empty();
			
			if(ck_empno_list.length>0){
				str_empno = ck_empno_list.join(",");
				
				$.ajax({
			    	url : "<%=ctxPath%>/messenger/chooseUser.pm",
			    	data:{"str_empno":str_empno },
		    		dataType: "JSON",
		    		async:true,
					success: function(json){ 
						let html = "";
						if(json.length>0){
							
							$.each(json, function(index, item){
								
								html += '<div class="choosedPsn" style="width: 100%;" name="'+item.empno+'">'+
									'<div class="sentPsnProf ml-2" style="background-color: '+item.profile_color+';"><span style="font-size: 9pt;">'+item.nickname+'</span></div>'+
									'<span class="ml-3" style="padding-top: 3px;">'+item.name+'</span>'+
									'<span class="ml-2" style="font-weight: normal; color: gray; font-size: 10pt;">'+item.deptname+' · '+item.position+'</span>'+
								'</div>';
								
							});// end of each
						}
						
						$('div#choosedPsnResult').html(html);
					},
					error: function(request, status, error){
		                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		            }
					
			    }); // end of ajax 
			}
		}
		
		
		// 프로필 클릭시 삭제 되도록 
		$(document).on('click', "div.choosedPsn",  function () {
			$('input#'+$(this).attr('name')).prop("checked",false); 
			$(this).remove()
		});
		
		// 받는 사람 닫기
		$('#choosePerson_outside').on('click', function () {
			choosePerson_close();
		});
		
		
		// 받는사람 선택 버튼 클릭이벤트
		$('button#addPersonBtn').click(function(){
			ck_empno_list = [];
			ck_name_list = [];
			
			$("input.names:checked").each(function(index, item){
				ck_empno_list.push($(item).val());
				ck_name_list.push($(item).next().text());
			});
			
			if(ck_empno_list.length>0){
				str_empno = ck_empno_list.join(",");
				str_name = ck_name_list.join(", ");
				
				if(str_name.length>50){
					str_name = str_name.substr(0, 50)+" ...";
				}
				
				$('input[name="fk_recipientno"]').val(str_empno);
				$('button#dropdownMenuButton').find('span').text(str_name);
				choosePerson_close();
				
			} else {
				Swal.fire('받는사람이 선택되지 않았습니다.','받는 사람은 한명이상 선택해주세요.', 'error');
			}
		});
		
		
		
		
		// 메세지 보내기 버튼 클릭 이벤트
		$("button#sendMsgBnt").click(function(){
			
			if($('div.sendMail input[name="subject"]').val().trim()== "" || $('div.sendMail input[name="subject"]').val().length>=30 ){
				Swal.fire('메신저 제목은','비워두거나, 30글자 이상 쓸 수 없습니다', 'error');
				return;
			}
			
			if($('div.sendMail textarea[name="content"]').val().trim()== "" || $('div.sendMail textarea[name="content"]').val().lenth>=1000 ){
				Swal.fire('메신저 내용은','비워두거나, 1000글자 이상 쓸 수 없습니다', 'error');
				return;
			}
			
			if($('div.sendMail input[name="fk_recipientno"]').val() == "" ){
				Swal.fire('받는사람을 선택하세요','', 'error');
				return;
			}
			
			var form = $("form")[0];        
	        var queryString = new FormData(form);
			
			$.ajax({
		    	url : "<%=ctxPath%>/messenger/sendMessenger.pm",
		    	data : queryString,
		    	type: 'POST',
		    	enctype: 'multipart/form-data',
		    	processData: false,
		        contentType: false,
				success: function(){
					
					const modal_frmArr = document.querySelectorAll("form#messengerFrm");
			  	  	for(let i=0; i<modal_frmArr.length; i++) {
			  			modal_frmArr[i].reset();
			  			$('button#dropdownMenuButton').find('span').text('받는 사람 선택');
			  	  	}
					$(".sendMail").modal('hide');
					toastr.success('메세지를 발송하였습니다.');
					
				},
				error: function(request, status, error){
	                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
			}); // end of ajax
			
		}); // end of 메세지 보내기 버튼 클릭 이벤트
		
		
		
		// 메세지 전달하기 버튼 클릭 이벤트
		$("button#deliverMsgBnt").click(function(){
			
			if($('div.deliverMail input[name="subject"]').val().trim()== "" || $('div.deliverMail input[name="subject"]').val().length>=30 ){
				Swal.fire('메신저 제목은','비워두거나, 30글자 이상 쓸 수 없습니다', 'error');
				return;
			}
			
			if($('div.deliverMail textarea[name="content"]').val().trim()== "" || $('div.deliverMail textarea[name="content"]').val().lenth>=1000 ){
				Swal.fire('메신저 내용은','비워두거나, 1000글자 이상 쓸 수 없습니다', 'error');
				return;
			}
			
			if($('div.deliverMail input[name="fk_recipientno"]').val() == "" ){
				Swal.fire('받는사람을 선택하세요','', 'error');
				return;
			}
			
			const queryString = $("form[name='messengerdeliverFrm']").serialize();
			
			$.ajax({
		    	url : "<%=ctxPath%>/messenger/.pm",
		    	data : queryString,
		    	type: 'POST',
				success: function(){
					
					const modal_frmArr = document.querySelectorAll("form#messengerdeliverFrm");
			  	  	for(let i=0; i<modal_frmArr.length; i++) {
			  			modal_frmArr[i].reset();
			  			$('button#dropdownMenuButton').find('span').text('받는 사람 선택');
			  	  	}
					$(".deliverMail").modal('hide');
					window.location.reload();
					toastr.success('메세지를 전달하였습니다.');
					
				},
				error: function(request, status, error){
	                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
			}); // end of ajax
			
		}); // end of 메세지 전달하기 버튼 클릭 이벤트
		
		
		
		/* $(document).on("click", "span.arrow", function(e){
			const idx = $("span.arrow").index($(e.target));
			const target = $("span.arrow").eq(idx).parent().next()[0];
			target.show();
			console.log(target);
		}); */
		
	}); // end of ready 
	
	
	// 받는사람 열기
	function search_choosePerson(){
		
		$('#choosePerson').addClass('active');
		$('button.dropdownBtn').css({'background-color':'#dddddd'});
	    $('#choosePerson_outside').fadeIn();
	    
		openAjax(); // 받는 사람 목록 ajax로 불러오기
		
		// 부서 토글
        $("div.hidDept").hide();
        $("div.hidTeam").hide();
		
	}
	
	// 받는사람 닫기
	function choosePerson_close(){
		$('div#choosedPsnResult').empty();
		$('#choosePerson').removeClass('active');
		$('button.dropdownBtn').css({'background-color':''});
	    $('#choosePerson_outside').fadeOut();
	}
	
	
	// 부서 토글
	function toggleShow(deptno){
		$("div[id='"+deptno+"']").toggle();
	}
	
	
	// 받는 사람 목록 ajax로 불러오기
	function openAjax(){
		$.ajax({
	    	url : "<%=ctxPath%>/service/getDept.pm",
    		dataType: "JSON",
    		async:false,
			success: function(json){ 
				
				let html = "";
				
				if(json.length>0){
					
					$.each(json, function(index1, item1){
						html += '<div style="display: flex; align-items: center;" class="py-1 pt-2">' +
									'<input type="checkbox" class="ml-3 depts" value="'+item1.deptno+'" /><label class="person ml-2" style="font-weight: bold;" onclick="toggleShow('+item1.deptno+')">'+item1.deptname+'</label>'+
									'<span class="arrow" onclick="toggleShow('+item1.deptno+')">&#128317;</span>'+
								'</div>'+
						        '<div class="hidDept pl-5" id="'+item1.deptno+'">';
						        
							// 부서 내 사람 구하기(부서장)
							$.ajax({
						    	url : "<%=ctxPath%>/service/getDeptPerson.pm",
						    	data : {"deptno" : item1.deptno},
					    		dataType: "JSON",
					    		async:false,
								success: function(json2){
									
									if(json2.length>0){
										$.each(json2, function(index2, item2){
											html +='<div><input type="checkbox" class="names '+item1.deptno+'" value="'+item2.empno+'" id="'+item2.empno+'" /><label class="person ml-2" for="'+item2.empno+'">'+item2.name+'</label></div>';
										}); // end of for each
									}
								},
								error: function(request, status, error){
					                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					            }
							}); // end of ajax (부서구하기)
						    	
							
							// 부서내 팀 구하기
							$.ajax({
						    	url : "<%=ctxPath%>/service/getTeam.pm",
						    	data : {"deptno" : item1.deptno},
					    		dataType: "JSON",
					    		async:false,
								success: function(json3){
									
									if(json3.length>0){
										$.each(json3, function(index3, item3){
											html += '<div class="py-1 pt-2">'+
												'<input type="checkbox" class="depts '+item1.deptno+'" value="'+item3.deptno+'" /><label class="person ml-2" style="font-weight: bold;" onclick="toggleShow('+item3.deptno+')">'+item3.deptname+'</label><span class="arrow" onclick="toggleShow('+item3.deptno+')">&#128317;</span>'+
												'</div>'+
												'<div class="hidTeam pl-5" id="'+item3.deptno+'">';
												
											
											// 팀 내 사람 구하기(팀원들)
											$.ajax({
										    	url : "<%=ctxPath%>/service/getTeamPerson.pm",
										    	data : {"deptno" : item3.deptno},
									    		dataType: "JSON",
									    		async:false,
												success: function(json4){
													
													if(json4.length>0){
														$.each(json4, function(index4, item4){
															html +='<div><input type="checkbox" class="names '+item1.deptno+' '+item3.deptno+'" value="'+item4.empno+'" id="'+item4.empno+'" /><label class="person ml-2" for="'+item4.empno+'" >'+item4.name+'</label></div>';
														}); // end of for each
														
														
													}
										        
												},
												error: function(request, status, error){
									                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
									            }
											}); // end of ajax (팀 내 사람 구하기(팀원들))
											
											html += '</div>';
										}); // end of for each
										
										
									}
								},
								error: function(request, status, error){
					                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					            }
							}); // end of ajax (팀구하기)
							
							html += '</div>';
					});// end of each
					
				}
				
				$('div#resultOfAjax').html(html);
				
			},
			error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
			
	    }); // end of ajax 
	}
	

</script>

<div id="messengerHeader" class="border-bottom">
		<span class="headerTitle ml-5" id="rcvmsg" onclick="javascript:location.href='<%= ctxPath%>/messenger/receivedMessage.pm'">받은 메신저</span>
		<span class="headerTitle" id="sndmsg" onclick="javascript:location.href='<%= ctxPath%>/messenger/sentMessage.pm'">보낸 메신저</span>
		<button type="button" class="headerBtn" data-toggle="modal" data-target=".sendMail">
			<i class="fas fa-regular fa-paper-plane" id="icon"></i>메신저 보내기
		</button>
</div>


<!-- 메세지 보내기 Modal -->
<!-- Modal 구성 요소는 현재 페이지 상단에 표시되는 대화 상자/팝업 창입니다. -->
<div class="modal fade sendMail"  id="staticBackdrop" data-backdrop="static">
  <div class="modal-dialog modal-dialog-scrollable modal-lg modal-dialog-centered">
  <!-- .modal-dialog-scrollable을 .modal-dialog에 추가하여 페이지 자체가 아닌 모달 내부에서만 스크롤할 수 있습니다. -->
    <div class="modal-content">

      <!-- Modal body -->
      <div class="modal-body">
      <button type="button" class="close my_close" data-dismiss="modal" aria-label="Close">&times;</button> 
      <form id='messengerFrm' name="messengerFrm"  enctype="multipart/form-data">
      	<input name="subject" placeholder="메신저 제목을 입력하세요"/>
      	
      	<button class="dropdownBtn" type="button" id="dropdownMenuButton" onclick="search_choosePerson()">
		   <div class="sentPsnProf"><i class="fas fa-solid fa-user"></i></div> <span style="color: #757575; font-size: 11pt; margin-left: 10px;">받는 사람 선택</span>
	  	</button>
	  	
        <textarea name="content"></textarea>
        <input type="hidden" name="fk_recipientno" />
        <input type="hidden" name="origin_msgno" />
        
        <div id="attachArea">
        	<span>파일 첨부하기</span>
        	<label for="spinnerImgQty">파일갯수 : </label>
        	<input id="spinnerImgQty" value="0" style="width: 30px; height: 20px;">
            <div id="divfileattach"></div>
            <input type="hidden" name="attachCount" id="attachCount" />
        	<!-- <div class="filebox">
			    <input class="upload-name" value="첨부파일" placeholder="첨부파일" readonly="readonly">
			    <label for="file">파일찾기</label>
			    <input type="file" id="file">
			</div> -->
        </div>
      </form>
        
        <button type="button" class="headerBtn" id="sendMsgBnt" style="width: 80%; margin: 10px 10% 50px 10%;">
			<i class="fas fa-regular fa-paper-plane" id="icon"></i>메신저 보내기
		</button>
      </div>
      
    </div>
  </div>
</div>



<!-- 전달하기 Modal -->
<!-- Modal 구성 요소는 현재 페이지 상단에 표시되는 대화 상자/팝업 창입니다. -->
<div class="modal fade deliverMail"  id="staticBackdrop" data-backdrop="static">
  <div class="modal-dialog modal-dialog-scrollable modal-lg modal-dialog-centered">
  <!-- .modal-dialog-scrollable을 .modal-dialog에 추가하여 페이지 자체가 아닌 모달 내부에서만 스크롤할 수 있습니다. -->
    <div class="modal-content">

      <!-- Modal body -->
      <div class="modal-body">
      <button type="button" class="close my_close" data-dismiss="modal" aria-label="Close">&times;</button> 
      <form id='messengerdeliverFrm' name="messengerdeliverFrm" >
      	<input name="subject" placeholder="메신저 제목을 입력하세요"/>
      	
      	<button class="dropdownBtn" type="button" id="dropdownMenuButton" onclick="search_choosePerson()">
		   <div class="sentPsnProf"><i class="fas fa-solid fa-user"></i></div> <span style="color: #757575; font-size: 11pt; margin-left: 10px;">받는 사람 선택</span>
	  	</button>
	  	
        <textarea name="content"></textarea>
        <input type="hidden" name="fk_recipientno" />
        <input type="hidden" name="origin_msgno" />
        
        <div id="mailAttachArea"></div>
      </form>
        
        <button type="button" class="headerBtn" id="deliverMsgBnt" style="width: 80%; margin: 10px 10% 50px 10%;">
			<i class="fas fa-regular fa-paper-plane" id="icon"></i>메신저 전달하기
		</button>
      </div>
      
    </div>
  </div>
</div>



<!-- 받는 사람 팝업 -->
<div id="choosePerson_outside"></div>

<div id="choosePerson">
	<div id="leftSide">
		<div style="display: flex; align-items: center;" class="border-bottom py-2">
			<input type="checkbox" class="ml-2" id="allCheck" /><label class="person ml-2" style="font-weight: bold;">전체선택</label>
		</div>
		
		<div id="resultOfAjax"></div>
		
		 <!-- <div style="display: flex; align-items: center;" class="py-1 pt-2">
			<input type="checkbox" class="ml-3"/><label class="person ml-2" style="font-weight: bold;">인사부</label><span class="arrow">&#128317;</span>
		</div>
        <div class="hidDept pl-5">
        	<div><input type="checkbox"/><label class="person ml-2">조상운</label></div>
        	<div class="py-1 pt-2">
				<input type="checkbox"/><label class="person ml-2" style="font-weight: bold;">인사부</label><span class="arrow">&#128317;</span>
			</div>
			<div class="hidTeam pl-5">
					<div><input type="checkbox"/><label class="person ml-2">조상운</label></div>
					<div><input type="checkbox"/><label class="person ml-2">조상운</label></div>
					<div><input type="checkbox"/><label class="person ml-2">조상운</label></div>
			</div>
        </div>  -->
        
        
	</div>
	<div id="rightSide">
		<div id="rightTitle"><span style="font-weight:bold;" class="mx-3 mt-2">받는사람 목록</span></div>
		<div id="rightUp">
			<div id="choosedPsnResult"></div>
			
			<!-- <div class="choosedPsn" style="width: 100%;">
				<div class="sentPsnProf ml-2" style="background-color: orange;"><span style="font-size: 9pt;">길동</span></div>
				<span class="ml-2" style="padding-top: 3px;">홍길동</span>
				<span class="ml-2" style="font-weight: normal; color: gray; font-size: 10pt;">인사 · 관리자</span>
			</div> -->
		</div>
		<div id="rightDown">
			<button type="button" id="addPersonBtn">받는사람 추가</button>
		</div>
	
	</div>
</div>