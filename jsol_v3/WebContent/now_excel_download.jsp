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

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>exceldown_load</title>
<%@include file="form_setup.jsp" %>
<%

BoardDAO dao = BoardDAO.getInstance();
ArrayList<Board>now_list = dao.getNow_List(c_number);
if(c_type.equals("M")){
	now_list = dao.getNow_List_boss();
}
System.out.println("now_list size:   " + now_list.size());

int list_row = dao.getNowlist_count(c_number);

String admission_check_flag = null;
String fever_check_flag = null;
String ips_check_flag = null;
String company_name = null;

Map<String,Object>map=null;
ArrayList<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
ArrayList<String> columnList=new ArrayList<String>();

if(now_list != null && now_list.size()>0){
for(int i=0;i<list_row;i++){
	map=new LinkedHashMap<String,Object>();
	if(c_type.equals("M")){
    	company_name = dao.getC_name(now_list.get(i).getEntry_time());
    	map.put("기관명",company_name);
    }
	map.put("날짜",now_list.get(i).getEntry_time().split(" ")[0]); 
    if(now_list.get(i).getEntry_time() != null ){
    	map.put("입장시간",now_list.get(i).getEntry_time().split(" ")[1]); } 
    
	if(now_list.get(i).getGo_time() == null){ 
		map.put("퇴장시간","-"); }
	else{ 
		map.put("퇴장시간",now_list.get(i).getGo_time().split(" ")[1]); }
     
    map.put("이름",now_list.get(i).getName());
    if(c_type.equals("M") || c_type.equals("A")){
    	map.put("주민번호",now_list.get(i).getBirth_d());
    }else{
    map.put("생년월일",now_list.get(i).getBirth_d());
    }
    map.put("전화번호",now_list.get(i).getPhone());
    map.put("방문유형",now_list.get(i).getCategory());
 
    map.put("체온",now_list.get(i).getTemperature());
    
    if(now_list.get(i).getTravel() == null){
    	ips_check_flag = "-";
    }else if(now_list.get(i).getTravel().equalsIgnoreCase("n")||
    		now_list.get(i).getTravel().equalsIgnoreCase("no")){
    	ips_check_flag = "없음";  
    }else{
    	ips_check_flag = "있음";
    }
    map.put("해외여행여부",ips_check_flag);
    
    if(c_type.equals("M") || (c_type.equals("A"))){
    	if(now_list.get(i).getOther_hospital() == null){
    		admission_check_flag = "-";
    	}else if(now_list.get(i).getOther_hospital().equalsIgnoreCase("n") ||
    			now_list.get(i).getOther_hospital().equalsIgnoreCase("no")){
    		admission_check_flag = "없음";
    	}
    	else{
    		admission_check_flag= "있음";
    	}
    map.put("타병원입원여부",admission_check_flag);
    }
    if(now_list.get(i).getFever_check_flag() == null){
    	fever_check_flag = "-";
    }else if(now_list.get(i).getFever_check_flag().equalsIgnoreCase("n")||
    		now_list.get(i).getFever_check_flag().equalsIgnoreCase("no")){
    	fever_check_flag = "없음";  
    }else{
    	fever_check_flag = "있음";
    }
    
    map.put("발열/기침 증상",fever_check_flag);
    map.put("개인정보 동의",now_list.get(i).getAceept());
    
    list.add(map);	
}
}else{
	out.println("<script>alert('방문자정보가 없습니다.');location.href='Visitor_now.jsp';</script>");
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
XSSFSheet sheet=workbook.createSheet("방문자현황");
//엑셀의 행
XSSFRow row=null;
//엑셀의 셀
XSSFCell cell=null;
//임의의 DB데이터 조회
if(list !=null &&list.size() >0){
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
String filename = "방문자현황"+".xlsx";

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
String filenameOrg = new String(filename.getBytes("UTF-8"),"ISO-8859-1"); //크롬일시 : 해당 파일명 한글로 변환
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

%>


</head>
<body>

</body>
</html>