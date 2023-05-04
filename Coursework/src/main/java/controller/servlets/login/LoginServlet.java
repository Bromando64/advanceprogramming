package controller.servlets.login;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.dbconnection.DbConnection;
import resources.MyConstants;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email=request.getParameter("email");
		String pass =request.getParameter("password");
		
		DbConnection connection = new DbConnection();
		Boolean isUserRegistered = connection.isUserRegistered(MyConstants.CHECK_LOGIN_INFO, email, pass);
		if(isUserRegistered !=null && isUserRegistered)
		{
			HttpSession session = request.getSession();
			session.setAttribute("email", email);
      
			//setting session to expire in 30 mins
			session.setMaxInactiveInterval(30*60);
			
			Cookie emailName = new Cookie("email", email);
			emailName.setMaxAge(30*60);
			response.addCookie(emailName);
			response.sendRedirect(request.getContextPath()+"/home.jsp");
		}else {
			//set error message
			request.setAttribute("errorMessage", "Invalid email or password");
			// forward request to login page
			RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
			dispatcher.include(request, response);
		}

	}

}
