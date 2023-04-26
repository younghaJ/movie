<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Servlet Test</title>
</head>
<body>
    <h1>Servlet Test</h1>
    <%
        // 서블릿에서 전달된 메시지를 출력합니다.
        out.println(request.getAttribute("message"));
        out.println(request.getAttribute("keyword"));
        Object data = request.getAttribute("message");
        String dataStr = (String) data;
        Object data1 = request.getAttribute("keyword");
        System.out.println(data);
        System.out.println(data1);
    %>
</body>
</html>