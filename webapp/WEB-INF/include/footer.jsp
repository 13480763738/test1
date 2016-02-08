<%@page import="com.jiudian.p2p.front.servlets.guide.Wiki"%>
	<!--底部-->
	<div class="new-footer">
		<div class="footer-top pt20 pb20">
			<div class="new-center">
				<ul class="first fl mr40 pt20">
					<li>
						<dl>
							<dt><a href="<%configureProvider.format(out, URLVariable.GYWM_GSJJ);%>">关于我们</a></dt>
							<dd><a href="<%configureProvider.format(out, URLVariable.GYWM_GSJJ);%>">平台简介</a></dd>
							<dd><a href="<%configureProvider.format(out, URLVariable.GYWM_GLTD);%>">管理团队</a></dd>
							<dd><a href="<%configureProvider.format(out, URLVariable.GYWM_LXWM);%>">联系我们</a></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt><a href="<%configureProvider.format(out, URLVariable.HELP_CJWT);%>">帮助中心</a></dt>
							<dd><a href="<%configureProvider.format(out, URLVariable.HELP_CJWT);%>">常见问题</a></dd>
							<dd><a href="<%configureProvider.format(out, URLVariable.HELP_ZFSM);%>">资费说明</a></dd>
							<dd><a href="<%configureProvider.format(out, URLVariable.GYWM_AQBZ);%>">安全保障</a></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt><a href="<%configureProvider.format(out, URLVariable.GUIDE);%>">新手指南</a></dt>
							<dd><a href="<%=controller.getViewURI(request, Wiki.class)%>">理财须知</a></dd>
							<dd><a href="<%configureProvider.format(out, URLVariable.HELP_WYJK);%>">借款须知</a></dd>
							<dd><a href="<%configureProvider.format(out, URLVariable.HELP_LCBK);%>">理财百科</a></dd>
						</dl>
					</li>
					<div class="clear"></div>
				</ul>
				<div class="new-winxin fl"> 
					<span><img src="<%=controller.getStaticPath(request)%>/images/wx1.png" width="90" height="90"></span>
					<span><img src="<%=controller.getStaticPath(request)%>/images/wx1.png" width="90" height="90"></span>
				</div>
				<div class="new-tel fl pt15">
					<p class="f16 tel-tit">全国理财热线:</p>
					<p class="tel f30 pt5 pb5" style="color:#be0a09"><%configureProvider.format(out, SystemVariable.SITE_CUSTOMERSERVICE_TEL);%></p>
					<p class="time">周一到周日9:00-18:00</p>
				</div>
				<div class="clear"></div>
			</div>
		</div>
		<div class="footer-bottom">
			<p><%configureProvider.format(out,SystemVariable.COMPANY_ADDRESS); %></p>
			<p><%configureProvider.format(out,SystemVariable.SITE_COPYRIGTH); %> | 备案号：<%configureProvider.format(out,SystemVariable.SITE_FILING_NUM); %></p>
 			<!--<p>法律顾问单位：<%configureProvider.format(out,SystemVariable.LEGAL_COUNSEL); %></p>
		 <span>
				<a class="lk01" href="http://www.itrust.org.cn/yz/pjwx.asp?wm=1061427753" rel="nofollow" target="_blank" title="中国信用企业"></a>
				<a class="lk02" href="http://www.miitbeian.gov.cn/" rel="nofollow" title="经营性网站备案信息" target="_blank"></a>
				<a style="display:none;" class="lk03" href="http://www.szeca.com.cn/html/fengcai/fhzdw/" rel="nofollow" target="_blank" title="深圳电子商务协会"></a>
				<a class="lk04" href="http://www.ebs.gov.cn/EntCertificate.aspx?domainId=9d03bef0-03fd-491d-97a7-b96169b9e744" target="_blank" rel="nofollow" title="深圳工商主体认证信息"></a>
				<a class="lk05" href="https://ss.knet.cn/verifyseal.dll?sn=e13071711010041651ahdh000000&amp;ct=df&amp;a=1&amp;pa=784545" rel="nofollow" target="_blank" title="可信网站"></a>
				<a class="lk06" title="安全联盟" target="_blank" key="5420e71cefbfb0496364cce3" logo_size="83x30" logo_type="realname" href="http://www.anquan.org/authenticate/cert/?site=www.xiaoniu88.com&amp;at=realname"></a>
			<a class="lk07" href="https://trustsealinfo.verisign.com/splash?form_file=fdf/splash.fdf&amp;dn=www.xiaoniu88.com&amp;lang=zh_cn" rel="nofollow" target="_blank" title="SSL"></a>
			 </span>-->
		</div>
	</div>