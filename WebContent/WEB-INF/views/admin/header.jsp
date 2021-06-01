<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
		<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
		<!-- APP CSS -->
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/dashboard.css">
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
						<i class='bx bx-shopping-bag'></i>
                   		<span>Vendite</span>
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
					<a href="#" <c:if test="${fn:endsWith(currentURL, '/admin/add-product')}">id="open"</c:if> class="sidebar-menu-dropdown">
						<i class='bx bx-category'></i>
						<span>E-commerce</span>
						<span class="dropdown-icon"></span>
					</a>
					<ul class="sidebar-menu sidebar-menu-dropdown-content">
						<li>
							<a href="#">
								Lista prodotti
							</a>
						</li>
						<li>
							<a href="${pageContext.request.contextPath}/admin/add-product" <c:if test="${fn:endsWith(currentURL, '/admin/add-product')}">class="active"</c:if>>
								Aggiungi prodotto
							</a>
						</li>
						<li>
							<a href="#">
								Aggiorna prodotto
							</a>
						</li>
						<li>
							<a href="#">
								Ordini
							</a>
						</li>
					</ul>
				</li>
				<li class="sidebar-submenu">
					<a href="#" class="sidebar-menu-dropdown">
						<i class='bx bx-cog'></i>
						<span>Impostazioni</span>
						<span class="dropdown-icon"></span>
					</a>
					<ul class="sidebar-menu sidebar-menu-dropdown-content">
						<li>
							<a href="#" class="darkmode-toggle" id="darkmode-toggle">
								Darkmode
								<span class="darkmode-switch"></span>
							</a>
						</li>
					</ul>
				</li>
			</ul>
			<!-- END SIDEBAR MENU-->
		</div>
		<!-- END SIDEBAR -->
				
			