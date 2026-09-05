package com.skillsharehub.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter("/pages/*")
public class AuthorizationFilter implements Filter {
	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
	        FilterChain chain) throws IOException, ServletException {

	    HttpServletRequest httpRequest = (HttpServletRequest) request;
	    HttpServletResponse httpResponse = (HttpServletResponse) response;

	    HttpSession session = httpRequest.getSession(false);

	    String requestedResource = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());

	    if (isAdminResource(requestedResource)) {

	        if (session != null && session.getAttribute("loggedInAdmin") != null) {

	            chain.doFilter(request, response);

	        } else {

	            httpResponse.sendRedirect(httpRequest.getContextPath() + "/pages/adminLogin.jsp");
	        }

	    } else {

	        chain.doFilter(request, response);
	    }
	}
	
	private boolean isAdminResource(String resource) {

	    return resource.equals("/pages/admin.jsp") || resource.equals("/pages/admin/users") || resource.equals("/pages/admin/categories");
	}
}