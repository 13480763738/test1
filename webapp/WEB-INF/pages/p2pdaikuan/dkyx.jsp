<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.Dkyx"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
String _TITLE_ = "借款咨询 - P2P贷款 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
String _KEYWORDS_ = "";
String _DESCRIPTION_ = "";
%>
<title><%=_TITLE_ %></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<meta name="keywords" content="<%=_KEYWORDS_ %>">
<meta name="description" content="<%=_DESCRIPTION_ %>">
<%@include file="/WEB-INF/include/style.jsp"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
</head>

<body>
<%@include file="/WEB-INF/include/header.jsp"%>
<form action="<%=controller.getURI(request, Dkyx.class)%>" class="form1" method="post">
<div class="contain clearfix">
   <div class="want_loan"><span>在线申请</span></div>
     <div class="contain_main want">
       <div class="tips">
          <p class="gray33">提示</p>
          <p class="ml20">1.由于业务原因，<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>目前只支持全国部分城市的借款业务；<br/>2.请仔细填写您的真实信息，我们将与您取得联系；</p>
       </div>
       <div class="pub_title mb30">信息填写</div>
       <div class="loan_con clearfix">
         <ul>
        	<%String ermsg = controller.getPrompt(request, response,PromptLevel.ERROR);if(!StringHelper.isEmpty(ermsg)){ %>
         	<li style="color: rgb(2, 196, 2);border: 1px solid rgb(3, 214, 3);padding: 10px;text-align: center;"><%StringHelper.filterHTML(out, ermsg);%></li>
         	<%} %>
           <li>
             <div class="tit"><i class="red">*</i>联系人</div>
             <div class="info">
               <input name="name" type="text" class="put01 required max-length-32" />
               <p tip>不超过32个字</p>
			   <p errortip class="" style="display: none"></p>
             </div>
             </li>
             <li>
               <div class="tit"><i class="red">*</i>手机号码</div>
               <div class="info">
                 <input name="phonenumber" type="text" class="put01 required phonenumber" />
                 <p tip></p>
			    <p errortip class="" style="display: none"></p>
               </div>
           </li>
             <li>
               <div class="tit"><i class="red">*</i>意向借款金额</div>
               <div class="info">
                 <input name="money" type="text" class="put01 isint mulriple-100" />元
                 <p tip></p>
			     <p errortip class="" style="display: none"></p>
               </div>
            </li>
            <li>
               <div class="tit"><i class="red">*</i>借款类型</div>
               <div class="info">
                 <select name="type" class="sel">
                 <option value="" ></option>
                 <option value="" ></option>
                 </select>
               </div>
           </li>
            <li>
               <div class="tit"><i class="red">*</i>所在城市</div>
               <div class="info">
               <select name="sheng" style="width:150px;" class="sel">
				</select> 
				<select name="shi" style="width:200px;" class="sel">
				</select>
				<select name="xian" style="width:200px;" class="sel required">
				</select>
				 <p tip></p>
			    <p errortip class="" style="display: none"></p>
               </div>
            </li>
            <li>
               <div class="tit">预期筹款期限</div>
               <div class="info"><select name="time" class="sel">
               <option>请选择</option>
               <option>7天之内</option>
               <option>15天之内</option>
               <option>15-30天</option>
               <option>1-3个月</option>
               <option>其他期限</option>
               </select></div>
            </li>
            <li>
               <div class="tit">借款描述<br/>(20-500字)</div>
               <div class="info"><textarea name="describe" cols="" rows="" class="area required min-length-20 max-length-500"></textarea>
               <p tip></p>
			    <p errortip class="" style="display: none"></p>
               </div>
            </li>
            
            <li>
               <div class="tit">&nbsp;</div>
               <div class="info"><input type="submit" class="btn btn01 sumbitForme" fromname="form1" fromname="form1" value="提  交"/></div>
            </li>
         </ul>
       </div>
   </div>   
</div>
</form>
<%@include file="/WEB-INF/include/footer.jsp"%>
<%@include file="/WEB-INF/include/script.jsp"%>

<script type="text/javascript"
	src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/region.js"></script>
</body>
</html>
