<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DB_Util.DB_connection" %>
<%@ page import="DB_Util.Board" %>
<%@ page import="DB_Util.BoardDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DB_Util.Member" %>
<%@ page import="DB_Util.company" %>

<!DOCTYPE html>
<%@ include file="manage_header.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String day_check = request.getParameter("date_search_flag");
String start_date = request.getParameter("start_date");
String end_date = request.getParameter("end_date");
String word = request.getParameter("searchText");	
String col = request.getParameter("searchMode");
String strPg = request.getParameter("pg");


BoardDAO dao = BoardDAO.getInstance();

if(day_check == null){
	day_check = "n";
}

int rowSize = 20;
int pg = 1;

if(strPg != null){ //list.jsp?pg=2
    pg = Integer.parseInt(strPg); //.저장
}

int from = (pg * rowSize) - (rowSize-1); //(1*10)-(10-1)=10-9=1 //from
int to=(pg * rowSize); //(1*10) = 10 //to

int total = dao.getAdmlist_count(); //총 게시물 수
int allPage = (int) Math.ceil(total/(double)rowSize); //페이지수
//int totalPage = total/rowSize + (total%rowSize==0?0:1);
int block = 10; //한페이지에 보여줄  범위 << [1] [2] [3] [4] [5] [6] [7] [8] [9] [10] >>

int fromPage = ((pg-1)/block*block)+1;  //보여줄 페이지의 시작
int toPage = ((pg-1)/block*block)+block; //보여줄 페이지의 끝
if(toPage> allPage){ // 예) 20>17
    toPage = allPage;
}


ArrayList<company> list = null;
ArrayList<company> all_list = null;
ArrayList<company> date_list = null;
ArrayList<company> Search_list = null;


//방문자 현황에 표시될 리스트
int count = dao.getAdmlist_count();

//기간검색 체크 누르고 검색창에 내용 검색할 
if (day_check.equalsIgnoreCase("y") && word !=""){
	all_list = dao.getAdm_All_list(start_date, end_date, col, word);
	list = all_list;
	count = all_list.size();
	if(list.size() ==0){
		out.println("<script>alert('검색결과가 없습니다!!');location.href='Visitor_now.jsp';</script>");
	}
//기간감섹 체크만 누르고 했을 때
}else if(day_check.equalsIgnoreCase("y") && word == "" ){
	date_list = dao.getAdm_Day_List(start_date, end_date);
	list = date_list;
	count = date_list.size();
	if(list.size() ==0){
		out.println("<script>alert('검색결과가 없습니다!!');location.href='Visitor_now.jsp';</script>");
	}
//기간검색 체크 안누르고 검색창에 내용 검색할 때
}else if(!day_check.equalsIgnoreCase("y")&& (word!=null || word=="") ){
	Search_list = dao.Adm_Search(col, word);
	list = Search_list;
	count = Search_list.size();
	if(list.size() ==0){
		out.println("<script>alert('검색결과가 없습니다!!');location.href='Visitor_now.jsp';</script>");
	}
//그 외의 경우
}else{
	list = dao.getAdm_paging_List((pg-1)*20 );
}
	
String Accept = "비동의";
String ips_check ="없음";
String admission_check = "없음";
String fever_check = "없음";

