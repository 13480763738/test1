<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.jiudian.p2p.front.service.information.entity.Article"%>
<%@page import="com.jiudian.p2p.front.service.information.ArticleManage"%>
<html>
<head>
<%
String _TITLE_ = ArticleType.PTZH.getName()+" - 投资攻略 - "+configureProvider.getProperty(SystemVariable.SITE_NAME);
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
	<div class="clear"></div>
<%
CURRENT_SUB_CATEGORY = "WDWZH";
%>
<%@include file="/WEB-INF/include/xszy/left.jsp"%>
<div class="center_box">
    	<div class="center">
        	<div class="n_nav_mc_hf_hf_hf">
				<div class="n_nav_mt_hf_hf_hf"><h1 style=" font-size:30px;">平台帐号</h1></div>
					<div style="width:100%;">
                    <div class="n_nav_mc_hf" style="padding-bottom:0px;">
					<div style="font-size:24px; color:#737373; margin-top:30px;">注册和登录</div>
					<div>
						<span class="n_mc_name_hf">1、如何成为麒麟通宝注册用户？</span>
						<div class="n_me_content_hf">
							（1）进入麒麟通宝首页，点击右上角"免费注册"按钮。<br>（2）根据提示信息，填写您的用户名、手机号码、密码、验证码等信息，点击"注册"。<br>（3）用户名为用户的展示昵称，一经注册后不可修改。
						</div>
					</div>

					<div>
						<span class="n_mc_name_hf">2、如何登录麒麟通宝？</span>
						<div class="n_me_content_hf">
							（1）注册成为麒麟通宝用户后，您就可以使用账号登录麒麟通宝了。<br> （2）进入麒麟通宝首页，点击右上角“登录”按钮。<br>
							（3）在登录页面可以通过用户名、绑定的手机号码或绑定的邮箱登录。
						</div>
					</div>

					<div>
						<span class="n_mc_name_hf">3、如何找回我的密码？</span>
						<div class="n_me_content_hf">
							如果您遗忘了密码，可以在网站用户登录页面，点击"找回密码"按钮，选择绑定邮箱或注册手机号找回密码。<br>
							（1）点击首页"登录"- 点击"找回密码"。<br> （2）选择使用绑定邮箱或注册手机号找回密码。<br>
							（3）填写绑定邮箱或手机号。<br> （4）发送验证码成功。<br> （4）输入发送给您的验证码。<br>
							（5）根据提示，输入新密码，点击确认后，重置密码成功，可使用新密码登录麒麟通宝帐号。
						</div>
					</div>
					<div>
						<span class="n_mc_name_hf">4、如何修改密码？</span>
						<div class="n_me_content_hf">您注册时输入的密码可以是数字或者英文字母，对于英文字母我们同时设置了大小写的区分。注册后您可以随时在"我的麒麟通宝"-"安全中心"-"安全信息"-"修改密码"中修改您所设定的密码。</div>
					</div>
					<div>
						<span class="n_mc_name_hf">5、如何设置密码更安全？</span>
						<div class="n_me_content_hf">
							（1）密码要保密且定期更改。<br> （2）请使用较长、复杂的字母数字组合以提高密码强度，不要用生日等容易被别人猜中的密码。<br>
							（3）如果使用了密码取回功能，请您及时删除我们发送给您的载有验证码的邮件。<br>
							（4）请记住不要与任何人共享您的密码。如果您已经与他人共享了密码，我们强烈建议您尽快更改
						</div>
					</div>
				</div>
				<div class="n_nav_mc_hf" style="padding-bottom:0px;">
					<div style="font-size:24px; color:#737373; margin-top:30px;">我的麒麟通宝</div>
					<div>
						<span class="n_mc_name_hf">1、什么情况下资金会被冻结？</span>
						<div class="n_me_content_hf">冻结金额指用户账户内不能自由支配的资金部分，包含投标冻结、提现冻结等类型。</div>
					</div>

					<div>
						<span class="n_mc_name_hf">2、为什么进行安全认证？</span>
						<div class="n_me_content_hf">
							为了保障用户资金的安全性和合同的有效性，麒麟通宝要求所有理财人及借款人必须通过身份证绑定、手机绑定以及
							提现密码设置。安全认证的过程简单便捷，麒麟通宝对于所有个人资料均作严格保密。</div>
					</div>
					<div>
						<span class="n_mc_name_hf">3、如何进行安全认证？</span>
						<div class="n_me_content_hf">访问"我的麒麟通宝"— "安全中心"—"安全信息"，即可进行安全认证。</div>
					</div>
				</div>
				<div class="n_nav_mc_hf">
					<div style="font-size:24px; color:#737373; margin-top:30px;">提现与充值</div>
					<div>
						<span class="n_mc_name_hf">1、有哪些方式可以给账户充值？</span>
						<div class="n_me_content_hf">目前支持通过网银向第三方支付账户进行充值。充值资金由第三方支付平台进行托管。</div>
					</div>

					<div>
						<span class="n_mc_name_hf">2、如何申请开通网上银行？</span>
						<div class="n_me_content_hf">
							目前所有的商业银行都支持个人网银业务，您只需要携带有效身份证件，到当地您所持银行卡的发卡行任意营业
							网点，即可申请开通网上银行业务。</div>
					</div>
					<div>
						<span class="n_mc_name_hf">3、如何提取现金？</span>
						<div class="n_me_content_hf">
							您可以随时将您在"麒麟通宝"账号中的可用余额申请提现到您现有的任何一家银行的账号上。<br>
							注意：请提供申请提现的银行卡账号，并确保该账号的开户人姓名和您在麒麟通宝上提供的身份证上的真实姓名一致， 否则无法成功提现。
						</div>
					</div>
					<div>
						<span class="n_mc_name_hf">4、为什么我申请取现失败？</span>
						<div class="n_me_content_hf">
							造成您取现失败的原因可能有以下几种：<br> （1）麒麟通宝账号未绑定本人身份证<br> （2）银行开户行信息错误<br>
							（5）银行账号/户名错误，或是账号和户名不符<br> （4）使用信用卡提现<br> （5）银行账户冻结或正在办理挂失<br>
							如果遇到以上情况，我们会在收到支付机构转账失败的通知后解除您的资金冻结（手续费退还），请您不必担心资金安全。
						</div>
					</div>
					
					<div id="name1">
                        <span class="n_mc_name_hf">5、平台充值流程</span>
                        <div class="n_me_content_hf">
                           <div style="font-size:18px; background:#f2f2f2; min-height:25px; line-height:25px; margin-top:10px;"><span style=" width:74px; height:25px; background:url(/images/step_bg.png) left top no-repeat; margin-right:15px; color:#fff; float:left;text-align:center;">第一步</span>登录平台账号，进入" <a style="color:#23a0fa;" href="javascript:void(0)">我的麒麟通宝<span style="padding:0 6px; color:#666;">&gt;</span>资金管理<span style="padding:0 6px; color:#666;">&gt;</span>充值</a> "</div>
                           <div style="font-size:18px; background:#f2f2f2; min-height:25px; line-height:25px; margin-top:20px;"><span style=" width:74px; height:25px; background:url(/images/step_bg.png) left top no-repeat; margin-right:15px; color:#fff; float:left;text-align:center;">第二步</span>选择充值方式，输入充值金额，点击"充值"按钮，进入支付界面</div>
                           <div style="margin-top:20px;"><img width="745" alt="麒麟通宝P2P网贷平台" src="/images/charge1.png"></div>
                           <div style="font-size:18px; background:#f2f2f2; min-height:25px; line-height:25px; margin:20px 0;"><span style=" width:74px; height:25px; background:url(/images/step_bg.png) left top no-repeat; margin-right:15px; color:#fff; float:left;text-align:center;">第三步</span>跳转到该银行的网上银行，完成网上银行的操作，即可成功充值</div>
                           <div class="clear"></div>
                        </div>
                    </div>
					
				</div>
			</div>
            </div>
        </div>
    </div>
<div class="clear"></div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/xszy/xszyjs.jsp"%>
	<script>
        $(function () {
            $(".n_mc_name_hf").click(function () {
                $(this).hasClass("open") ? $(this).removeClass("open").next("div").slideUp(500) : $(this).addClass("open").next("div").slideDown(500);
            });
        });
    </script>
</body>
</html>