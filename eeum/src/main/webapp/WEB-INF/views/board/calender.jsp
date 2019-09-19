<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType= "text/html; charset=UTF-8" pageEncoding= "UTF-8" %>
<!DOCTYPE html>
<html lang="kor">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>GroupWare</title>
<!-- Custom fonts for this template-->
<link href="${contextPath}/resources/bootstrap/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<!-- Bootstrap core JavaScript-->
<script	src="${contextPath}/resources/bootstrap/vendor/jquery/jquery.min.js"></script>
<script	src="${contextPath}/resources/bootstrap/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="${contextPath}/resources/bootstrap/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="${contextPath}/resources/bootstrap/js/sb-admin-2.min.js"></script>

<!-- Custom styles for this template-->
<link href="${contextPath}/resources/bootstrap/css/sb-admin-2.min.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/fbd170e696.js"></script>

<!-- Full Calendar  -->
<link href='${contextPath}/resources/fullcalendar/core/main.css' rel='stylesheet' />
<link href='${contextPath}/resources/fullcalendar/daygrid/main.css' rel='stylesheet' />
<script src='${contextPath}/resources/fullcalendar/core/main.js'></script>
<script src='${contextPath}/resources/fullcalendar/interaction/main.js'></script>
<script src='${contextPath}/resources/fullcalendar/daygrid/main.js'></script>


<!--자동완성  -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />

<style type="text/css">
	/* #calendar{
	width:80%;
	margin-left: 10%;
	transition: .8s;
	} */
	.fc-title{
	color: white;
	}
	.fc-event, .fc-event-dot {
    background-color: rgb(20,20,50);
	}
	.fc-event{
	border: rgb(20,20,50);
	}
	.plusDetail{
	margin-top: 2rem;
	}
	.btnArea{
		margin-left: auto;
		margin-right: auto;
		display: inline-block;
	}
	#insertBtn{
		background-color: rgba(44,62,80,0.5);
		color:white;
	}
	#deletetBtn{
		background-color: rgba(44,62,80,0.5);
		color:white;
	}
	.calendarArea{
	margin-left: 20%;
	transition: 1s;
	}
	.hideArea{
	display: none;
	position: absolute;
	background: white;
	/* transition-delay:0.5s;
	 -webkit-transition-delay:0.5s; */
	}
	#shareBtn{
		background-color: rgba(20,20,50,0.8);
		color:white;
	}
	
	#joinEmp{
	display:none;
	border: none;
	margin: 5px;
	padding: 5px;
	clear: both;
	width: 60%;	
		
	}
	#joinEmp:focus{
	outline: none;
	}
	.calssArea{
		float:left;
		border: 2px solid rgb(20,20,50); 
		background: rgba(20,20,50, 0.7); 
		color:white;
		border-radius: 1rem;
		padding: 8px;
		padding-top:2px;
		padding-bottom: 2px;
		margin: 5px;
		transition: .8s;
	}
	.plusArea{
		display: none;
		
	}
	.btn{
	transition: .8s;
	}
	#plusBtn{
	margin-bottom: 3rem;
	}
	
	.second_hideArea{
	margin-left:65%;
	display: none;
	position: absolute;
	background: white;
	}
	#closeBtn{
		background-color: rgb(20,20,50);
		color:white;
	}
	#SharedBtn{
		background-color:  #E97C2B;
		color:white;
	}
</style>
</head>

