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
public class AuthenticationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();

        String requestedResource = requestURI.substring(contextPath.length());

        if (isPublicResource(requestedResource) || isAdminResource(requestedResource)) {

            chain.doFilter(request, response);
            return;
        }
        
        HttpSession session = httpRequest.getSession(false);

        if (session != null && session.getAttribute("loggedInUser") != null) {

            chain.doFilter(request, response);

        } else {

            httpResponse.sendRedirect( contextPath + "/pages/login.jsp");
        }
    }

    private boolean isPublicResource(String resource) {

        return resource.equals("/pages/login.jsp")
        		|| resource.equals("/pages/adminLogin.jsp")
                || resource.equals("/pages/register.jsp")
                || resource.equals("/pages/login")
                || resource.equals("/pages/adminLogin")
                || resource.equals("/pages/register")
                || resource.equals("/pages/logout");
    }
    
    private boolean isAdminResource(String resource) {

        return resource.equals("/pages/admin.jsp") || resource.equals("/pages/admin/users") || resource.equals("/pages/admin/categories");
    }
}