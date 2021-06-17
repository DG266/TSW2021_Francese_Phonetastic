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
		<c:import url="/WEB-INF/views/ecommerce/footer.jsp" />
	</body>
</html>
