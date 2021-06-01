<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="resources/css/style.css" rel="stylesheet" type="text/css">
<title>Dettagli ordine</title>
</head>
<body>
	<%@ include file="header.jsp"%>
	<table border="1">
		<tr>
			<th>Nome prodotto</th>
			<th>Costo</th>
			<th>Quantità</th>
			<th>IVA</th>
		</tr>
		<c:forEach var="composition" items="${orderInfo.elements}">
			<tr>
				<c:forEach var="product" items="${orderProducts}">
					<c:if test="${composition.productId == product.id}">
						<td>${product.name}</td>
					</c:if>
				</c:forEach>
				<td>${composition.price}</td>
				<td>${composition.quantity}</td>
				<td>${composition.iva}</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="footer.jsp"%>
</body>
</html>
