<%@page import="java.sql.*" %>
<%@page import="java.time.format.DateTimeFormatter" %>
<%@page import="java.time.*" %>
<%@page import="java.time.LocalDateTime" %>
<%@page import="java.util.Date.*" %>
<html>
<head>
<title>Library Management System App</title>
<link rel="icon"  href="library.ico">

<style>
	*{
		font-size: 40px;
	}
    body{
        background-color: rgb(118, 150, 30);
    }
    .btnBack{
		text-decoration: none;
		background-color: rgb(0, 0, 0);
		color: rgb(255, 254, 254);
	}
    input{
		border: 2px solid black;
	}
</style>

<script>
    function setFocusToTextBox(){
        document.getElementById("myText").focus();
    }
</script>

</head>
<body onload="setFocusToTextBox()">
    <center>
        <h1 style="background-color: black; color: white; width: 65%; border: 2px solid yellow; border-radius: 25px;">Issued Books</h1>
        <form action="" method="post">
        search by Rno: <input type="text" name="rno" id="myText" style="border-radius: 25px; padding: 8px 15px;">  
        <input type="submit" name="btnSearch" value="search"  >
    </form>
    <table border="2px" style="width:70%; background-color: rgb(213, 213, 213);">
        <tr>
            <th>Rno</th>
            <th>Issuer</th>
            <th>Title</th>
            <th>Author</th>
            <th>Days</th>
            <th>Remaining</th>
        </tr>
    <%
        if(request.getParameter("btnSearch")!=null){
            LocalDateTime date = LocalDateTime.now();
            
            String rno=request.getParameter("rno");
            try{
            DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
            String url="jdbc:mysql://localhost:3306/LibMngSys_proj";
            
            Connection con=DriverManager.getConnection(url,"root","Harsh@12345");
            String sql= "select * from isbks where rno=?";
            PreparedStatement pst=con.prepareStatement(sql);
            pst.setString(1,rno);
            ResultSet rs=pst.executeQuery();
            
            DateTimeFormatter formatter;
            LocalDateTime prevDate;

            int flag=0;
            while(rs.next()){
                flag=1;
                String name=rs.getString(2);
                String title=rs.getString(3);
                String author=rs.getString(4);
                int days=rs.getInt(5);
                formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
                prevDate=LocalDateTime.parse(rs.getString(6), formatter);
                long daysBetween = days-(Duration.between(prevDate, date).toDays());
    %>  <tr style="text-align:center">
            <td><%=rno%></td>
            <td><%=name%></td>
            <td><%=title%></td>
            <td><%=author%></td>
            <td><%=days%></td>
            <td><%=daysBetween%></td>
        </tr>
    <%
    
            }
            if(flag==0){
                out.println("No books found.");
    %>
            <br><br>
    <%      }
        }
    
        catch(SQLException se){
            out.println("issue "+se);
        }
        }
    %>
    
    
    </table>
    
    <%
    if(session.getAttribute("user")!=null)
    {
        String user=(String)session.getAttribute("user");
    }
    else
    {
            response.sendRedirect("index.jsp");
    
    
    }
    %>
    <br><br>
    <form>
    <a href="home.jsp" class="btnBack">Back</a><br><br>
    <input type="submit" value="logout" name="btn">
    
    </form>
    
    <%
    
    if(request.getParameter("btn")!=null)
    {
        request.getSession().invalidate();
        response.sendRedirect("index.jsp");
    
    }
    
    
    %>
    </center>
    </body>
    </html>