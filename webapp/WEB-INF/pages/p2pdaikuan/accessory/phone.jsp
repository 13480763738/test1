<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.accessory.Phone"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.accessory.IdCard"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.accessory.AddAccessory"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
String _TITLE_ = "P2P贷款 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
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
<%@include file="/WEB-INF/include/upload.jsp" %>
	<div class="popup_tips" >
			<div class="popup_tips">
				
			    <div class="con clearfix">
			    	<div class="bigtit">手机实名认证</div>
			        <div class="info_top">手机实名认证需要用户上传手机流水单。手机流水单是用户最近一段时间内的详细通话记录，是<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>用以验证借入者真实性的重要凭证之一。您的手机流水单不会以任何形式被泄露。</div>
			        <div class="mt10">
			           <div class="smalltit">认证说明：</div>
			           <p>1.请您上传您绑定的手机号码<i class="d_red">最近3个月的手机详单</i>原件的照片。如详单数量较多可分月打印并上传<i class="d_red">每月前5日部分</i>（每月详单均需清晰显示机主手机号码）。</p>
			           <p>2.请确认您上传的资料是清晰的、未经修改的数码照片（不可以是扫描图片）。每张图片的尺寸<i class="d_red">不大于4M</i>。</p>
			           <p><i class="f16 gray33">认证有效期：</i><i class="d_red">永久</i></p>
			           <p><i class="f16 gray33">如何办理手机详单：前往最近的手机运营商营业厅，提供手机服务密码或机主身份证明即可打印。</i></p>
			        </div>
			        <div class="mt10">
			            <p><i class="d_red mr5">*</i><i class="f16 gray33">上传手机流水单：</i></p>
				            <form action="<%=controller.getURI(request, Phone.class)%>" method="post" enctype="multipart/form-data">
								<div id="uploader" style="width:523px;height:208px;margin-left:101px;margin-bottom:103px;">
									<p>您的浏览器未安装 Flash, Silverlight, Gears, BrowserPlus 或者支持 HTML5 .</p>
								</div>
							</form>
			            <div class="pt10 ml300"><a href="javascript:void(-1);" onclick="var list=parent.art.dialog.list;for(var i in list)list[i].close();"  class="btn btn01">提交审核</a></div>
			        </div>
			        <div class="mt10 warn"><i class="ui_w">
			           </i><i class="d_red">警告：</i><%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>是一个注重诚信的网络平台。如果我们发现您上传的资料系伪造或有人工修改痕迹，<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>会将你加入系统黑名单，永久取消您在<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>的借款资格。
			        </div>
			    </div>
			</div>
			<input id="isupload" value="0" type="hidden"/>
	</div>
	<%@include file="/WEB-INF/include/script1.jsp"%>
	<%@include file="/WEB-INF/include/upload.jsp"%>
	<script type="text/javascript">
	$(function() {
		$("#uploader").plupload({
			runtimes : 'html5,flash,silverlight,html4',
			url : '<%=controller.getURI(request, Phone.class)%>',
			max_file_size : '4mb',
			chunk_size : '4mb',			
			filters : [ {
				title : "Image files",
				extensions : "jpg,gif,png,jpeg"
			}],
			rename : false,
			sortable : true,
			dragdrop : true,
			views : {
				list : true,
				thumbs : true, 
				active : 'thumbs'
			},
			flash_swf_url : '<%=controller.getStaticPath(request)%>/js/upload/js/Moxie.swf',
			silverlight_xap_url : '<%=controller.getStaticPath(request)%>/js/upload/js/Moxie.xap',
			init: {
				PostInit: function() {
					
				},
				FilesAdded: function(up, files) {
					
				},
				BeforeUpload: function(up, file) {
					var count = $("#uploader_filelist").children().size();
					var total = parseInt(count);
					if(total>5){
						alert("每次最多能上传5张！请删除多余的");
						stop();
						return false;
					}
					$("#isupload").val(1);
				},

				Error: function(up, err) {
				}
			}
			
		});
	});
</script>
</body>
</html>
