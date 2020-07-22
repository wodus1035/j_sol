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


int cur_c_number;
if(request.getParameter("cur_c_number") == null)
	cur_c_number = c_number;
else
	cur_c_number = Integer.parseInt( request.getParameter("cur_c_number"));

System.out.println("wo rd debug!! : " + word);
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

int total = dao.getNowlist_count(cur_c_number); //총 게시물 수
int allPage = (int) Math.ceil(total/(double)rowSize); //페이지수
//int totalPage = total/rowSize + (total%rowSize==0?0:1);
int block = 10; //한페이지에 보여줄  범위 << [1] [2] [3] [4] [5] [6] [7] [8] [9] [10] >>

int fromPage = ((pg-1)/block*block)+1;  //보여줄 페이지의 시작
int toPage = ((pg-1)/block*block)+block; //보여줄 페이지의 끝
if(toPage> allPage){ // 예) 20>17
    toPage = allPage;
}


ArrayList<Board> list = null;
ArrayList<Board> all_list = null;
ArrayList<Board> date_list = null;
ArrayList<Board> Search_list = null;


//방문자 현황에 표시될 리스트
int count = total;

//기간검색 체크 누르고 검색창에 내용 검색할 
if (day_check.equalsIgnoreCase("y") && word !=""){
	all_list = dao.getNow_All_list(start_date, end_date, col, word, cur_c_number);
	list = all_list;
	count = all_list.size();
	if(list.size() ==0){
		out.println("<script>alert('검색결과가 없습니다!!');location.href='Visitor_now.jsp';</script>");
	}
	System.out.println("alllist check");
//기간감섹 체크만 누르고 했을 때
}else if(day_check.equalsIgnoreCase("y") && word == "" ){
	date_list = dao.getNow_Day_List(start_date, end_date,cur_c_number);
	list = date_list;
	count = date_list.size();
	if(list.size() ==0){
		out.println("<script>alert('검색결과가 없습니다!!');location.href='Visitor_now.jsp';</script>");
	}
	System.out.println("date_list check!");
//기간검색 체크 안누르고 검색창에 내용 검색할 때
}else if(!day_check.equalsIgnoreCase("y")&& (word!=null || word=="") ){
	Search_list = dao.Visitor_Search(col, word, cur_c_number);
	list = Search_list;
	count = Search_list.size();
	if(list.size() ==0){
		out.println("<script>alert('검색결과가 없습니다!!');location.href='Visitor_now.jsp';</script>");
	}
	System.out.println("search_list check!");
//그 외의 경우
}else{
	list = dao.getNow_paging_List((pg-1)*20 ,cur_c_number);
}
	System.out.println("list:  " + list);
String Accept = "비동의";
String ips_check ="없음";
String admission_check = "없음";
String fever_check = "없음";

ArrayList<company> companys = null;
if("M".equals(c_type)){
	companys = dao.getCompanys();
}

