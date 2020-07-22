<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DB_Util.BoardDAO"%>
<%@ page import="DB_Util.Board"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DB_Util.Member" %>
<%@ page import="DB_Util.company" %>


<!DOCTYPE html>
<style>
	#qrbtt{
		cursor:pointer;
	}
	.sortbtt{
		text-decoration: underline;
		cursor:pointer;
	}
</style>
<html>
<%@ include file="manage_header.jsp" %>
<%
request.setCharacterEncoding("utf-8"); 

int cur_c_number;
if(request.getParameter("cur_c_number") == null)
	cur_c_number = c_number;
else
	cur_c_number = Integer.parseInt( request.getParameter("cur_c_number"));

String word = request.getParameter("searchText");	
String col = request.getParameter("searchMode");
BoardDAO dao = BoardDAO.getInstance();

String strPg = request.getParameter("pg");

int rowSize = 20;
int pg = 1;

if(strPg != null){ //list.jsp?pg=2
    pg = Integer.parseInt(strPg); //.저장
}

int from = (pg * rowSize) - (rowSize-1); //(1*10)-(10-1)=10-9=1 //from
int to=(pg * rowSize); //(1*10) = 10 //to

int total = dao.getMember_count(cur_c_number); //총 게시물 수
int allPage = (int) Math.ceil(total/(double)rowSize); //페이지수
//int totalPage = total/rowSize + (total%rowSize==0?0:1);
int block = 10; //한페이지에 보여줄  범위 << [1] [2] [3] [4] [5] [6] [7] [8] [9] [10] >>

int fromPage = ((pg-1)/block*block)+1;  //보여줄 페이지의 시작
int toPage = ((pg-1)/block*block)+block; //보여줄 페이지의 끝
if(toPage> allPage){ // 예) 20>17
    toPage = allPage;
}

String sortrule = "1";
if(request.getParameter("sortrule") != null)
	sortrule = request.getParameter("sortrule");


//ArrayList<Member> list = dao.getEnroll_List();
ArrayList<Member> list = dao.getAdmin_paging_List((pg-1)*20,cur_c_number, sortrule);
ArrayList<Member> Search_list = null;

int count = dao.getMember_count(cur_c_number);

if(word!=null || word== ""){
	Search_list = dao.Member_Search(col, word, cur_c_number, sortrule);
	list=Search_list;
	total = list.size();
	allPage = (int) Math.ceil(total/(double)rowSize);
	if(toPage> allPage){ // 예) 20>17
	    toPage = allPage;
	}
	count = list.size();
	if(list.size()==0){
		out.println("<script>alert('검색결과가 없습니다!!');location.href='Visitor_admin.jsp';</script>");
	}
}

String Accept = "비동의";

ArrayList<company> companys = null;
if("M".equals(c_type)){
	companys = dao.getCompanys();
}


%>

            <div id="layoutSidenav_content">
				<main>
