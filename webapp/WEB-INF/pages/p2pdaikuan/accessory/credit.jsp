<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.sl.Xybgsl"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.accessory.Credit"%>
<%@page	import="com.jiudian.p2p.front.servlets.p2pdaikuan.accessory.Education"%>
<%@page import="com.jiudian.p2p.front.servlets.p2pdaikuan.accessory.Address"%>
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
<meta name="description" content="<%=_DESCRIPTION_ %>">lude/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/upload.jsp"%>
	<div class="popup_tips" >
			<div class="popup_tips">
				
			    <div class="con clearfix">
				<div class="bigtit">个人信用报告认证</div>
				<div class="info_top">个人信用报告是由中国人民银行出具，全面记录个人信用活动，反映个人信用基本状况的文件。本报告是<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>了解您信用状况的一个重要参考资料。您信用报告内体现的信用记录和信用卡额度等数据，将在您发布借款时经<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>工作人员整理，在充分保护您隐私的前提下披露给<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>借出者，作为借出者投标的依据。</div>
				<div class="mt10">
					<div class="smalltit">认证说明：</div>
					<p>
						1、 个人信用报告需<i class="d_red">15日内</i>开具。
					</p>
					<p>
						2、 上传您的<i class="d_red">个人信用报告原件</i>的照片，每页信用报告需独立照相，并将整份信用报告按页码先后顺序完整上传。<a
						 target="_blank" href="<%=controller.getViewURI(request, Xybgsl.class) %>" class="blue ml15">查看示例</a>
					</p>
					如何办理个人信用报告？ 全国各地征信中心联系方式查询
					</p>
					<p>3、 请确认您上传的资料是清晰的、未经修改的数码照片或扫描图片。</p>
					<p>2.请确认您上传的资料是清晰的、未经修改的数码照片（不可以是扫描图片）。</p>
					<p>
						<i class="f16 gray33">认证条件：</i><i class="d_red">信用记录良好</i>
					</p>
					<p>
						<i class="f16 gray33">认证有效期：</i><i class="d_red">6个月</i>
					</p>
				</div>
				<div class="mt10">
					<p>
						<i class="d_red mr5">*</i><i class="f16 gray33">上传央行信用报告：</i>
					</p>
					<form action="<%=controller.getURI(request, Credit.class)%>" method="post" enctype="multipart/form-data">
						<div id="uploader"
							style="width: 523px; height: 208px; margin-left: 101px; margin-bottom: 103px;">
							<p>您的浏览器未安装 Flash, Silverlight, Gears, BrowserPlus 或者支持 HTML5
								.</p>
						</div>
					</form>
					<div class="pt10 ml300">
						<a href="javascript:void(-1);" onclick="var list=parent.art.dialog.list;for(var i in list)list[i].close();"  class="btn btn01">提交审核</a>
					</div>
				</div>
				<div class="mt10 warn">
					<i class="ui_w"> </i><i class="d_red">警告：</i><%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>是一个注重诚信的网络平台。如果我们发现您上传的资料系伪造或有人工修改痕迹，<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>会将你加入系统黑名单，永久取消您在<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>的借款资格。
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
			url : '<%=controller.getURI(request, Credit.class)%>',
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
