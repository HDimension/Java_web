<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>联系客服页面</title>
	<link type="text/css" rel="stylesheet" href="../css/style.css"/>
	<script type="text/javascript" src="../js/javascript.js"></script>
	<script type="text/javascript" src="../js/jquery-3.4.1.js"></script>
	<c:if test="${empty user.username}">
		<script type="text/javascript">
			alert('请先登录');
			location.href="../front/login.jsp";
		</script>
	</c:if>
</head>
<body>
<%@include file="top.jsp" %>

<div id="middle">
	<div id="position">
		您现在的位置是&nbsp;&gt;&nbsp;<a href="index.jsp">网上商城</a>&nbsp;&gt;&nbsp;聊天室
	</div>
	<div id="chat">
		<div id="chatuser">
			<ul>
				<c:forEach var="chat_user" items="${userlist}">
					<li class="chatuser">${chat_user.username}<input type="hidden" name="chat_userid" value="${chat_user.id}"/></li>
				</c:forEach>
			</ul>
			<script>
				$(function(){
					$("#chatuser ul li[class='chatuser']").click(function(){
						$("#chatuser li[class='chatuser']").css({"background-color":"#FFFFFF"});
						$(this).css({"background-color":"#FFDDAA"});
						var chat_username = $(this).text();
						var chat_userid = $(this).children("input").val();
						location.href="../ChatServlet?action=openroom&chat_userid="+chat_userid+"&chat_username="+chat_username;
					});
				});
			</script>
		</div>
		<div id="chathead">${chat_username}</div>
		<div id="chatcontents">
			<c:forEach var="chat" items="${chatlist}">
				<div id="chatdatetime">${chat.chat_datetime}</div>
				<c:if test="${chat.chat_userid>0}">					
					<div id="chatword" align="left"><span>${chat.chat_contents}</span></div>
				</c:if>
				<c:if test="${chat.chat_userid==0}">
					<div id="chatword" align="right"><span>${chat.chat_contents}</span></div>
				</c:if>
			</c:forEach>
		</div>
		<div id="chattext">		
			<textarea name="chat_contents"></textarea>
			<input type="submit" value="发送" class="button"/>
			<script>
				$(function(){			
					$("#chattext input[type='submit']").click(function(){
						var chat_contents = $("#chattext textarea[name='chat_contents']").val();
						var chat_receive = ${chat_receive};
						location.href="../ChatServlet?action=chatuser&chat_contents="+chat_contents+"&chat_receive="+chat_receive;
					});
				});
			</script>	
		</div>
	</div>
</div>

<%@include file="../front/bottom.jsp" %>
</body>
</html>