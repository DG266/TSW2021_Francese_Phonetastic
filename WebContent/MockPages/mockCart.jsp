<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<link href="MockPages/mockStyles.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Il tuo carrello</title>
</head>
<body>
	<%@ include file="mockHeader.jsp"%>
	<a href="catalog">Catalogo</a>
	<h2>Carrello</h2>
	<c:choose>
		<c:when test="${cart != null && cart.products.size() > 0}">
			<table border="1">
				<tr>
					<th>Nome</th>
					<th>Quantità</th>
					<th>Prezzo</th>
					<th>Azione</th>
				</tr>
				<c:forEach var="cartItem" items="${cart.products}">
					<tr>
						<td>${cartItem.product.name}</td>
						<td>
							<form action="cart" method="GET">
								<input type="hidden" name="action" value="changeQuantity">
								<input type="hidden" name="id" value="${cartItem.product.id}"> 
								<input type="text" name="quantity" size="2" value="${cartItem.quantity}"> 	
								<input type="submit" value="Aggiorna ordine">
							</form>
						</td>
						<td>${cartItem.product.price * cartItem.quantity}</td>
						<td>
							<a href="cart?action=deleteCart&id=${cartItem.product.id}">Rimuovi dal carrello</a>
						</td>
					</tr>
				</c:forEach>
			</table>
			<br>
			<form action="checkout" method="GET">
				<input type="submit" value="Procedi con il pagamento">
			</form>
		</c:when>
		<c:otherwise>
			<h2>Il tuo carrello è vuoto</h2>
		</c:otherwise>
	</c:choose>
	<%@ include file="mockFooter.jsp"%>
</body>
</html>