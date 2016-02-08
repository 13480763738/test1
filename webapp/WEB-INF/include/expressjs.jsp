<%if(JQUERY_NOT_INCLUDED){%>

<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/express/jquery.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/express/scroll.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/express/web.js"></script>


<%JQUERY_NOT_INCLUDED=false;}%>