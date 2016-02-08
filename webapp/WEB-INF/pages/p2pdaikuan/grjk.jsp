<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.JkyzmCheck"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.Jkverify"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<html>
<head>
<%
String _TITLE_ = "网上贷款、P2P贷款快捷门槛低 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "网上贷款,p2p贷款,网络借贷,网络贷款,p2p借贷,网上贷款平台,网络贷款平台,网络借贷平台,p2p网络贷款";
String _DESCRIPTION_ = "麒麟通宝P2P贷款频道 - 灵活多样的网络贷款形式,为个人及中小企融资提供高效低门槛贷款。";
%>
<title><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" content="<%=_DESCRIPTION_ %>">
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="clear"></div>
	<div class="new-contant mt20 pb30">
     <div class="project-list mt20">
		<div class="sub-nav" sup="Project">
	    <div class="sub-nav-inner">
	        <div class="container">
	            <!--start: Navigation -->
	            <div class="navbar navbar-inverse">
	                <div class="navbar-inner">
	                    <ul class="nav">
	                        <li class="selected"><a href="javascript:viod(0);" >个人借款</a></li>
	                        </ul>
	                </div>
	            </div>
	            <!--end: Navigation -->
	        </div>
	    </div>
	</div><!--start: container -->
	<div class="clear"></div>
	<div class="center_box">
	        <!-- <div class="zclc"><img src="<%=controller.getStaticPath(request)%>/images/zclc.png" width="1170" height="48" /></div> -->
	        <form action="<%=controller.getURI(request, Grjk.class)%>" class="form1" method="post">
        <div class="center ">
        	<div class="jkzx_box_hf white-bg">
                <p style="padding-top:15px;">温馨提示：目前平台借款在线申请只针对深圳地区。若有疑问，可致电客服热线<%=configureProvider.getProperty(SystemVariable.SITE_CUSTOMERSERVICE_TEL)%>。</p>
                <div class="xxtx_bot_hf">
                	<h3>信息填写</h3>
                    <dl>
                    	<dt><span>*</span>借款人姓名&nbsp;&nbsp;</dt>
                        <dd><input name="jkrxm" type="text" class="required max-length-50" />
                        	<p tip></p>
			   				<p errortip class="" style="display: none"></p>
                        </dd>
                    </dl>
                    <dl>
                    	<dt><span>*</span>身份证号&nbsp;&nbsp;</dt>
                        <dd>
                         <input name="sfzh" type="text" class="required idcard" />
		                  <p tip></p>
					      <p errortip class="" style="display: none"></p>
                        </dd>
                    </dl>
                    <dl>
                    	<dt><span>*</span>住址&nbsp;&nbsp;</dt>
                        <dd>
                         <input name="jtzz" type="text" class="required max-length-100" />
		                  <p tip></p>
					      <p errortip class="" style="display: none"></p>
                        </dd>
                    </dl>
                    <dl>
                    	<dt><span>*</span>联系方式&nbsp;&nbsp;</dt>
                        <dd>
                         <input name="lxfs" type="text" class="required phonenumber" />
		                  <p tip></p>
					      <p errortip class="" style="display: none"></p>
                        </dd>
                    </dl>
                    <dl>
                    	<dt><span>*</span>职业&nbsp;&nbsp;</dt>
                        <dd>
                         <input name="zy" type="text" class="required required max-length-50" />
		                  <p tip></p>
					      <p errortip class="" style="display: none"></p>
                        </dd>
                    </dl>
                    <dl>
                    	<dt><span>*</span>婚姻状况&nbsp;&nbsp;</dt>
                        <dd>
                        	<div class="dd_box_hf">
                            	<div class="select_bg"></div>
                            	<div id="select_text_hf" class="select_div">已婚</div>
                            	<select class="select_hf" name="hyzk" onchange="show_sub(this.options[this.options.selectedIndex].text)" style=" width:305px;">
                                     <option value="<%=MarriageStatus.YH.name()%>" selected><%=MarriageStatus.YH.getName()%></option>
                                     <option value="<%=MarriageStatus.WH.name()%>"><%=MarriageStatus.WH.getName()%></option>
                                 </select>
                            </div>
                        </dd>
                    </dl>
                    <dl>
                    	<dt>配偶姓名&nbsp;&nbsp;</dt>
                        <dd>
                         <input name="poxm" type="text" class="max-length-20" />
		                  <p tip></p>
					      <p errortip class="" style="display: none"></p>
                        </dd>
                    </dl>
                    <dl>
                    	<dt>配偶身份证号&nbsp;&nbsp;</dt>
                        <dd>
                         <input name="posfzh" type="text"  />
		                  <p tip></p>
					      <p errortip class="" style="display: none"></p>
                        </dd>
                    </dl>
                    <dl>
                    	<dt><span>*</span>借款金额&nbsp;&nbsp;</dt>
                        <dd><input name="jkje" type="text" class="required isint mulriple-100" /><em>元</em>
		                 <p tip></p>
					     <p errortip class="" style="display: none"></p>
                        </dd>
                    </dl>
                    <dl>
                    	<dt><span>*</span>预期筹款期限&nbsp;&nbsp;</dt>
                        <dd>
                        	<div class="dd_box_hf">
                            	<div class="select_bg"></div>
                            	<div id="select_timtext_hf" class="select_div">7天之内</div>
                            	<select class="select_hf required" name="ckqx" onchange="show_sub04(this.options[this.options.selectedIndex].text)" style=" width:305px;">
						               <option selected>7天之内</option>
						               <option>15天之内</option>
						               <option>15-30天</option>
						               <option>1-3个月</option>
						               <option>其他期限</option>
                                 </select>
                            </div>
                        </dd>
                    </dl>
                    <dl>
                    	<dt><span>*</span>借款利率&nbsp;&nbsp;</dt>
                        <dd><input name="jkll" type="text" class="required isint max-size-100" /><em>%</em>
		                 <p tip></p>
					     <p errortip class="" style="display: none"></p>
                        </dd>
                    </dl>
                    <dl>
                    	<dt><span>*</span>借款用途&nbsp;&nbsp;<br/><em>(20-500字)</em></dt>
                        <dd>
                        <textarea name="jkyt" cols="" rows="" class="required min-length-20 max-length-500"></textarea>
		                <p tip></p>
					    <p errortip class="" style="display: none"></p>
                        </dd>
                    </dl>
                     <dl>
                    	<dt><span>*</span>还款方式&nbsp;&nbsp;</dt>
                        <dd>
                        	<div class="dd_box_hf">
                            	<div class="select_bg"></div>
                            	<div id="select_text_hkfs" class="select_div">每月还息到期还本</div>
                            	<select class="select_hf" name="hkfs" onchange="show_sub01(this.options[this.options.selectedIndex].text)" style=" width:305px;">
                                     <option value="<%=RepaymentType.MYHKDQHB2.name()%>" selected><%=RepaymentType.MYHKDQHB2.getName()%></option>
                                     <option value="<%=RepaymentType.DQYCXFQ.name()%>"><%=RepaymentType.DQYCXFQ.getName()%></option>
                                     <option value="<%=RepaymentType.XYHK.name()%>"><%=RepaymentType.XYHK.getName()%></option>
                                 </select>
                            </div>
                        </dd>
                    </dl>
                     <dl>
                    	<dt><span>*</span>还款来源&nbsp;&nbsp;<br/><em>(20-500字)</em></dt>
                        <dd>
                        <textarea name="hkly" cols="" rows="" class="required min-length-20 max-length-500"></textarea>
		                <p tip></p>
					    <p errortip class="" style="display: none"></p>
                        </dd>
                    </dl>
                    <dl>
                    	<dt><span>*</span>验证码&nbsp;&nbsp;</dt>
                         <dd>
                            <input name="verifyCode" value="" >
		                     <img  id="_verifyImg" src="<%=controller.getURI(request, Jkverify.class)%>" title="看不清楚?换一张" width="112" height="40" onclick="this.src='<%=controller.getURI(request, Jkverify.class)%>?'+Math.random()" style="cursor: pointer;" />
		                      <a href="javascript:void(0)" onclick="$('#_verifyImg').attr('src','<%=controller.getURI(request, Jkverify.class)%>?'+Math.random())" class="change_hf"></a> 
                            <p class="red" id="verifyError" style="display:block;"></p>
                            </dd>
                    </dl>
                    
                    <dl>
                    </dl>
                    
                    <%String ermsg = controller.getPrompt(request, response,PromptLevel.ERROR);if(!StringHelper.isEmpty(ermsg)){ %>
                    <dl>
                    	<dt></dt>
                        <dd><p style="font-size:18px; color: rgb(2, 196, 2); text-align:center; width:493px; padding-top:20px;"><%StringHelper.filterHTML(out, ermsg);%></p></dd>
                    </dl>
		         	<%} %>
                    
                    <dl>
                    	<dt></dt>
                        <dd style="padding-top:40px; padding-bottom:40px;">
                        <input type="submit" fromname="form1" value="提&nbsp;&nbsp;交" class="btn_hf sumbitForme"></dd>
                    </dl>
                </div>
            </div>
        </div>
        </form>
	    </div>
	</div>
 	<div class="clear"></div>
</div>   
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script>
	var url = '<%=controller.getURI(request, JkyzmCheck.class)%>';
	$(function(){
		$("input").each(function(){
			$(this).attr("autocomplete","off");
		});
	});
 	function show_sub(v){   
 		document.getElementById("select_text_hf").innerHTML=v;
    }  
	function show_sub01(v){
 		document.getElementById("select_text_hkfs").innerHTML=v;
    }  
	function show_sub04(v){   
 		document.getElementById("select_timtext_hf").innerHTML=v;
    }  
	
	</script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jkyxvalidation.js"></script>
</body>
</html>
