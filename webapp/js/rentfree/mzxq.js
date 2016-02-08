
$(function(){
	
	var islogin = $("#islogin").val();
	
	$(".tables").click(function(){
		$(".tables").removeClass("hover");
		$(this).addClass("hover");
		if(islogin=="true"){
			showdate();
		}
	});
	
	
	function showdate(){
		var $selectli = $(".hover");
		//获取选中ID名称
		var name = $selectli.attr("id");
		$(".iframes").hide();
		//通过选中ID显示Id对于的div
		var $selectdiv = $("div[name='"+name+"']");
		$selectdiv.show();
		//获取地址
		var url = $selectli.attr("src");
		//刷新对应div数据
		var myiframe = document.getElementById("f"+name);
		myiframe.src = url;
	}
	
	//初始化选中
	$("#xmjs").addClass("hover");
	if(islogin=="true"){
		showdate();
	}
});

