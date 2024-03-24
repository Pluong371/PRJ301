
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no"
            />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Clowzy</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
            rel="stylesheet"
            />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
        <style>
            .dropbtn {
                background-color: white;
                color: black;
                padding: 10px;
                font-size: 15px;
                border-color: #f1f1f1;
                margin-left: 10px;

            }

            /* The container <div> - needed to position the dropdown content */
            .dropdown {
                float: right;
                position: relative;
                display: inline-block;
            }

            /* Dropdown Content (Hidden by Default) */
            .dropdown-content {
                display: none;
                position: absolute;
                background-color: #f1f1f1;
                min-width: 160px;
                box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
                z-index: 1;
            }

            .dropdown-content a {
                color: black;
                padding: 12px 16px;
                text-decoration: none;
                display: block;
            }

            .dropdown-content a:hover {
                background-color: #ddd;
            }

            .dropdown:hover .dropdown-content {
                display: block;
            }

            .dropdown:hover .dropbtn {
                background-color: #ddd;
            }
        </style>
    </head>
    <body>
        <%@include file="components/navBarComponent.jsp" %>
        <!-- Header-->
        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-w
                     hite">
                    <h1 class="display-4 fw-bolder" style="color: white">Clowzy Clothes</h1>
                    <p class="lead fw-normal text-white-50 mb-0">
                        Good to the last drop!
                    </p>
                </div>
            </div>
        </header>
        <!-- Section-->
        <section class="py-5">
            <div class="container px-4 px-lg-5 mt-5">
                <div class="row">
                    <div class="col-md-3 mb-5 ">
                        <h3>List Categories</h3>
                        <form action="home" method="get">
                            
                            <ul class="list-group category_block mt-5">
                                <c:forEach items="${listCategories}" var="C">
                                    <li class="list-group-item ">
                                        <label>
                                            <input class="text-black-50" type="checkbox" name="selectedCategories" value="${C.cid}" ${tag == C.cid ? 'checked' : ''}>
                                            ${C.cname}
                                        </label>
                                    </li>
                                </c:forEach>
                            </ul>
                            <button class="mt-3 btn btn-success" type="submit">Submit</button>
                        </form>
                    </div>

                    <div class="col-md-9">

                        <h3>List Products</h3>
                        <div class="la">
                            <div class="dropdown" style="right: 40px;">
                                <button class="dropbtn btn btn-info" style="padding-left: 20px; padding-right: 20px; padding-top: 5px; padding-bottom: 5px;border-radius: 5%; ">View</button>
                                <div class="dropdown-content"style="left: 5px; border-radius: 5%">
                                    <a class="page-link" href="home?sort=true&sortby=price">Low to High</a>
                                    <a class="page-link" href="home?sort=false&sortby=price">High to Low</a> 
                                    <a class="page-link" href="home?sort=true&sortby=name">Name A-Z</a>
                                    <a class="page-link" href="home?sort=false&sortby=name">Name Z-A</a>
                                </div>
                            </div> 


                            <c:choose>

                                <c:when test="${listProducts==null || listProducts.size()==0}">
                                    Not founds
                                </c:when>
                                <c:otherwise>
                                    <nav aria-label="Page navigation example" class="d-flex justify-content-center">
                                        <ul class="pagination">
                                                <c:forEach begin="1" end="${totalPage}" var="i">
                                                <li class="page-item ${i == page?"active":""}"><a class="page-link" href="home?page=${i}">${i}</a></li>
                                                </c:forEach>
                                        </ul>
                                    </nav>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        <div
                            class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 justify-content-center"
                            >
                            <c:forEach items="${listProducts}" var="P">
                                <div class="col mb-5">

                                    <div class="card h-100">
                                        <!-- Sale badge-->
                                        <div
                                            class="badge bg-dark text-white position-absolute"
                                            style="top: 0.5rem; right: 0.5rem"
                                            >
                                            Sale
                                        </div>
                                        <!-- Product image-->
                                        <a href="detail?productId=${P.id}">
                                            <img
                                                class="card-img-top"
                                                src="${P.imageUrl}"
                                                alt="..."
                                                />
                                        </a>
                                        <!-- Product details-->
                                        <div class="card-body p-4">
                                            <div class="text-center">
                                                <!-- Product name-->
                                                <h5 class="fw-bolder">${P.name}</h5>
                                                <!-- Product reviews-->
                                                <div
                                                    class="d-flex justify-content-center small text-warning mb-2"
                                                    >
                                                    <div class="bi-star-fill">${P.tiltle}</div>

                                                </div>
                                                <!-- Product price-->
                                                <span class="text-muted text-decoration-line-through"
                                                      >$${P.price+10}</span
                                                >
                                                $${P.price}
                                            </div>
                                        </div>
                                        <!-- Product actions-->
                                        <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                            <div class="text-center">
                                                <a class="btn btn-outline-dark mt-auto" href="add-to-cart?productId=${P.id}"
                                                   >Add to cart</a
                                                >
<!--                                                <a class="btn btn-outline-dark mt-auto" href="add-to-cart?productId=${P.id}"
                                                   >BuyNow</a
                                                >-->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <%@include file="components/footerComponent.jsp" %>
    </body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</html>
