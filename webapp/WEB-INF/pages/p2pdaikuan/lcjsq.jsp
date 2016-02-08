<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
String _TITLE_ = "理财计算器 - P2P贷款 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" content="<%=_DESCRIPTION_ %>">
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="center_box" style="width: 100%;">
    	<div class="center" style="margin-top:40px;">
            <div class="pub_title_hf"><img src="<%=controller.getStaticPath(request)%>/images/lcjsq_tit.png"></div>
    	</div>
        <div class="plan_content_hf">
        	<div class="center">
                 <div class="jkjsq_box_hf">
                    <dl>
                        <dt>出借金额</dt>
                        <dd>
                        	<input name="cjje" type="text" class="jejs required isint mulriple-<%=configureProvider.format(SystemVariable.AUTO_BIDING_MULT_AMOUNT)%> min-size-<%=configureProvider.format(SystemVariable.AUTO_BIDING_MIN_AMOUNT)%>"  maxlength="9"/>
							<p tip>最低金额<%=configureProvider.format(SystemVariable.AUTO_BIDING_MIN_AMOUNT)%>元,且为100的倍数</p>
							<p errortip class="" style="display: none"></p>
                        </dd>
                    </dl>
                    <dl>
                        <dt>年利率</dt>
                        <dd>
                        	<input name="rating" type="text" class="required minf-size-10 maxf-size-24 jejs"  mtest="/^\d+(\d|(\.[1-9]{1}))$/" mtestmsg="只能有一位小数"  value="0"/><span>%</span>
							<p tip>利率精确到小数点后一位，范围10%-24%之间</p>
							<p errortip class="" style="display: none"></p>
                        </dd>
                    </dl>
                    <dl>
                        <dt>借款期限</dt>
                        <dd>
                            <div class="dd_box_hf">
                                <div class="select_bg"></div>
                                <div id="jkqx_hf" class="select_div">请选择</div>
                            </div>
                            <select class="select_hf jejs" id="select" onChange="show_sub01(this.options[this.options.selectedIndex].text)" style="width:305px;">
                            	<option value="">请选择</option>
                            	<option value="1">1个月</option>
								 <option value="3">3个月</option>
								<option value="6" >6个月</option>
								<option value="9" >9个月</option>
								<option value="12" >12个月</option>
								<option value="18" >18个月</option>
								<option value="24" >24个月</option>
                             </select>
                        </dd>
                    </dl>
                    <dl>
                        <dt>还款方式</dt>
                        <dd>
                            <div class="dd_box_hf">
                                <div class="select_bg"></div>
                                <div id="hkfs_hf" class="select_div">请选择</div>
                            </div>
                            <select class="select_hf jejs" id="hkfs" onChange="show_sub02(this.options[this.options.selectedIndex].text)" style="width:305px;">
                            	<option>请选择</option>
                                <% 
	                    			for(RepaymentType e :RepaymentType.values()){
	                    				if(e.equals(RepaymentType.XYHK)){
	                    					continue;
	                    				}
	                    		%>
	                    			<option value="<%=e%>" ><%=e.getName() %></option>
	                    		<%
	                    			}
	                    		%>
                             </select>
                             <p tip=""></p>
                        </dd>
                    </dl>
                    <div class="center" style=" float:left; text-align:center; margin-top:50px;">
                    <input type="button" class="jkjsq_btn_hf jsqks" value="开始计算" />
                    </div>
                 </div>
             </div>
             <div class="elect_info_hf" style="background:#f1f3f5; padding-bottom:40px;display: none;" id="showjs">
             	<div class="center">
                    <div style="padding:20px 0;display: none;" id="divs">
                	<p class="fs18c73">收益描述</p>
                    	<table width="100%" cellspacing="0" border="0" >
							<tbody>
                            	<tr>
                                	<td width="168" style="text-align:right;">出借金额</td>
                                    <td width="395"><span style="padding-left:20px;" id="mtoal">0.0</span>元</td>
                                    <td>应收利息<span style="padding-left:20px;" id="ghbx">0.0</span>元</td>
                                </tr>
                                <tr>
                                	<td width="168" style="text-align:right;">月收本息</td>
                                    <td width="395"><span style="padding-left:20px;" id="myhbx">0.0</span>元</td>
                                    <td>您将在<span style="font-size:18px; color:#176fa7;" id="mthns">3</span>个月后收回本息</td>
                                </tr>
							</tbody>
						</table>
                    </div>
                    <p class="fs18c73" style="padding-top:20px;">本息回收时间表</p>
                    <table width="100%" cellspacing="0" border="0" class="plan_tab_con01_hf jstr">
                    	<tbody>
                        </tbody>
                    </table>
                </div>
             </div>
             <div class="center">
                 <div class="elect_info_hf">
                    <p>等额本息，即借款人每月以相等的金额偿还借款本息，也是银行房贷等采用的方法。<br/>
    每月还息到期还本（扣首月利息）还款法是平台为保障投资人收益采用的一种还款方式。在借款者成功借款时从借款金额中扣除首期利息至投资人账户，往后<br/>
    每期还息，最后一期只还本金。<br/>
    每月还息到期还本（不扣首月利息）还款法是平台为保障投资人收益采用的一种还款方式。在借款者成功借款时每期还息，最后一期还当期利息和全部本金。<br/>
    使用利息计算器，能帮您计算每月的本息情况；同时，一份完整的本息偿还时间表，让您能更直观地了解还款本息详情 。<br/>
    注：因平台采用了以100元为一份的计算方式，每月还息到期还本的计算结果会存在偏差，具体情况请以账户中显示的信息为准。<br/>
  （例如：小明投资2000元，16%年利率，每月还息到期还本。每月每份收益100*16%/12保留2位小数四舍五入为1.33元，所以小明每月收益为2000/100*1.33=26.6元）
    </p>
                </div>
            </div>
         </div>
    </div>
    <div class=" clear"></div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript"
	src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript">
	Number.prototype.toFixed = function(d)
	  {
	      var s=this+"";if(!d)d=0;
	      if(s.indexOf(".")==-1)s+=".";s+=new Array(d+1).join("0");
	      if (new RegExp("^(-|\\+)?(\\d+(\\.\\d{0,"+ (d+1) +"})?)\\d*$").test(s))
	      {
	          var s="0"+ RegExp.$2, pm=RegExp.$1, a=RegExp.$3.length, b=true;
	          if (a==d+2){a=s.match(/\d/g); if (parseInt(a[a.length-1])>4)
	          {
	              for(var i=a.length-2; i>=0; i--) {a[i] = parseInt(a[i])+1;
	              if(a[i]==10){a[i]=0; b=i!=1;} else break;}
	          }
	          s=a.join("").replace(new RegExp("(\\d+)(\\d{"+d+"})\\d$"),"$1.$2");
	      }if(b)s=s.substr(1);return (pm+s).replace(/\.$/, "");} return this+"";
	};
	function accDiv(arg1,arg2){
		var t1=0,t2=0,r1,r2;
		try{t1=arg1.toString().split(".")[1].length;}catch(e){}
		try{t2=arg2.toString().split(".")[1].length;}catch(e){}
		with(Math){
		r1=Number(arg1.toString().replace(".",""));
		r2=Number(arg2.toString().replace(".",""));
		return (r1/r2)*pow(10,t2-t1);
		}
	}
	function accMul(arg1,arg2)
	{
		var m=0,s1=arg1.toString(),s2=arg2.toString();
		try{m+=s1.split(".")[1].length;}catch(e){}
		try{m+=s2.split(".")[1].length;}catch(e){}
		return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m);
	}
	Number.prototype.mul = function (arg){
		return accMul(arg, this);
	};
	
	function accAdd(arg1,arg2){
		var r1,r2,m;
		try{r1=arg1.toString().split(".")[1].length;}catch(e){r1=0;}
		try{r2=arg2.toString().split(".")[1].length;}catch(e){r2=0;}
		m=Math.pow(10,Math.max(r1,r2));
		return (arg1*m+arg2*m)/m;
	}
	
	Number.prototype.add = function (arg){
		return accAdd(arg,this);
	};
	
	
	Number.prototype.div = function (arg){
		return accDiv(this, arg);
	};
	
	function Subtr(arg1,arg2){
		var r1,r2,m,n;
		try{r1=arg1.toString().split(".")[1].length;}catch(e){r1=0;}
		try{r2=arg2.toString().split(".")[1].length;}catch(e){r2=0;}
		m=Math.pow(10,Math.max(r1,r2));
	     //last modify by deeka
		 //动态控制精度长度
		n=(r1>=r2)?r1:r2;
		return ((arg1*m-arg2*m)/m).toFixed(n);
	}
	Number.prototype.substr = function (arg){
		return Subtr(this, arg);
	};
	
		$(".jsqks").click( function() {
			if(checkValue()){
					$("#divs").show();
				//}else{
				//	$("#divs").hide();
				//}
				var $envs = $(".jejs");
				var toal = $envs.eq(0).val();
			  	var money = 100;
			  	var size = toal/money;
			  	//借款期限
			  	var month = $envs.eq(2).val();
			  	//借款年利率
			  	var year = $envs.eq(1).val();
				if($.trim(money) == "" || $.trim(month) == "" || $.trim(year) == "0"){
			  		return false;
			  	}
			  	$("#showjs").show();
			   var mln = (parseFloat(year)/12/100);
			   //月还本息
			   var s = ((parseFloat(parseInt(money)*mln*Math.pow((1+mln),month))/(Math.pow((1+mln),month)-1))).toFixed(2);
			   $("#mthns").html(month);
			   $("#myhbx").html(parseFloat(accMul(s, size)).toFixed(2));
			   $("#mtoal").html(toal);
			   
			//应收利息
			 var yslxh = 0; 
			 $(".jstr").html("");
             
			 var content='<tr class="leve_titbj_hf">';
				 content+='<td width="175">月份</td>';
				 content+='<td width="203" class="border_lr3">月收本息</td>';
				 content+='<td width="202">月收本金</td>';
				 content+='<td width="202" class="border_lr3">月收利息</td>';
 				 content+='<td>待收本息</td>';
				 content+='</tr>';
				 
			 var amount_remain = 100;
			 var totalYhbj = 0;
			 var zbx = 0;
				 
				 if($("#hkfs").val() == "<%=RepaymentType.MYHKDQHB2.name()%>"){
					 var ylx = parseFloat((mln*amount_remain)).toFixed(2);
					 var zlx = accAdd(accMul(ylx, month), amount_remain).toFixed(2);
					 $("#ghbx").html(parseFloat(accMul(ylx, size*month)).toFixed(2));
					 $("#myhbx").html(parseFloat(accMul(ylx, size)).toFixed(2));
					 for(var i=1;i<=month;i++){
						 	var bj = 0;
						 	if(i==month){
						 		bj = amount_remain;
						 	}
						 	var bx = accAdd(bj, ylx);
						 	zlx = Subtr(zlx, bx);
						 	content+='<tr>';
						  	content+='<td>'+i+'月</td>';
							content+='<td>'+parseFloat(accMul(bx, size)).toFixed(2)+'</td>';
							content+='<td>'+parseFloat(accMul(bj, size)).toFixed(2)+'</td>';
							content+='<td>'+parseFloat(accMul(ylx, size)).toFixed(2)+'</td>';
			 			    content+='<td>'+parseFloat(accMul(zlx, size)).toFixed(2)+'</td>';
							content+='</tr>';
					 }
					 $(".jstr").append(content);
				 }
			}
		});
		
		function checkValue(){
			var cjje = $("input[name='cjje']");
			var $error = cjje.nextAll("p[errortip]");
			var $tip = cjje.nextAll("p[tip]");
			if(parseInt(cjje.val()) % parseInt(100) != 0){
				$error.addClass("error_tip");
				$error.html("必须是"+100+"的倍数");
				$tip.hide();
				$error.show();
				return false;
			}else{
				$error.hide();
			}
			
			var nll  = $("input[name='rating']");
			var errorNll = nll.nextAll("p[errortip]");
			var nlltip = nll.nextAll("p[tip]");
			if(parseInt(nll.val()) < parseInt(10)){
				errorNll.addClass("error_tip");
				errorNll.html("小于最小范围值");
				nlltip.hide();
				errorNll.show();
				return false;
				
			}else if(parseInt(nll.val()) > parseInt(24)){
				errorNll.addClass("error_tip");
				errorNll.html("超出最大范围值");
				nlltip.hide();
				errorNll.show();
				return false;
			}else{
				errorNll.hide();
			}
			return true;
		}
		
		function show_sub01(v){
		 	document.getElementById("jkqx_hf").innerHTML=v;
		    }  
		function show_sub02(v){
		 	document.getElementById("hkfs_hf").innerHTML=v;
		}  

	</script>
</body>
</html>
