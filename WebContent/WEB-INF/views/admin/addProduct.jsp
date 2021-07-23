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
				<label for="product-name">Nome</label> <br>
				<input type="text" id="product-name" name="name" placeholder="Nome" autofocus required/>
				<br><br>
				<label for="product-manufacturer">Casa produttrice</label> <br>
				<input type="text" id="product-manufacturer" name="manufacturer" placeholder="Casa produttrice" autofocus required/>
				<br><br>
				<label for="category">Categoria</label> <br>
				<input list="categories" name="category" id="category" placeholder="Categoria" autofocus required>
				<datalist id="categories">
					<c:forEach var="cat" items="${categories}">
					 	<option value="${cat.categoryName}"/>
					</c:forEach>
				</datalist>
				<br><br>
				<label for="product-price">Prezzo (&euro;)</label> <br>
				<input type="number" id="product-price" name="price" placeholder="Prezzo" step="any" min="1" autofocus required/>
				<br><br>
				<label for="product-discount">Sconto (%)</label> <br>
				<input type="number" id="product-discount" name="discount" placeholder="% Sconto" min="0" max="100" autofocus required/>
				<br><br>
				<label for="product-iva">IVA (%)</label> <br>
				<input type="number" id="product-iva" name="iva" placeholder="IVA" min="0" max="100" autofocus required/>
				<br><br>
				<label for="product-description">Descrizione</label> <br>
				<textarea name="description" id="product-description" rows="5" cols="48" placeholder="Aggiungi una descrizione del prodotto..." autofocus required></textarea>
				<br><br>
				<label for="product-quantity">Quantità</label> <br>
				<input type="number" id="product-quantity" name="quantity" placeholder="Quantità" min="1" autofocus required/>
				<br><br>
				<label>Immagine:</label>
				<input type="file" name="image" autofocus required/>
				<br><br>
				<input type="submit" value="Aggiungi al catalogo">
			</form>
		</div>
	</div>

<%@ include file="/WEB-INF/views/admin/fragments/footer.jsp" %>
