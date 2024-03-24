package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import model.Cart;

public class CartDao extends DBContext {

    public boolean addToCart(List<Cart> cartList, int userid) {
        boolean flag = false;
        if (cartList != null) {
            List<Cart> exitsCart = this.getCartById(userid);
            try {
                for (Cart cart : cartList) {
                    if (exitsCart.contains(cart)) {
                        String query = "UPDATE cart SET Amount = ? WHERE AccountID = ? AND ProductID = ?";
                        PreparedStatement psmt = connection.prepareStatement(query);
                        psmt.setInt(1, cart.getQuantity());
                        psmt.setInt(2, userid);
                        psmt.setInt(3, cart.getProduct().getId());
                        psmt.executeUpdate();

                    } else {
                        String query = "INSERT INTO [cart] ([AccountID], [ProductID], [Amount]) VALUES (?, ?, ?)";
                        PreparedStatement psmt = connection.prepareStatement(query);
                        psmt.setInt(1, userid);
                        psmt.setInt(2, cart.getProduct().getId());
                        psmt.setInt(3, cart.getQuantity());
                        psmt.executeUpdate();
                    }
                    flag = true;
                }
            } catch (Exception e) {
                e.printStackTrace();
                return flag;

            }

        }
        return flag;
    }

    public List<Cart> getCartById(int userid) {
        List<Cart> cartlist = new ArrayList<>();
        ProductDBContext prodb = new ProductDBContext();
        try {
            String sql = "SELECT * FROM Cart where AccountID=?";// lay cart co id = userid
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, userid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Cart cart = new Cart();
                cart.setQuantity(rs.getInt("AccountID"));
                cart.setQuantity(rs.getInt("Amount"));
                cart.setProduct(prodb.getProductById(rs.getInt("ProductID")));
                cartlist.add(cart);
            }
        } catch (Exception ex) {
            Logger.getLogger(AcountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cartlist;
    }

    public boolean deleteCartById(int userid, int productId) {
        ProductDBContext prodb = new ProductDBContext();
        try {
            String sql = "DELETE FROM Cart where AccountID=? and ProductID=?";// lay cart co id = userid
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, userid);
            stm.setInt(2, productId);
            ResultSet rs = stm.executeQuery();

            return true;
        } catch (Exception ex) {
            Logger.getLogger(AcountDBContext.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
}
