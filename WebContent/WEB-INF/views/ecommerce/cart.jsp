<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<c:import url="/WEB-INF/views/ecommerce/header.jsp" />
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
		<c:import url="/WEB-INF/views/ecommerce/footer.jsp" />
	</body>
</html>