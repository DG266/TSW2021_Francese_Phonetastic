<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>  

		<c:import url="/WEB-INF/views/ecommerce/header.jsp" />
		<table border="1">
			<tr>
				<th>ID</th>
				<th>Data</th>
				<th>Importo complessivo</th>
			</tr>
			<c:choose>
				<c:when test="${orders != null && orders.size() != 0}">
					<c:forEach var="bean" items="${orders}">
						<tr>
							<td>${bean.id}</td>
							<td><fmt:formatDate type="both" timeZone="UTC" value="${bean.lastUpdateDate}"/></td>
							<td>${bean.total}</td>
							<td>
								<form action="my-orders" method="POST">
									<input type="hidden" name="id" value="${bean.id}"> 
									<input type="submit" value="Dettagli">
								</form>
							</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="6">Non hai effettuato alcun ordine.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
		<c:import url="/WEB-INF/views/ecommerce/footer.jsp" />
	</body>
</html>