%>
            <div id="layoutSidenav_content">
				<main><div class="container-fluid">
	<h4 class="mt-4" style="display:flex;">업체 현황</h4>
	<div class="card mb-4">
			<div class="card-header">
				<div class="form-inline row">
					<div class="col-sm-20">
						<!-- 검색 영역 [START] -->
				<form id="search" action="#" method="get" autocomplete="off">	
						<div class="row pL30">
							<div class="form-group row fs14 fl-right">
								<i class="far fa-calendar-alt fs20"></i> &nbsp;
								기간검색 
								&nbsp;
								<input type="checkbox" id="date_search_flag" name="date_search_flag" value="Y" />
								&nbsp;: &nbsp;
								<input type="text" class="g2-form-control col-sm-2" id="start_date" name="start_date" value="" placeholder="YYYY-MM-DD"/>
								&nbsp; ~ &nbsp;
								<input type="text" class="g2-form-control col-sm-2" id="end_date" name="end_date" value="" placeholder="YYYY-MM-DD"/>
								<span class="p10"></span>
								<i class="fas fa-keyboard fs20"></i> &nbsp;
								단어검색 &nbsp;: &nbsp;
								<select id="searchMode" name="searchMode" class="g2-form-control col-sm-2 fs12" >
									<option value="empty"  selected >선택</option>
									<option value="업체명" >업체명</option>
									<option value="관리자ID" >관리자ID</option>
									<option value="타입" >업체타입</option>
								</select>
								&nbsp; 
								<input type="text" class="g2-form-control col-sm-2" id="searchText" name="searchText" value="" placeholder="검색어 입력"/>			
							</div>	
							
							<div class="form-group fl-right pL10">
								<button type="submit" id="searchButton" class="btn fl-right btn-sm g2-btn-warning click-search" ><i class="fas fa-search"></i> 검색</button>
							</div>
							<div class="form-group fl-right pL5">
								<button type="button" class="btn fl-right btn-sm g2-btn-info click-cancel"><i class="fas fa-redo-alt"></i> 취소</button>
							</div>
							<div class="form-group fl-right pL5">
							<button type="button" id="deletebtt" class="btn btn-sm g2-btn-danger click-add-user" 
								onclick="deleteselected()" disabled="disabled">삭제</button>
								</div>
							<div class="form-group fl-right pL5">
								<button type="button" id="changebtt" class="btn btn-sm g2-btn-info click-add-user" 
								onclick="changeselected()" disabled="disabled">수정</button>
							</div>
						</div>
				</form>
						<!-- 검색 영역 [ END ] -->
					</div>
					<div class="col-sm-2">&nbsp;</div>
				</div>
			</div>
			<div class="card-body">
					<div class="form-inline row">
						<!-- 전체 리스트 수 출력 [START] -->
						<div class="col-sm-3">
							<div class="form-group row fs14">
								<label for="total-list" class="col-sm-3 col-form-label">전체 &nbsp;:</label>
								<div class="col-sm-9 pL0">
									<%=count%> 건
								</div>
							</div>
						</div>
						<!-- 전체 리스트 수 출력 [ END ] -->
					</div>
					<div class="table-responsive">
						<table class="table table-bordered fs14" id="" width="100%" cellspacing="0">
							<thead>
								<tr class="text-align-center">
									<th><input id="selectall" type="checkbox" onclick="checkselall()"/>No</th>
									<th>기관명</th>
									<th>등록일</th>
									<th>관리자ID</th>
									<th>관리자타입</th>
								</tr>
							</thead>
							<tbody>
								<form name="selectform" action="Admin_manage_del.jsp" type="get" target="_blank">						
								<% 					
									
									if(list.size()!=0){//방문자 현황에 한명이라도 있을경우 불러옴
										for(int i=0;i<list.size();i++){		
								%>
								
									<tr class="fs14 text-align-center">	
									<td>
									<input class="selectbox" type="checkbox" name="selected" value="<%=list.get(i).getCompany_id() %>" onclick="checksel()"/>
									<%=from+i%>
									</td> 
									<td><%=list.get(i).getCompany_name()%></td>
									<td><%=list.get(i).getCompany_createtime()%></td>
									<td><%=list.get(i).getCompany_id()%></td>
									<td><%=list.get(i).getCompany_type() %>
									<%
									if("M".equals(list.get(i).getCompany_type())){
										out.print("(최종관리자)");
									} else if("A".equals(list.get(i).getCompany_type())){
										out.print("(병원)");
									}else if("B".equals(list.get(i).getCompany_type())){
										out.print("(교회)");
									}else if("C".equals(list.get(i).getCompany_type())){
										out.print("(오락시설)");
									}else if("D".equals(list.get(i).getCompany_type())){
										out.print("(학원)");
									}
									%>
									
									</td>
									
									</tr>
									<% 
									}
								}
								%>
											
								</form>
							</tbody>
						</table>

					</div>
					<!-- paging [START] -->
					<div class="row mL0">
						<input type="hidden" id="pageno" name="pageno" value=""/>
