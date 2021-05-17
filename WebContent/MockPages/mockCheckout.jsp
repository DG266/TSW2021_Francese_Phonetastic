<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="MockPages/mockStyles.css" rel="stylesheet" type="text/css">
<title>Acquisto effettuato</title>
</head>
<body>
	<%@ include file="mockHeader.jsp"%>
	<c:choose>
		<c:when
			test="${currentSessionUser == null || !currentSessionUser.valid}">
			<h1>Non ho fatto nulla!</h1>
			<p>Ricorda di fare il login.</p>
			<a href="catalog">Torna al Catalogo</a>
		</c:when>
		<c:otherwise>
			<h1>Grazie per il tuo acquisto!</h1>
			<p>(esempio di checkout, ho svuotato il tuo carrello e salvato l'ordine nel database)</p>
			<a href="catalog">Torna al Catalogo</a>
		</c:otherwise>
	</c:choose>
	<%@ include file="mockFooter.jsp"%>
</body>
</html>