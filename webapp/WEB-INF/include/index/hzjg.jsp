<%@page import="com.jiudian.p2p.front.service.information.entity.Article"%>
<%@page import="com.jiudian.p2p.front.service.information.ArticleManage"%>
<%
						final int currentPage = IntegerParser.parse(request
									.getParameter("paging.current"));
							ArticleManage articleManage1 = serviceSession
									.getService(ArticleManage.class);
							PagingResult<Article> results = articleManage1.search(
									ArticleType.HZJG, new Paging() {
										public int getCurrentPage() {
											return currentPage;
										}

										public int getSize() {
											return 10;
										}
									});
							Article[] articles = results.getItems();
							if (articles != null && articles.length > 0) {
								
					%>
<div class="new-center white-bg pt30 pb30 hzjg">
			<h2>合作机构</h2>
		</div>
		<div id="roll" class="mt20 mb20">
			<ul class="flink">
				<% for (Article article : articles) {if (!StringHelper.isEmpty(article.imageCode)) {%>
				<li><img src="<%=fileStore.getURL(article.imageCode)%>" width="118px;" height="70px;"></li>
				<%
						}
					}
				}
					%>
			</ul>
</div>
 <!--合作伙伴滚动js-->
 <script>
		 var oDiv=document.getElementById('roll');
         var oUl=oDiv.getElementsByTagName('ul')[0];
         var aLi=oUl.getElementsByTagName('li');
         var iSpeed=3;
		 var timer=null;

		 
			if(aLi.length<9){
				oUl.style.left=0+'px';
				clearInterval( timer );
				
			}else{
				oUl.innerHTML+=oUl.innerHTML;
                oUl.style.width=(aLi[0].offsetWidth+12)*aLi.length+'px';
				
				function move(){
				timer=setInterval(function ()
                {
                        oUl.style.left=oUl.offsetLeft+iSpeed +'px';

                        if (oUl.offsetLeft<-oUl.offsetWidth/2) {
                                oUl.style.left='0px';
                        } else if (oUl.offsetLeft>0) {
                                oUl.style.left=-oUl.offsetWidth/2+'px';
                        };
                }, 100);
			  }
			  setTimeout(move(),30);

			  oDiv.onmouseover=function(){
				clearInterval( timer );
			  }
			   oDiv.onmouseout=function(){
				clearInterval( timer );
				move();
			  }

		}
 </script>