<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="/WEB-INF/views/ecommerce/fragments/header.jsp" %>
	
		<c:if test="${message != null }">
			<h2>${message}</h2>
		</c:if>
	
		<h2>Effettua il login</h2>
		<p id="loginInfo"></p>
		<form action="login?action=login" method="POST" id="loginForm">
			<input type="email" name="email" placeholder="Email" required/> 
			<input type="password" name="pwd" placeholder="Password" required/> 
			<input type="submit" value="Login">
		</form>
		<br>
		<br>
	
		<h2>Oppure registrati</h2>
		<p id="registrationInfo"></p>
		<form action="login?action=register" method="POST" id="registrationForm">
			<input type="text" name="firstName" placeholder="Nome" required/> 
			<input type="text" name="lastName" placeholder="Cognome" required/>
			<br><br> 
			<input type="email" name="email" placeholder="Email" required/> 
			<input type="password" name="pwd" placeholder="Password" required/>
			<br><br> 
			<input type="submit" value="Register">
		</form>
		
	
<%@ include file="/WEB-INF/views/ecommerce/fragments/footer.jsp" %>
