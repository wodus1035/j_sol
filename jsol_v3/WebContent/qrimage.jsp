<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="com.google.zxing.BarcodeFormat" %>
<%@ page import="com.google.zxing.common.BitMatrix" %>
<%@ page import="com.google.zxing.qrcode.QRCodeWriter" %>
<%@ page import="com.google.zxing.client.j2se.MatrixToImageWriter" %>
<%
//qr 코드 이미지를 내보내줌
request.setCharacterEncoding("UTF-8");
	String text = request.getParameter("src");
	if(request.getParameter("c_type") != null)
		text += "&c_type=" + request.getParameter("c_type");
	int width = 400, height = 400;
	QRCodeWriter q = new QRCodeWriter();
	 
	 text = new String(text.getBytes("UTF-8"), "ISO-8859-1");
	 
	 BitMatrix bitMatrix = q.encode(text, BarcodeFormat.QR_CODE, width, height);

	 out.clear(); // clear buffer

	 ServletOutputStream outputStream = response.getOutputStream();

	 MatrixToImageWriter.writeToStream(bitMatrix, "png", outputStream);

	 outputStream.flush();
	 outputStream.close();
%>