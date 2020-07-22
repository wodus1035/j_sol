<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(document).ready(function(){
	var prevfocus;
	$(document).bind("keydown", function(s) {
		var cont = $(":focus").val();
		if(document.activeElement.tagName != "INPUT" && document.activeElement.getAttribute("type") != "text"){
			//prevfocus = $(":focus");
			$("#qri").focus();
		}else{
			if((document.activeElement.getAttribute("maxlength") == "2" || document.activeElement.getAttribute("maxlength") == "1") && document.activeElement.innerText.contains("/")){
				$("#qri").focus();
				return;
			}
			if(cont.match("/!/")){
				//prevfocus = $(":focus");
				$("#qri").val(cont.substring(cont.indexOf("/!/"), cont.length-1));
				//prevfocus.val(cont.substring(0, cont.indexOf("/!/") ));
				$("#qri").focus();
			}
		}
	});
	$("#qri").bind("keyup paste", function(s) {
		var cont = $("#qri").val();
		//alert(cont);
		if(cont.match("/!@!/")){
			//var real= ;
			$("#qri").val(cont.substring(cont.indexOf("/!/")+3, cont.indexOf("/!@!/") ));
			//$('form').submit();
			url = "identify_mod.jsp?qrimage=" + $("#qri").val();
			$("#qri").val("");
			window.open(url,"id check", "toolbar=no, width=300, height=150, top=150, left=150");
			//prevfocus.focus();
		}
	    //$("#qri").val("");
	});
});

</script>

<input type="text" style="opacity:0;" id="qri" name="qrimage"/>