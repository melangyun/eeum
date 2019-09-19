<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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

<!-- Page level plugins -->
<script src="${contextPath}/resources/bootstrap/vendor/chart.js/Chart.min.js"></script>

<!-- Page level custom scripts -->
<script src="${contextPath}/resources/bootstrap/js/demo/chart-area-demo.js"></script>
<script src="${contextPath}/resources/bootstrap/js/demo/chart-pie-demo.js"></script>

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
	.fc-title{
	color: white;
	}
	.fc-event, .fc-event-dot {
    background-color: rgb(20,20,50);
	}
	.fc-event{
	border: rgb(20,20,50);
	}
	
	.first-area{
		margin-bottom: 5rem;
		margin-left: auto;
		margin-right: auto;
		transition: .8s;
		margin-top: 5rem;
	}
	
	#calendarWrapper{
	display: none;
	}
	
	.secondArea, .ThirdArea{
		display: none;
	}
	.selection{
		text-align: center;
		
	}
	.cards{
		display:inline-block;
	 	margin:.8rem;
	 	transition: .8s;
	 	cursor: pointer;
	}
	.cards:hover{
		background: lightblue;
		/* margin:.9rem; */
	}
	.cardsSelect{
		background: lightgray;
		border: 2px solid rgb(150,150,150);
	}
	.fc-day:hover{
		background: lightblue;
	}
	#joinEmp{
		display:inline-block;
		border: none;
		margin: 5px;
		padding: 5px;
		clear: both;
		width: 30%;		
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
	#commit{
		/* display: none; */
		text-align: center;
		margin: auto;
	}
	.buttonArea{
		text-align: center;
		margin-top: 2rem;
		margin-bottom: 2rem;
	}
	.notFcards{
		display:inline-block;
	 	margin:.8rem;
	 	transition: .8s;
	 	background: rgb(20,20,50);
	 	color: rgb(255,255,255);
	}
	.fc-scroller {
   	overflow-y: hidden !important;
	}
</style>
</head>

