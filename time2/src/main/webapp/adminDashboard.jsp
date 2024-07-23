<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <h1>Admin Dashboard</h1>
    <form action="assignTask" method="post">
        <label>Employee Username: </label><input type="text" name="employeeUsername" required><br>
        <label>Project: </label><input type="text" name="project" required><br>
        <label>Date: </label><input type="date" name="date" required><br>
        <label>Start Time: </label><input type="time" name="startTime" required><br>
        <label>End Time: </label><input type="time" name="endTime" required><br>
        <label>Task Category: </label><input type="text" name="taskCategory" required><br>
        <label>Description: </label><textarea name="description" required></textarea><br>
        <input type="submit" value="Assign Task">
    </form>
</body>
</html>
