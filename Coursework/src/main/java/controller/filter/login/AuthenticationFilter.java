package controller.filter.login;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter("/authenticationfilter")
public class AuthenticationFilter implements Filter{
	private ServletContext context;


	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		context=filterConfig.getServletContext();
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		
		//Check if the request is a login or logout request
		String uri = req.getRequestURI();
		boolean isLoginJsp = uri.endsWith("login.jsp");
		boolean isLoginServlet = uri.endsWith("LoginServlet");
		boolean isLogoutServlet = uri.endsWith("LogoutServlet");
        boolean isHomeJsp = uri.endsWith("home.jsp");
        boolean isProductListJsp = uri.contains("product_list.jsp");
        boolean isProductFilterServlet = uri.contains("ProductFilterServlet");
		boolean isRegisterJsp = uri.endsWith("register.jsp");
		boolean isUserRegisterServlet = uri.endsWith("UserServlet");
        
		this.context.log("Requested Resource::" + uri);
		
		HttpSession session = req.getSession(false);
		boolean loggedIn = session != null && session.getAttribute("email") != null;
		
		if (!loggedIn && !(isLoginJsp || isLoginServlet  || isHomeJsp || isProductListJsp|| isProductFilterServlet || isUserRegisterServlet ||  isRegisterJsp) && !uri.contains("css")&& !uri.contains("png") && !uri.contains("jpg")) {
			res.sendRedirect(req.getContextPath()+"/login.jsp");
		}else if(loggedIn && isLoginJsp) {
			res.sendRedirect(req.getContextPath()+"/home.jsp");
		}else {
			chain.doFilter(request, response);
		}
		
	}
	
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}


	
}
