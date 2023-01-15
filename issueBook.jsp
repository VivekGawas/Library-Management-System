<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>
<%@page import="java.time.format.DateTimeFormatter" %>
<%@page import="java.time.LocalDateTime" %>
<html>
<head>
<title>Library Management System App</title>
<link rel="icon"  href="library.ico">

<style>
	*{
		font-size: 40px;
	}
    body{
        background-color: rgb(224, 138, 211);
    }
    a{
		text-decoration: none;
		background-color: rgb(0, 0, 0);
		color: rgb(255, 254, 254);
	}
    input{
		border: 2px solid black;
	}
</style>
</head>
<body>
<center>
    <h1 style="background-color: black; color: white; width: 65%; border: 2px solid yellow; border-radius: 25px;">Issue a Book</h1>

    <form action="" method="post">
    Enter Rno: <input type="text" name="rno" required ><br><br>
    Enter your Name: <input type="text" name="cstName" required ><br><br>
    Enter Title of book : <input type="text" name="title" required ><br><br>
    Enter book author: <input type="text" name="author"><br><br>
    Enter no of days: <input type="number" name="days" required ><br><br>
    <input type="submit" name="btnIssue" value="issue">
</form>

<%
    if(request.getParameter("btnIssue")!=null){
        String rno=request.getParameter("rno");
        String name=request.getParameter("cstName");
        String title=request.getParameter("title");
        String author=request.getParameter("author");
        int days=Integer.parseInt(request.getParameter("days"));
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        LocalDateTime date = LocalDateTime.now();
        String strDate=formatter.format(date);

        try{
        DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
		String url="jdbc:mysql://localhost:3306/LibMngSys_proj";
		
		Connection con=DriverManager.getConnection(url,"root","Harsh@12345");
		String sql= "delete from avlbks where btitle=? and bauthor=? limit 1";
        PreparedStatement pst;
		pst=con.prepareStatement(sql);
        pst.setString(1,title);
        pst.setString(2,author);
        int rows=pst.executeUpdate();

        if(rows!=0){
            String sql2= "insert into isbks values(?, ?, ?, ?, ?, ?)";
		    PreparedStatement pst1=con.prepareStatement(sql2);
            pst1.setString(1,rno);
            pst1.setString(2,name);
            pst1.setString(3,title);
            pst1.setString(4,author);
            pst1.setInt(5,days);
            pst1.setString(6,strDate);
            pst1.executeUpdate();
            out.println("Book: "+title+", issued to "+name);
        }
        else{
            out.println("The required book not available.");
        }
        }
        catch(SQLException se){
            out.println("issue "+se);
        }

}
    

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
<a href="home.jsp">Back</a><br><br>
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