/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dal.CartDao;
import dal.ProductDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedHashMap;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.Cart;
import model.Product;

@WebServlet(name = "AddToCartController", urlPatterns = {"/add-to-cart"})
public class AddToCartController extends BaseRequiredAuthenController {

    private dal.CartDao _cartDao = new CartDao();
    private dal.ProductDBContext _prDao = new ProductDBContext();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequests(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            int productId = Integer.parseInt(request.getParameter("productId"));
            Product prx = this._prDao.getProductById(productId);
            HttpSession session = request.getSession();
            Map<Integer, Cart> carts = (Map<Integer, Cart>) session.getAttribute("carts");
            if (carts == null) {
                carts = new LinkedHashMap<>();
            }

            if (carts.containsKey(productId)) {//sản phẩm đã có trên giỏ hàng
                int oldQuantity = carts.get(productId).getQuantity();
                carts.get(productId).setQuantity(oldQuantity + 1);
            } else {//sản phẩm chưa có trên giỏ hàng
                Cart cartnew = new Cart(prx, 1);
                carts.put(productId, cartnew);
            }
            Account acccont = (Account) session.getAttribute("acc");
            List<Cart> cartss = new ArrayList<>(carts.values());
            Cart addCart = new Cart(prx, 1);
            if (cartss.contains(addCart)) {
                addCart.setQuantity(addCart.getQuantity() + 1);
            }
            this._cartDao.addToCart(cartss, acccont.getUid());
            String urlHistory = (String) session.getAttribute("urlHistory");
            if (urlHistory == null) {
                urlHistory = "home";
            }
            session.removeAttribute("carts");
            session.setAttribute("carts", carts);
            response.sendRedirect(urlHistory);
        }

    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
