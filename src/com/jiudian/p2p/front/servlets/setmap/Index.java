package com.jiudian.p2p.front.servlets.setmap;

import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jiudian.framework.config.ConfigureProvider;
import com.jiudian.framework.resource.ResourceRegister;
import com.jiudian.framework.service.ServiceSession;
import com.jiudian.framework.service.query.Paging;
import com.jiudian.framework.service.query.PagingResult;
import com.jiudian.p2p.common.enums.ArticleType;
import com.jiudian.p2p.front.service.financing.InvestManage;
import com.jiudian.p2p.front.service.financing.entity.CreditInfo;
import com.jiudian.p2p.front.service.information.ArticleManage;
import com.jiudian.p2p.front.service.information.entity.Article;
import com.jiudian.p2p.front.service.information.entity.TjzxVo;
import com.jiudian.p2p.front.servlets.p2plicai.AbstractFinancingServlet;
import com.jiudian.p2p.front.servlets.p2plicai.sbtz.Bdxq;
import com.jiudian.p2p.front.servlets.zxdt.Hlwjryj;
import com.jiudian.p2p.front.servlets.zxdt.Mtbd;
import com.jiudian.p2p.front.servlets.zxdt.Wdhyzx;
import com.jiudian.p2p.front.servlets.zxdt.Wdzs;
import com.jiudian.p2p.variables.defines.SystemVariable;
import com.jiudian.util.parser.DateParser;
import com.jiudian.util.parser.IntegerParser;

public class Index extends AbstractFinancingServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}
	
	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		ConfigureProvider configureProvider = ResourceRegister
				.getResourceProvider(getServletContext()).getResource(
						ConfigureProvider.class);
		String sitemap_path = configureProvider.format(SystemVariable.SITEMAP_PATH);
		String http = "http://"+configureProvider.format(SystemVariable.SITE_DOMAIN);
		long millis = System.currentTimeMillis();
		String now = new Timestamp(millis).toString();
		String lastmod = now.substring(0, 10) + "T" + now.substring(11, 19) + "+08:00";
		System.out.println("starting generate seo hot words sitemap............................");
		String filename = sitemap_path;
		BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(filename), "UTF-8"));
		writer.write(" <urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">  \n");
		
		writer.write(" <url> \n");
		writer.write(" <loc>http://www.jiudian.com</loc> \n");
		writer.write(" <changefreq>always</changefreq> \n");
		writer.write(" <priority>1.0</priority> \n");
		writer.write(" </url>\n ");
		writer.write(" <url> \n");
		writer.write(" <loc>http://www.jiudian.com/p2plicai/</loc> \n");
		writer.write(" </url>\n ");
		writer.write(" <url> \n");
		writer.write(" <loc>http://www.jiudian.com/p2pdaikuan/</loc> \n");
		writer.write(" </url>\n");
		
		final int currentPage = 1;
		ArticleManage articleManage = serviceSession.getService(ArticleManage.class);
		PagingResult<Article> results = articleManage.search(ArticleType.MTBD, new Paging() {public int getCurrentPage() {return currentPage;}public int getSize() {return 30;}});
		Article[] articles = results.getItems();
		if (articles != null && articles.length > 0) {
			for (Article article : articles) {
			// 最新动态及行业资讯
			String loc = http+getController().getPagingItemURI(request, Mtbd.class,article.id)+"?seo="+article.creater;
			writer.write("  <url>\n");
			writer.write("    <loc>" + loc + "</loc>\n");
			writer.write("    <lastmod>" + DateParser.format(article.publishTime) + "</lastmod>\n");
			writer.write("  </url>\n");
			}
		}
		
		
		PagingResult<Article> results2 = articleManage.search(ArticleType.HLWJRYJ, new Paging() {public int getCurrentPage() {return currentPage;}public int getSize() {return 30;}});
		Article[] articles2 = results2.getItems();
		if (articles2 != null && articles2.length > 0) {
			for (Article article : articles2) {
			//互联网金融
			String loc = http+getController().getPagingItemURI(request, Hlwjryj.class,article.id)+"?seo="+article.creater;
			writer.write("  <url>\n");
			writer.write("    <loc>" + loc + "</loc>\n");
			writer.write("    <lastmod>" + DateParser.format(article.publishTime) + "</lastmod>\n");
			writer.write("  </url>\n");
			}
		}
		
		
		PagingResult<Article> results3 = articleManage.search(
		ArticleType.WDHYZX, new Paging() {public int getCurrentPage() {return currentPage;}public int getSize() {return 30;}});
		Article[] articles3 = results3.getItems();
		if (articles3 != null && articles3.length > 0) {
			for (Article article : articles3) {
			//网贷咨询
			String loc = http+getController().getPagingItemURI(request, Wdhyzx.class,article.id )+"?seo="+article.creater;
			writer.write("  <url>\n");
			writer.write("    <loc>" + loc + "</loc>\n");
			writer.write("    <lastmod>" + DateParser.format(article.publishTime) + "</lastmod>\n");
			writer.write("  </url>\n");
			}
		}
		
		PagingResult<Article> results4 = articleManage.search(
		ArticleType.WDZS, new Paging() {public int getCurrentPage() {return currentPage;}public int getSize() {return 30;}});
		Article[] articles4 = results4.getItems();
		if (results4 != null && articles4.length > 0) {
			for (Article article : articles4) {
			//网贷知识
			String loc = http+getController().getPagingItemURI(request, Wdzs.class,article.id )+"?seo="+article.creater;
			writer.write("  <url>\n");
			writer.write("    <loc>" + loc + "</loc>\n");
			writer.write("    <lastmod>" + DateParser.format(article.publishTime) + "</lastmod>\n");
			writer.write("  </url>\n");
			}
		}
				
		
		InvestManage cnvestmentManage = serviceSession.getService(InvestManage.class);
		PagingResult<CreditInfo> result = cnvestmentManage.search(null, new Paging() {
					public int getCurrentPage() {return IntegerParser.parse("1");}public int getSize() {return 10;}
				});
		
		// 我的贷款
    	CreditInfo[] creditInfos=result.getItems();if(creditInfos!=null){for (CreditInfo creditInfo : creditInfos) {
    			if (creditInfo == null) {continue;}
					String loc = http+getController().getPagingItemURI(request, Bdxq.class,creditInfo.id);
					writer.write("  <url>\n");
					writer.write("    <loc>" + loc + "</loc>\n");
					writer.write("    <lastmod>" + lastmod + "</lastmod>\n");
					writer.write("  </url>\n");
			}
		}
    	
    	//论团帖子
    	TjzxVo[] ltlist = articleManage.getLt();
		if (ltlist != null && ltlist.length > 0) {
			for (TjzxVo t : ltlist) {
			// 最新动态及行业资讯
			String loc = http+"/forum/thread-"+t.id+"-1-1.html";
			writer.write("  <url>\n");
			writer.write("    <loc>" + loc + "</loc>\n");
			writer.write("    <lastmod>" + DateParser.format(t.time) + "</lastmod>\n");
			writer.write("  </url>\n");
			}
		}
    	
        	
		writer.write("</urlset>\n");
		writer.close();
	}

}
