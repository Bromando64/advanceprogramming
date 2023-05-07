package controller.product;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.dbconnection.DbConnection;
import resources.MyConstants;

/**
 * Servlet implementation class DeleteProductImageServlet
 */
@WebServlet("/DeleteProductImageServlet")
public class DeleteProductImageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteProductImageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String imageUrl = request.getParameter("productImageUrl");
		try {
			DbConnection connection = new DbConnection();
			Connection con = connection.getConnection();
			PreparedStatement statement = con.prepareStatement(MyConstants.PRODUCT_IMAGE_DELETE);
			statement.setString(1, imageUrl);
			int result = statement.executeUpdate();
			if (result>=0) {
				response.sendRedirect(request.getContextPath()+"/Pages/admin_profile.jsp");
			}else {
				request.setAttribute("updateMessage", "Error Not deleted");
				request.getRequestDispatcher("Pages/admin_profile.jsp").forward(request, response);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}

}
