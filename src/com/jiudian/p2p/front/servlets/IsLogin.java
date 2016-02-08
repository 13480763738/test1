package com.jiudian.p2p.front.servlets;

import java.io.PrintWriter;
import java.net.URLDecoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jiudian.framework.service.ServiceSession;
import com.jiudian.p2p.front.service.common.UserManage;
import com.jiudian.util.StringHelper;

public class IsLogin extends AbstractFrontServlet {
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
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		PrintWriter out=response.getWriter();
		String key = request.getParameter("key");
		SimpleDateFormat sd = new SimpleDateFormat("yyyyMMdd");
		String date = Md5(sd.format(new Date())+"TZSYJYQDS");
		String nickname = serviceSession.getService(UserManage.class).getNickName();
		
		StringBuffer sb = new StringBuffer("{");
		if(nickname==null || nickname==""){
			sb.append("\"result\":"+0);
		}else{
			//未登陆
			if(!serviceSession.getSession().isAuthenticated() && StringHelper.isEmpty(nickname)){
				sb.append("\"result\":"+0);
			}else if(date.equals(key)){
				sb.append("\"result\":"+1);
				sb.append(",\"jiudianname\":\""+nickname+"\"");
			}else{
				sb.append("\"result\":"+0);
			}
		}
		sb.append("}");
		out.print(URLDecoder.decode(sb.toString(), "UTF-8"));
	}
	
	private static String Md5(String plainText) { 
		try { 
			MessageDigest md = MessageDigest.getInstance("MD5"); 
			md.update(plainText.getBytes()); 
			byte b[] = md.digest(); 
	
			int i; 
	
			StringBuffer buf = new StringBuffer(""); 
			for (int offset = 0; offset < b.length; offset++) { 
			i = b[offset]; 
			if(i<0) i+= 256; 
			if(i<16) 
			buf.append("0"); 
			buf.append(Integer.toHexString(i)); 
			} 
	
			return buf.toString(); 
	
			} catch (NoSuchAlgorithmException e) { 
			e.printStackTrace(); 
		}
		return null; 
	}
	
	
}
