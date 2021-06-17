<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

		<c:import url="/WEB-INF/views/ecommerce/header.jsp" />
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
		<c:import url="/WEB-INF/views/ecommerce/footer.jsp" />
	</body>
</html>