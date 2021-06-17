<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<c:import url="/WEB-INF/views/ecommerce/header.jsp" />
		<h2>Effettua il login</h2>
		<form action="login?action=login" method="POST">
			<input type="email" name="email" placeholder="Email" /> 
			<input type="password" name="pwd" placeholder="Password" /> 
			<input type="submit" value="Login">
		</form>
		<br>
		<br>
	
		<h2>Oppure registrati</h2>
	
		<form action="login?action=register" method="POST">
			<input type="text" name="firstName" placeholder="Nome" /> 
			<input type="text" name="lastName" placeholder="Cognome" />
			<br><br> 
			<input type="email" name="email" placeholder="Email" /> 
			<input type="password" name="pwd" placeholder="Password" />
			<br><br> 
			<input type="submit" value="Register">
		</form>
	
		<c:import url="/WEB-INF/views/ecommerce/footer.jsp" />
	</body>
</html>