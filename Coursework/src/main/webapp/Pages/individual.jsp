<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Detail</title>
    <link rel="stylesheet" href="./CSS/individual.css">
    <link rel="stylesheet" href="./CSS/navbar.css">
    <link rel="stylesheet" href="./CSS/scroll-body.css">
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
                <button class="search-btn"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20"
                        viewBox="0 0 512 512" id="search">
                        <path
                            d="M448.3 424.7L335 311.3c20.8-26 33.3-59.1 33.3-95.1 0-84.1-68.1-152.2-152-152.2-84 0-152 68.2-152 152.2s68.1 152.2 152 152.2c36.2 0 69.4-12.7 95.5-33.8L425 448l23.3-23.3zM120.1 312.6c-25.7-25.7-39.8-59.9-39.8-96.3s14.2-70.6 39.8-96.3 59.9-40 96.2-40c36.3 0 70.5 14.2 96.2 39.9s39.8 59.9 39.8 96.3-14.2 70.6-39.8 96.3c-25.7 25.7-59.9 39.9-96.2 39.9-36.3.1-70.5-14.1-96.2-39.8z">
                        </path>
                    </svg></button>
            </div>
            <button class="cart-btn">Go to Cart</button>
        </div>
    </header>

    <main>
        <div class="product-page-container">

            <div class="side-images">
                <img src="./products/Product_F 8/Product_F_8_1.jpg" alt="Product Image 1" class="side-image">
                <img src="./products/Product_F 8/Product_F_8_2.jpg" alt="Product Image 2" class="side-image">
                <img src="./products/Product_F 8/Product_F_8_3.jpg" alt="Product Image 3" class="side-image">
                <img src="./products/Product_F 8/Product_F_8_4.jpg" alt="Product Image 4" class="side-image">
            </div>
            <div class="center-image">
                <img src="./products/Product_F 8/Product_F_8_1.jpg" alt="Main Product Image" id="main-image">
            </div>
            <div class="product-info">
                <h1>Product Name</h1>
                <p>Product Description</p>
                <div class="price">$49.99</div>
                <button class="add-to-cart">Add to Cart</button>
            </div>

        </div>
    </main>

    <footer>
        &copy; 2023 FashionHub. All rights reserved.
    </footer>
    <script src="./JS/individual.js"></script>
</body>

</html>