<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<%@ include file="/WEB-INF/views/admin/fragments/header.jsp" %>

	<!-- MAIN CONTENT -->
	<div class="main">
		<div class="main-header">
			<div class="mobile-toggle" id="mobile-toggle">
				<i class='bx bx-menu-alt-right'></i>
			</div>
			<div class="main-title">
				dashboard
			</div>
		</div>
		<div class="main-content">
			<c:if test="${message != null}">
				<h2>${message}</h2>
			</c:if>
			<div class="info">
			</div>
			<br><br>
			<h2>Aggiungi un prodotto</h2>
			<form action="add-product" method="POST" enctype="multipart/form-data" class="productForm">
				<br><br>
				<input type="text" name="name" placeholder="Nome" autofocus required/>
				<br><br>
				<input type="text" name="manufacturer" placeholder="Casa produttrice" autofocus required/>
				<br><br>
				<input list="categories" name="category" id="category" placeholder="Categoria" autofocus required>
				<datalist id="categories">
					<c:forEach var="cat" items="${categories}">
					 	<option value="${cat.categoryName}"/>
					</c:forEach>
				</datalist>
				<br><br>
				<input type="number" name="price" placeholder="Prezzo" step="any" min="1" autofocus required/>
				<br><br>
				<input type="number" name="discount" placeholder="% Sconto" min="0" max="100" autofocus required/>
				<br><br>
				<input type="number" name="iva" placeholder="IVA" min="0" max="100" autofocus required/>
				<br><br>
				<textarea name="description" rows="5" cols="48" placeholder="Aggiungi una descrizione del prodotto..." autofocus required></textarea>
				<br><br>
				<input type="number" name="quantity" placeholder="Quantità" min="1" autofocus required/>
				<br><br>
				<label>Immagine:</label>
				<input type="file" name="image" autofocus required/>
				<br><br>
				<input type="submit" value="Aggiungi al catalogo">
			</form>
		</div>
	</div>

<%@ include file="/WEB-INF/views/admin/fragments/footer.jsp" %>
