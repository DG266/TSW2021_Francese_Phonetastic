<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<link href="resources/css/style.css" rel="stylesheet" type="text/css">
<meta charset="ISO-8859-1">
<title>Dettagli Prodotto</title>
</head>
<body>
	<%@ include file="header.jsp"%>
	<c:choose>
		<c:when test="${product.id != -1}">
			<img src="${product.imagePath}" width="300" height="300">
			<h2>Nome: ${product.name}</h2>
			<h2>Descrizione: ${product.description}</h2>
			<h2>Prezzo: ${product.price}</h2>
			<h2>Disponibili: ${product.quantity}</h2>
			<a href="info?action=addCart&id=${product.id}">Aggiungi al Carrello</a>
		</c:when>
		<c:otherwise>
			<h2>Prodotto non trovato</h2>
		</c:otherwise>
	</c:choose>
	<h2>
		<a href="catalog">Torna al Catalogo</a>
	</h2>
	<%@ include file="footer.jsp" %>
</body>
</html>