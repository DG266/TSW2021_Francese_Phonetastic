<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
    <head>
    	<meta charset="UTF-8">
    	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    	<title>Phonetastic</title>
		<!-- Icona scheda (da mettere) -->
		<link rel="shortcut icon" href="" type="image/png">
        <!-- BOXICONS -->
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/boxicons.min.css">
		
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/ecommerce-grid.css">
		
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/ecommerce.css">
        
        <!-- FONT GOOGLE -->
		<link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,900&display=swap" rel="stylesheet">
				
    </head>
	<body>
        <header>
            <!-- MENU MOBILE -->
            <div class="mobile-menu">
                <span class="mobile-menu-toggle" id="open">
                    <i class="bx bx-menu"></i>
                </span>
                <a href="${pageContext.request.contextPath}/catalog" class="mobile-logo">Phonetastic</a>
                <ul class="user-menu">
                	<c:if test="${currentSessionUser != null && currentSessionUser.isAdmin()}">
						<li><a href="${pageContext.request.contextPath}/admin"><i class="bx bxs-crown"></i></a></li>
					</c:if>
                    <c:choose>
						<c:when test="${currentSessionUser == null || !currentSessionUser.valid}">
							<li><a href="${pageContext.request.contextPath}/login"><i class='bx bx-log-in'></i></a></li>
						</c:when>
						<c:otherwise>
                          		<li><a href="${pageContext.request.contextPath}/my-orders"><i class="bx bx-user-circle"></i></a></li>
							<li><a href="${pageContext.request.contextPath}/logout"><i class='bx bx-log-out'></i></a></li>
						</c:otherwise>
					</c:choose>
                    <li><a href="${pageContext.request.contextPath}/cart"><i class="bx bx-cart"></i></a></li>
                </ul>
            </div>
            <!-- END MENU MOBILE -->

            <div class="header-wrapper" id="header-wrapper">
                <span class="mobile-menu-toggle mobile-menu-close" id="close">
                    <i class="bx bx-x"></i>
                </span>

                <!-- TOP HEADER -->
                <div class="header-background">
                    <div class="top-header container">
                        <a href="${pageContext.request.contextPath}/catalog" class="logo">Phonetastic</a>
                        <div class="search">
                            <input type="text" placeholder="Cerca">
                            <i class="bx bx-search-alt"></i>
                        </div>
                        <ul class="user-menu">
                        	<c:if test="${currentSessionUser != null && currentSessionUser.isAdmin()}">
								<li><a href="${pageContext.request.contextPath}/admin"><i class="bx bxs-crown"></i></a></li>
							</c:if>
		                   	<c:choose>
								<c:when test="${currentSessionUser == null || !currentSessionUser.valid}">
									<li><a href="${pageContext.request.contextPath}/login"><i class='bx bx-log-in'></i></a></li>
								</c:when>
								<c:otherwise>
                            		<li><a href="${pageContext.request.contextPath}/my-orders"><i class="bx bx-user-circle"></i></a></li>
									<li><a href="${pageContext.request.contextPath}/logout"><i class='bx bx-log-out'></i></a></li>
								</c:otherwise>
							</c:choose>
                            <li><a href="${pageContext.request.contextPath}/cart"><i class="bx bx-cart"></i></a></li>
                        </ul>
                    </div>
                </div>
                <!-- END TOP HEADER-->

                <!-- NAVBAR -->
                <div class="navbar-background">
                    <div class="bottom-header container">
                        <nav>
                            <ul>
                                <li><a href="${pageContext.request.contextPath}/catalog">Home</a></li>
    
                                <!-- CATEGORY MENU -->
                                <li class="dropdown">
                                    <a href="./products.html">Prodotti <i class="bx bxs-chevron-down"></i></a>
                                    <div class="dropdown-content">
                                        <section class="category-grid">
                                            <div class="category-grid-item">
                                                <h3>Smartphone</h3>
                                                <ul>
                                                    <li><a href="#">Xiaomi</a></li>
                                                    <li><a href="#">Apple</a></li>
                                                    <li><a href="#">Huawei</a></li>
                                                    <li><a href="#">Oneplus</a></li>
                                                </ul>
                                            </div>
                                               <div class="category-grid-item">
                                                <h3>Smartwatch</h3>
                                                <ul>
                                                    <li><a href="#">Apple</a></li>
                                                    <li><a href="#">Samsung</a></li>
                                                    <li><a href="#">Xiaomi</a></li>
                                                    <li><a href="#">Huawei</a></li>
                                                    <li><a href="#">Asus</a></li>
                                                    <li><a href="#">Amazfit</a></li>
                                                </ul>
                                            </div>
                                            <div class="category-grid-item">
                                                <h3>Accessori</h3>
                                                <ul>
                                                    <li><a href="#">Auricolari</a></li>
                                                    <li><a href="#">Cover</a></li>
                                                </ul>
                                            </div>
                                        </section>
                                    </div>
                                </li>
                                 <!-- END CATEGORY MENU -->
    
                                <li><a href="#">Offerte</a></li>
                            </ul>
                        </nav>
                    </div>
                </div>
                <!-- END NAVBAR-->
            </div>
        </header>
        
