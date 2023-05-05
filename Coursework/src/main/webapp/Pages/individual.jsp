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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Detail</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Pages/CSS/individual.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Pages/CSS/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Pages/CSS/scroll-body.css">
</head>

<body>
	<c:set var="productID" value="${param.product_id}"/>
	
	<sql:setDataSource var="dbConnection" driver="com.mysql.cj.jdbc.Driver" 
	url = "jdbc:mysql://localhost:3306/coursework" user="root" password=""/>
	
	<sql:query var="productData" dataSource="${dbConnection}">
    SELECT 
    	product.productID,
        product.product_name, 
        product.price,
        product.brand,
        product.quantity,
        GROUP_CONCAT(product_images.image_url) AS urls
    FROM product 
    JOIN product_images ON product.productId = product_images.productId 
    WHERE product.productId = ?
    GROUP BY product.productId
    <sql:param value="${productID}" />
	</sql:query>
    <header>
        <div class="logo">FashionHub</div>
        <nav>
            <a href="${pageContext.request.contextPath}/home.jsp">Home</a>
            <a href="${pageContext.request.contextPath}/Pages/product_list.jsp?category=Men">Men</a>
            <a href="${pageContext.request.contextPath}/Pages/product_list.jsp?category=Women">Women</a>
            <a href="${pageContext.request.contextPath}/Pages/product_list.jsp">All Products</a>
            <%if(mySession.checkUser(email)){%>
        		<a href="${pageContext.request.contextPath}/Pages/user_profile.jsp">User Profile</a>
        	<%}%>
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

    <main>
    
        <div class="product-page-container">
        <c:set var="imageUrls" value="${fn:split(productData.rows[0].urls, ',')}" />
            <div class="side-images">
            	<c:forEach var="imageUrl" items="${imageUrls}">
            		<img src="http://localhost:7070/images/${imageUrl}" alt="Product Image 1" class="side-image">
                </c:forEach>
            </div>
            <div class="center-image">
                <img src="http://localhost:7070/images/${imageUrls[0]}" alt="Main Product Image" id="main-image">
            </div>
            <div class="product-info">
				<h1>${productData.rows[0].product_name}</h1>
                <p class="brand">Brand: ${productData.rows[0].brand }</p>
                <p class="quantity">Quantity: ${productData.rows[0].quantity}</p>
                <div class="price">Rs.${productData.rows[0].price}</div>
                <form action="${pageContext.request.contextPath}/AddToCartServlet" method="POST" class="add-to-cart-form">
					    <input type="hidden" name="productID" value="${productData.rows[0].productID}">
					    <input type="hidden" name="quantity" value="1" />
					    <button type="submit" class="add-to-cart">Add to Cart</button>
				</form>
            </div>
        </div>
    </main>

    <footer>
        &copy; 2023 FashionHub. All rights reserved.
    </footer>
    <script src="${pageContext.request.contextPath}/Pages/JS/individual.js"></script>
</body>

</html>