%>
            <div id="layoutSidenav_content">
				<main><div class="container-fluid">
	<div class="row">
		<div class="col-md-6"><h4 class="mt-4" style="display:flex;">방문자 현황</h4></div>
		<%if("M".equals(c_type)){%>
		<div class="col-md-6" style="text-align:right;">
			기관선택 &nbsp;: &nbsp;
			<form name="selectcom" action="#">
			<%if(strPg != null){ %>
			<input type="hidden" name="searchText" value="<%=word %>"/>
			<input type="hidden" name="searchMode" value="<%=col %>"/>
			<input type="hidden" name="pg" value="<%=strPg %>"/>
			<input type="hidden" name="end_date" value="<%=end_date %>"/>
			<input type="hidden" name="start_date" value="<%=start_date %>"/>
			<input type="hidden" name="date_search_flag" value="<%=day_check %>"/>
			<%} %>
			<select id="cur_c_number" name="cur_c_number" onchange="selectcompany()">
				<option value="1"  selected >전체</option>
				<%for(int i = 1; i < companys.size(); i ++){ %>
					<option value="<%=companys.get(i).getCompany_number()%>" <%if(companys.get(i).getCompany_number() == cur_c_number){ %> selected<%} %>><%=companys.get(i).getCompany_name() %></option>
				<%} %>
			</select>
			</form>
		</div>
		<%} %>
	</div>
	<div class="card mb-4">
			<div class="card-header">
				<div class="form-inline row">
					<div class="col-sm-30">
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
									<option value="name" >성함</option>
									<%if("M".equals( c_type) || "A".equals( c_type)){%>
									<option value="birth" >주민번호</option>
									<%}else{ %>
									<option value="birth" >생년월일</option>
									<%} %>
									<option value="phone" >핸드폰번호</option>
								</select>
								&nbsp; 
								<input type="text" class="g2-form-control col-sm-2" id="searchText" name="searchText" value="" placeholder="검색어 입력"/>			
							</div>	
							
							<div class="form-group fl-right pL10">
								<button type="submit" id="searchButton" class="btn fl-right btn-sm g2-btn-warning click-search" ><i class="fas fa-search"></i> 검색</button>
							</div>
							<div class="form-group fl-right pL5">
								<button type="button" class="btn fl-right btn-sm g2-btn-info click-cancel" onclick='location.href="Visitor_now.jsp"'><i class="fas fa-redo-alt"></i> 취소</button>
							</div>
							<div class="form-group fl-right pL10">
								<button type="button" class="btn fl-right btn-sm g2-btn-warning click-search" onclick='if(confirm("엑셀파일로 다운로드하시겠습니까?")){location.href="now_excel_download.jsp"}else{return;}'>엑셀다운로드</button>
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
								

									<%=count%> 건									</div>
							</div>
						</div>
						<!-- 전체 리스트 수 출력 [ END ] -->
					</div>
					<div class="table-responsive">
						<table class="table table-bordered fs14" id="" width="100%" cellspacing="0">
							<thead>
								<tr class="text-align-center">
									<th><input id="selectall" type="checkbox" onclick="checkselall()"/>No</th>
									<%if("M".equals( c_type)){%>
									<th>기관명</th>
									<%} %>
									<th>날짜</th>
									<th>입장시간</th>
									<th>퇴장시간</th>
									<th>이름</th>
									<%if("M".equals( c_type) || "A".equals( c_type)){%>
									<th>주민번호</th>
									<%}else{ %>
									<th>생년월일</th>
									<%} %>
									<th>전화번호</th>
									<th>방문유형</th>
									<th>체온</th>
									
									<th>해외여행여부</th>
									<th>발열/기침증상</th>
									<%if("A".equals( c_type) || "M".equals( c_type)){%>
									<th>타병원입원여부</th>
									<%} %>
									<th>개인정보동의</th>
									<th>승인여부</th>
									<th>메모</th>
								</tr>
							</thead>
							<tbody>
																		
											<% 					
												
												if(list.size()!=0){//방문자 현황에 한명이라도 있을경우 불러옴
													for(int i=0;i<list.size();i++){		
											%>
											
											<tr class="fs14 text-align-center">	
												<td>
													<input id="selectbox<%=i+1%>" class="selectbox" type="checkbox" name="selected" value="<%=list.get(i).getNumber() %>" onclick="checksel()"/>
													<%=from+i%>
												</td>
												<%if("M".equals( c_type)){%>
												<% String c_nametmp = dao.getCompany_name(list.get(i).getCompany_id()) ;if(c_nametmp == null){   %>
												<td>존재하지 않는 회사</td>
												<%}else{ %>
												<td><%=c_nametmp%></td>
												<%} %>
												<%} %>
												<td><%=list.get(i).getEntry_time().split(" ")[0] %></td>
												<td><%if(list.get(i).getEntry_time() != null ){ out.print(list.get(i).getEntry_time().split(" ")[1]); } %></td>
												<td><%if(list.get(i).getGo_time() == null){ out.print("-"); }else{ out.print(list.get(i).getGo_time().split(" ")[1]); }%></td>
												<td><div class="copy" onclick="copytext(this)"><%=list.get(i).getName() %></div></td>
												<td><%=list.get(i).getBirth_d()%></td>
												<td><div class="copy" onclick="copytext(this)"><%=list.get(i).getPhone()%> </div></td>
												<td><%=list.get(i).getCategory()%></td>
												<%if(list.get(i).getTemperature() > 38.0){ %>
												<td style="background-color:red; color:white;"><%=list.get(i).getTemperature()%></td>
												<%}else{ %>
												<td><%=list.get(i).getTemperature()%></td>
												<%} %>
												
												<%
												if(list.get(i).getTravel() == null){
													ips_check = "-";
												}
												else if(list.get(i).getTravel().equalsIgnoreCase("Y")){
												ips_check = "있음";	 
												}else{
												ips_check = "없음";
												}
												%>
												<td><%=ips_check%></td>
												
												<%
												if(list.get(i).getFever_check_flag() == null){
													fever_check = "-";
												}
												else if(list.get(i).getFever_check_flag().equalsIgnoreCase("Y")){
												fever_check = "있음";
												}else{
													fever_check="없음";													
												}
												%>
												<td><%=fever_check%></td>
												<%if("A".equals( c_type) || "M".equals( c_type)){%>
												<%
												if(list.get(i).getOther_hospital() == null){
													admission_check = "-";
												}
												else if(list.get(i).getOther_hospital().equalsIgnoreCase("Y")){
												admission_check = "있음";	 
												}else{
													admission_check = "없음";
												}
												%>
												<td><%=admission_check%></td>
												<%} %>
												
												<% if(list.get(i).getAceept().equalsIgnoreCase("Yes") || list.get(i).getAceept().equalsIgnoreCase("y") ){
												Accept = "동의";	 
												}else{
												Accept = "비동의";
												}
												%>
												<td><%=Accept%></td>
												<td>승인</td>
												<td><%= list.get(i).getEtc() %></td>
												<% 
												}
											}
											%>
											</tr>
									
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

			})
})

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

function deleteselected(){
	var url = "Visitor_del.jsp?";
	for(var i = 1; i <= <%=list.size()%>; i ++){
		if(i > 1){
			url+="&";
		}
		if($("#selectbox"+i).is(":checked") == true){
			url += "selected=" + $("#selectbox"+i).val();
		}
	}
	url += "#";
	window.open(url,"id check", "toolbar=no, width=300, height=150, top=150, left=150");
	
}
function changeselected(){
	var number = $(".selectbox:checked").val();
	url="now_modify.jsp?number="+number;
	window.open(url, "", "width=400, height=700, left=500, top=50");
}

function copytext(s){
	 var tempElem = document.createElement('textarea');
	  tempElem.value = s.innerText;  
	  document.body.appendChild(tempElem);

	  tempElem.select();
	  document.execCommand("copy");
	  document.body.removeChild(tempElem);
	alert("복사되었습니다.");
}
</script> 	
</body>

</html>