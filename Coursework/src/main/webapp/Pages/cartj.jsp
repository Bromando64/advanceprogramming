<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<!-- This is a title for the page -->
<title>Your Cart</title>

<!--Linking the CSS file-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/Pages/CSS/cartnav.css">

</head>

<!-- body section contains  -->
<body>

	<!-- header section contains a Logo and navigation bar -->
	<header>
        <div class="logo">FashionHub</div>
        
        <!-- This is a navigation bar for different pages -->
        <nav>
            <a href="#">Home</a>
            <a href="#">Men</a>
            <a href="#">Women</a>
        </nav>
        
        
        <div class="right-container">
            <div class="search-container">
                <input type="text" class="search-input" placeholder="Search">
                
                <button class="search-btn">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 512 512" id="search">
                        <path
                            d="M448.3 424.7L335 311.3c20.8-26 33.3-59.1 33.3-95.1 0-84.1-68.1-152.2-152-152.2-84 0-152 68.2-152 152.2s68.1 152.2 152 152.2c36.2 0 69.4-12.7 95.5-33.8L425 448l23.3-23.3zM120.1 312.6c-25.7-25.7-39.8-59.9-39.8-96.3s14.2-70.6 39.8-96.3 59.9-40 96.2-40c36.3 0 70.5 14.2 96.2 39.9s39.8 59.9 39.8 96.3-14.2 70.6-39.8 96.3c-25.7 25.7-59.9 39.9-96.2 39.9-36.3.1-70.5-14.1-96.2-39.8z">
                        </path>
                </svg>
                </button>
            
            <!-- displayes shopping cart icon -->
            </div>
            	<img src="${pageContext.request.contextPath}/Pages/banner/cart.png" width="36" height="32"/>
        	</div>
        
    </header>
    
    <!-- displayes message about discount -->
    <div class="move"> <marquee direction="right" width="320px" > <h4>Buy 5 Products..And Get $2 off!</h4>  </marquee> </div>
    
    <!-- br tag forces the line to break -->
	<br>
	<br>
	<br>
	<br>
	<br>


	<!-- button is displayed with a hover effect that takes user to products page when clicked -->
	<div class = "cart_section">
		<h2> There are no items in this cart. </h2>
		<button class="btn-hover">"Shop vintage"!</button>
	</div>

	<!-- This is a footer section -->
	<footer>
        &copy; 2023 FashionHub. All rights reserved.
    </footer>
  
</body>
</html>