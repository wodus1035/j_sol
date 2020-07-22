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
<%@page import = "DB_Util.Board"%>
<%@page import = "DB_Util.BoardDAO"%>
<%@ include file="form_setup.jsp" %>

<%
		String formName = "";  
		String fileName = ""; 		
		int sizeLimit = 30 * 1024 * 1024 ;
		Vector<Object> vFileName = new Vector<Object>();  
		Vector<Object> vFileSize = new Vector<Object>();  
		String[] aFileName = null;  
		String[] aFileSize = null;  
		long fileSize = 0;

		String savePath="";
		String saveFolder="Fileupload/upload/";
		
		ServletContext context = getServletContext();
		savePath = context.getRealPath(saveFolder); 
			
		MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8");
		Enumeration<?> formNames = multi.getFileNames();
		
		while (formNames.hasMoreElements()) {   
			 
			 formName = (String)formNames.nextElement();   
			    fileName = multi.getFilesystemName(formName);   
			 
			 if(fileName != null) {   // 파일이 업로드 되면  
			 
			  fileSize = multi.getFile(formName).length();  
			  vFileName.addElement(fileName);  
			        vFileSize.addElement(String.valueOf(fileSize));   
			 }   
			 }  
		 aFileName = (String[])vFileName.toArray(new String[vFileName.size()]);  
		 aFileSize = (String[])vFileSize.toArray(new String[vFileSize.size()]);
        
		try {
            FileInputStream file = new FileInputStream(savePath+"/"+multi.getFilesystemName("file"));
        
            XSSFWorkbook workbook = new XSSFWorkbook(file);
            BoardDAO dao = BoardDAO.getInstance();
            
            String name=null;
            String birth=null;
            String phone=null;
            String purpose1=null;
            String purpose2=null;
            String is_sign=null;
            String createtime=dao.getnow_day();
            String date = null;
            date = dao.getDate();
            
            date = date.replaceAll("-", "");
        	date = date + "0001";
        	
            int i=0;
            //System.out.println("createtime:  " + createtime);
            int company_id=1;
            int check=0;
            
         	// 데이터 포멧터
    		DataFormatter formatter = new DataFormatter();
    		// 데이트 포맷
    		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
           
            int rowindex=0;
            int columnindex=0;
            //시트 수 (첫번째에만 존재하므로 0을 준다)
            //만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
            XSSFSheet sheet=workbook.getSheetAt(0);
            //행의 수
            int rows=sheet.getLastRowNum();
            System.out.println("rows:   " + rows);
     
            for(rowindex=1;rowindex<=rows;rowindex++){
            	name = null;
            	birth = null;
            	phone = null;
            	purpose1 = null;
            	purpose2 = null;
            	is_sign = null;
            	
                //행을읽는다
                XSSFRow row=sheet.getRow(rowindex);
                if(row ==null || row.getCell(0) == null){
                	continue;
                }
                else{
                    //셀의 수
                   // System.out.println("row.getcell:  " + row.getCell(0));
                    int cells=row.getPhysicalNumberOfCells();
                    for(columnindex=0; columnindex<=cells; columnindex++){
                        //셀값을 읽는다
                        XSSFCell cell=row.getCell(columnindex);
                        String value="";
                        //셀이 빈값일경우를 위한 널체크
                        if(cell==null){
                            continue;
                        }else{
                            //타입별로 내용 읽기
                        	 switch (cell.getCellType()){
                             case XSSFCell.CELL_TYPE_FORMULA:
                                 value=cell.getCellFormula()+"";
                                 break;
                             case XSSFCell.CELL_TYPE_NUMERIC:
                            	// 날짜 예외 처리
                            	 if (HSSFDateUtil.isInternalDateFormat(cell.getCellStyle().getDataFormat())) {
         							value = sdf.format(cell.getDateCellValue());
         						}
         						// 기타
         						else {
         							value = formatter.formatCellValue(cell);
         						}
                                 break;
                             case XSSFCell.CELL_TYPE_STRING:
                                 value=cell.getStringCellValue()+"";
                                 break;
                             case XSSFCell.CELL_TYPE_BLANK:
                                 value="";
                                 break;
                             case XSSFCell.CELL_TYPE_ERROR:
                                 value="";
                                 break;
                             }
                            if(columnindex==0){
                            	name =value;
                            }else if(columnindex==1){
                            	birth=value;
                            }else if(columnindex==2){
                            	phone=value;
                            }else if(columnindex==3){
                            	purpose1=value;
                            }else if(columnindex==4){
                            	purpose2=value;                    	
                            }
                            else if(columnindex==5){
                            	is_sign=value;
                            }
                        }
                       // System.out.println(rowindex+"번 행 : "+columnindex+"번 열 값은: "+value);
                    }
                    
                    if(purpose2!=null && purpose2!=""){
                    purpose1 = purpose1 +"(" +purpose2+")"; 
                    }
                    
               
                    if(phone==null || phone==""){
                    	phone = "-" + i;
                    	i++;
                    }
                   	if(birth==null || birth==""){
                   		birth ="-";
                   	}
                   	if(is_sign == null || is_sign==""){
                   		is_sign="y";
                   	}
                   
                  // System.out.println("name:  " + name + "birth:   " + birth + "phone:   " + phone + "purpose:  " + purpose1 + "is_sign:  " + is_sign
                		  // + "creattime:  " + createtime);
                                
                	long max_number = dao.getM_number();
                	long m_number = Long.parseLong(date);
                	
                	System.out.println("max_number:  " + max_number + "m_number:  "+ m_number);
                	if(m_number <= max_number){
                		m_number = max_number+1;
                	}
                  check = dao.signup(createtime, name, birth, phone, purpose1, is_sign,c_number,m_number,c_type);
                   
                  if(check == 0){
                  	  out.println("<script>alert('" + name + "님은 이미 등록되어있습니다.');</script>");
                }
                  
                
            }
        }
            if(check == 0){
            	  out.println("<script>alert('등록에 실패하셨습니다.'); location.href='Visitor_admin.jsp'</script>");
              }else{
            	  out.println("<script>alert('회원정보를 등록하셨습니다.');location.href='Visitor_admin.jsp'</script>");
              }
            workbook.close();
        }catch(Exception e) {
            e.printStackTrace();
        }
		File del_file = new File(savePath+"/"+multi.getFilesystemName("file"));
		if( del_file.exists() ){ 
			if(del_file.delete()){ 
				//System.out.println("파일삭제 성공"); 
			}else{ 
			//System.out.println("파일삭제 실패"); 
			}
		}else{ 
			//System.out.println("파일이 존재하지 않습니다.");
			} 
	
%>