<div class="container-fluid">
	<div class="row">
		<div class="col-md-6"><h4 class="mt-4" style="display:flex;">방문자 관리</h4></div>
			
			<div class="col-md-6" style="text-align:right;">
			
				<form name="selectcom" action="#">
				<%if(word!=null || word== ""){ %>
					<input type="hidden" name="searchText" value="<%=word %>"/>
					<input type="hidden" name="searchMode" value="<%=col %>"/>
					<%} %>
					<input type="hidden" name="sortrule" value="<%=sortrule %>"/>
					<%if("M".equals( c_type)){%>
					기관선택 &nbsp;: &nbsp;
					<select id="cur_c_number" name="cur_c_number" onchange="selectcompany()">
						<option value="1"  selected >전체</option>
						<%for(int i = 1; i < companys.size(); i ++){ %>
							<option value="<%=companys.get(i).getCompany_number()%>" <%if(companys.get(i).getCompany_number() == cur_c_number){ %> selected<%} %>><%=companys.get(i).getCompany_name() %></option>
						<%} %>
					</select>
					<%} %>
				</form>
			</div>
			
		
	</div>
	<div class="card mb-4">
		<!-- <form id="copyClip" name="copyClip" method="post">
			<input type="hidden" id="name" name="name" value=""/>
			<input type="hidden" id="birth" name="birth" value=""/>
		</form> -->
		<!-- <form id="confirmForm" name="confirmForm" method="post">
			<input type="hidden" id="procMode" name="procMode" value=""/>	
			<input type="hidden" id="list_id" name="list_id" value=""/>
			<input type="hidden" id="confirm_flag" name="confirm_flag" value=""/>
			<input type="hidden" id="ips_check_flag" name="ips_check_flag" value=""/>
			<input type="hidden" id="admission_check_flag" name="admission_check_flag" value=""/>
		</form>
 -->
		
			<div class="card-header">
				<div class="form-inline row">
					<div class="col-sm-50">
						<!-- 검색 영역 [START] -->
				<form id="search" action="Visitor_admin.jsp" method="get">	
						<input type="hidden" name="cur_c_number" value="<%=cur_c_number%>"/>
						<input type="hidden" name="sortrule" value="<%=sortrule %>"/>
						<div class="row pL40">				
							<div class="form-group row fs14 fl-right">
								<i class="fas fa-keyboard fs20"></i> &nbsp;
								단어검색 &nbsp;: &nbsp;
								
								<select id="searchMode" name="searchMode" class="g2-form-control col-sm-3 fs12" >
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
								
								<input type="text" class="g2-form-control col-sm-4" id="searchText" name="searchText" value="" placeholder="검색어 입력"/>	
							</div>	
							<div class="form-group fl-right pL10">
								<button type="submit" id="searchButton" class="btn fl-right btn-sm g2-btn-warning click-search"><i class="fas fa-search"></i> 검색</button>
							</div>				
					</form>
							<div class="form-group fl-right pL5">
								<button type="button" class="btn fl-right btn-sm g2-btn-info click-cancel" onclick='location.href="Visitor_admin.jsp"'><i class="fas fa-redo-alt"></i> 취소</button>
							</div>
							<div class="form-group fl-right pL5">
								<button type="button" class="btn fl-right btn-sm g2-btn-danger click-add-user" 
								onclick="window.open( 'register.jsp?c_number=<%=c_number%>&c_type=<%=c_type%>', '_blank');"><i class="fas fa-user-plus"></i> 방문자 등록</button>
							</div>
							<div class="form-group fl-right pL5">
								<button type="button" class="btn fl-right btn-sm g2-btn-warning click-search" onclick='if(confirm("엑셀파일로 다운로드하시겠습니까?")){location.href="admin_excel_download.jsp"}else{return;}'>엑셀다운로드</button>
							</div>
							<div class="form-group fl-right pL5" id="excelUploadbtt">
								<button type="button" class="btn fl-right btn-sm g2-btn-info click-search" onclick='document.file.file.click();'>엑셀업로드</button>
							</div>
					<form class="filebox" id="file" name="file" action="input_file.jsp" method="post" enctype="multipart/form-data">
						<input type="file" id="excel" name="file" style="display:none;" onchange="document.file.submit();">
					</form>
					<div class="form-group fl-right pL5">
								<button type="button" class="btn fl-right btn-sm g2-btn-warning click-search" 
								onclick='if(confirm("엑셀양식을 다운로드하시겠습니까?")){location.href="excel_Template_down.jsp"}else{return;}'>엑셀양식다운로드</button>					
				</div>
					<div class="form-group fl-right pL5">
								<button type="button" id="deletebtt" class="btn btn-sm g2-btn-danger click-add-user" 
								onclick="deleteselected()" disabled="disabled">삭제</button>
							</div>
							<div class="form-group fl-right pL5">
								<button type="button" id="changebtt" class="btn btn-sm g2-btn-info click-add-user" 
								onclick="changeselected()" disabled="disabled">수정</button>
							</div>
							<div class="form-group fl-right pL5">
								<button type="button" id="printbtt" class="btn btn-sm g2-btn-warning click-add-user" 
								onclick="printall()" disabled="disabled">출력</button>
							</div>
						</div>
						
						<!-- 검색 영역 [ END ] -->
					</div>
				</div>
			</div>
			
			<div class="card-body">
					<div class="form-inline row">
						<!-- 전체 방문자수 출력 [START] -->
						<div class="form-group col-sm-12 row fs14 fl-left">
							<label for="total-list" class="col-form-label fl-left pL15" style="width:auto;"><span style="color:#dc3545;font-weight:bold">전체</span> &nbsp;: &nbsp;</label>
							<div class="pL0 fl-left">
							<%=count%>명
															</div>
						</div>
						<!-- 전체 방문자수 출력 [ END ] -->
						
					</div>
					<div class="table-responsive">
						
				<!------ 등록된 방문자 ------->
						<table class="table table-bordered fs14" id="" width="100%" cellspacing="0">
							<thead>
								<tr class="text-align-center">
									<th><input id="selectall" type="checkbox" onclick="checkselall()"/>No</th>
									<th>회원번호</th>
									<%if("M".equals( c_type)){%>
									<th>기관명</th>
									<%} %>
									<th><div class="sortbtt" onclick="sortlist('name')">이름
									<%if("1".equals(sortrule)){ 
										out.print("(↑)");
									}else if("2".equals(sortrule)){
										out.print("(↓)");
									}
									%>
									</div></th>
									<th>등록일</th>
									<th><div class="sortbtt" onclick="sortlist('birth')">
									<%if("M".equals( c_type) || "A".equals( c_type)){%>
									주민번호
									<%}else{ %>
									생년월일
									<%} %>
									<%if("3".equals(sortrule)){ 
										out.print("(↑)");
									}else if("4".equals(sortrule)){
										out.print("(↓)");
									}
									%>
									</div></th>
									<th>전화번호</th>
									<th>방문유형</th>
									<th>개인정보동의</th>
									<th>QR</th>
									<!--<th>비고</th>-->
								</tr>
							</thead>
							<tbody>			
							<form name="selectform" action="Member_print_all.jsp" type="post" target="_blank">																												
							 <% 
								if(list.size()!=0){//방문자 현황에 한명이라도 있을경우 불러옴
								
									for(int i=0;i<list.size();i++){		
								%>
						<tr class="fs14 text-align-center">	
							<td>
								<input id="selectbox<%=i+1%>" class="selectbox" type="checkbox" name="selected" value="<%= list.get(i).getCompany_id() + "," + list.get(i).getBirth() + "," + list.get(i).getPhone() %>" onclick="checksel()"/>
								<%=from+i%>
							</td>
							<td><%=list.get(i).getM_number() %></td>
							<%if("M".equals( c_type)){%>
							<% String c_nametmp = dao.getCompany_name(list.get(i).getCompany_id()) ;if(c_nametmp == null){   %>
							<td>존재하지 않는 회사</td>
							<%}else{ %>
							<td><%=c_nametmp%></td>
							<%} %>
							<%} %>
							<td><div class="copy" onclick="copytext(this)"><%=list.get(i).getName() %></div></td>
							<td><%=list.get(i).getCreatetime().split(" ")[0] %></td>
							<td><%=list.get(i).getBirth()%></td>
							<td><div class="copy" onclick="copytext(this)"><%=list.get(i).getPhone()%> </div></td>
							<td><%=list.get(i).getPurpose()%></td>
								<% if(list.get(i).getIs_sign().equalsIgnoreCase("y") || list.get(i).getIs_sign().equalsIgnoreCase("yes") ){
									Accept = "동의";	 
								}
								%>
							<td><%=Accept%></td>
											
							<td><div id="qrbtt" onclick="openQR('<%=list.get(i).getCompany_id()+"&name=" + list.get(i).getName()+"&phone="+ list.get(i).getPhone() %>')">
							<img src="qrimage.jsp?src=<%="/!/"+list.get(i).getCompany_id()+","+list.get(i).getBirth()+","+ list.get(i).getPhone()+"/!@!/"%>" width="50px"></img>
							</div></td>														
						</tr>
							<% 
								}
							}
						
							%>				
							</form>														
							</tbody>
						</table>
					<!------ 등록된 방문자 출력------->	
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
                <a class="page-link" href="Visitor_admin.jsp?pg=1" aria-label="Previous">
                <span aria-hidden="true">&raquo;</span>
                </a>
                </li>  
                
                <li class="page-item ">
                <a class="page-link" href="Visitor_admin.jsp?pg=<%=fromPage-1%>" aria-label="Previous">
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
						 <a class="page-link" onclick="pagechange('<%=i%>')"><%=i%></a>
						 </li>
			<% 	
						}
					}
			%>
			<%
            if(toPage<allPage){ //다음, 이후 링크
       
        %>
        <li class="page-item ">
                <a class="page-link" onclick="pagechange('<%=toPage + 1%>')" aria-label="End">
                 <span aria-hidden="true">&gt;</span>
                 </a>
        </li>
        <li class="page-item ">
                <a class="page-link" onclick="pagechange('<%=allPage%>')" aria-label="End">
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
					<input id="clip_target" type="text" value="" style="position:absolute;top:-9999em;"/>
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
	<form name="page" action="#" type="post">
	<input name="pg" type="hidden" value=<%=pg %>>
	<%if(word!=null || word== ""){ %>
	<input type="hidden" name="searchText" value="<%=word %>"/>
	<input type="hidden" name="searchMode" value="<%=col %>"/>
	<%} %>
	<input type="hidden" name="sortrule" value="<%=sortrule %>"/>
	<input type="hidden" name="cur_c_number" value="<%=cur_c_number %>"/>
	</form>
</div>
<script src="resources/framework/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="resources/framework/sbAdmin/dist/js/scripts.js"></script>

<script src="resources/framework/sbAdmin/dist/js/jquery.dataTables.min.js"></script>
<script src="resources/framework/sbAdmin/dist/js/dataTables.bootstrap4.min.js"></script>
<script src="resources/framework/sbAdmin/dist/assets/demo/datatables-demo.js"></script>
<script type="text/javascript">
$(document)
.ready(
		function() {
$("#searchButton").click(function() {
				var searchCheck = 0;
				if ($("#searchText").val() == "") {
					alert("검색어를 입력해 주세요.")
					$("#searchBox").focus();//커서입력
					return false;
				}

			})
});
function selectcompany(){
	document.selectcom.submit();
}
function modify(phone){
	url="admin_modify.jsp?phone="+phone;
	window.open(url, "", "width=400, height=700, left=500, top=50");
	
}

function openQR(s){
	url = "check.jsp?company_id="+ s;
	window.open(url,"id check", "toolbar=no, width=250, height=400, top=150, left=150");
}

function checksel(){
	if($(".selectbox").is(":checked") == true){
		$("#deletebtt").removeAttr("disabled");
		$("#printbtt").removeAttr("disabled");
	}else{
		$("#deletebtt").attr("disabled","disabled");
		$("#printbtt").attr("disabled","disabled");
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
	var url = "Member_del.jsp?";
	for(var i = 1; i <= <%=list.size()%>; i ++){
		if($("#selectbox"+i).is(":checked") == true){
			if(i > 1){
				url+="&";
			}
			url += "selected=" + $("#selectbox"+i).val().split(",")[2];
		}
	}
	url += "#";
	window.open(url,"id check", "toolbar=no, width=300, height=150, top=150, left=150");
	//document.selectform.submit();
}
function changeselected(){
	var phone = $(".selectbox:checked").val().split(",")[2];
	url="admin_modify.jsp?phone="+phone;
	window.open(url, "", "width=400, height=700, left=500, top=50");
	//document.selectform.submit();
}
function printall(){
	var qrimage = $(".selectbox:checked").val();
	//url="admin_modify.jsp?phone="+qrimage;
	//window.open(url, "", "width=400, height=700, left=500, top=50");
	document.selectform.submit();
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

function sortlist(s){
	var form = document.selectcom;
	if(s == "name"){
		if(form.sortrule.value == "1")
			form.sortrule.value = "2";
		else
			form.sortrule.value = "1";
	}else{
		if(form.sortrule.value == "3")
			form.sortrule.value = "4";
		else
			form.sortrule.value = "3";
	}
	form.submit();
}

function pagechange(s){
	document.page.pg.value=s;
	document.page.submit();
}
</script>
</body>
</html>