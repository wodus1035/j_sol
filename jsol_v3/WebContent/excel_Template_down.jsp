<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.io.InputStream" %>
<%@page import="java.io.OutputStream" %>
<%@page import="java.io.File"%>
<%@ page import="java.io.IOException"%>
<%@page import= "java.io.FileInputStream"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@include file="form_setup.jsp" %>
<%


String savePath="";
String saveFolder="excelTemplate";
String filename = null;

if(c_type.equals("A")){
	filename = "회원정보(병원).xlsx";
}
else if(c_type.equals("B")){
	filename = "회원정보(교회).xlsx";
}else if(c_type.equals("C")){
	filename = "회원정보(노래방,pc방 등).xlsx";
}else if(c_type.equals("D")){
	filename = "회원정보(햑원).xlsx";
}else{
	filename = "회원정보(병원).xlsx";
}

ServletContext context = getServletContext();
savePath = context.getRealPath(saveFolder); 

//여기부터 화일 다운로드 창이 자동으로 뜨게 하기 위한 코딩(임시화일을 스트림으로 저장)

File file = new File (savePath+"/"+filename); //해당 경로의 파일 객체를 만든다.
String filenameOrg =  new String(filename.getBytes("UTF-8"),"ISO-8859-1"); //크롬일때 : 해당 파일명 한글로 변환


byte[] bytestream = new byte[(int)file.length()]; //파일 스트림을 저장하기 위한 바이트 배열 생성.

FileInputStream filestream = new FileInputStream(file); //파일 객체를 스트림으로 불러온다.
int i = 0, j = 0; //파일 스트림을 바이트 배열에 넣는다.
while((i = filestream.read()) != -1) {
bytestream[j] = (byte)i;
j++;
}
 //FileInputStream을 닫아줘야 file이 삭제된다.

/* try{
boolean success = file.delete(); //화일을 생성과 동시에 byte[]배열에 입력후 화일은 삭제
if(!success) System.out.println("<script>alert('not success')</script>");
} catch(IllegalArgumentException e){
System.err.println(e.getMessage());
} */

response.setContentType("application/x-msdownload;charset=UTF-8"); //응답 헤더의 Content-Type을 세팅한다.
response.setHeader("Content-Disposition","attachment; filename=\"" + filenameOrg+ "\"");



OutputStream outStream = response.getOutputStream(); // 응답 스트림 객체를 생성한다.
outStream.write(bytestream); // 응답 스트림에 파일 바이트 배열을 쓴다.
//outStream.flush();
outStream.close();
filestream.close();

%>

</body>
</html>