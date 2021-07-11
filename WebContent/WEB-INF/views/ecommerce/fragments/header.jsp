<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                          		<li><a href="${pageContext.request.contextPath}/my-account"><i class="bx bx-user-circle"></i></a></li>
							<li><a href="${pageContext.request.contextPath}/logout"><i class='bx bx-log-out'></i></a></li>
						</c:otherwise>
					</c:choose>
                    <li>
                    	<a href="${pageContext.request.contextPath}/cart"><i class="bx bx-cart"></i></a>
            	        <div class="cart-quantity">
                   			<span class="cart-quantity-number">
                   				<c:choose>
	                    			<c:when test="${cart != null}">
	                    				${cart.getProducts().size()}
	                    			</c:when>
	                    			<c:otherwise>
	                    				0
	                    			</c:otherwise>
	                    		</c:choose>
                   			</span>
                   		</div>
                    </li>
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
                        <a href="${pageContext.request.contextPath}" class="logo">Phonetastic</a>
                        <div class="search">
                        	<form action="${pageContext.request.contextPath}/search" method="GET" autocomplete="off">
	                        	<input type="text" name="keyword" id="searchText" placeholder="Cerca">
	                       		<button type="submit">
	                       			<i class="bx bx-search-alt"></i>
	                       		</button>
                        	</form>
                            <div class="suggestions-box">
                                <ul class="suggestions">
									<!-- SEARCH RESULTS WILL BE ADDED HERE -->
								</ul>
                            </div>
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
                            		<li><a href="${pageContext.request.contextPath}/my-account"><i class="bx bx-user-circle"></i></a></li>
									<li><a href="${pageContext.request.contextPath}/logout"><i class='bx bx-log-out'></i></a></li>
								</c:otherwise>
							</c:choose>
                            <li>
                            	<a href="${pageContext.request.contextPath}/cart"><i class="bx bx-cart"></i></a>
	                    		<div class="cart-quantity">
	                    			<span class="cart-quantity-number">
	                    				<c:choose>
			                    			<c:when test="${cart != null}">
			                    				${cart.getProducts().size()}
			                    			</c:when>
			                    			<c:otherwise>
			                    				0
			                    			</c:otherwise>
			                    		</c:choose>
	                    			</span>
	                    		</div>
                            </li>
                        </ul>
                    </div>
                </div>
                <!-- END TOP HEADER-->

                <!-- NAVBAR -->
                <div class="navbar-background">
                    <div class="bottom-header container">
                        <!-- REMEMBER TO MODIFY THE HREFS -->
                        <nav>
                            <ul>
                                <li><a href="${pageContext.request.contextPath}">Home</a></li>
    
                                <!-- CATEGORY MENU -->
                                <li class="dropdown">
                                    <a href="${pageContext.request.contextPath}/catalog">Prodotti <i class="bx bxs-chevron-down"></i></a>
                                    <div class="dropdown-content">
                                        <section class="category-grid">
                                            <div class="category-grid-item">
                                                <h3><a href="${pageContext.request.contextPath}/catalog?category=Smartphone">Smartphone</a></h3>
                                                <ul>
                                                    <li><a href="${pageContext.request.contextPath}/catalog?category=Smartphone&manufacturer=Xiaomi">Xiaomi</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/catalog?category=Smartphone&manufacturer=Apple">Apple</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/catalog?category=Smartphone&manufacturer=Huawei">Huawei</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/catalog?category=Smartphone&manufacturer=Oneplus">Oneplus</a></li>
                                                </ul>
                                            </div>
                                               <div class="category-grid-item">
                                                <h3><a href="${pageContext.request.contextPath}/catalog?category=Smartwatch">Smartwatch</a></h3>
                                                <ul>
                                                    <li><a href="${pageContext.request.contextPath}/catalog?category=Smartwatch&manufacturer=Apple">Apple</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/catalog?category=Smartwatch&manufacturer=Samsung">Samsung</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/catalog?category=Smartwatch&manufacturer=Xiaomi">Xiaomi</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/catalog?category=Smartwatch&manufacturer=Huawei">Huawei</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/catalog?category=Smartwatch&manufacturer=Asus">Asus</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/catalog?category=Smartwatch&manufacturer=Amazfit">Amazfit</a></li>
                                                </ul>
                                            </div>
                                            <div class="category-grid-item">
                                                <h3><a href="${pageContext.request.contextPath}/catalog?category=Accessori">Accessori</a></h3>
                                                <ul>
                                                    <li><a href="${pageContext.request.contextPath}/catalog?category=Auricolari">Auricolari</a></li>
                                                    <li><a href="${pageContext.request.contextPath}/catalog?category=Cover">Cover</a></li>
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
        
