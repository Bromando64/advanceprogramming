<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix ="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link rel="stylesheet" type="text/css" href="./Pages/CSS/scroll-body.css" />
    <link rel="stylesheet" type="text/css" href="./Pages/CSS/navbar.css">
    <link rel="stylesheet" type="text/css" href="./Pages/CSS/home.css" />
    <style type="text/css">
		    .no-style {
		    text-decoration: none;
		    color: inherit;
		}
    </style>
</head>

<body>
	<sql:setDataSource var="dbConnection" driver="com.mysql.cj.jdbc.Driver" 
	url = "jdbc:mysql://localhost:3306/coursework" user="root" password=""/>
	
	<sql:query var="products" dataSource="${dbConnection}">
    SELECT 
    	product.productID,
        product.product_name, 
        product.price, 
        GROUP_CONCAT(product_images.image_url) AS urls 
    FROM product 
    JOIN product_images ON product.productId = product_images.productId 
    WHERE product.productId IN (1, 15, 6, 8) 
    GROUP BY product.productId
</sql:query>
    <header>
        <div class="logo">FashionHub</div>
        <nav>
            <a href="#">Home</a>
            <a href="#">Men</a>
            <a href="#">Women</a>
        </nav>
        <div class="right-container">
            <div class="search-container">
                <input type="text" class="search-input" placeholder="Search">
                <button class="search-btn"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 512 512" id="search">
                        <path d="M448.3 424.7L335 311.3c20.8-26 33.3-59.1 33.3-95.1 0-84.1-68.1-152.2-152-152.2-84 0-152 68.2-152 152.2s68.1 152.2 152 152.2c36.2 0 69.4-12.7 95.5-33.8L425 448l23.3-23.3zM120.1 312.6c-25.7-25.7-39.8-59.9-39.8-96.3s14.2-70.6 39.8-96.3 59.9-40 96.2-40c36.3 0 70.5 14.2 96.2 39.9s39.8 59.9 39.8 96.3-14.2 70.6-39.8 96.3c-25.7 25.7-59.9 39.9-96.2 39.9-36.3.1-70.5-14.1-96.2-39.8z">
                        </path>
                    </svg></button>
            </div>
            <button class="cart-btn">Go to Cart</button>
        </div>
    </header>
    <div class="banner">
        <div class="banner-slider">
            <div class="banner-slide" style="background-image: url('./Pages/banner/banner1.jpg');"></div>
            <div class="banner-slide" style="background-image: url('./Pages/banner/banner2.jpg');"></div>
            <div class="banner-slide" style="background-image: url('./Pages/banner/banner3.jpg');"></div>
            <div class="banner-slide" style="background-image: url('./Pages/banner/banner4.jpg');"></div>
            <div class="banner-slide" style="background-image: url('./Pages/banner/banner5.jpg');"></div>
        </div>
        <div class="banner-text-container">
            <h1>Discover the Latest Trends</h1>
        </div>
    </div>
    <p class="section-title">New Arrivals</p>
    <div class="products">
    <c:forEach var="product" items="${products.rows}">
    <a href="./Pages/individual.jsp?product_id=${product.productID}" class="no-style">
        <div class="product">
            <div class="product-image-wrapper">
            	<c:set var="imageUrls" value="${fn:split(product.urls, ',')}" />
                <img class="product-img" src="http://localhost:7070/images/${imageUrls[0]}" alt="Product">
            <c:if test="${not empty imageUrls[1]}">
                <img class="product-img-hover" src="http://localhost:7070/images/${imageUrls[1]}" alt="Product Hover">
            </c:if>
            </div>
            <h2 class="no-style">${product.product_name}</h2>
            <p class="no-style">Rs.${product.price}</p>
        </div>
    </a>
    </c:forEach>
    </div>
    <footer>
        &copy; 2023 FashionHub. All rights reserved.
    </footer>
    <script src="./HTML/JS/home.js"></script>
</body>

</html>