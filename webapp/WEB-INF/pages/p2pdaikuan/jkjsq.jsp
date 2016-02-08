<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
String _TITLE_ = "借款计算器 - P2P贷款 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
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
	
	
	<div class="center_box" style="border-top:1px solid #ccccce;">
    	<div class="center" style="margin-top:40px;">
            <div class="pub_title_hf"><img src="<%=controller.getStaticPath(request)%>/images/new_images/jkjsq_tit.png"></div>
    	</div>
        <div class="plan_content_hf">
        	<div class="center">
                 <div class="jkjsq_box_hf">
                    <dl>
                        <dt>出借金额</dt>
                        <dd>
                            <input name="" type="text" class="required jejs isint mulriple-<%=configureProvider.format(SystemVariable.AUTO_BIDING_MULT_AMOUNT)%> min-size-<%=configureProvider.format(SystemVariable.AUTO_BIDING_MIN_AMOUNT)%>" maxlength="9" />
							<p tip>最低金额<%=configureProvider.format(SystemVariable.AUTO_BIDING_MIN_AMOUNT)%>,且为100的倍数</p>
							<p errortip class="" style="display: none"></p>
                        </dd>
                    </dl>
                    <dl>
                        <dt>年利率</dt>
                        <dd>
                             <input name="rating" type="text" class="required jejs minf-size-10 maxf-size-24 jejs"  mtest="/^\d+(\d|(\.[1-9]{1}))$/" mtestmsg="只能有一位小数"  value="0"/><span>%</span>
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
                            <select name="select" id="select" class="select_hf jejs" onchange="show_sub01(this.options[this.options.selectedIndex].text)">
                            	<option value="" selected="selected">请选择</option>
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
                             <select name="status" id="hkfs" class="select_hf jejs" onchange="show_sub02(this.options[this.options.selectedIndex].text)">
	                    			<option value="" selected="selected">请选择</option>
		                    		<% 
		                    			for(RepaymentType e :RepaymentType.values()){
// 		                    				if(e.equals(RepaymentType.DQYCXFQ)){
// 		                    					continue;
// 		                    				}
		                    		%>
		                    			<option value="<%=e%>" ><%=e.getName() %></option>
		                    		<%
		                    			}
		                    		%>
                    		</select>
                    		<p tip>请选择还款方式</p>
                        </dd>
                    </dl>
                    <div class="center" style=" float:left; text-align:center; margin-top:50px;">
                    <input type="button" class="jkjsq_btn_hf sumbitForme" fromname="form1" value="开始计算" /></div>
                 </div>
             </div>
             <div class="elect_info_hf" style="background:#f1f3f5; padding-bottom:40px;display: none" id="showjs">
             	<div class="center">
                	<p class="fs18c73">服务费情况</p>
                    <div>
                    	<table width="65%" cellspacing="0" border="0" class="level_table_hf">
							<thead>
								<tr>
									<td style="font-size:14px; color:#515151; padding-left:0px;">信用等级</td>
									<th><span class="star star07"></span></th>
									<th><span class="star star06"></span></th>
									<th><span class="star star05"></span></th>
									<th><span class="star star04"></span></th>
									<th><span class="star star03"></span></th>
									<th><span class="star star02"></span></th>
									<th><span class="star star01"></span></th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td style="font-size:14px; color:#515151; padding-left:0px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;费率</td>
									<td><%=Formater.formatRate(Float.parseFloat(configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_AA)))%></td>
									<td><%=Formater.formatRate(Float.parseFloat(configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_A)))%></td>
									<td><%=Formater.formatRate(Float.parseFloat(configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_B)))%></td>
									<td><%=Formater.formatRate(Float.parseFloat(configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_C)))%></td>
									<td><%=Formater.formatRate(Float.parseFloat(configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_D)))%></td>
									<td><%=Formater.formatRate(Float.parseFloat(configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_E)))%></td>
									<td><%=Formater.formatRate(Float.parseFloat(configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_HR)))%></td>
								</tr>
							</tbody>
							<tbody>
								<tr>
									<td style="font-size:14px; color:#515151; padding-left:0px; border-bottom:none;">实际费率</td>
									<td id="creaa" fl="<%=configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_AA)%>" >00</td>
									<td id="crea"  fl="<%=configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_A)%>" >00</td>
									<td id="creb"  fl="<%=configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_B)%>" >00</td>
									<td id="crec"  fl="<%=configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_C)%>" >00</td>
									<td id="cred"  fl="<%=configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_D)%>">00</td>
									<td id="cree"  fl="<%=configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_E)%>">00</td>
									<td id="crehr" fl="<%=configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_HR)%>">00</td>
								</tr>
							</tbody>
						</table>
                    </div>
                    <div style="padding:20px 0;" id="divs">
                    <p class="fs18c73" style="padding-top:20px;">借款描述</p>
                    	<table width="100%" cellspacing="0" border="0" >
							<tbody>
                            	<tr>
                                	<td width="168" style="text-align:right;">每月还本息</td>
                                    <td width="395"><span style="padding-left:20px;" id="myhbx">0.00</span>元</td>
                                    <td>您将在<span style="font-size:18px; color:#176fa7;" id="mthns">0</span>个月后还清借款 </td>
                                </tr>
                                <tr>
                                	<td width="168" style="text-align:right;">月利率</td>
                                    <td width="395"><span style="padding-left:20px;" id="yln">0.0</span>%</td>
                                    <td>您共需还本息<span id="ghbx">0.0</span>元</td>
                                </tr>
							</tbody>
						</table>
                    </div>
                    <p class="fs18c73" style="padding-top:20px;">本息偿还时间表</p>
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
    使用利息计算器，能帮您计算每月的本息情况；同时，一份完整的本息偿还时间表，让您能更直观地了解还款本息详情 。</p>
                </div>
            </div>
         </div>
    </div>
	
	
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

	
		$(".jkjsq_btn_hf").click( function() {
			$("#divs").show();
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
		   var j = ((money*parseFloat(<%=configureProvider.format(SystemVariable.LMONEY_SUCCESS_RATION)%>))).toFixed(2);
		   $("#mthns").html(month);
		   $("#myhbx").html(parseFloat(accMul(s, size)).toFixed(2));
		   $("#mj").html(parseFloat(accMul(j, size)).toFixed(2));
		   $("#yln").html(parseFloat(accMul(mln, 100)).toFixed(2));
		   
		  var $creaa = $("#creaa");
		  var $crea =  $("#crea");
		  var $creb =  $("#creb");
		  var $crec =  $("#crec");
		  var $cred =  $("#cred");
		  var $cree =  $("#cree");
		  var $crehr =  $("#crehr");
		  $creaa.html((parseInt(money)*parseFloat($creaa.attr("fl"))*size).toFixed(2));
		  $crea.html((parseInt(money)*parseFloat($crea.attr("fl"))*size).toFixed(2));
		  $creb.html((parseInt(money)*parseFloat($creb.attr("fl"))*size).toFixed(2));
		  $crec.html((parseInt(money)*parseFloat($crec.attr("fl"))*size).toFixed(2));
		  $cred.html((parseInt(money)*parseFloat($cred.attr("fl"))*size).toFixed(2));
		  $cree.html((parseInt(money)*parseFloat($cree.attr("fl"))*size).toFixed(2));
		  $crehr.html((parseInt(money)*parseFloat($crehr.attr("fl"))*size).toFixed(2));
		//剩余总本金		  
		 $(".jstr").html("");
		 var content='<tr class="leve_titbj_hf">';
			 content+='<td width="125">月份</td>';
			 content+='<td width="171" class="border_lr3">月还本息</td>';
			 content+='<td width="171">月还本金</td>';
			 content+='<td width="171" class="border_lr3">月还利息</td>';
			 content+='<td width="171" style="border-right:3px solid #fff;">借款管理费</td>';
			 content+='<td>本息余额</td>';
			 content+='</tr>';
		 var amount_remain = 100;
		 var totalYhbj = 0;
		 var zbx = 0;
		 
		 if($("#hkfs").val() == "<%=RepaymentType.MYHKDQHB2.name()%>"){
			 var ylx = parseFloat((mln*amount_remain)).toFixed(2);
			 var zlx = accAdd(accMul(ylx, month), amount_remain).toFixed(2);
			 for(var i=1;i<=month;i++){
				 	var bj = 0;
				 	if(i==month){
				 		bj = amount_remain;
				 	}
				 	var jkglf = accMul(j, size);
				 	var bx = accAdd(bj, ylx);
				 	zlx = Subtr(zlx, bx);
				 	content+='<tr>';
				  	content+='<td>'+i+'月</td>';
					content+='<td>'+parseFloat(accMul(bx, size)).toFixed(2)+'</td>';
					content+='<td>'+parseFloat(accMul(bj, size)).toFixed(2)+'</td>';
					content+='<td>'+parseFloat(accMul(ylx, size)).toFixed(2)+'</td>';
					content+='<td>'+jkglf.toFixed(2)+'</td>';
				    content+='<td>'+parseFloat(accMul(zlx, size)).toFixed(2)+'</td>';
					content+='</tr>';
			 }
			 $(".jstr").append(content);
		 }
		 
	});
		
		function show_sub01(v){
		 	document.getElementById("jkqx_hf").innerHTML=v;
		    }  
		function show_sub02(v){
		 	document.getElementById("hkfs_hf").innerHTML=v;
		} 
	</script>
</body>
</html>
