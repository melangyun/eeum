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

<!-- Page level plugins -->
<script src="${contextPath}/resources/bootstrap/vendor/chart.js/Chart.min.js"></script>

<!-- Page level custom scripts -->
<script src="${contextPath}/resources/bootstrap/js/demo/chart-area-demo.js"></script>
<script src="${contextPath}/resources/bootstrap/js/demo/chart-pie-demo.js"></script>

<!-- Custom styles for this template-->
<link href="${contextPath}/resources/bootstrap/css/sb-admin-2.min.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/fbd170e696.js"></script>

<style type="text/css">
	textarea:focus, input:focus{
    outline: none;
}
</style>
</head>

<body id="page-top">

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
				<h1 class="h3 mb-0 text-gray-800">${loginEmp.empName}의 To-do List</h1>
			</div>
			<div class="row">
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">총 To-do List</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">${total} 개</div>
                    </div>
                    <div class="col-auto">
                      <i class="fa fa-list fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-success text-uppercase mb-1">완료된 To-do List</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">${done} 개</div>
                    </div>
                    <div class="col-auto">
                      <i class="fa fa-check-square-o fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-info text-uppercase mb-1">이번주 작업율</div>
                      <div class="row no-gutters align-items-center">
                        <div class="col-auto">
                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">${percent} %</div>
                        </div>
                        <div class="col">
                          <div class="progress progress-sm mr-2">
                            <div id="percent" class="progress-bar bg-info" role="progressbar" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                          	<script type="text/javascript">
                          		$(document).ready(function(){
                          			var percent = '${percent}%';
                          			$("#percent").width(percent);
                          		});
                          	</script>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="col-auto">
                      <i class="fa fa-calendar-check-o fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">남은 할일</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">${undo} 개</div>
                    </div>
                    <div class="col-auto">
                      <i class="fa fa fa-list-alt fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
			<div class="row">
	            <div class="col-lg-6">
					<div class="card">
						<div class="card-body">
							<div>
								<h4 style="display: inline-block;">to-do List</h4>
							</div>
							<div class="row">
							
								<div class="col-md-6 mb-4" style="max-width: 100%;flex: 0 0 100%;">
								<!--등록하는부분  -->
						              <div id="box-color" class="card border-left-primary shadow h-100 py-2">
						                <div class="card-body">
						                  <div class="row no-gutters align-items-center">
						                    <select id="selectbox" name="dataTable_length" aria-controls="dataTable" class="custom-select custom-select-sm form-control form-control-sm" style="width:20%; margin-right: 1rem;">
								           			<option value="">중요도 선택</option>
								           			<option value="긴급">긴급</option>
								           			<option value="보통">보통</option>
								           			<option value="여유">여유</option>
							           			</select>
						                    <div class="col mr-2">
						                      <div class="text-xs font-weight-bold text-warning text-uppercase mb-1" style="cursor: pointer;">
						                      	<input type="text" id="tTitle" placeholder="제목을 입력해주세요" style="border: none;">
						                      </div>
						                      <div class="h5 mb-0 font-weight-bold text-gray-800" style="cursor: pointer;">
						                      	<input type="text" id="tContent" placeholder="내용을 입력해주세요"  style="border: none; width:100%;">
						                      </div>
						                    </div>
						                    <div class="col-auto">
						                      <i id="plus" class="fa fa fa-plus fa-2x text-gray-300" style="cursor: pointer;"></i>
						                    </div>
						                  </div>
						                </div>
						              </div>
						            </div>
						            
					            </div>
							<!--카드  할알목록(미완료) for문 시작  -->
								<div class="row"  id="space">
							<c:forEach var="l" items="${undoList}">
									<div class="hidearea col-xl-6 col-md-6 mb-4">
										<c:set var="tImport" value="${l.tImport}"/>
										<c:if test="${tImport eq '긴급'}">
											<div class="card border-left-danger shadow h-100 py-2">
						              	</c:if>
						              	<c:if test="${tImport eq '보통'}">
											<div class="card border-left-warning shadow h-100 py-2">
						              	</c:if>
						              	<c:if test="${tImport eq '여유'}">
											<div class="card border-left-success shadow h-100 py-2">
						              	</c:if>
								                <div class="card-body">
								                  <div class="row no-gutters align-items-center">
								                    <div class="col mr-2">
								                      <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">${l.tTitle}</div>
								                      <div class="h5 mb-0 font-weight-bold text-gray-800">${l.tContent}</div>
								                    </div>
								                    <div class="col-auto done" style="margin-right: 10px;">
								                    	<input type="hidden" class="tNo" value="${l.tNo}">
								                    	<input type="hidden" class="tContent" value="${l.tContent }">
								                    	<input type="hidden" class="tTitle" value="${l.tTitle }">
								                    	<input type="hidden" class="tImport" value="${l.tImport }">
								                      <i class="check fa fa-check fa-2x text-gray-300" style="cursor: pointer;"></i>
								                    </div>
								                    <div class="col-auto trash">
								                    	<input type="hidden" value="${l.tNo}">
								                      <i class="check fa fa-trash-o fa-2x text-gray-300" style="cursor: pointer;"></i>
								                    </div>
								                  </div>
								                </div>
								              </div>
						              
						            </div>
				            </c:forEach>
				            
					            </div>
						</div>
					</div>
	            </div>
	            <div class="col-lg-6">
					<div class="card">
						<div class="card-body">
							<div><h4>최근 완료 목록</h4></div>
							<!--카드 카드  -->
							<div class="row" id="doneSpace">
								<c:if test="${empty doneList}">
									<h5 id="shutup" style="display:inline-block; margin: 5rem; margin-left: auto;margin-right: auto;">이번주 완료한 할일이 없네요!</h5>
								</c:if>
								<c:forEach var="d" items="${doneList}">
									<div class="hidearea col-xl-6 col-md-6 mb-4"><!--div1  -->
						              <div class="card border-left-light shadow h-100 py-2"><!--div2  -->
						                <div class="card-body"><!--div3  -->
						                  <div class="row no-gutters align-items-center"><!--div4  -->
						                    <div class="col mr-2"><!--div5  -->
						                      <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">${d.tTitle}</div><!--div6  -->
						                      <div class="h5 mb-0 font-weight-bold text-gray-800">${d.tContent}</div><!--div7  -->
						                    </div>
						                     <div class="col-auto undone" style="margin-right: 10px;"><!--div8  -->
						                    	<input type="hidden" class="tNo" value="${d.tNo}">
						                    	<input type="hidden" class="tContent" value="${d.tContent }">
						                    	<input type="hidden" class="tTitle" value="${d.tTitle }">
						                    	<input type="hidden" class="tImport" value="${d.tImport }"><!--input1  -->
						                      <i class="checked fa fa-check fa-2x text-gray-900" style="cursor: pointer;"></i><!--i1  -->
						                    </div>
						                    <div class="col-auto trash"><!--div9  -->
						                    	<input type="hidden" value="${d.tNo}"><!--input2  -->
						                      <i class="check fa fa-trash-o fa-2x text-gray-300" style="cursor: pointer;"></i><!-- i2 -->
						                    </div>
						                  </div>
						                </div>
						              </div>
						            </div>
				            </c:forEach>
				            
				            
				            </div>
				            
						</div>
					</div>
	            </div>
          </div>

		</div>

		</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>
	<script type="text/javascript">
	// 할일 추가시 ajax로 추가
	$(document).on('click','#plus',function(){
		var tImport = $("#selectbox option:selected").val();
		var empNo = "${loginEmp.empNo}";
		var tTitle = $("#tTitle").val();
		var tContent = $("#tContent").val();
		
		if(tImport==""){
			alert("중요도를 선택해주세요!");
			return;
		}
		if(tTitle==""){
			alert("제목을 입력해주세요!");
			return;
		}
		if(tContent==""){
			alert("내용을 입력해주세요!");
			return;
		}
		
		$.ajax({
			url:"insertTodo.do",
			data : {empNo:empNo,tImport:tImport,tTitle:tTitle,tContent:tContent},
			type: "post",
			success: function(data){
				$("#tTitle").val("");
				$("#tContent").val("");
				
				$space = $("#space");
				
				var $div1 = $('<div class="hidearea col-xl-6 col-md-6 mb-4">');
				if(tImport == '긴급'){
				var $div2 = $('<div class="card border-left-danger shadow h-100 py-2">');
				}else if(tImport == '보통'){
					var $div2 = $('<div class="card border-left-warning shadow h-100 py-2">');	
				}else if(tImport == '여유'){
					var $div2 = $('<div class="card border-left-success shadow h-100 py-2">');	
				}
				var $div3 = $('<div class="card-body">');
				var $div4 = $('<div class="row no-gutters align-items-center">');
				var $div5 = $('<div class="col mr-2">');
				var $div6 = $('<div class="text-xs font-weight-bold text-warning text-uppercase mb-1">').text(tTitle);
				var $div7 = $('<div class="h5 mb-0 font-weight-bold text-gray-800">').text(tContent);
				var $div8 = $('<div class="col-auto done" style="margin-right: 10px;">');
				var $div9 = $('<div class="col-auto trash">');
				var $input1 = $('<input class="tNo" type="hidden">').val(data);
				var $input2 = $('<input class="tNo" type="hidden">').val(data);
				var $input3 = $('<input class="tContent" type="hidden">').val(tContent);
				var $input4 = $('<input class="tTitle" type="hidden">').val(tTitle);
				var $input5 = $('<input class="tImport" type="hidden">').val(tImport);
				var $i1 = $('<i class="check fa fa-check fa-2x text-gray-300" style="cursor: pointer;">');
				var $i2 = $('<i class="check fa fa-trash-o fa-2x text-gray-300" style="cursor: pointer;">');
				
				
				$div9.append($i2);
				$div9.append($input2);
				
				$div8.append($i1);
				$div8.append($input1);
				$div8.append($input3);
				$div8.append($input4);
				$div8.append($input5);
				
				$div5.append($div6);
				$div5.append($div7);
				
				
				$div4.append($div5);
				$div4.append($div8);
				$div4.append($div9);
				$div3.append($div4);
				$div2.append($div3);
				$div1.append($div2);
				$space.append($div1);
			}
		});
		
	});	
	//마우스 오버시 색깔 바뀜 -추가부분
	$("#plus").mouseover(function(){
		$(this).removeClass('text-gray-300');
		$(this).addClass('text-gray-900');
	});
	$("#plus").mouseout(function(){
		$(this).addClass('text-gray-300');
		$(this).removeClass('text-gray-900');
	});
	
	//selectbox 색변경
		$("#selectbox").change(function(){
			var cate = $("#selectbox option:selected").val();
			if(cate == "긴급"){
				$("#box-color").removeClass('border-left-primary');
				$("#box-color").removeClass('border-left-warning');
				$("#box-color").removeClass('border-left-success');

				$("#box-color").addClass('border-left-danger');
			}else if(cate == "보통"){
				$("#box-color").removeClass('border-left-primary');
				$("#box-color").removeClass('border-left-danger');
				$("#box-color").removeClass('border-left-success');
				
				$("#box-color").addClass('border-left-warning');
			}else if(cate =="여유"){
				$("#box-color").removeClass('border-left-primary');
				$("#box-color").removeClass('border-left-danger');
				$("#box-color").removeClass('border-left-warning');
				
				$("#box-color").addClass('border-left-success');
			}
		});
	
	
        //마우스 오버시 색깔 바뀜 -체크부분
		$(document).on('mouseover','.check',function(){
			$(this).removeClass('text-gray-300');
			$(this).addClass('text-gray-900');
		});
		$(document).on('mouseout','.check',function(){
			$(this).addClass('text-gray-300');
			$(this).removeClass('text-gray-900');
		});
		$(document).on('mouseover','.checked',function(){
			$(this).addClass('text-gray-300');
			$(this).removeClass('text-gray-900');
		});
		$(document).on('mouseover','.checked',function(){
			$(this).removeClass('text-gray-300');
			$(this).addClass('text-gray-900');
		});
		
		
   		/* 완료 목록으로 이동 */
   		
 		$(document).on('click','.done',function(){
			var tNo = $(this).find(".tNo").val();
			var tStatus = 'D';
			var tContent=$(this).find(".tContent").val();
			var tTitle=$(this).find(".tTitle").val();
			var tImport=$(this).find(".tImport").val();
			
			$(this).closest(".hidearea").hide(1000);
			$.ajax({
				url:"updateTodo.do",
				data : {tNo:tNo,tStatus:tStatus},
				type: "post",
				success: function(data){
					$space = $("#doneSpace");
					$("#shutup").hide();
					var $div1 = $('<div class="hidearea col-xl-6 col-md-6 mb-4">');
					var $div2 = $('<div class="card border-left-light shadow h-100 py-2">');
					var $div3 = $('<div class="card-body">');
					var $div4 = $('<div class="row no-gutters align-items-center">');
					var $div5 = $('<div class="col mr-2">');
					var $div6 = $('<div class="text-xs font-weight-bold text-warning text-uppercase mb-1">').text(tTitle);
					var $div7 = $('<div class="h5 mb-0 font-weight-bold text-gray-800">').text(tContent);
					var $div8 = $('<div class="col-auto undone" style="margin-right: 10px;">');
					var $div9 = $('<div class="col-auto trash">');
					var $input1 = $('<input class="tNo" type="hidden">').val(tNo);
					var $input2 = $('<input class="tNo" type="hidden">').val(tNo);
					var $input3 = $('<input class="tContent" type="hidden">').val(tContent);
					var $input4 = $('<input class="tTitle" type="hidden">').val(tTitle);
					var $input5 = $('<input class="tImport" type="hidden">').val(tImport);
					var $i1 = $('<i class="checked fa fa-check fa-2x text-gray-900" style="cursor: pointer;">');
					var $i2 = $('<i class="check fa fa-trash-o fa-2x text-gray-300" style="cursor: pointer;">');
					
					
					$div9.append($i2);
					$div9.append($input2);
					
					$div8.append($i1);
					$div8.append($input1);
					$div8.append($input3);
					$div8.append($input4);
					$div8.append($input5);
					
					$div5.append($div6);
					$div5.append($div7);
					
					
					$div4.append($div5);
					$div4.append($div8);
					$div4.append($div9);
					$div3.append($div4);
					$div2.append($div3);
					$div1.append($div2);
					$space.append($div1);
				}
			});
			
		});
 			$(document).on('click','.done',function(){
 				$(this).removeClass('text-gray-300');
 				$(this).addClass('text-gray-900');
 			});
 			$(document).on('mouseout','.check',function(){
 				$(this).addClass('text-gray-300');
 				$(this).removeClass('text-gray-900');
 			});
			$(document).on('mouseover','.checked',function(){
 				$(this).addClass('text-gray-300');
 				$(this).removeClass('text-gray-900');
 			});
			$(document).on('mouseout','.checked',function(){
				$(this).removeClass('text-gray-300');
 				$(this).addClass('text-gray-900');
 			});
 			
 	   		
   		
   			$(document).on('click','.undone',function(){
   	   			var tNo = $(this).find(".tNo").val();
   				var tContent=$(this).find(".tContent").val();
   				var tTitle=$(this).find(".tTitle").val();
   				var tImport =$(this).find(".tImport").val();
   				var tStatus = 'Y';
   				$(this).closest(".hidearea").hide(1000);
   				$.ajax({
   					url:"updateTodo.do",
   					data : {tNo:tNo,tStatus:tStatus},
   					type: "post",
   					success: function(data){
   						
   						$space = $("#space");
   						
   						var $div1 = $('<div class="hidearea col-xl-6 col-md-6 mb-4">');
   						if(tImport == '긴급'){
   						var $div2 = $('<div class="card border-left-danger shadow h-100 py-2">');
   						}else if(tImport == '보통'){
   							var $div2 = $('<div class="card border-left-warning shadow h-100 py-2">');	
   						}else if(tImport == '여유'){
   							var $div2 = $('<div class="card border-left-success shadow h-100 py-2">');	
   						}
   						var $div3 = $('<div class="card-body">');
   						var $div4 = $('<div class="row no-gutters align-items-center">');
   						var $div5 = $('<div class="col mr-2">');
   						var $div6 = $('<div class="text-xs font-weight-bold text-warning text-uppercase mb-1">').text(tTitle);
   						var $div7 = $('<div class="h5 mb-0 font-weight-bold text-gray-800">').text(tContent);
   						var $div8 = $('<div class="col-auto done" style="margin-right: 10px;">');
   						var $div9 = $('<div class="col-auto trash">');
   						var $input1 = $('<input class="tNo" type="hidden">').val(tNo);
   						var $input2 = $('<input class="tNo" type="hidden">').val(tNo);
   						var $input3 = $('<input class="tContent" type="hidden">').val(tContent);
   						var $input4 = $('<input class="tTitle" type="hidden">').val(tTitle);
   						var $input5 = $('<input class="tImport" type="hidden">').val(tImport);
   						var $i1 = $('<i class="check fa fa-check fa-2x text-gray-300" style="cursor: pointer;">');
   						var $i2 = $('<i class="check fa fa-trash-o fa-2x text-gray-300" style="cursor: pointer;">');
   						
   						
   						$div9.append($i2);
   						$div9.append($input2);
   						
   						$div8.append($i1);
   						$div8.append($input1);
   						$div8.append($input3);
   						$div8.append($input4);
   						$div8.append($input5);
   						
   						
   						$div5.append($div6);
   						$div5.append($div7);
   						
   						
   						$div4.append($div5);
   						$div4.append($div8);
   						$div4.append($div9);
   						$div3.append($div4);
   						$div2.append($div3);
   						$div1.append($div2);
   						$space.append($div1);
   					}
   				});
   				
   			});
   		
   			//휴지통 클릭
    		$(document).on('click','.trash',function(){
    			if(confirm("정말로 삭제하시겠습니까?")){
    				var tNo = $(this).find("input").val();
    				var tStatus = 'R';
    				$(this).closest(".hidearea").hide(1000);
    				$.ajax({
    					url:"updateTodo.do",
    					data : {tNo:tNo,tStatus:tStatus},
    					type: "post",
    					success : function(data){
    						alert("정상적으로 삭제되었습니다.");
    					}
    					});
    				}
    			})
              		
          </script>
</body>

</html>
