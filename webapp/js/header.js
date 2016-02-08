
var content="<div style='padding-top:18%;padding-left:40%;font-size:18px;line-height:30px;color: #c30'>"+
'警告: 如果看到该页面,可能是因为:<div style="list-style: decimal outside;"><div><span>1. 您的浏览器没有启用JavaScript功能;</span></div>'+
'<div><span>2. 请确认您访问的是九点科技官网地址 <b><a href="www.jiudian.com">www.jiudian.com</a></b>.</span></div></div></div>';
var _dyid = document.getElementById("_dyid").value;
try{
	if(document.getElementById(_dyid)){
		document.getElementById(_dyid).style.display='none';
	}else{
		document.getElementsByName("dyym").innerHTML = content;
	}
}catch(e){}	
