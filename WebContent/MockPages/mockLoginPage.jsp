<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<link href="MockPages/mockStyles.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>
</head>
<body>
	<%@ include file="mockHeader.jsp" %>
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
	
	<%@ include file="mockFooter.jsp"%>
</body>
</html>