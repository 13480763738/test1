package com.jiudian.p2p.front.servlets.setmap;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;


public class GenSitemapJob implements Runnable  {

	public void run() {
		try {
			genSitemap();
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}

	private int genSitemap() throws Exception {
		String urlStr = "http://www.jiudian.com/setmap/index.htm"; 
		//String urlStr = "http://localhost:9111/setmap/index.htm"; 
        URL url;
        try {
            url = new URL(urlStr);
            URLConnection URLconnection = url.openConnection();  
            HttpURLConnection httpConnection = (HttpURLConnection)URLconnection;  
            int responseCode = httpConnection.getResponseCode();  
            if (responseCode == HttpURLConnection.HTTP_OK) {  
                System.err.println("成功");
                InputStream urlStream = httpConnection.getInputStream();  
                BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(urlStream));  
                String sCurrentLine = "";  
                String sTotalString = "";  
                while ((sCurrentLine = bufferedReader.readLine()) != null) {  
                    sTotalString += sCurrentLine;  
                }  
                System.err.println(sTotalString);
               if (sTotalString.equals("OK")) {
               } else {
                }  
            }else{
                System.err.println("失败");
             }
        } catch (Exception e) {
            e.printStackTrace();
        }  
          
		return 1;
	}

}
