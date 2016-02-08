function switched(id){
	$(id).find("span").click(function(){
		$(id).find("span").removeClass('active');
		$(this).addClass('active');
		$(id).find("section").hide();
		$(id).find("section").eq($(this).index()).fadeIn("slow");
	
})}