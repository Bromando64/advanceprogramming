<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix ="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ page import="java.util.List" %>
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
    <title>Fashion | FashionHub</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Pages/CSS/scroll-body.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Pages/CSS/navbar.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Pages/CSS/product.css">
</head>

<body>
	<c:set var="category" value="${param.category}"/>
	<c:set var="sort" value="${param.sort}"/>
	<c:set var="popularity" value="popularity"/>
	<c:set var="price-asc" value="price-asc"/>
	<c:set var="price-desc" value="price-desc"/>
	<sql:setDataSource var="dbConnection" driver="com.mysql.cj.jdbc.Driver" 
	url = "jdbc:mysql://localhost:3306/coursework" user="root" password=""/>
	<sql:query var="products" dataSource="${dbConnection}">
	    SELECT 
	        product.productID,
	        product.product_name,
	        product.price,
	        product.brand,
	        product.quantity,
	        product.sold,
	        GROUP_CONCAT(product_images.image_url) AS urls 
	    FROM product 
	    JOIN product_images ON product.productId = product_images.productId	    
	    <% boolean isCategoryNotEmpty = request.getParameter("category") != null && !request.getParameter("category").isEmpty();
   		   boolean isSearchPerformed = request.getAttribute("searchPerformed") != null;
   		   boolean isProductIdsNotEmpty = request.getAttribute("productIds") != null && !((List)request.getAttribute("productIds")).isEmpty();
			if (isCategoryNotEmpty || (isSearchPerformed && isProductIdsNotEmpty)) { %>
	        WHERE
	        <% if(isCategoryNotEmpty) { %>
	        	product.category = ?
	    	<% } %>
	    	<% if (isCategoryNotEmpty && isSearchPerformed && isProductIdsNotEmpty) {%>
	    	AND 
	    	<%} %>
		    <% if (isSearchPerformed && isProductIdsNotEmpty) {%>
		    product.productID IN (<c:forEach var="id" items="${productIds}" varStatus="loop"><c:out value="${id}" /><c:if test="${not loop.last}">,</c:if></c:forEach>)
		    <% } %>
		<% } %>
	    GROUP BY product.productId
	    <c:choose>
	    	<c:when test="${sort == 'popularity'}">
	    		ORDER BY product.sold DESC
	    	</c:when>
	    	<c:when test="${sort == 'price-asc'}">
	    		ORDER BY product.price ASC
	    	</c:when>
	    	<c:when test="${sort == 'price-desc'}">
	    		ORDER BY product.price DESC
	    	</c:when>
	    </c:choose>
	    <c:if test="${not empty category}">
	        <sql:param value="${category}" />
	    </c:if>
	</sql:query>

<sql:query var="uniqueBrands" dataSource="${dbConnection}">
    SELECT DISTINCT brand FROM product
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
        		<button class="cart-btn">Go to Cart</button>
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
        <div class="filters">
            <h2>Filters</h2>
            <h3>Brand</h3>
            <form id="filterForm" action="${pageContext.request.contextPath}/ProductFilterServlet" method="GET">
            <div class="filter-options">
            <c:forEach var="brand" items="${uniqueBrands.rows}">
                <input type="checkbox" id="${brand.brand}" name="${brand.brand}" onchange="document.getElementById('filterForm').submit()">
                <label for="${brand.brand}">${brand.brand}</label><br>
            </c:forEach>
            </div>
            </form>
        </div>
        <div class="products-container">
        	<div class="sort-container">
        	<form id="sortForm" action="${pageContext.request.contextPath}/Pages/product_list.jsp" method="GET">
	       	    <input type="hidden" name="category" value="${category}">
            	<label for="sort">Sort by:</label>
            	<div class="select-container">
                	<select name="sort" id="sort" onchange="document.getElementById('sortForm').submit()">
	                    <option value="">---------</option>
	                    <option value="popularity">Popularity</option>
	                    <option value="price-asc" >Price: Low to High</option>
	                    <option value="price-desc">Price: High to Low</option>
                	</select>
            	</div>
            </form>
        	</div>

            <div class="products-grid">
            <c:forEach var="product" items="${products.rows}">
                <div class="product-card">
                	<a href="${pageContext.request.contextPath}/Pages/individual.jsp?product_id=${product.productID}">
                    <div class="image-container">
                    	<c:set var="imageUrls" value="${fn:split(product.urls, ',')}" />
                        <img src="http://localhost:7070/images/${imageUrls[0]}" alt="Product Image">
                        <c:if test="${not empty imageUrls[1]}">
                        	<img src="http://localhost:7070/images/${imageUrls[1]}" alt="Product Image" class="hover-image">
                        </c:if>
                    </div>
                    </a>
                    <h3>${product.product_name}</h3>
                    <p class="brand">Brand:${product.brand}</p>
                    <p class="quantity">Stock:${product.quantity}</p>
                    <div class="price">Rs.${product.price}</div>
                    <form action="${pageContext.request.contextPath}/AddToCartServlet" method="POST" class="add-to-cart-form">
					    <input type="hidden" name="productID" value="${product.productID}">
					    <input type="hidden" name="quantity" value="1" />
					    <button type="submit" class="add-to-cart">Add to Cart</button>
					</form>
                </div>
            </c:forEach>
            </div>
        </div>
    </main>
    <footer>
        &copy; 2023 FashionHub. All rights reserved.
    </footer>
</body>

</html>