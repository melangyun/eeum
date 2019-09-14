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

<!-- 썸머노트  -->

<!-- include summernote css/js-->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
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
			 <form id="boardForm" role="form" action="boardinsert.do" method="post" autocomplete="off">
			  <br style="clear: both">
			  <div class="card">
				  <div class="card-body">
					  <h3 style="margin-bottom: 25px;">공지작성</h3>
					  <div class="form-group">
					    <input type="text" class="form-control" id="subject" name="bTitle" placeholder="제목을 입력해주세요" required>
					    <label style="margin:0;margin-top:1em;"><input type="checkbox" id="type">전체 공지로 등록하기</label>
					    <input type="hidden" name="bType" value="B">
					  </div>
					    <div class="form-group">
						    <textarea class="form-control" id="summernote" name="bContent" maxlength="140" rows="7"></textarea>
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
			        		console.log(data);
			        		var renameFile ="${ contextPath }/resources/buploadFiles/" + data;
			        		console.log(renameFile);
			        		$("#summernote").summernote('insertImage', renameFile);

			        	}
			      	});
			    }
				
				
			$("#Type").click(function(){
				var check = $("input:checkbox[id='type']").is(":checked")?true : false;
				if(check){
					$("#bType").val("B");
				}else{
					$("#bType").val("I");
				}
			});
			function commit(){
				var title = $("#subject").val();
				var content = $("#summernote").val();
				if(title=="" || content==""){
					alert("제목과 내용 모두를 입력해주세요!");
					return;
				}else{
					$("#boardForm").submit();
				}
				
			}
			</script>


		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>

</body>

</html>
