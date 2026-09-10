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