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
<link href="${contextPath}/resources/bootstrap/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
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

<!-- 썸머노트  -->

<!-- include summernote css/js-->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>

<!--자동완성  -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<style type="text/css">
	#buttons button{
		margin: 5em;
		display: inline-block;
		margin-left: auto;
		margin-right: auto;
	}
	#buttons{
		display: inline-block;
		margin-left: auto;
		margin-right: auto;
		text-align: center;
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
			 <form id="emailForm" role="form" action="boardinsert.do" method="post" autocomplete="off">
			  <br style="clear: both">
			  <div class="card">
				  <div class="card-body">
					  <h3 style="margin-bottom: 25px;">메일작성</h3>
					  <div class="form-group">
					    <input type="text" class="form-control" id=eTitle name="eTitle" placeholder="제목을 입력해주세요" required>
					   </div>
					  <div class="form-group">
					    <input type="text" class="form-control" id="recieveEmp" name="recieveEmp" value="${empNo}" placeholder="받는 이를 입력해주세요" required>
					  </div>
					    <label style="margin:0;margin-top:1em;"><input type="checkbox" id="forMe">나에게로 메일 쓰기</label>
					    <div class="form-group">
						    <textarea class="form-control" id="summernote" name="eContent" maxlength="140" rows="7"></textarea>
						  </div>
					  <div class="row">
						  <div id="buttons">
							  <button type="button" onclick="commit();" class="btn btn-primary">등록</button>
							  <button type="button" onclick="javascript:history.back();" class="btn btn-danger">취소</button>
						  </div>
					  </div>
				 </div>
				</div>
			</form>


			<script type="text/javascript">
			$(document).ready(function(){
				if($("#recieveEmp").val()!=""){
					$("#recieveEmp").attr('readonly',true);
				}
			});
			
			$(document).on('click','#recieveEmp',function(){
				if ( $(this).is('[readonly]') ) { 
					if(confirm("수신인을 변경하시겠습니까?")){
						$(this).removeAttr('readonly');
						$(this).val("");
					}
				}
			})
			
			$(document).on('keyup','#recieveEmp',function(){
				var search = $(this).val();
				/* var search =string;
				var result = -1;
				result = string.lastIndexOf(",")+1;
				if(result!=-1){
					search = string.substring(result,string.length);
				} */
				//console.log(search);
					$.ajax({
						url:"searchEmpList.do",
						data:{search:search},
						dataType:"json",
						success : function(data){
							var list = [];
							if(data.length > 0){
								for(var i in data){
									list.push(decodeURIComponent(data[i].replace(/\+/g," ")));
								}
								$("#recieveEmp").autocomplete({
									source:list,
									select: function(event, ui) {
										//console.log(ui.item);
										$(this).attr('readonly',true);
							        },
							        focus: function(event, ui) {
							            return false;
							        }
								});
							}
						}
					});
			});
			
			$(document).ready(function() {
			      $('#summernote').summernote({
			    	  toolbar: [
			    		    ['style', ['bold', 'italic', 'underline', 'clear']],
			    		    ['font', ['strikethrough']],
			    		    ['fontsize', ['fontsize']],
			    		    ['color', ['color']],
			    		    ['para', ['ul', 'ol', 'paragraph']],
			    		    ['height', ['height']],
			    		    ['Insert',['picture','link','video','table']],
			    		    ['Misc',['codeview']]
			    		  ],
			    	disableDragAndDrop: true,
			    	placeholder: '내용을 입력해주세요',
			        height: 500,
			        minHeight: 500,
			        focus: true,
			        callbacks: {
			        	onImageUpload: function(files, editor, welEditable) {
				            for (var i = files.length - 1; i >= 0; i--) {
				            	sendFile(files[i], this);
				            }
				        }
	               }
			      });
			    });
				
			
			
				function sendFile(file,el) {
					var form_data = new FormData();
			      	form_data.append('file', file);
			      	$.ajax({
			        	data: form_data,
			        	type: "POST",
			        	url: 'getchagePhoto.do',
			        	cache: false,
			        	contentType: false,
			        	enctype: 'multipart/form-data',
			        	processData: false,
			        	success: function(data) {
			        		var renameFile ="${ contextPath }/resources/buploadFiles/" + data;
			        		$("#summernote").summernote('insertImage', renameFile);

			        	}
			      	});
			    }
				
				//나에게로 메일 쓰기
				
				$("#forMe").click(function(){
					var check = $("input:checkbox[id='forMe']").is(":checked")?true : false;
					var empNo = "${loginEmp.empNo}";
					if(check){
						$("#recieveEmp").val(empNo);
						$("#recieveEmp").attr("readonly",true);
					}else{
						$("#recieveEmp").val("");
						$("#recieveEmp").attr("readonly",false);
					}
				});
				
				function commit(){
				if ( !$('#recieveEmp').is('[readonly]') ) {
					alert("수신인을 정확히 입력해주세요!");
					return;
				}
				var eTitle = $("#eTitle").val();
				var eContent = $("#summernote").val();
				var recieveEmp = $("#recieveEmp").val().trim();
				var empNo = "${loginEmp.empNo}";
				
				if(recieveEmp==""){
					alert("받는이를 입력해주세요!");
					$('#recieveEmp').focus();
					return;
				}
				
				if(eTitle == ""){
					var result = confirm("제목이 비어있습니다.\n(제목 없음)\n 으로 메일을 전송하시겠습니까?");
					if(!result){
						$('#eType').focus();
						return;
					}else{
						eTitle = "(제목없음)";
					}
				}
				
				if(eContent == ""){
					var result = confirm("내용이 비어있습니다.\n(내용 없음)\n 으로 메일을 전송하시겠습니까?");
					if(!result){
						$('#summernote').focus();
						return;
					}else{
						eContent = "(내용없음)";
					}
				}
				
				var recieveEmp = $("#recieveEmp").val();
				var eType ="내부";
				var eStatus = 'N';
				if(recieveEmp.match("@")){
					eType ="외부";
				}
				var eStatus = 'N';
				if(recieveEmp.includes(empNo)){
					eStatus = 'M';
				}
				
				$.ajax({
					url:"sendEmail.do",
					data:{empNo:empNo,recieveEmp:recieveEmp,eType:eType,eTitle:eTitle,eContent:eContent,eStatus:eStatus},
					type:"POST",
					success:function(data){
						alert("메일이 성공적으로 전송되었습니다.");
						window.location.href="mailSendView.do?eStatus=N";
					}
				});
				
				
			}
				
				
			
				
				
			
			</script>


		</div>
		
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>
	<script type="text/javascript">
		$('#email').trigger('click');
	</script>
</body>

</html>
