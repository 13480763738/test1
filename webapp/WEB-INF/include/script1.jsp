<%if(JQUERY_NOT_INCLUDED){%>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery/jquery-1.8.3.min.js"></script>
<!--[if lt IE 9]>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/html5.js"></script>
<![endif]-->
<%JQUERY_NOT_INCLUDED=false;}%>
<script type='text/javascript'>{var a = window.opener||window.parent;while(a.parent!=a){a = a.parent;}if(a.location.host!='<%=configureProvider.format(systemDefine.getSiteDomainKey())%>'){a.location.href='<%=configureProvider.format(systemDefine.getSiteIndexKey())%>';}}</script>