<body id="page-top">
	<script type="text/javascript">
		var joinEmp ="";//참여 emp
		var date = ""; //참여일
		var SelectTime = "";//선택시간
		var mNo = "";//회의실 번호
		var savedTime="";//예약되어있는시간
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
			<div
				class="d-sm-flex align-items-center justify-content-between mb-4">
				<h1 class="h3 mb-0 text-gray-800">회의실 예약</h1>
			</div>
			<div class="row">
				<div class="col-lg-4">
					<div class="card shadow mb-4">
						<div class="card-header">
			             	<h6 class="m-0 font-weight-bold text-primary" style="display: inline-block;">회의실 목록</h6>
			           	</div>
			           	<div class="card-body" >
			           		<div class="row first-area">
				           		<div class="col-lg-3">
				           			<h5 style="margin-top: 3px">회의실</h5>
				           		</div>
				           		<div class="col-lg-7">
					           		<select name="dataTable_length" id="selectBox" aria-controls="dataTable" class="custom-select custom-select-sm form-control form-control-sm">
					           			<c:forEach var="r" items="${roomList}">
					           				<option value="${r.MNO}">${r.MNAME}</option>
					           			</c:forEach>
					           		</select>
				           		</div>
			           		</div>
			           		<script type="text/javascript">
			           			$(document).ready(function(){
					           		$("#selectBox").val("");
			           			});
	
			           			$("#selectBox").change(function() {
			           					mNo = $("#selectBox option:selected").val();
			           				   $(".first-area").css('margin-top','0').css('margin-bottom','2rem');
							           $("#calendarWrapper").fadeIn(1000);
							           $(".fc-today-button").trigger('click');
										
							           if(date!=""){
							        	   rSelectDateFun(date);
							           }
									});
			           		</script>
			           			<div id="calendarWrapper">
			           			 	<div id="calendar" class="fc fc-ltr fc-bootstrap">
			           			 </div>
			           		 </div>
           		 			<script>
								  document.addEventListener('DOMContentLoaded', function() {
									    var calendarEl = document.getElementById('calendar');
				           		 		var today = new Date();
				           		 		var firstDayOfMonth = new Date( today.getFullYear(), today.getMonth() , 1 );
				           		 		var lastMonth = new Date ( firstDayOfMonth.setDate( firstDayOfMonth.getDate() - 1 ) );
					           			 var yesterDate = today.getTime() - (1 * 24 * 60 * 60 * 1000);
					
									    var calendar = new FullCalendar.Calendar(calendarEl, {
									        plugins: [ 'interaction', 'dayGrid' ],
									        defaultDate: lastMonth,
									        editable: false,
									        eventLimit: true, // allow "more" link when too many events
									        dateClick: function(info) {
									            /* alert('Clicked on: ' + info.dateStr); */
									            //날짜 받아옴!
												if(yesterDate > info.date){
													alert("이미 지난 날짜는 선택할 수 없습니다.");
												}else{			             
										            date=info.dateStr;
										            $(".secondArea").fadeIn(1000);
										            $(".fc-day").css('background','none');
										            info.dayEl.style.backgroundColor = 'lightgray';
										            
										            rSelectDateFun(date);
												}
									          }
									      });

									      calendar.render();
									    });
										function rSelectDateFun(date){
											$.ajax({
												url:"rSelectDate.do",
												data:{date:date,mNo:mNo},
												dataType:"json",
												success:function(data){
													savedTime = data;
													
													var $timearea = $("#timearea");
													$timearea.html("");
													for(var i = 9 ; i < 18 ; i ++){
														if(savedTime.includes(i)){
															var $div1 = $('<div class="card shadow h-100 py-2 notFcards">');	
														}else{
														var $div1 = $('<div class="card shadow h-100 py-2 cards">');
														}
														var $div2 = $('<div class="card-body">');
														var $div3 = $('<div class="row no-gutters align-items-center">');
														var $div4 = $('<div class="col mr-2">');
														var $div5 = $('<div class="h5 mb-0 font-weight-bold selection">');
														var $span = $('<span class="time">').text(i);
														var $span2 = $('<span>').text("시");
														
														$div5.append($span);
														$div5.append($span2);
														$div4.append($div5);
														$div3.append($div4);
														$div2.append($div3);
														$div1.append($div2);
														$timearea.append($div1);
													}
												}
											});
										}
					
								</script>
			           	</div>
			       </div>
			    </div>
			    <div class="col-lg-8">
			    	<div class="card shadow mb-4 secondArea">
			    		<div class="card-header">
			    			<h6 class="m-0 font-weight-bold text-primary" style="display: inline-block;">예약 가능시간</h6>
			    		</div>
		                <div class="card-body">
		                	<div class="row" id="timearea" style="margin: auto; min-height: 9rem;">
		                	</div>
				          
				          <script type="text/javascript">
				          $(document).on('click',".cards",function(){
				        	  var time =$(this).find(".time").text();
				        	  SelectTime += time+",";
				        	  $(this).addClass("cardsSelect");
				        	  $(".ThirdArea").show(1000);
				          });
				          
				          $(document).on('click',".cardsSelect",function(){
				        	  $(this).removeClass("cardsSelect");
				        	  var time =$(this).find(".time").text();
				        	  var array = SelectTime.split(",");
				        	 	SelectTime = "";
		  						for ( var i in array ) {
		  							if(array[i]==time){
		  								array[i]="";
		  							}else{
		  								array[i]+=",";
		  							}
		  							SelectTime+=array[i];
		  					      }
		  							SelectTime=SelectTime.substr(0,SelectTime.length-1);
			  						console.log(SelectTime);
				          });
				          
				          $(document).on('click','.notFcards',function(){
				        	  alert("이미 마감된 시간입니다.");
				          })
				          </script>
		                </div>
			    	</div>
			    	<div class="card shadow mb-4 ThirdArea">
			    		<div class="card-header">
			    			<h6 class="m-0 font-weight-bold text-primary" style="display: inline-block;">상세입력</h6>
			    		</div>
			    		<div class="card-body">
			    			<div class="form-group">
						    	<input type="text" class="form-control" id="mTitle" placeholder="미팅명">
						  	</div>
						  	<div class="form-group">
						  		<textarea class="form-control" rows="5" id="mContnet" placeholder="설명" style="resize: none; overflow: auto;"></textarea>
						  	</div>
						  	<div class="form-group">
						  		<div>
							  		<div class="extraArea">
							  			
							  		</div>
					  				<input type="text" id="joinEmp" placeholder="참가인 추가">
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
																//console.log(ui.item);
																/* $(this).attr('readonly',true); */
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
						  						$(this).fadeOut(500);
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
					  			<div class="buttonArea">
					  				<button type="button" id="commit" class="btn btn-primary">예약</button>
						  			<script type="text/javascript">
						  				$(document).on('click','#commit',function(){
						  					var mTitle = $("#mTitle").val();
						  					var mContnet = $("#mContnet").val();
						  					var count = false;
						  					
						  					if(mTitle==""){
						  						alert("회의 명을 입력해주세요!");
						  						$("#mTitle").focus();
						  						return;
						  					}
						  					if(mContnet==""){
						  						alert("설명을 입력해주세요!");
						  						$("#mContnet").focus();
						  						return;
						  					}
						  					if(joinEmp!=""){
							  					var array = joinEmp.match(/;/g);
							  					count = array.length>=1?true:false;
						  					}
						  					if(!count){
						  						alert("참가인은 한명 이상 입력되어야 합니다.");
						  						$("#joinEmp").focus();
						  						return;
						  					}
						  					if(SelectTime==""){
						  						alert("시간을 선택해주세요!");
						  						return;
						  					}
						  					
						  					SelectTime = SelectTime.substr(0,SelectTime.length-1);
						  					
						  					if(confirm("날짜 : "+date+"\n시간 : "+SelectTime+"시\n제목 : \'"+mTitle+"\'\n예약이 맞습니까?")){
						  						var rDate = date+";"+SelectTime;
						  						var empNo = "${loginEmp.empNo}";
						  						
						  						$.ajax({
													url:"rinsert.do",
													data:{rDate:rDate,mNo:mNo,empNo:empNo,joinEmp:joinEmp,mTitle:mTitle,mContnet:mContnet},
													type:"post",
													success:function(data){
														if(data=="success"){
															alert("성공적으로 예약되었습니다.");
															location.href="rListView.do";
														}else{
															alert("예약에 실패하였습니다.\n관리자에게 문의해주세요!");
														}
													}
						  						});
						  					}else{
						  						SelectTime+=",";
						  					}
						  					
						  				})
						  			</script>
						  		</div>
						  	</div>
			    		</div>
			    	</div>
			    </div>
			</div>



		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>
	<script type="text/javascript">
		$('#recoM').trigger('click');
	</script>
</body>

</html>
