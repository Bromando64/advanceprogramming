<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="./HTML/CSS/scroll-body.css" />
    <link rel="stylesheet" href="./HTML/CSS/navbar.css">
    <link rel="stylesheet" href="./HTML/CSS/home.css" />
</head>

<body>
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
            <button class="cart-btn">Add to Cart</button>
        </div>
    </header>
    <div class="banner">
        <div class="banner-slider">
            <div class="banner-slide" style="background-image: url('./HTML/banner/banner1.jpg');"></div>
            <div class="banner-slide" style="background-image: url('./HTML/banner/banner2.jpg');"></div>
            <div class="banner-slide" style="background-image: url('./HTML/banner/banner3.jpg');"></div>
            <div class="banner-slide" style="background-image: url('./HTML/banner/banner4.jpg');"></div>
            <div class="banner-slide" style="background-image: url('./HTML/banner/banner5.jpg');"></div>
        </div>
        <div class="banner-text-container">
            <h1>Discover the Latest Trends</h1>
        </div>
    </div>
    <p class="section-title">New Arrivals</p>
    <div class="products">
        <div class="product">
            <div class="product-image-wrapper">
                <img class="product-img" src="./HTML/products/Product_F 1/Product_F_1_1.jpg" alt="Product 1">
                <img class="product-img-hover" src="./HTML/products/Product_F 1/Product_F_1_2.jpg" alt="Product 1 Hover">
            </div>
            <h2>Product Name 1</h2>
            <p>$49.99</p>
        </div>
        <div class="product">
            <div class="product-image-wrapper">
                <img class="product-img" src="./HTML/products/Product_M 3/Product_M_3_1.jpg" alt="Product 1">
                <img class="product-img-hover" src="./HTML/products/Product_M 3/Product_M_3_2.jpg" alt="Product 1 Hover">
            </div>
            <h2>Product Name 2</h2>
            <p>$49.99</p>
        </div>
        <div class="product">
            <div class="product-image-wrapper">
                <img class="product-img" src="./HTML/products/Product_F 6/Product_F_6_1.jpg" alt="Product 1">
                <img class="product-img-hover" src="./HTML/products/Product_F 6/Product_F_6_2.jpg" alt="Product 1 Hover">
            </div>
            <h2>Product Name 3</h2>
            <p>$49.99</p>
        </div>
        <div class="product">
            <div class="product-image-wrapper">
                <img class="product-img" src="./HTML/products/Product_F 8/Product_F_8_1.jpg" alt="Product 1">
                <img class="product-img-hover" src="./HTML/products/Product_F 8/Product_F_8_2.jpg" alt="Product 1 Hover">
            </div>
            <h2>Product Name 4</h2>
            <p>$49.99</p>
        </div>
    </div>
    <footer>
        &copy; 2023 FashionHub. All rights reserved.
    </footer>
    <script src="./HTML/JS/home.js"></script>
</body>

</html>