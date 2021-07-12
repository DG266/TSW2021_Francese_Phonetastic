<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/ecommerce/fragments/header.jsp" %>

	<c:if test="${message != null }">
		<h2>${message}</h2>
	</c:if>

	<div class="login-box">	
		<div class="login-form">
			<h2>Effettua il login</h2>
			<form action="login?action=login" method="POST" id="loginForm">
				<input type="email" name="email" placeholder="Email" required/>
				<input type="password" name="pwd" placeholder="Password" required/> 
				<input type="submit" value="Login">
			</form>
		</div>	
		
		<div class="register-form">	
			<h2>Oppure registrati</h2>
			<form action="login?action=register" method="POST" id="registrationForm">
				<div class="register-name">
					<input type="text" name="firstName" placeholder="Nome" required/> 
					<input type="text" name="lastName" placeholder="Cognome" required/>
				</div>
					<br><br> 
					<input type="email" name="email" placeholder="Email" required/> 
					<input type="password" name="pwd" placeholder="Password" required/>
					<br><br> 
					<input type="submit" value="Register">
			</form>
		</div>	
	</div>	
		<%@ include file="/WEB-INF/views/ecommerce/fragments/footer.jsp" %>
