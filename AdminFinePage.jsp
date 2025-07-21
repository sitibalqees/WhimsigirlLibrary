<%@ page import="java.util.*,java.text.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Fine Management</title>
    <style>
        body {
            font-family: Georgia, serif;
            background-color: #f4e1e4;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1100px;
            margin: 40px auto;
            background: rgba(255,255,255,0.97);
            border-radius: 14px;
            box-shadow: 0 4px 24px rgba(60,40,10,0.10);
            padding: 32px 40px 40px 40px;
        }
        h2 {
            color: #8b3f3f;
            margin-bottom: 24px;
            font-size: 1.7em;
            font-weight: 600;
            letter-spacing: 1px;
        }
        form {
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 16px;
        }
        input[type="text"], select {
            padding: 7px 10px;
            border: 1px solid #bfa3a3;
            border-radius: 4px;
            font-size: 1em;
            background: #f9f3f3;
            color: #3c0d0d;
        }
        input[type="submit"] {
            background: #8b3f3f;
            color: #fff;
            border: none;
            border-radius: 4px;
            padding: 8px 18px;
            font-size: 1em;
            cursor: pointer;
            transition: background 0.2s;
            font-family: Georgia, serif;
        }
        input[type="submit"]:hover {
            background: #3c0d0d;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            margin-bottom: 24px;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(60,13,13,0.06);
        }
        th, td {
            padding: 12px 10px;
            border-bottom: 1px solid #e5c9d1;
            text-align: left;
        }
        th {
            background: #f4e1e4;
            color: #3c0d0d;
            font-weight: 600;
        }
        tr:nth-child(even) {
            background: #f9f3f3;
        }
        tr:hover {
            background: #fbeff2;
        }
        .paid {
            color: #2ecc71;
            font-weight: bold;
        }
        .unpaid {
            color: #e74c3c;
            font-weight: bold;
        }
        .action-btn {
            background: #a05252;
            color: #fff;
            border: none;
            border-radius: 4px;
            padding: 6px 14px;
            font-size: 0.98em;
            cursor: pointer;
            transition: background 0.2s;
            font-family: Georgia, serif;
        }
        .action-btn:hover {
            background: #3c0d0d;
        }
        a {
            color: #8b3f3f;
            text-decoration: none;
            font-weight: 500;
        }
        a:hover {
            text-decoration: underline;
        }
        @media (max-width: 700px) {
            .container {
                padding: 16px 4px 12px 4px;
            }
            th, td {
                padding: 8px 4px;
            }
            form {
                flex-direction: column;
                align-items: flex-start;
                gap: 8px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>All Fines</h2>
        <form method="get" action="AdminFineController">
            Search by User Email: <input type="text" name="userEmail" value="<%= request.getParameter("userEmail") != null ? request.getParameter("userEmail") : "" %>"/>
            Status:
            <select name="status">
                <option value="">All</option>
                <option value="unpaid" <%= "unpaid".equals(request.getParameter("status")) ? "selected" : "" %>>Unpaid</option>
                <option value="paid" <%= "paid".equals(request.getParameter("status")) ? "selected" : "" %>>Paid</option>
            </select>
            <input type="submit" value="Search"/>
        </form>
        <table>
            <tr>
                <th>Fine ID</th>
                <th>User Email</th>
                <th>Book Title</th>
                <th>Amount (RM)</th>
                <th>Status</th>
                <th>Payment Date</th>
                <th>Reason</th>
                <th>Action</th>
            </tr>
            <%
                List<Map<String, Object>> fines = (List<Map<String, Object>>) request.getAttribute("fines");
                if (fines != null && !fines.isEmpty()) {
                    for (Map<String, Object> fine : fines) {
            %>
            <tr>
                <td><%= fine.get("fineID") %></td>
                <td><%= fine.get("userEmail") %></td>
                <td><%= fine.get("bookTitle") %></td>
                <td><%= new DecimalFormat("#0.00").format(fine.get("fine_amount")) %></td>
                <td class="<%= fine.get("status") %>"><%= fine.get("status") %></td>
                <td><%= fine.get("payment_date") %></td>
                <td><%= fine.get("reason") %></td>
                <td>
                    <% if ("unpaid".equals(fine.get("status"))) { %>
                    <form method="post" action="AdminFineController" style="display:inline;">
                        <input type="hidden" name="fineID" value="<%= fine.get("fineID") %>"/>
                        <input type="submit" name="action" value="Mark as Paid" class="action-btn"/>
                    </form>
                    <% } else { %>
                    <span class="paid">Paid</span>
                    <% } %>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr><td colspan="8">No fines found.</td></tr>
            <% } %>
        </table>
        <a href="AdminPage.jsp">&larr; Back to Admin Dashboard</a>
    </div>
</body>
</html>