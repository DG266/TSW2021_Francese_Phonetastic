<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

		<%@ include file="/WEB-INF/views/ecommerce/fragments/header.jsp" %>
		<c:choose>
			<c:when test="${product.id != -1}">
				<img src="${product.imagePath}" width="300" height="300">
				<h2>Nome: ${product.name}</h2>
				<h2>Descrizione: ${product.description}</h2>
				<h2>Prezzo: ${product.price}</h2>
				<h2>Disponibili: ${product.quantity}</h2>
				<form action="${pageContext.request.contextPath}/cart" method="POST">
                	<input type="hidden" name="id" value ="${product.id}">
                	<input type="hidden" name="quantity" value ="1">
                	<input type="hidden" name="action" value ="addCart">
                	<input type="submit" value="Aggiungi al carrello">
            	</form>
			</c:when>
			<c:otherwise>
				<h2>Prodotto non trovato</h2>
			</c:otherwise>
		</c:choose>
		<h2>
			<a href="catalog">Torna al Catalogo</a>
		</h2>
		<%@ include file="/WEB-INF/views/ecommerce/fragments/footer.jsp" %>
	</body>
</html>