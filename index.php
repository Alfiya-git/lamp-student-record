<?php
$servername = "mysql-container";
$username = "root";
$password = "rootpassword";
$dbname = "student_db";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT id, name, course FROM students";
$result = $conn->query($sql);
?>
<!DOCTYPE html>
<html>
<head>
<title>Student Records</title>
</head>
<body>
<h1>Student List</h1>
<table border="1">
<tr><th>ID</th><th>Name</th><th>Course</th></tr>
<?php
if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        echo "<tr><td>{$row['id']}</td><td>{$row['name']}</td><td>{$row['course']}</td></tr>";
    }
} else {
    echo "<tr><td colspan='3'>No records found</td></tr>";
}
$conn->close();
?>
</table>
</body>
</html>
