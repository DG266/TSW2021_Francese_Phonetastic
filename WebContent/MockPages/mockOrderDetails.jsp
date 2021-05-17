<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="MockPages/mockStyles.css" rel="stylesheet" type="text/css">
<title>Dettagli ordine</title>
</head>
<body>
	<%@ include file="mockHeader.jsp"%>
	<table border="1">
		<tr>
			<th>Nome prodotto</th>
			<th>Costo</th>
			<th>Quantit�</th>
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
	<%@ include file="mockFooter.jsp"%>
</body>
</html>
