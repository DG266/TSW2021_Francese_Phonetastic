<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<link href="../resources/css/style.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login amministratore</title>
</head>
<body>
	<%@ include file="header.jsp" %>
	
	<h2>Effettua il login amministratore</h2>
	<form action="admin/login?action=login" method="POST">
		<input type="email" name="email" placeholder="Email" /> 
		<input type="password" name="pwd" placeholder="Password" /> 
		<input type="submit" value="Login">
	</form>

	<%@ include file="footer.jsp"%>
</body>
</html>