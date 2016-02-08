<%@page import="com.jiudian.p2p.variables.defines.URLVariable"%>
<div class="tzlc_box">
	<div class="tzlc_tit">
    	<h2>投资理财</h2>
    </div> 
    <a href="<%configureProvider.format(out,URLVariable.WAP_SBTZLB);%>?pt=<%StringHelper.filterHTML(out, ProductType.KXT.name()); %>"  rel="external">
    	<span class="sbtz_01">供应链贷</span><br/>
        <i>11%-18%年化收益，100元起投</i>
    </a>
    <a href="<%configureProvider.format(out,URLVariable.WAP_SBTZLB);%>?pt=<%StringHelper.filterHTML(out, ProductType.XWD.name()); %>"  rel="external">
    	<span class="sbtz_01">小微贷</span><br/>
        <i>11%-18%年化收益，100元起投</i>
    </a>
    <a href="<%configureProvider.format(out,URLVariable.WAP_LCTY);%>"  rel="external">
    	<span class="sbtz_02">体验专区</span><br/>
        <i>20%年化收益，零成本</i>
    </a>
    <%if(jiudianSession==null || !jiudianSession.isAuthenticated()){%>
     <a href="<%configureProvider.format(out,URLVariable.WAP_LOGIN);%>"  rel="external" class="get_coin">领取体验金</a>
     <a href="<%configureProvider.format(out,URLVariable.WAP_SBTZLB);%>?pt=<%StringHelper.filterHTML(out, ProductType.XWD.name()); %>" rel="external" class="qtz">去投资</a>
     <a href="<%configureProvider.format(out,URLVariable.WAP_SBTZLB);%>?pt=<%StringHelper.filterHTML(out, ProductType.KXT.name()); %>" rel="external" class="qtz2">去投资</a>
    <%}else{%>
	    <a href="javascript:void(0);"  rel="external" class="get_coin index_get_experiences">领取体验金</a>
	    <a href="<%configureProvider.format(out,URLVariable.WAP_SBTZLB);%>?pt=<%StringHelper.filterHTML(out, ProductType.XWD.name()); %>" rel="external" class="qtz">去投资</a>
	    <a href="<%configureProvider.format(out,URLVariable.WAP_SBTZLB);%>?pt=<%StringHelper.filterHTML(out, ProductType.KXT.name()); %>" rel="external" class="qtz2">去投资</a>
    <%}%>
</div>

