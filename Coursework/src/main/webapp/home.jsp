<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix ="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page import="controller.statemanagement.SessionManage"%>

<%! SessionManage mySession = new SessionManage(); %>
<% String mainPath = request.getContextPath(); %>
<% String email = (String) session.getAttribute("email");%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Pages/CSS/scroll-body.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Pages/CSS/navbar.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Pages/CSS/home.css" />
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
        product.category,
        GROUP_CONCAT(product_images.image_url) AS urls 
    FROM product 
    JOIN product_images ON product.productId = product_images.productId 
    WHERE product.productId IN (1, 15, 6, 8) 
    GROUP BY product.productId
	</sql:query>
    <header>
        <div class="logo">FashionHub</div>
        <nav>
            <a href="${pageContext.request.contextPath}/home.jsp">Home</a>
            <a href="${pageContext.request.contextPath}/Pages/product_list.jsp?category=Men">Men</a>
            <a href="${pageContext.request.contextPath}/Pages/product_list.jsp?category=Women">Women</a>
            <a href="${pageContext.request.contextPath}/Pages/product_list.jsp">All Products</a>
        </nav>
        <div class="right-container">
            <div class="search-container">
                <form action="${pageContext.request.contextPath}/ProductFilterServlet" method="get">
            	<input type="hidden" name="category" value="${category}">
                <input type="text" class="search-input" placeholder="Search" name="search">
                <button type="submit" class="search-btn"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                        viewBox="0 0 512 512" id="search">
                        <path d="M448.3 424.7L335 311.3c20.8-26 33.3-59.1 33.3-95.1 0-84.1-68.1-152.2-152-152.2-84 0-152 68.2-152 152.2s68.1 152.2 152 152.2c36.2 0 69.4-12.7 95.5-33.8L425 448l23.3-23.3zM120.1 312.6c-25.7-25.7-39.8-59.9-39.8-96.3s14.2-70.6 39.8-96.3 59.9-40 96.2-40c36.3 0 70.5 14.2 96.2 39.9s39.8 59.9 39.8 96.3-14.2 70.6-39.8 96.3c-25.7 25.7-59.9 39.9-96.2 39.9-36.3.1-70.5-14.1-96.2-39.8z"></path>
                    </svg></button>
                </form>
            </div>
            <%if(mySession.checkUser(email)){%>
        		<a href="${pageContext.request.contextPath}/Pages/cart_page.jsp"><button class="cart-btn">Go to Cart</button></a>
    		<%}%>
   	    	<form action="
    				<%if(!mySession.checkUser(email)){
    					out.print(mainPath);%>/login.jsp<%
   					} 
    				else { 
    					out.print(mainPath);%>/LogoutServlet<%
   					}%>"
	    		method="post">
	  			<input class="cart-btn" type="submit" value="<%if(mySession.checkUser(email)){%> Logout <%}else{%> Login <%}%>"/>
	    	</form>
        </div>
    </header>
    <div class="banner">
        <div class="banner-slider">
            <div class="banner-slide" style="background-image: url('${pageContext.request.contextPath}/Pages/banner/banner1.jpg');"></div>
            <div class="banner-slide" style="background-image: url('${pageContext.request.contextPath}/Pages/banner/banner2.jpg');"></div>
            <div class="banner-slide" style="background-image: url('${pageContext.request.contextPath}/Pages/banner/banner3.jpg');"></div>
            <div class="banner-slide" style="background-image: url('${pageContext.request.contextPath}/Pages/banner/banner4.jpg');"></div>
            <div class="banner-slide" style="background-image: url('${pageContext.request.contextPath}/Pages/banner/banner5.jpg');"></div>
        </div>
        <div class="banner-text-container">
            <h1>Discover the Latest Trends</h1>
        </div>
    </div>
    <p class="section-title">Our New Arrivals...</p>
    <div class="products">
    <c:forEach var="product" items="${products.rows}">
    <a href="${pageContext.request.contextPath}/Pages/individual.jsp?product_id=${product.productID}" class="no-style">
        <div class="product">
            <div class="product-image-wrapper">
            	<c:set var="imageUrls" value="${fn:split(product.urls, ',')}" />
                <img class="product-img" src="http://localhost:7070/images/${imageUrls[0]}" alt="Product">
            <c:if test="${not empty imageUrls[1]}">
                <img class="product-img-hover" src="http://localhost:7070/images/${imageUrls[1]}" alt="Product Hover">
            </c:if>
            </div>
            <h3 style="font-family: Times New Roman; class="no-style">${product.product_name}</h3>
            <h3 style="font-family: Times New Roman; class="no-style">Rs.${product.price}</h3>
        </div>
    </a>
    </c:forEach>
    </div>
    <footer>
        &copy; 2023 FashionHub. All rights reserved.
    </footer>
    <script src="${pageContext.request.contextPath}/Pages/JS/home.js"></script>
</body>

</html>