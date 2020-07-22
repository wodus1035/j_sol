<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@ page import="java.io.IOException"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import= "java.io.FileInputStream"%>
<%@page import= "org.apache.poi.xssf.usermodel.XSSFCell"%>
<%@page import= "org.apache.poi.xssf.usermodel.XSSFRow"%>
<%@page import= "org.apache.poi.xssf.usermodel.XSSFSheet"%>
<%@page import= "org.apache.poi.xssf.usermodel.XSSFWorkbook"%>
<%@page import= "org.apache.poi.hssf.usermodel.HSSFDateUtil"%>
<%@page import= "org.apache.poi.ss.usermodel.DataFormatter"%>
<%@page import="com.oreilly.servlet.*"%>
<%@page import="com.oreilly.servlet.multipart.*"%>
<%@page import= "DB_Util.Board"%>
<%@page import="DB_Util.BoardDAO"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.OutputStream" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.io.InputStream" %>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="DB_Util.Member" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>exceldown_load</title>
<%@include file="form_setup.jsp" %>
<%

String c_name = null;
String temp1 = null;
String temp2 = null;

BoardDAO dao = BoardDAO.getInstance();


ArrayList<Member>admin_list = dao.getAdmin_list(c_number);

//System.out.println("admin_list size:   " + admin_list.size());

//엑셀 로우 갯수
int list_row = dao.getMember_count(c_number);
//System.out.println("list_row:  " + list_row);

Map<String,Object>map=null;
ArrayList<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
ArrayList<String> columnList=new ArrayList<String>();
String company_name = null;

if(admin_list != null && admin_list.size()>0){
	
	for(int i=0;i<list_row;i++){
		map=new LinkedHashMap<String,Object>();
		company_name = dao.getCompany_name(c_number);
		if(c_type.equals("M")){
	    	company_name = dao.getCompany_name(admin_list.get(i).getCompany_id());
	    	map.put("기관명",company_name);
	    }
		map.put("회원번호", admin_list.get(i).getM_number());
		map.put("이름",admin_list.get(i).getName());
		map.put("등록일",admin_list.get(i).getCreatetime().split(" ")[0]);
		if(c_type.equals("M") || c_type.equals("A")){
	    	map.put("주민번호",admin_list.get(i).getBirth());
	    }
		else{
	    map.put("생년월일",admin_list.get(i).getBirth());
		}
	    map.put("전화번호",admin_list.get(i).getPhone());
	    map.put("방문유형",admin_list.get(i).getPurpose());
	    map.put("개인정보 동의",admin_list.get(i).getIs_sign());
	    
	    list.add(map);	
}

//System.out.println(list);
//MAP의 KEY값을 담기위함
if(list !=null &&list.size() >0){
  //LIST의 첫번째 데이터의 KEY값만 알면 되므로
  Map<String,Object>m=list.get(0);
  System.out.println(m);
  //MAP의 KEY값을 columnList객체에 ADD
  for(String k : m.keySet()){
      columnList.add(k);
  }
}

//System.out.println(columnList);

//1차로 workbook을 생성
XSSFWorkbook workbook = new XSSFWorkbook();
//2차는 sheet생성
XSSFSheet sheet=workbook.createSheet("방문자관리");
//엑셀의 행
XSSFRow row=null;
//엑셀의 셀
XSSFCell cell=null;
//임의의 DB데이터 조회
if(list !=null && list.size() >0){
	row=sheet.createRow((short)0);
	 for(int j=0;j<columnList.size();j++){
         //생성된 row에 컬럼을 생성한다
         cell=row.createCell(j);
         //map에 담긴 데이터를 가져와 cell에 add한다
         cell.setCellValue(columnList.get(j));
     }
    int i=1;
    for(Map<String,Object>mapobject : list){
        // 시트에 하나의 행을 생성한다(i 값이 0이면 첫번째 줄에 해당)
        row=sheet.createRow((short)i);
        i++;
        if(columnList !=null &&columnList.size() >0){
            for(int j=0;j<columnList.size();j++){
                //생성된 row에 컬럼을 생성한다
                cell=row.createCell(j);
                //map에 담긴 데이터를 가져와 cell에 add한다
                cell.setCellValue(String.valueOf(mapobject.get(columnList.get(j))));
            }
        }
    }
}

String savePath="";
String saveFolder="Filedownload/download/";
String filename = "방문자관리"+".xlsx";

ServletContext context = getServletContext();
savePath = context.getRealPath(saveFolder); 

System.out.println("savePath:    "+savePath);
FileOutputStream fileoutputstream= null;
fileoutputstream = new FileOutputStream(savePath+"/"+filename);
//파일을 쓴다
workbook.write(fileoutputstream);
//필수로 닫아주어야 함.
fileoutputstream.close();
workbook.close();
System.out.println("엑셀파일생성성공");

//여기부터 화일 다운로드 창이 자동으로 뜨게 하기 위한 코딩(임시화일을 스트림으로 저장)
File file = new File (savePath+"/"+filename); //해당 경로의 파일 객체를 만든다.
String filenameOrg = new String(filename.getBytes("UTF-8"),"ISO-8859-1"); //크롬일때 : 해당 파일명 한글로 변환

byte[] bytestream = new byte[(int)file.length()]; //파일 스트림을 저장하기 위한 바이트 배열 생성.
FileInputStream filestream = new FileInputStream(file); //파일 객체를 스트림으로 불러온다.
int i = 0, j = 0; //파일 스트림을 바이트 배열에 넣는다.
while((i = filestream.read()) != -1) {
bytestream[j] = (byte)i;
j++;
}
filestream.close(); //FileInputStream을 닫아줘야 file이 삭제된다.

 try{
boolean success = file.delete(); //화일을 생성과 동시에 byte[]배열에 입력후 화일은 삭제
if(!success) System.out.println("<script>alert('not success')</script>");
} catch(IllegalArgumentException e){
System.err.println(e.getMessage());
}
 
response.setContentType("application/x-msdownload;charset=UTF-8"); //응답 헤더의 Content-Type을 세팅한다.
response.setHeader("Content-Disposition","attachment; filename="+filenameOrg); //Content-Disposition 헤더에 파일 이름 세팅.

OutputStream outStream = response.getOutputStream(); // 응답 스트림 객체를 생성한다.
outStream.write(bytestream); // 응답 스트림에 파일 바이트 배열을 쓴다.
outStream.close();
}
else{
	out.println("<script>alert('방문자정보가 없습니다.');location.href='Visitor_amdin.jsp';</script>");
}
%>


</head>
<body>

</body>
</html>