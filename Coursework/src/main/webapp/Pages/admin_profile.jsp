<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix ="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Panel</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Pages/CSS/admin_profile.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Pages/CSS/navbar-admin.css" />
</head>
<body>
	<sql:setDataSource var="dbConnection" driver="com.mysql.cj.jdbc.Driver" 
    url = "jdbc:mysql://localhost:3306/coursework" user="root" password=""/>
    <sql:query var="users" dataSource="${dbConnection}">
    	SELECT userID, first_name, last_name
    	FROM user
    </sql:query>
    <sql:query var="products" dataSource="${dbConnection}">
    	SELECT product.productID, product.product_name, product.price, product.brand, product.quantity, product.category, product.sold, product_images.image_url
    	FROM product
    	JOIN product_images ON product_images.productID = product.productID
    	ORDER BY product.productID
</sql:query>
    <header>
        <div class="logo">FashionHub</div>
        <nav>
            ADMIN PANEL
        </nav>
        <div class="right-container">
            <button class="logout-btn">Log Out</button>
        </div>
    </header>
    <main>
    <h2>ADMIN PANEL</h2>
		
    <div id="addProduct">
        <h3>Add Product</h3>
        <form action="${pageContext.request.contextPath}/AddProductServlet" method="post" enctype="multipart/form-data">
            <label for="productName">Product Name:</label>
            <input type="text" id="productName" name="productName">
            <label for="Price">Price:</label>
            <input type="text" id="Price" name="price">
            <label for="Brand">Brand:</label>
            <input type="text" id="Brand" name="brand">
            <label for="Quantity">Quantity:</label>
            <input type="text" id="Quantity" name="quantity">
            <label for="Quantity">Sold:</label>
            <input type="text" id="Sold" name="sold">
            <label for="Category">Category:</label>
            <input type="text" id="Category" name="category">
            <label for="Category">Product Image:</label>
            <input type="file" id="Product Image" name="image">
            <input type="submit" value="Add Product">
        </form>
    </div>
    <div class="tab">
            <button class="tablinks" onclick="openTab(event, 'productList')" id="defaultOpen">Product List</button>
            <button class="tablinks" onclick="openTab(event, 'orderList')">Order List</button>
    </div>
                    
<div id="productList" class="tabcontent">
    <h3>Product List</h3>

    <c:set var="prevProductID" value="-1" />

<c:forEach var="product" items="${products.rows}">
    <c:if test="${prevProductID ne product.productID}">
        <c:set var="prevProductID" value="${product.productID}" />

        <table id="productTable${product.productID}">
            <thead>
                <tr>
                    <th>Product Name</th>
                    <th>Price</th>
                    <th>Brand</th>
                    <th>Quantity</th>
                    <th>Category</th>
                    <th>Sold</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>${product.product_name}</td>
                    <td>${product.price}</td>
                    <td>${product.brand}</td>
                    <td>${product.quantity}</td>
                    <td>${product.category}</td>
                    <td>${product.sold}</td>
                </tr>
            </tbody>
        </table>
    </c:if>

    <table id="productImageTable${product.productID}">
        <thead>
            <tr>
                <th>Product Image</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <c:forEach var="productImage" items="${product.image_url}" varStatus="loop">
                    <c:if test="${loop.index % 4 == 1}">
                        </tr><tr>
                    </c:if>
                    <td><img src="http://localhost:7070/images/${productImage}" width="100" height="130"></td>
                    <c:if test="${loop.last && loop.index % 4 != 0}">
                        <c:forEach var="i" begin="0" end="${4 - loop.index % 4}">
                            <td></td>
                        </c:forEach>
                    </c:if>
                </c:forEach>
            </tr>
        </tbody>
    </table>
</c:forEach>
</div>

    <div id="orderList" class="tabcontent">
        <h3>Order List</h3>
        <c:forEach var="user" items="${users.rows}">
        	<p><b>User Name:</b> ${user.first_name} ${user.last_name}</p>
        	<sql:query var="orders" dataSource="${dbConnection}">
        		SELECT ordered.orderID, product.product_name, product.price, product.brand, orderedproduct.quantity, product.category, user.email, user.userID 
        		FROM ordered 
        		JOIN orderedproduct ON ordered.orderID = orderedproduct.orderID 
        		JOIN user ON ordered.userID = user.userID 
        		JOIN product ON orderedproduct.productID = product.productID 
        
        		WHERE ordered.userID = ?
        		<sql:param value="${user.userID}" />
    		</sql:query>
        	<table id="orderTable">
            	<thead>
                	<tr>
                		<th>Email</th>
                    	<th>Product Name</th>
                    	<th>Price</th>
                    	<th>Brand</th>
                    	<th>Quantity</th>
                    	<th>Category</th>
                	</tr>
            	</thead>
            	<tbody>
                	<c:forEach var="order" items="${orders.rows}">
                        	<tr>
                        		<td>${order.email}</td>
	                            <td>${order.product_name}</td>
	                            <td>${order.price}</td>
	                            <td>${order.brand}</td>
	                            <td>${order.quantity}</td>
	                            <td>${order.category}</td>
                        	</tr>
                	</c:forEach>
            	</tbody>
        	</table>
        </c:forEach>
    </div>
    </main>
    <footer>

    </footer>
    <script>
        function openTab(evt, tabName) {
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("tabcontent");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tablinks");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }
            document.getElementById(tabName).style.display = "block";
            evt.currentTarget.className += " active";
        }
        document.getElementById("defaultOpen").click();
    </script>
    
</body>
</html>