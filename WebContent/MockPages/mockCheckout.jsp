<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" import="it.unisa.phonetastic.model.beans.*"%>
	<head>
		<meta charset="UTF-8">
		<link href="MockPages/mockStyles.css" rel="stylesheet" type="text/css">
		<title>Acquisto effettuato</title>
	</head>
	<%
		UserBean currentUser = (UserBean) session.getAttribute("currentSessionUser");
		if(currentUser == null || !currentUser.isValid()){
	%>
	<body>
		<h1>Non ho fatto nulla!</h1>
		<p>Ricorda di fare il login.</p>
		<a href="catalog">Torna al Catalogo</a>
	</body>
	<%	} else {%>
	<body>
		<h1>Grazie per il tuo acquisto!</h1>
		<p>(esempio di checkout, ho svuotato il tuo carrello e salvato l'ordine nel database)</p>
		<a href="catalog">Torna al Catalogo</a>
	</body>
	<%	} %>
</html>