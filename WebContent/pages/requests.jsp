<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.skillsharehub.model.LearningRequest" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Learning Requests</title>
</head>
<body>
    <h1>Learning Requests</h1>
	    
	<%
	    String requestMessage = request.getParameter("request");
	
	    if ("updated".equals(requestMessage)) {
	%>
	    <p style="color: green;">Learning request updated successfully.</p>
	<%
	    } else if ("success".equals(requestMessage)) {
	%>
	    <p style="color: green;">Learning request sent successfully.</p>
	<%
	    } else if ("failed".equals(requestMessage)) {
	%>
	    <p style="color: red;">Unable to process the learning request.</p>
	<%
	    } else if ("invalid".equals(requestMessage)) {
	%>
	    <p style="color: red;">Invalid learning request.</p>
	<%
	    } else if ("self".equals(requestMessage)) {
	%>
	    <p style="color: red;">You cannot send a learning request to your own skill.</p>
	<%
	    } else if ("duplicate".equals(requestMessage)) {
	%>
	    <p style="color: red;">A pending request already exists for this skill.</p>
	<%
	    } else if ("notfound".equals(requestMessage)) {
	%>
	    <p style="color: red;">Skill not found.</p>
	<%
	    }
	%>
    
    <h2>Received Requests</h2>
    <%
        List<LearningRequest> receivedRequests = (List<LearningRequest>) request.getAttribute("receivedRequests");
        if (receivedRequests == null || receivedRequests.isEmpty()) {
    %>
        <p>No received learning requests.</p>
    <%
        } else {
            for (LearningRequest requestItem :
                    receivedRequests) {
    %>
        <div>
            <p>
                <strong>From:</strong>
                <%= requestItem.getSenderName() %>
            </p>

            <p>
                <strong>Skill:</strong>
                <%
                    if (requestItem.getSkillName() != null) {
                %>

                    <%= requestItem.getSkillName() %>
                <%
                    } else {
                %>
                    Skill no longer available
                <%
                    }
                %>
            </p>

            <p>
                <strong>Message:</strong>
                <%= requestItem.getRequestMessage() %>
            </p>

            <p>
                <strong>Status:</strong>
                <%= requestItem.getRequestStatus() %>
            </p>

            <p>
                <strong>Date:</strong>
                <%= requestItem.getRequestDate() %>
            </p>
            
            <%
    			if ("Pending".equals(requestItem.getRequestStatus())) {
			%>
		
		    <!-- Accept -->
		    <form action="${pageContext.request.contextPath}/pages/learning-request-status"
		          method="post" style="display:inline;">
		        <input type="hidden" name="requestId" value="<%= requestItem.getRequestId() %>">
		        <input type="hidden" name="action" value="accept">
		        <button type="submit">Accept</button>
		    </form>
		
		    <!-- Reject -->
		    <form action="${pageContext.request.contextPath}/pages/learning-request-status"
		          method="post" style="display:inline;">
		        <input type="hidden" name="requestId" value="<%= requestItem.getRequestId() %>">
		        <input type="hidden" name="action" value="reject">
		        <button type="submit">Reject</button>
		    </form>
		
		    <!-- Cancel -->
		    <form action="${pageContext.request.contextPath}/pages/learning-request-status"
		          method="post" style="display:inline;">
		        <input type="hidden" name="requestId" value="<%= requestItem.getRequestId() %>">
		        <input type="hidden" name="action" value="cancel">
		        <button type="submit">Cancel</button>
		
		    </form>
			<%
			    } else if ("Accepted".equals(requestItem.getRequestStatus())) {
			%>
			
		    <!-- Complete -->
		    <form action="${pageContext.request.contextPath}/pages/learning-request-status" method="post">
		        <input type="hidden" name="requestId" value="<%= requestItem.getRequestId() %>">
		        <input type="hidden" name="action" value="complete">
		
		        <button type="submit">Complete</button>
		    </form>
			<%
			    }
			%>
        </div>
            <hr>
    <%
            }
        }
    %>
    
    <%--- Sent Requests --%>
	    <h2>Sent Requests</h2>
	<%
	    List<LearningRequest> sentRequests = (List<LearningRequest>) request.getAttribute("sentRequests");
	    if (sentRequests == null || sentRequests.isEmpty()) {
	%>
	    <p>No sent learning requests.</p>
	<%
	    } else {
	        for (LearningRequest requestItem :
	                sentRequests) {
	%>
    <div>
        <p>
            <strong>To:</strong>
            <%= requestItem.getReceiverName() %>
        </p>

        <p>
            <strong>Skill:</strong>
            <%
                if (requestItem.getSkillName() != null) {
            %>
                <%= requestItem.getSkillName() %>
            <%
                } else {
            %>
                Skill no longer available
            <%
                }
            %>

        </p>

        <p>
            <strong>Message:</strong>
            <%= requestItem.getRequestMessage() %>
        </p>

        <p>
            <strong>Status:</strong>
            <%= requestItem.getRequestStatus() %>
        </p>

        <p>
            <strong>Date:</strong>
            <%= requestItem.getRequestDate() %>
        </p>
        
        <%
		    if ("Pending".equals(requestItem.getRequestStatus())) {
		%>
	    <!-- Cancel -->
	    <form action="${pageContext.request.contextPath}/pages/learning-request-status" method="post">
	        <input type="hidden" name="requestId" value="<%= requestItem.getRequestId() %>">
	        <input type="hidden" name="action" value="cancel">
	        <button type="submit">Cancel</button>
	    </form>
		<%
		    }
		%>
        
	</div>
        <hr>
	<%
        	}
    	}
	%>
	
	<br>

<a href="${pageContext.request.contextPath}/pages/dashboard.jsp">Back to Home</a>
</body>
</html>