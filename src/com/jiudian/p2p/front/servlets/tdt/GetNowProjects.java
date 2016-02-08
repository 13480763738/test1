package com.jiudian.p2p.front.servlets.tdt;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jiudian.framework.service.ServiceSession;
import com.jiudian.framework.service.query.Paging;
import com.jiudian.framework.service.query.PagingResult;
import com.jiudian.p2p.common.enums.CreditCycle;
import com.jiudian.p2p.front.service.financing.InvestInfoManage;
import com.jiudian.p2p.front.service.financing.InvestManage;
import com.jiudian.p2p.front.service.financing.entity.CreditInfo;
import com.jiudian.p2p.front.service.financing.entity.Rewards;
import com.jiudian.p2p.front.service.financing.entity.TenderRecord;
import com.jiudian.util.Formater;
import com.jiudian.util.parser.IntegerParser;

public class GetNowProjects extends AbstractTdtServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected boolean mustAuthenticated() {
		return false;
	}
	
	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		PrintWriter out = response.getWriter();
		InvestManage im = serviceSession.getService(InvestManage.class);
		InvestInfoManage iim = serviceSession.getService(InvestInfoManage.class);
		PagingResult<CreditInfo> result = im.getNowProjects(
				new Paging() {
					public int getCurrentPage() {
						return IntegerParser.parse(request
								.getParameter("currentPage"));
					}

					public int getSize() {
						return 20;
					}
				});

		StringBuilder sb = new StringBuilder();
		sb.append("{");
		sb.append("\"totalPage\":\""+result.getPageCount()+"\",");
		sb.append("\"currentPage\":\""+result.getCurrentPage()+"\",");
		sb.append("\"totalCount\":\""+result.getItemCount()+"\",");
		sb.append("\"totalAmount\":\"0\",");
		sb.append("\"borrowList\":[");
		CreditInfo[] cs = result.getItems();
		int idx=0;
		if(cs!=null)
			for(CreditInfo c:cs){idx++;int tdx=0;
			Rewards r = im.getRewards(c.id);
			if(r==null)r = new Rewards();
			sb.append("{");
			sb.append("\"title\":\""+c.title+"\",");
			sb.append("\"amount\":\""+c.amount+"\",");
			sb.append("\"schedule\":\""+c.progress+"%\",");
			sb.append("\"interestRate\":\""+Formater.formatRate(c.rate,false)+"%\",");
			sb.append("\"deadline\":\""+c.term+"\",");
			if(c.creditCycle.equals(CreditCycle.AYHK)){
				sb.append("\"deadLineUnit\":\"月\",");
			}else if(c.creditCycle.equals(CreditCycle.TB)){
				sb.append("\"deadLineUnit\":\"天\",");
			}
			sb.append("\"reward\":\""+Formater.formatRate(r.jlbl,false)+"\",");
			sb.append("\"type\":\"实地认证;担保\",");
			sb.append("\"repaymentType\":\"5\",");
			sb.append("\"projectId\":\""+c.id+"\",");
			sb.append("\"province\":\"\",");
			sb.append("\"city\":\"\",");
			sb.append("\"userName\":\""+c.userAccountName+"\",");
			sb.append("\"userAvatarUrl\":\"\",");
			sb.append("\"amountUsedDesc\":\""+c.purpose+"\",");
			sb.append("\"revenue\":0, ");
			sb.append("\"loanUrl\":\"http://www.jiudian.com/p2plicai/sbtz/index/"+c.id+".html\",");
			sb.append("\"publishTime\":\""+Formater.formatDateTime(c.fbTime)+"\",");
			sb.append("\"successTime\":\""+Formater.formatDateTime(c.mbTime)+"\",");
			sb.append("\"subscribes\":[");
			TenderRecord[] tenders = iim.getRecord(c.id);
			if (tenders != null)
				for (TenderRecord t : tenders) {
					tdx++;
					sb.append("{\"status\":1,\"amount\":\""+t.tenderMoney+"\",\"type\":0,\"validAmount\":\""+t.tenderMoney+"\",\"addDate\":\""+Formater.formatDateTime(t.tenderTime)+"\",\"subscribeUserName\":\""+t.tenderName+"\"}");
					if (tdx < tenders.length) {
						sb.append(",");// 判断逗号
					}
				}
			sb.append("]");
			sb.append("}");
			if(idx<cs.length){
				sb.append(",");// 判断逗号
			}
		}
		sb.append("]");
		sb.append("}");
		System.out.println(sb.toString());
		out.write(sb.toString());
		return;
	}
}