<body id="page-top">
<script type="text/javascript">
var joinEmp ="";//공유 emp
</script>
	<!-- 메인레버 -->
	<div id="wrapper">
		<!-- 사이드바 -->
		<jsp:include page="/WEB-INF/views/common/sidebar.jsp" flush="false"></jsp:include>
		<!-- 상단바 -->
		<jsp:include page="/WEB-INF/views/common/topbar.jsp" flush="false"></jsp:include>
				
		<!-- 컨텐츠 영역 -->
		<div class="container-fluid">
			<!-- 타이틀 영역 -->
			<div class="d-sm-flex align-items-center justify-content-between mb-4">
				<h1 class="h3 mb-0 text-gray-800">일정 관리</h1>
			</div>
			<div class="card shadow mb-4">
                <div class="card-body" style="padding:5rem;">
                	<a id="plusBtn" class="btn btn-primary btn-icon-split" style="display: inline-block; maring:0; text-align:right">
						<span class="icon" style="color: white;">
							<i class="fa fa-plus"></i>신규일정
						</span>
					</a>
					<div class="row">
					  <div class="col-lg-3 hideArea">
					  	<div class="card card-body plusDetail">
					  		<div class="form-group">
						    	일정 제목 <input type="text" class="form-control" id="cTitle">
						  	</div>
						  	<div class="form-group">
						    	시작일<input type="date" class="form-control" id="cDate" max="9999-12-31">
						  	</div>
						  	<div class="form-group">
						    	종료일<input type="date" class="form-control" id="cFDate" max="9999-12-31">
						    	<c:if test="${loginEmp.empStatus eq 'A' }">
						    		<label style="margin-top: 1rem;"><input id="cType" type="checkbox">전체 일정으로 공지</label>
						  		</c:if>
						  	</div>
						  	<div class="form-group">
						  		<div class="extraArea">
							  			
							  	</div>
							  	<input type="text" id="joinEmp" placeholder="공유인 추가">
							  	<script type="text/javascript">
						  				$(document).on('keyup','#joinEmp',function(){
						  					var search = $(this).val();
						  					$.ajax({
												url:"searchEmpList.do",
												data:{search:search},
												dataType:"json",
												success : function(data){
													var list = [];
													if(data.length > 0){
														for(var i in data){
															var inputText = decodeURIComponent(data[i].replace(/\+/g," "));
															if(!joinEmp.includes(inputText)){
																list.push(inputText);
															}
														}
														$("#joinEmp").autocomplete({
															source:list,
															select: function(event, ui) {
																addFun(ui.item.value);
																return false;
													        },
													        focus: function(event, ui) {
													            return false;
													        }
														});
													}
												}
											});
									});
						  				
						  				$(document).on('keydown','#joinEmp',function(e){
						  					var text = $(this).val();
						  					if(text=="" && e.keyCode == 8 && joinEmp.includes(";")){
						  					// user has pressed backspace
						  						var text = joinEmp.substring(0,joinEmp.length-1);
						  						var lastEmp = text.substring(text.lastIndexOf(";")+1,text.length);
						  						console.log(lastEmp);
						  						if(confirm("'"+lastEmp+"' 를 정말로 삭제하시겠습니까?")){
						  							joinEmp = text.substring(0,text.lastIndexOf(";")+1);
						  							$(".calssArea:last").hide().removeClass("calssArea");
						  						}
						  						console.log(joinEmp);
						  						}
						  					
						  					});
						  				
						  				function addFun(value){
						  					var $div = $(".extraArea");
											var $span = $("<span class='calssArea'>").text(value);
											if(joinEmp.includes(value)){
												alert("이미 추가한 사원입니다.");
											}else{
												joinEmp += value+";";
												$div.append($span);
											}
											$("#joinEmp").val("");
						  				}
						  				
						  				$(document).on('click','.calssArea',function(){
						  					var text = $(this).text();
						  					if(confirm(text +" 사원을 정말로 삭제하시겠습니까?")){
						  						$(this).fadeOut(400);
						  						var array = joinEmp.split(";");
						  						joinEmp = "";
						  						for ( var i in array ) {
						  							if(array[i]==text){
						  								array[i]="";
						  							}else{
						  								array[i]+=";";
						  							}
						  							joinEmp+=array[i];
						  					      }
					  							joinEmp=joinEmp.substr(0,joinEmp.length-1);
						  						console.log(joinEmp);
						  					}
						  				});
					  				</script>
						  	</div>
						  	<div class="btnArea">
						  		<button type="button" class="btn" id="insertBtn">등록</button>
						  		<button type="button" class="btn" id="shareBtn">공유</button>
						  	</div>
						  </div>
					  </div>
					  <div class="col-lg-7 calendarArea">
	                  	<div id="calendar" class="fc fc-ltr fc-bootstrap"></div>
	                  	</div>
                  	 <div class="col-lg-3 second_hideArea">
                  	 	<div class="card card-body plusDetail">
					  		<div class="form-group">
						    	일정 제목 <input type="text" class="form-control" id="write_cTitle" readonly>
						  	</div>
						  	<div class="form-group">
						    	유형<input type="text" class="form-control" id="write_cStatus" readonly>
						  	</div>
						  	<div class="form-group selectHidden">
						    	공유자<input type="text" class="form-control" id="write_empNo" readonly>
						  	</div>
						  	<div class="btnArea">
						  		<input type="hidden" id="cId">
						  		<button type="button" class="btn" id="deletetBtn">삭제</button>
						  		<button type="button" class="btn" id="closeBtn">닫기</button>
						  	</div>
						  </div>
                  	 </div>
					</div>
                </div>
              </div>
			
			<script>
			var date = new Date();
			  document.addEventListener('DOMContentLoaded', function() {
				  var calendarEl = document.getElementById('calendar');
					
				    var calendar = new FullCalendar.Calendar(calendarEl, {
				        plugins: [ 'interaction', 'dayGrid' ],
				        defaultDate: date,
				        editable: false,
				        eventLimit: true,
				        dateClick: function(info) {
				          },
				        views: {
				            dayGrid: {
				               eventLimit: 2
				            }
				        },
				        eventClick: function(info) {
				        	var id = info.event.id;
				        	console.log(info.event);
				        	if(id=="N"){
				        		$(".selectHidden").hide();
				        		$("#deletetBtn").hide();
				        		$("#write_cTitle").val(info.event.title);
				        		$("#write_cStatus").val("부서원일정 공유");
				        	}else{
				        		var array = id.split(";");
				        		if(array[0]=='a'){
				        			//전체일정
				        			$(".selectHidden").hide();
					        		$("#deletetBtn").hide();
					        		$("#write_cTitle").val(info.event.title);
					        		$("#cId").val(info.event.id);
					        		$("#write_cStatus").val("사내일정");
					        		<c:if test="${loginEmp.empStatus eq 'A' }">
					        		$("#deletetBtn").show();
						  			</c:if>
				        		}else if(array[0]=='s'){
				        			//공유일정
					        		$(".selectHidden").show();
				        			$("#write_empNo").val(array[2]);
					        		$("#deletetBtn").show();
					        		$("#write_cTitle").val(info.event.title);
					        		$("#cId").val(info.event.id);
					        		$("#write_cStatus").val("개인 일정 공유");
				        		}else if(array[0]=='m'){
				        			//개인일정
				        			$(".selectHidden").hide();
					        		$("#deletetBtn").show();
					        		$("#write_cTitle").val(info.event.title);
					        		$("#cId").val(info.event.id);
					        		$("#write_cStatus").val("개인 일정");
				        		}
				        	}
				        	
				        	//id ==n이면 수정 불가
				        	
				        	$(".calendarArea").css('margin-left','5%');
				        	$(".second_hideArea").hide();
				        	$(".second_hideArea").fadeIn(1300);
				        	$(".hideArea").fadeOut(400);
				        	
				        }
				      });
				  		  //참여 회의
					    <c:forEach var ='i' items='${rlist}'>
			           		calendar.addEvent({'title': '${i.title}',
			           							'id':'N',
			           							'start':'${i.start}',
			           							'url':'rListView.do',
			           							'color':'rgb(20,20,50)',
			           							'textColor':'white'
			           							});
	           			</c:forEach>
	           			
	           			//입사기념일
	           			<c:forEach var ='i' items='${elist}'>
			           		calendar.addEvent({'title': '${i.title}님 입사기념일',
			           							'id':'N',
			           							'start':'${i.start}',
			           							'color':'#FFBB00',
			           							'textColor':'white'
			           							});
	           			</c:forEach>
	           			//휴가
	           			<c:forEach var ='i' items='${vlist}'>
		           		calendar.addEvent({'title': '${i.title}님 휴가',
		           							'id':'N',
		           							'start':'${i.start}',
		           							'end':'${i.finish}',
		           							'color':'#5F00FF',
		           							'textColor':'white'
		           							});
           				</c:forEach>
           				//본인일정
           				<c:forEach var ='i' items='${r_pList}'>
		           		calendar.addEvent({ 'id':'m;${i.cNo};${i.empNo}',
		           							'title': '${i.cTitle}',
		           							'start':'${i.cDate}',
		           							'end':'${i.cFDate}',
		           							'color':'#0054FF',
		           							'textColor':'white'
		           							});
           				</c:forEach>
           				//공유일정
           				<c:forEach var ='i' items='${r_sList}'>
		           		calendar.addEvent({ 'id':'s;${i.cNo};${i.empNo}',
											'title': '${i.cTitle}',
		           							'start':'${i.cDate}',
		           							'end':'${i.cFDate}',
		           							'color':'#CC3D3D',
		           							'textColor':'white'
		           							});
		           		//전체일정
		           		</c:forEach>
           				<c:forEach var ='i' items='${r_aList}'>
		           		calendar.addEvent({'id':'a;${i.cNo};${i.empNo}',
   											'title': '${i.cTitle}',
		           							'start':'${i.cDate}',
		           							'end':'${i.cFDate}',
		           							'color':'#A566FF',
		           							'textColor':'#fff'
		           							});
           				</c:forEach>
				      calendar.render();
				    });

			</script>
			<script type="text/javascript">
				$(document).on('click', '#plusBtn', function(){
					$("#shareBtn").fadeIn(1500);
					$(".plusArea").fadeOut(400);
					$("#joinEmp").fadeOut(400);
					$(".calendarArea").css('margin-left','35%');
					$(".hideArea").fadeIn(1500);
					$(".second_hideArea").fadeOut(400);
				});
				
				$(document).on('click','#insertBtn',function(){
					//추가(등록)버튼 눌렀을 때!
					var empNo = "${loginEmp.empNo}";
					var cDate = $("#cDate").val();
					var check = $("input:checkbox[id='cType']").is(":checked") ;
					var cStatus = 'Y';
					var cTitle = $("#cTitle").val();
					
					var cFDate = $("#cFDate").val();
					var array = cFDate.split("-");
					var date = new Date(array[0], array[1], array[2]);
					date.setDate(date.getDate()+1);
					cFDate = getFormatDate(date);
						
					console.log("cFDate : "+cFDate);
					console.log("check : " +check);
					if(check){
						cStatus = 'A';
					}
					var sEmp = joinEmp;
					console.log(empNo);
					$.ajax({
						url:"cinsert.do",
						data:{empNo:empNo,cDate:cDate,cStatus:cStatus,cTitle:cTitle,sEmp:sEmp,cFDate:cFDate},
						type:"post",
						success:function(data){
							if(data=="success"){
								alert("성공적으로 등록되었습니다.");
								$(".calendarArea").css('margin-left','20%');
								$(".hideArea").fadeOut(400);
								$(".second_hideArea").fadeOut(400);
								$("#cDate").val("");
								$("#cTitle").val("")
								$("#cFDate").val("");
								$("input:checkbox[id='cFDate']").prop("checked", false); 
								setTimeout(function() {
									location.href="calPage.do";
									}, 2500);
							}else{
								alert("등록에 실패하였습니다.\n관리자에게 문의해주세요");
							}
						}
					});
					
				});
				
				$(document).on('click','#shareBtn',function(){
					$(".plusArea").fadeIn(1500);
					$("#joinEmp").fadeIn(1500);
					$(this).hide();
				});
				
				$(document).on('click','#closeBtn',function(){
					$(".second_hideArea").fadeOut(400);
					$(".calendarArea").css('margin-left','20%');
				});
				
				function getFormatDate(date){
					var year = date.getFullYear();
					var month = (date.getMonth());
					month = month >= 10 ? month : '0' + month;
					var day = date.getDate();
					day = day >= 10 ? day : '0' + day;
					return year + '-' + month + '-' + day;
				}
				
				$(document).on('click','#deletetBtn',function(){
					var cId = $("#cId").val();
					var array = cId.split(";");
					var cate = array[0];
					var id = array[1];
					
					if(cate=='m'){
						if(confirm("정말로 삭제하시겠습니까?\n공유된 일정이 모두 삭제됩니다.")){
							cUpdateFun(cate,id);
						}
					}else if(cate=='s'){
						if(confirm("정말로 삭제하시겠습니까?\n공유받은 일정만 삭제됩니다.")){
							cUpdateFun(cate,id);
						}
					}else if(cate=='a'){
						if(confirm("정말로 삭제하시겠습니까?\n전체 공유 일정이 삭제됩니다.")){
							cUpdateFun(cate,id);
						}
					}
				});
				
				function cUpdateFun(cate,id){
					$.ajax({
						url:"cUpdate.do",
						data:{cate:cate,id:id},
						type:"post",
						success:function(data){
							if(data="success"){
								alert("성공적으로 삭제되었습니다.");
								$(".second_hideArea").fadeOut(500);
								$(".calendarArea").css('margin-left','20%');
								setTimeout(function() {
								location.href="calPage.do";
								}, 2500);
							}else{
								alert("삭제에 실패하였습니다.\n관리자에게 문의해주세요!");								
							}
						}
					});
				}
				
			</script>

		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>

</body>

</html>


