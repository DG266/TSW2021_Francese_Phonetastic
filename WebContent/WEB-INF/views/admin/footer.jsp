<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
   
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