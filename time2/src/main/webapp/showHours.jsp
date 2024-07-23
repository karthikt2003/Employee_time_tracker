<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%
    Integer employeeId = (Integer) session.getAttribute("employeeId");
    String username = (String) session.getAttribute("username");

    if (employeeId == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    Map<String, Integer> timeSpentMap = new HashMap<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/employeetimetracker", "karthik", "krithika");

        String sql = "SELECT task_category, TIMESTAMPDIFF(MINUTE, start_time, end_time) AS duration FROM Task WHERE employee_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, employeeId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            String taskCategory = rs.getString("task_category");
            int duration = rs.getInt("duration");
            timeSpentMap.put(taskCategory, timeSpentMap.getOrDefault(taskCategory, 0) + duration);
        }

        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    request.setAttribute("timeSpentMap", timeSpentMap);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Employee Working Hours</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <h1>Welcome, <%= username %></h1>
    <h2>Employee Working Hours</h2>
    <canvas id="timeSpentChart"></canvas>
    <script>
        const labels = [];
        const data = [];
        <%
            for (Map.Entry<String, Integer> entry : timeSpentMap.entrySet()) {
                String task = entry.getKey();
                Integer hours = entry.getValue();
        %>
                labels.push("<%= task %>");
                data.push(<%= hours %>);
        <%
            }
        %>

        const ctx = document.getElementById('timeSpentChart').getContext('2d');
        new Chart(ctx, {
            type: 'pie',
            data: {
                labels: labels,
                datasets: [{
                    data: data,
                    backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0']
                }]
            }
        });
    </script>
</body>
</html>
