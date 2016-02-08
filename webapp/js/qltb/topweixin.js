function show(btnclass,boxclass){
	var Ttimer=null; 

	$("#top").find(btnclass).hover(function(){
		$("#top").find(boxclass).fadeIn(200);
	},function(){
		Ttimer=setTimeout(
			function(){
				$("#top").find(boxclass).hide()
			},30)
	  }
	);

	$("#top").find(boxclass).hover(
		
		function(){
			clearTimeout( Ttimer )
			$("#top").find(boxclass).show()
		
		},function(){
			$("#top").find(boxclass).hide();
			$("#top").find(btnclass).css('background','')
		
		}
	)
}
	show('.wx','.wxdw',"#00c500");
	show('.wb','.wbdw','#d94a39');

	$(".wxdw").hover(function(){
	
		$(".top-left").find("span").eq(2).attr('class','activewx');
	},function(){
		$(".top-left").find("span").eq(2).attr('class','wx allbtn');
	})
	$(".wbdw").hover(function(){
	
		$(".top-left").find("span").eq(3).attr('class','activewb');
	},function(){
		$(".top-left").find("span").eq(3).attr('class','wb allbtn');
	})