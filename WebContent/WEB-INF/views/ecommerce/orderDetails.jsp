<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

		<c:import url="/WEB-INF/views/ecommerce/header.jsp" />
			<table border="1">
				<tr>
					<th>Nome prodotto</th>
					<th>Costo</th>
					<th>Quantità</th>
					<th>IVA</th>
				</tr>
				<c:choose>
					<c:when test="${orderProducts != null && orderProducts.size() != 0}">
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
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="6">Non ci sono informazioni riguardanti questo ordine.</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</table>
		<c:import url="/WEB-INF/views/ecommerce/footer.jsp" />
	</body>
</html>
