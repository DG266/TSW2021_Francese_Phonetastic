<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
    <head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Dashboard</title>
		<!-- Icona scheda (da mettere) -->
		<link rel="shortcut icon" href="" type="image/png">
		<!-- BOXICONS -->
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/boxicons.min.css">
		<!-- APP CSS -->
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/admin.css">
		<!-- FONT GOOGLE -->
		<link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,900&display=swap" rel="stylesheet">
    </head>
    <body>
        
		<!-- SIDEBAR -->
		<div class ="sidebar">
			<div class="sidebar-logo">
				<a href="${pageContext.request.contextPath}/catalog">
					<img src="${pageContext.request.contextPath}/resources/images/LogoImage/logo.png" alt="Logo sito">
				</a>
				<div class="sidebar-close" id="sidebar-close">
					<i class="bx bx-left-arrow-alt"></i>
				</div>
			</div>
			<div class="sidebar-user">
				<div class="sidebar-user-info">
					<img src="" alt="Foto profilo" class="profile-image">
					<div class="sidebar-user-name">
						Ciao, ${currentSessionUser.firstName}
					</div>
				</div>
				<form action="${pageContext.request.contextPath}/logout">
					<button class="btn btn-outline" type="submit">
						<i class="bx bx-log-out bx-flip-horizontal"></i>
					</button>
				</form>
			</div>
			<!-- SIDEBAR MENU -->
			<c:set var = "currentURL" value = "${requestScope['javax.servlet.forward.request_uri']}"/>
			<ul class="sidebar-menu">
				<li>
					<a href="${pageContext.request.contextPath}/admin" <c:if test="${fn:endsWith(currentURL, '/admin')}">class="active"</c:if>>
						<i class='bx bx-home'></i>
                   		<span>Dashboard</span>
					</a>
				</li>
				<li>
					<a href="#">
						<i class='bx bx-chart'></i>
                   		<span>Statistiche</span>
					</a>
				</li>
				<li class="sidebar-submenu">
					<a href="#" class="sidebar-menu-dropdown">
						<i class='bx bx-user-circle'></i>
                   		<span>Utenti</span>
						<span class="dropdown-icon"></span>
					</a>
					<ul class="sidebar-menu sidebar-menu-dropdown-content">
						<li>
							<a href="#">
								Opzione 1
							</a>
						</li>
						<li>
							<a href="#">
								Opzione 2
							</a>
						</li>
						<li>
							<a href="#">
								Opzione 3
							</a>
						</li>
					</ul>
				</li>
				<li class="sidebar-submenu">
					<a href="#" <c:if test="${fn:endsWith(currentURL, '/admin/add-product') || fn:endsWith(currentURL, '/admin/products') || fn:contains(currentURL, '/admin/update-product')}">id="open"</c:if> class="sidebar-menu-dropdown">
						<i class='bx bx-category'></i>
						<span>Catalogo</span>
						<span class="dropdown-icon"></span>
					</a>
					<ul class="sidebar-menu sidebar-menu-dropdown-content">
						<li>
							<a href="${pageContext.request.contextPath}/admin/products" <c:if test="${fn:endsWith(currentURL, '/admin/products')}">class="active"</c:if>>
								Lista prodotti
							</a>
						</li>
						<li>
							<a href="${pageContext.request.contextPath}/admin/add-product" <c:if test="${fn:endsWith(currentURL, '/admin/add-product')}">class="active"</c:if>>
								Aggiungi prodotto
							</a>
						</li>
						<li>
							<a href="${pageContext.request.contextPath}/admin/update-product" <c:if test="${fn:contains(currentURL, '/admin/update-product')}">class="active"</c:if>>
								Aggiorna prodotto
							</a>
						</li>
					</ul>
				</li>
				<li class="sidebar-submenu">
					<a href="#" <c:if test="${fn:endsWith(currentURL, '/admin/orders')}">id="open"</c:if> class="sidebar-menu-dropdown">
						<i class='bx bx-notepad'></i>
						<span>Ordini</span>
						<span class="dropdown-icon"></span>
					</a>
					<ul class="sidebar-menu sidebar-menu-dropdown-content">
						<li>
							<a href="${pageContext.request.contextPath}/admin/orders" <c:if test="${fn:endsWith(currentURL, '/admin/orders')}">class="active"</c:if>>
								Visualizza ordini
							</a>
						</li>
					</ul>
				</li>
				<li>
					<a href="#">
						<i class='bx bx-help-circle'></i>
                   		<span>Aiuto</span>
					</a>
				</li>
			</ul>
			<!-- END SIDEBAR MENU-->
		</div>
		<!-- END SIDEBAR -->
				
			