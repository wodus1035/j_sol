<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
/* qr코드 인식 기 */
/* 키보드 입력시 마다 체크해 키코드가 qr에 포함된다면 qri에 기록 qri가 /!@!/ 를 포함하고 있으면 identify_mod로 넘김 */
/*   /!@!/ 에서 거치형은 191,16,49,50,49,191 , 핸드형은 191,16,49,16,50,16,49,191 로 입력  */
$(document).ready(function(){
	var prevfocus;
	$(document).bind("keydown", function(s) {
		console.log("key : ", event.keyCode);
		//alert(event.keyCode);
		if(event.keyCode == 191){
			$("#qri").val($("#qri").val() + "/");
		}else if(event.keyCode == 188){
			$("#qri").val($("#qri").val() + ",");
		}else if((event.keyCode >= 48) && (event.keyCode <= 57)){
			if(event.keyCode == 49 && $("#qri").val().substring($("#qri").val().length-1, $("#qri").val().length) == "s"){
				$("#qri").val($("#qri").val().substring(0, $("#qri").val().length-1) + "!");
			}else if(event.keyCode == 49 && $("#qri").val().substring($("#qri").val().length-1, $("#qri").val().length) == "@"){
				$("#qri").val($("#qri").val() + "!");
			}else if(event.keyCode == 50 && $("#qri").val().substring($("#qri").val().length-1, $("#qri").val().length) == "s"){
				$("#qri").val($("#qri").val().substring(0, $("#qri").val().length-1) + "@");
			}else if(event.keyCode == 50 && $("#qri").val().substring($("#qri").val().length-1, $("#qri").val().length) == "!"){
				$("#qri").val($("#qri").val() + "@");
			}else{
				$("#qri").val($("#qri").val() + String.fromCharCode(event.keyCode));
			}
		}else if(event.keyCode == 16){
			$("#qri").val($("#qri").val() + "s");
		}else if(event.keyCode == 189){
			$("#qri").val($("#qri").val() + "-");
		}
		var cont = $("#qri").val();
		//alert(cont);
		
		if(cont.match("/!@!/")){
			$("#qriconf").val($("#qri").val());
			//var real= ;
			$("#qri").val(cont.substring(cont.lastIndexOf("/!/")+3, cont.lastIndexOf("/!@!/") ));
			//$('form').submit();
			url = "identify_mod.jsp?qrimage=" + $("#qri").val();
			//$("#qri").val("");
			window.open(url,"id check", "toolbar=no, width=300, height=150, top=150, left=150");
			//alert("SDFSDF");
			//prevfocus.focus();
		}
	});
});
</script>

<input type="hidden" id="qri" name="qrimage" autocomplete="off"/>
<input type="hidden" id="qriconf" autocomplete="off"/>