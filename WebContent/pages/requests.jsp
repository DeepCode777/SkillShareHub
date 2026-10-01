<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.skillsharehub.model.LearningRequest" %>
<%
    String requestMessage = request.getParameter("request");
    List<LearningRequest> receivedRequests = (List<LearningRequest>) request.getAttribute("receivedRequests");
    List<LearningRequest> sentRequests = (List<LearningRequest>) request.getAttribute("sentRequests");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Learning Requests - SkillShareHub</title>
    <link rel="icon" href="../images/logo.png" type="image/png">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/assets/style2.css">
    <style>
        .requests-wrapper {
            padding: 2.5rem 1rem 4rem 1rem;
            max-width: 960px;
            margin: 0 auto;
        }

        .requests-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        /* Tab Switcher */
        .tab-navigation {
            display: flex;
            gap: 0.75rem;
            border-bottom: 2px solid var(--border);
            margin-bottom: 2rem;
        }

        .tab-btn {
            background: none;
            border: none;
            padding: 0.75rem 1.25rem;
            font-size: 1rem;
            font-weight: 600;
            color: var(--text-muted);
            cursor: pointer;
            border-bottom: 3px solid transparent;
            margin-bottom: -2px;
            transition: var(--transition);
        }

        .tab-btn:hover {
            color: var(--primary);
        }

        .tab-btn.active {
            color: var(--primary);
            border-bottom-color: var(--primary);
        }

        .tab-pane {
            display: none;
        }

        .tab-pane.active {
            display: block;
        }

        /* Request Cards */
        .requests-list {
            display: flex;
            flex-direction: column;
            gap: 1.25rem;
        }

        .req-card {
            background-color: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            padding: 1.5rem;
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .req-card:hover {
            box-shadow: var(--shadow-md);
            border-color: var(--border-focus);
        }

        .req-header-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            flex-wrap: wrap;
            gap: 0.75rem;
            border-bottom: 1px solid var(--border);
            padding-bottom: 0.85rem;
        }

        .req-title {
            font-size: 1.2rem;
            font-weight: 700;
            margin-bottom: 0.25rem;
            color: var(--text);
        }

        .req-meta-sub {
            font-size: 0.85rem;
            color: var(--text-muted);
        }

        .req-message-box {
            background-color: var(--surface-alt);
            border: 1px solid var(--border);
            border-radius: var(--radius-sm);
            padding: 1rem 1.25rem;
            color: var(--text);
            font-size: 0.925rem;
            line-height: 1.6;
            white-space: pre-line;
            word-break: break-word;
        }

        .req-actions-row {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 0.6rem;
            flex-wrap: wrap;
            border-top: 1px solid var(--border);
            padding-top: 0.85rem;
        }

        @media (max-width: 640px) {
            .req-header-row {
                flex-direction: column;
                align-items: flex-start;
            }
            .req-actions-row {
                flex-direction: column;
                align-items: stretch;
            }
            .req-actions-row form,
            .req-actions-row .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>

    <!-- Shared Navigation -->
    <%@ include file="/includes/navbar.jsp" %>

    <!-- Main Content Area -->
    <main class="page-content">
        <div class="container requests-wrapper">

            <!-- Page Top Header -->
            <div class="requests-header">
                <div>
                    <h1 style="font-size: 1.85rem; margin-bottom: 0.25rem;">Learning Requests</h1>
                    <p class="text-muted" style="margin-bottom: 0;">Manage learning exchanges, incoming proposals, and collaboration requests</p>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/pages/dashboard.jsp" class="btn btn-outline btn-sm">&larr; Back to Home</a>
                </div>
            </div>

            <!-- Feedback Alert Banners -->
            <% if ("updated".equals(requestMessage)) { %>
                <div class="alert alert-success" role="alert">
                    <span>✓ Learning request updated successfully.</span>
                </div>
            <% } else if ("success".equals(requestMessage)) { %>
                <div class="alert alert-success" role="alert">
                    <span>✓ Learning request sent successfully.</span>
                </div>
            <% } else if ("failed".equals(requestMessage)) { %>
                <div class="alert alert-danger" role="alert">
                    <span>⚠ Unable to process the learning request. Please try again.</span>
                </div>
            <% } else if ("invalid".equals(requestMessage)) { %>
                <div class="alert alert-danger" role="alert">
                    <span>⚠ Invalid learning request data.</span>
                </div>
            <% } else if ("self".equals(requestMessage)) { %>
                <div class="alert alert-danger" role="alert">
                    <span>⚠ You cannot send a learning request to your own skill.</span>
                </div>
            <% } else if ("duplicate".equals(requestMessage)) { %>
                <div class="alert alert-warning" role="alert">
                    <span>⚠ A pending request already exists for this skill.</span>
                </div>
            <% } else if ("notfound".equals(requestMessage)) { %>
                <div class="alert alert-danger" role="alert">
                    <span>⚠ Requested skill could not be found.</span>
                </div>
            <% } %>

            <!-- Tab Switcher Navigation -->
            <div class="tab-navigation" role="tablist">
                <button type="button" class="tab-btn active" onclick="switchTab('receivedTab', this)" role="tab" aria-selected="true">
                    Received Requests (<%= receivedRequests != null ? receivedRequests.size() : 0 %>)
                </button>
                <button type="button" class="tab-btn" onclick="switchTab('sentTab', this)" role="tab" aria-selected="false">
                    Sent Requests (<%= sentRequests != null ? sentRequests.size() : 0 %>)
                </button>
            </div>

            <!-- 1. Received Requests Pane -->
            <div id="receivedTab" class="tab-pane active" role="tabpanel">
                <% if (receivedRequests == null || receivedRequests.isEmpty()) { %>
                    <div class="empty-state">
                        <div class="empty-state-icon">📥</div>
                        <h2 class="empty-state-title">No Received Requests</h2>
                        <p class="empty-state-desc">You haven't received any learning requests from peer students yet.</p>
                        <a href="${pageContext.request.contextPath}/pages/my-skills/add" class="btn btn-primary btn-sm">Add More Skills</a>
                    </div>
                <% } else { %>
                    <div class="requests-list">
                        <% for (LearningRequest requestItem : receivedRequests) { %>
                            <div class="req-card">
                                <div class="req-header-row">
                                    <div>
                                        <div class="req-title">
                                            <%= requestItem.getSkillName() != null ? requestItem.getSkillName() : "Skill no longer available" %>
                                        </div>
                                        <div class="req-meta-sub">
                                            <span><strong>From Learner:</strong> <%= requestItem.getSenderName() %></span>
                                            <span>&bull;</span>
                                            <span><strong>Date:</strong> <%= requestItem.getRequestDate() %></span>
                                        </div>
                                    </div>
                                    <div>
                                        <%
                                            String status = requestItem.getRequestStatus();
                                            String badgeClass = "badge-pending";
                                            if ("Accepted".equalsIgnoreCase(status) || "Completed".equalsIgnoreCase(status)) {
                                                badgeClass = "badge-accepted";
                                            } else if ("Rejected".equalsIgnoreCase(status) || "Cancelled".equalsIgnoreCase(status)) {
                                                badgeClass = "badge-rejected";
                                            }
                                        %>
                                        <span class="badge <%= badgeClass %>"><%= status %></span>
                                    </div>
                                </div>

                                <div class="req-message-box">
                                    <strong>Learner Message:</strong>
                                    <p style="margin: 0.35rem 0 0 0;"><%= requestItem.getRequestMessage() %></p>
                                </div>

                                <% if ("Pending".equals(requestItem.getRequestStatus())) { %>
                                    <div class="req-actions-row">
                                        <!-- Accept -->
                                        <form action="${pageContext.request.contextPath}/pages/learning-request-status" method="post" style="margin:0;">
                                            <input type="hidden" name="requestId" value="<%= requestItem.getRequestId() %>">
                                            <input type="hidden" name="action" value="accept">
                                            <button type="submit" class="btn btn-success btn-sm">Accept</button>
                                        </form>

                                        <!-- Reject -->
                                        <form action="${pageContext.request.contextPath}/pages/learning-request-status" method="post" style="margin:0;"
                                              onsubmit="return confirm('Reject this learning request?');">
                                            <input type="hidden" name="requestId" value="<%= requestItem.getRequestId() %>">
                                            <input type="hidden" name="action" value="reject">
                                            <button type="submit" class="btn btn-danger btn-sm">Reject</button>
                                        </form>

                                        <!-- Cancel -->
                                        <form action="${pageContext.request.contextPath}/pages/learning-request-status" method="post" style="margin:0;"
                                              onsubmit="return confirm('Cancel this learning request?');">
                                            <input type="hidden" name="requestId" value="<%= requestItem.getRequestId() %>">
                                            <input type="hidden" name="action" value="cancel">
                                            <button type="submit" class="btn btn-outline btn-sm">Cancel</button>
                                        </form>
                                    </div>
                                <% } else if ("Accepted".equals(requestItem.getRequestStatus())) { %>
                                    <div class="req-actions-row">
                                        <!-- Complete -->
                                        <form action="${pageContext.request.contextPath}/pages/learning-request-status" method="post" style="margin:0;"
                                              onsubmit="return confirm('Mark this learning request as completed?');">
                                            <input type="hidden" name="requestId" value="<%= requestItem.getRequestId() %>">
                                            <input type="hidden" name="action" value="complete">
                                            <button type="submit" class="btn btn-primary btn-sm">Complete</button>
                                        </form>
                                    </div>
                                <% } %>
                            </div>
                        <% } %>
                    </div>
                <% } %>
            </div>

            <!-- 2. Sent Requests Pane -->
            <div id="sentTab" class="tab-pane" role="tabpanel">
                <% if (sentRequests == null || sentRequests.isEmpty()) { %>
                    <div class="empty-state">
                        <div class="empty-state-icon">📤</div>
                        <h2 class="empty-state-title">No Sent Requests</h2>
                        <p class="empty-state-desc">You haven't requested to learn any skills yet.</p>
                        <a href="${pageContext.request.contextPath}/pages/skills" class="btn btn-primary btn-sm">Explore Skills</a>
                    </div>
                <% } else { %>
                    <div class="requests-list">
                        <% for (LearningRequest requestItem : sentRequests) { %>
                            <div class="req-card">
                                <div class="req-header-row">
                                    <div>
                                        <div class="req-title">
                                            <%= requestItem.getSkillName() != null ? requestItem.getSkillName() : "Skill no longer available" %>
                                        </div>
                                        <div class="req-meta-sub">
                                            <span><strong>To Provider:</strong> <%= requestItem.getReceiverName() %></span>
                                            <span>&bull;</span>
                                            <span><strong>Date:</strong> <%= requestItem.getRequestDate() %></span>
                                        </div>
                                    </div>
                                    <div>
                                        <%
                                            String status = requestItem.getRequestStatus();
                                            String badgeClass = "badge-pending";
                                            if ("Accepted".equalsIgnoreCase(status) || "Completed".equalsIgnoreCase(status)) {
                                                badgeClass = "badge-accepted";
                                            } else if ("Rejected".equalsIgnoreCase(status) || "Cancelled".equalsIgnoreCase(status)) {
                                                badgeClass = "badge-rejected";
                                            }
                                        %>
                                        <span class="badge <%= badgeClass %>"><%= status %></span>
                                    </div>
                                </div>

                                <div class="req-message-box">
                                    <strong>Your Message:</strong>
                                    <p style="margin: 0.35rem 0 0 0;"><%= requestItem.getRequestMessage() %></p>
                                </div>

                                <% if ("Pending".equals(requestItem.getRequestStatus())) { %>
                                    <div class="req-actions-row">
                                        <!-- Cancel Sent Request -->
                                        <form action="${pageContext.request.contextPath}/pages/learning-request-status" method="post" style="margin:0;"
                                              onsubmit="return confirm('Cancel your request to learn this skill?');">
                                            <input type="hidden" name="requestId" value="<%= requestItem.getRequestId() %>">
                                            <input type="hidden" name="action" value="cancel">
                                            <button type="submit" class="btn btn-outline btn-sm">Cancel Request</button>
                                        </form>
                                    </div>
                                <% } %>
                            </div>
                        <% } %>
                    </div>
                <% } %>
            </div>

        </div>
    </main>

    <!-- Shared Sticky Footer -->
    <%@ include file="/includes/footer.jsp" %>

    <!-- Tab Switcher Handler -->
    <script>
        function switchTab(tabId, btnElement) {
            document.querySelectorAll('.tab-pane').forEach(function(pane) {
                pane.classList.remove('active');
            });
            document.querySelectorAll('.tab-btn').forEach(function(btn) {
                btn.classList.remove('active');
                btn.setAttribute('aria-selected', 'false');
            });

            var target = document.getElementById(tabId);
            if (target) {
                target.classList.add('active');
            }
            btnElement.classList.add('active');
            btnElement.setAttribute('aria-selected', 'true');
        }
    </script>

</body>
</html>