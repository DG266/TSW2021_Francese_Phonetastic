<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="MockPages/mockStyles.css" rel="stylesheet" type="text/css">
<title>Dashboard amministratore</title>
</head>
<body>
	<%@ include file="/MockPages/mockHeader.jsp" %>
	<div class="b">
		<p class="b">Prodotti</p>
	</div>
	<a href="">Aggiungi al catalogo</a>
	<table border="1">
		<tr>
			<th>ID <a href="catalog?sort=id">Ordina</a></th>
			<th>Nome <a href="catalog?sort=name">Ordina</a></th>
			<th>Descrizione <a href="catalog?sort=description">Ordina</a></th>
			<th>Azione</th>
		</tr>
		<c:choose>
			<c:when test="${products != null && products.size() != 0}">
				<c:forEach var="bean" items="${products}">
					<tr>
						<td>${bean.id}</td>
						<td>${bean.name}</td>
						<td>${bean.description}</td>
						<td>
							<a href="info?id=${bean.id}">Dettagli</a><br> 
							<a href="catalog?action=addCart&id=${bean.id}">Aggiungi al carrello</a>
							<a href="">Modifica prodotto</a>
							<!--Da implementare   <a href="">Rimuovi prodotto</a>   -->
						</td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan="6">Non ci sono prodotti disponibili.</td>
				</tr>
			</c:otherwise>
		</c:choose>
	</table>
	<%@ include file="/MockPages/mockFooter.jsp"%>
</body>
</html>