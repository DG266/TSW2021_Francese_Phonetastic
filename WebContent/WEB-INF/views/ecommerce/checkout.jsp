<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<c:import url="/WEB-INF/views/ecommerce/header.jsp" />
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
	<c:import url="/WEB-INF/views/ecommerce/footer.jsp" />
</body>
</html>