$(function(){	
	$("div.dialog_close").click(function(){
		$("#info").html("");
		$("div.popup_bg").hide();
		$("div.dialog").hide();
	});
	
	$("#cancel").click(function(){
		$("div.dialog").hide();
		$("div.popup_bg").hide();
	});
	
	$("#cancels").click(function(){
		$("div.dialog").hide();
		$("div.popup_bg").hide();
	});
});
// 封装信息消息文本.
	function showDialogInfo(msg,type){
		return '<div class="dialog w510 thickpos" style="margin:-80px 0 0 -255px;">'+
			  '<div class="dialog_close fr" onclick="closeInfo()"><a></a></div>'+
			  '<div class="con clearfix">'+
			    '<div class="d_'+type+' fl"></div>'+
			    '<div class="info fr">'+
			      '<p class="f20 gray33">'+msg+'</p>'+
			    '</div>'+
			    '<div class="clear"></div>'+
			    '<div class="dialog_btn"><a onclick="closeInfo()" class="btn btn07">关闭</a></div>'+
			  '</div>'+
			'</div>';
	}

	function showForwardInfo(msg,type,url){
		return '<div class="dialog w510"  style="margin:-150px 0 0 -255px;">'+
		'<div class="dialog_close fr" onclick="closeInfo()"><a></a></div>'+
	    '<div class="con clearfix">'+
	     ' <div class="d_'+type+' fl"></div>'+
	     ' <div class="dialog_btn"><a href="'+url+'" class="btn btn07">确 定</a><a onclick="closeInfo()" class="btn btn08">取 消</a></div> '+
	     '<div class="info fr"><p class="f20 gray33">'+msg+'</p></div>'+
	   ' </div>'+
	'</div>';
	}
	
	
	function newForwardInfo(width,msg,type,url){
		return '<div class="cgcz_box2" style="width:'+width+'px; margin-top:-140px; margin-left:-315px; display:block;">'+
		'<a href="javascript:void(0)" onclick="closeInfo()" class="tc_close"></a>'+
		'    <div class="ltc_top_left"></div>'+
		 '   <span class="ltc_span" style="width:'+(width-50)+'px;"></span>'+
		 '   <div class="ltc_top_right"></div>'+
		'<div class="ltc_centers">'+
		'	<div class="cgcz">'+
		   '     	<dl>'+
		   '        	<dt style="padding-left:64px; font-size:24px; width:auto; margin-bottom:20px;"><span class="cgcz0'+type+'"></span>'+msg+'</dt><!--01是√，02是 x ，03是！-->'+
		 '       </dl>'+
		 '       		 <p style="text-align:center;">'+
		 '           	 <a href="'+url+'" class="zr_submit">确&nbsp;认</a>'+
		 '               <a class="cancel" href="javascript:void(0)"  onclick="closeInfo()" style="font-size:13px;">取消</a>'+
		 '       		</p>'+
		
		 '   </div>'+
		   ' </div>'+
		   ' <div class="ltc_bottom_left"></div>'+
		   ' <span class="ltc_span" style="width:'+(width-50)+'px;"></span>'+
		   ' <div class="ltc_bottom_right"></div>'+
		'</div>';
	}
	
	function newSuccInfo(width,msg,type,url){
		return '<div class="cgcz_box2" style="width:'+width+'px; margin-top:-140px; margin-left:-315px; display:block;">'+
		'<a href="javascript:void(0)" onclick="closeInfo()" class="tc_close"></a>'+
		'    <div class="ltc_top_left"></div>'+
		 '   <span class="ltc_span" style="width:'+(width-50)+'px;"></span>'+
		 '   <div class="ltc_top_right"></div>'+
		'<div class="ltc_centers">'+
		'	<div class="cgcz">'+
		   '     	<dl>'+
		   '        	<dt style="padding-left:64px; font-size:24px; width:auto; margin-bottom:20px;"><span class="cgcz0'+type+'"></span>'+msg+'</dt><!--01是√，02是 x ，03是！-->'+
		 '       </dl>'+
		 '       		 <p style="text-align:center;">'+
		 '           	 <a href="'+url+'" class="zr_submit">确&nbsp;认</a>'+
		 '       		</p>'+
		 '   </div>'+
		   ' </div>'+
		   ' <div class="ltc_bottom_left"></div>'+
		   ' <span class="ltc_span" style="width:'+(width-50)+'px;"></span>'+
		   ' <div class="ltc_bottom_right"></div>'+
		'</div>';
	}
	
	function newDialogInfo(width,msg,type,url){
		return '<div class="cgcz_box2" style="width:'+width+'px; margin-top:-140px; margin-left:-315px; display:block;">'+
		'<a href="javascript:void(0)" onclick="closeInfo()" class="tc_close"></a>'+
		'    <div class="ltc_top_left"></div>'+
		 '   <span class="ltc_span" style="width:'+(width-50)+'px;"></span>'+
		 '   <div class="ltc_top_right"></div>'+
		'<div class="ltc_centers">'+
		'	<div class="cgcz">'+
		   '     	<dl>'+
		   '        	<dt style="padding-left:64px; font-size:24px; width:auto; margin-bottom:20px;"><span class="cgcz0'+type+'"></span>'+msg+'</dt><!--01是√，02是 x ，03是！-->'+
		 '       </dl>'+
		 '       <dl>'+
		 '       		 <p style="text-align:center;">'+
		 '           	 <a href="javascript:void(0);" onclick="closeInfo()"  class="zr_submit">关&nbsp;闭</a>'+
		 '       		</p>'+
		 '   </div>'+
		   ' </div>'+
		   ' <div class="ltc_bottom_left"></div>'+
		   ' <span class="ltc_span" style="width:'+(width-50)+'px;"></span>'+
		   ' <div class="ltc_bottom_right"></div>'+
		'</div>';
	}
	
	
	function showSuccInfo(msg,type,url){
		return '<div class="dialog w510"  style="margin:-150px 0 0 -255px;">'+
		'<div class="dialog_close fr" onclick="closeInfo()"><a></a></div>'+
	    '<div class="con clearfix">'+
	     ' <div class="d_'+type+' fl"></div>'+
	      '<div class="info"><p class="f20 gray33">'+msg+'</p></div>'+
	     ' <div class="dialog_btn"><a href="'+url+'" class="btn btn07">确 定</a></div> '+
	   ' </div>'+
	'</div>';
	}
	
	function closeInfo(){
		$("#info").html("");
		$("div.popup_bg").hide();
	}
	
	function cleartc(id){
		$("."+id).hide();
		$("div.popup_bg").hide();
	}
	