<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
   
		<div class="overlay"></div>

		<!-- APP JS -->
		<script src="${pageContext.request.contextPath}/resources/js/dashboard.js"></script>
		<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
		<script>
			$(document).ready(function(){
				$('#open').trigger('click');
			});
		</script>
    </body>
</html>