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
        <title>Shop Homepage - Start Bootstrap Template</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
            rel="stylesheet"
            />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
    </head>
    <body>
        <%@include file="components/navBarComponent.jsp" %>

        <div class="container" style="min-height: 1000px">
            <div class="alert alert-success text-center mt-5" role="alert" >
                <h3>List Products</h3>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">#</th>
                                    <th scope="col">Image</th>
                                    <th scope="col">Name</th>
                                    <th scope="col">Price</th>
                                    <th scope="col">Quantity</th>
                                    <th scope="col">Total Price</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${carts}" var="C">
                                    <tr>
                                <input type="hidden" name="productId" value="${C.id}"/>
                                <th scope="row">${C.id}</th>
                                <td>${C.productName}</td>
                                <td><img src="${C.productImage}" width="50"/></td>
                                <td>${C.productPrice}</td>
                                <td>${C.quantity}</td>
                                <td>${C.productPrice*C.quantity}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <h3>Total Amount: $${totalPrice}</h3>
                Order successfully, Thank you very much...
                <div class="text-center mt-2">
                    <a class="btn btn-outline-primary" href="home">Continue Shopping</a>
                </div>
            </div>
        </div>
        <%@include file="components/footerComponent.jsp" %>
    </body>
</html>