<nav aria-label="Page navigation example">
	<ul class="pagination">
						
				<%
            if(pg>block){ //처음, 이전 링크
       
        %>
                <li class="page-item ">
                <a class="page-link" href="Visitor_now.jsp?pg=1" aria-label="Previous">
                <span aria-hidden="true">&raquo;</span>
                </a>
                </li>  
                
                <li class="page-item ">
                <a class="page-link" href="Visitor_now.jsp?pg=<%=fromPage-1%>" aria-label="Previous">
                <span aria-hidden="true">&gt;</span>
                </a>
                </li>
                  
        <%     
            }
        %>
					<% 
					
					for(int i=fromPage;i<=toPage;i++){

						if(i==pg){
					%>					 
					<li class="page-item active">
				<a class="page-link"><%=i%></a>
			</li>
			<%
						}
						else{
			%>			<li class="page-item">
						 <a class="page-link" href="Visitor_now.jsp?pg=<%=i%>"><%=i%></a>
						 </li>
			<% 	
						}
					}
			%>
			<%
            if(toPage<allPage){ //다음, 이후 링크
       
        %>
        <li class="page-item ">
                <a class="page-link" href="Visitor_now.jsp?pg=<%=toPage+1%>" aria-label="End">
                 <span aria-hidden="true">&gt;</span>
                 </a>
        </li>
        <li class="page-item ">
                <a class="page-link" href="Visitor_now.jsp?pg=<%=allPage%>" aria-label="End">
                 <span aria-hidden="true">&raquo;</span>
                 </a>
          </li>            
        <%     
            }
		%>
			</ul>
</nav>
				</div>
					<!-- paging [ END ] -->				
			</div>
	</div>
</div>
		</main>
		<footer class="py-4 bg-light mt-auto">
			<div class="container-fluid">
				<div class="d-flex align-items-center justify-content-between small">
					<div class="text-muted">Copyright &copy; J-SOLUTION JIPA 2020</div>
					<div>
						&nbsp;
					</div>
				</div>
			</div>
		</footer>
	</div>
</div>
<script src="resources/framework/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="resources/framework/sbAdmin/dist/js/scripts.js"></script>

<script src="resources/framework/sbAdmin/dist/js/jquery.dataTables.min.js"></script>
<script src="resources/framework/sbAdmin/dist/js/dataTables.bootstrap4.min.js"></script>
<script src="resources/framework/sbAdmin/dist/assets/demo/datatables-demo.js"></script>
<!-- // jQuery 기본 js파일 -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<!-- // jQuery UI 라이브러리 js파일 -->
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script> 

<script type="text/javascript">
$(document)
.ready(
		function() {
$("#searchButton").click(function() {
				var searchCheck = 0;
		
			
				if ($("#searchText").val() == "" && $("#start_date").val() == "" && $("#end_date").val() == "") {
					alert("검색어를 입력해 주세요.")

					$("#searchBox").focus();//커서입력
					return false;
				}
				if(($("#start_date").val()!=""|| $("#end_date").val()!="") && $("input[name=date_search_flag]:checked").val() != "Y" ){
					alert("기간검색을 체크해주세요!")
					return false;
				}
				if($("input[name=date_search_flag]:checked").val() == "Y" && ($("#start_date").val()==""|| $("#end_date").val()=="") ){
					alert("기간검색을 해주세요!")
					return false;
				}

			});
});
$(function() {
	$("#start_date").datepicker({
    	dateFormat:'yy-mm-dd',
    	showMonthAfterYear:true,
    	monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
		dayNamesMin: ['일','월','화','수','목','금','토']
    });
	$("#end_date").datepicker({
    	dateFormat:'yy-mm-dd',
    	showMonthAfterYear:true,
    	monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
		dayNamesMin: ['일','월','화','수','목','금','토']
    });
    
});

function selectcompany(){
	document.selectcom.submit();
}

function deleteselected(){
	document.selectform.submit();
}

function modify(number){
	url="now_modify.jsp?number="+number;
	window.open(url, "", "width=400, height=700, left=500, top=50");
	
	
}

function checksel(){
	if($(".selectbox").is(":checked") == true){
		$("#deletebtt").removeAttr("disabled");
	}else{
		$("#deletebtt").attr("disabled","disabled");
	}
	if($(".selectbox:checked").length == 1){
		$("#changebtt").removeAttr("disabled");
	}else{
		$("#changebtt").attr("disabled","disabled");
	}
}

function checkselall(){
	if($("#selectall").is(":checked") == true){
		$(".selectbox").prop("checked", true);
	}else{
		$(".selectbox").prop("checked", false);
	}
	checksel();
}

function changeselected(){
	var selectedcid = $(".selectbox:checked").val();
	url="Company_modify.jsp?c_id="+selectedcid;
	window.open(url, "", "width=400, height=700, left=500, top=50");
}
</script> 	
</body>

</html>