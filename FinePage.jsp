<%@ page import="java.util.*,java.text.*" %>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Your Fines</title>
    <style>
        body {
            font-family: 'Poppins', Arial, sans-serif;
            background: #f4e1e4;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 800px;
            margin: 40px auto;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 24px rgba(60,40,10,0.10);
            padding: 32px 24px 32px 24px;
        }
        h2 {
            color: #8b3f3f;
            margin-bottom: 24px;
            font-size: 1.6em;
            font-weight: 600;
            letter-spacing: 1px;
            text-align: center;
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
            font-family: 'Poppins', Arial, sans-serif;
        }
        .action-btn:hover {
            background: #3c0d0d;
        }
        .no-fines {
            text-align: center;
            color: #888;
            font-size: 1.1em;
            padding: 24px 0;
        }
        @media (max-width: 700px) {
            .container {
                padding: 12px 2px 12px 2px;
            }
            th, td {
                padding: 8px 4px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
    <h2>Your Fines</h2>
    <table>
        <tr>
            <th>Fine ID</th>
            <th>Book ID</th>
            <th>Amount (RM)</th>
            <th>Status</th>
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
            <td><%= fine.get("bookID") %></td>
            <td><%= new DecimalFormat("#0.00").format(fine.get("fine_amount")) %></td>
            <td class="<%= fine.get("status") %>"><%= fine.get("status") %></td>
            <td><%= fine.get("reason") %></td>
            <td>
                <% if ("unpaid".equals(fine.get("status"))) { %>
                <form method="post" action="FineController" style="display:inline;">
                    <input type="hidden" name="fineID" value="<%= fine.get("fineID") %>"/>
                    <input type="submit" value="Pay" class="action-btn"/>
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
        <tr><td colspan="6" class="no-fines">No fines found.</td></tr>
        <% } %>
    </table>
    </div>
</body>
</html>