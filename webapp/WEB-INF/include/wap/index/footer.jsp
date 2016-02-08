<%-- <%@page import="com.jiudian.p2p.variables.defines.URLVariable"%>
<div data-role="footer" class="qfooter center">
	<div class="footer_links">
	<p><a  rel="external" href="<%configureProvider.format(out,URLVariable.WAP_INDEX);%>">首页</a>|
	<a href="<%configureProvider.format(out,URLVariable.WAP_USER_INDEX);%>"  rel="external">我的账户</a>|
	<a href="<%configureProvider.format(out,URLVariable.INDEX);%>"  rel="external">电脑版</a></p>
  </div>
  <div class="footer_info">
  	<p style="padding-top:0rem;">©2014麒麟通宝  www.kylintb.com<br/>备案号：粤ICP备14060638号</p>
  </div>
</div> --%>
<%@page import="com.jiudian.p2p.front.servlets.m.others.Gywm"%>
<footer class="index-footer">
		<nav class="footer-nav">
			<ul>
				<li>
					<a href="<%=configureProvider.format(URLVariable.WAP_GYWM) %>">关于我们</a>
				</li>	
				<li style="border:none;">
					<a href="<%=configureProvider.format(URLVariable.WAP_SBTZLB) %>">投资列表</a>
				</li>
				<div class="clear"></div>
			</ul>
			<p class="banquan">©深圳市旗丰投资有限公司<br /><%configureProvider.format(out,SystemVariable.SITE_FILING_NUM); %></p>
		</nav>
	</footer>