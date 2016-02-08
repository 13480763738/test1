package com.jiudian.p2p.front.servlets.m;

import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;



public final class AES {		
	
	private static final String key = "*#XGWL@*QIANHAIQIRONGjiudian*&LJ";
	
	public AES(){
		
	}
	
	public static void main(String[] args) throws Exception {
		String str = "us=1.1";
		String encrytStr;
		byte[] encrytByte;
		
		byte[] byteRe = enCrypt(str);
		
		//加密过的二进制数组转化成16进制的字符串
		encrytStr = parseByte2HexStr(byteRe);		
		System.out.println("加密后："+encrytStr);
		
		parseByte2HexStr(enCrypt(str));		
		
		
		//加密过的16进制的字符串转化成二进制数组
		encrytByte = parseHexStr2Byte(encrytStr);		
		System.out.println("解密后："+deCrypt(encrytByte));
		
		
	}
	
	public static String MDkey(String str) throws Exception{
		String encrytStr;
		byte[] byteRe = enCrypt(str.trim());
		//加密过的二进制数组转化成16进制的字符串
		encrytStr = parseByte2HexStr(byteRe);
		return encrytStr;
	}
	
	/**
	 * 加密函数
	 * @param content   加密的内容
	 * @param strKey    密钥
	 * @return  		返回二进制字符数组
	 * @throws Exception
	 */
	public static byte[] enCrypt(String content) throws Exception{
		KeyGenerator keygen = KeyGenerator.getInstance("AES");
		SecureRandom secureRandom = SecureRandom.getInstance("SHA1PRNG" );  
		secureRandom.setSeed(key.getBytes("UTF-8"));  
		keygen.init(128, secureRandom);
		
		SecretKey desKey = keygen.generateKey();		
		Cipher c = Cipher.getInstance("AES");
		
		c.init(Cipher.ENCRYPT_MODE, desKey);
		
		byte[] cByte = c.doFinal(content.getBytes("UTF-8"));		
		
		return cByte;
	}
	
	/** 解密函数
	 * @param src   加密过的二进制字符数组
	 * @param strKey  密钥
	 * @return
	 * @throws Exception
	 */
	public static String deCrypt (byte[] src) throws Exception{
		
		try {     
	            KeyGenerator kgen = KeyGenerator.getInstance("AES");   
	            SecureRandom secureRandom = SecureRandom.getInstance("SHA1PRNG" );     
	            secureRandom.setSeed(key.getBytes("UTF-8"));     
	            kgen.init(128, secureRandom);  
	            //kgen.init(128, new SecureRandom(password.getBytes()));     
	            SecretKey secretKey = kgen.generateKey();     
	            byte[] enCodeFormat = secretKey.getEncoded();     
	            SecretKeySpec key = new SecretKeySpec(enCodeFormat, "AES");                 
	            Cipher cipher = Cipher.getInstance("AES");// 创建密码器     
	           cipher.init(Cipher.DECRYPT_MODE, key);// 初始化     
	           byte[] result = cipher.doFinal(src);  
	           return new String(result,"UTF-8");
	   } catch (NoSuchAlgorithmException e) {     
	           e.printStackTrace();     
	   } catch (NoSuchPaddingException e) {     
	           e.printStackTrace();     
	   } catch (InvalidKeyException e) {     
	           e.printStackTrace();     
	   } catch (IllegalBlockSizeException e) {     
	           e.printStackTrace();     
	   } catch (BadPaddingException e) {     
	           e.printStackTrace();     
	   }     
	   return null;
		
		
	}
	
	
	/**2进制转化成16进制
	 * @param buf
	 * @return
	 */
	public static String parseByte2HexStr(byte buf[]) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < buf.length; i++) {
			String hex = Integer.toHexString(buf[i] & 0xFF);
			if (hex.length() == 1) {
				hex = '0' + hex;
				}
			sb.append(hex.toUpperCase());
			}
		return sb.toString();
		}
	
	
	/**将16进制转换为二进制
	 * @param hexStr
	 * @return
	 */ 	
	public static byte[] parseHexStr2Byte(String hexStr) { 
	        if (hexStr.length() < 1) 
	                return null; 
	        byte[] result = new byte[hexStr.length()/2]; 
	        for (int i = 0;i< hexStr.length()/2; i++) { 
	                int high = Integer.parseInt(hexStr.substring(i*2, i*2+1), 16); 
	                int low = Integer.parseInt(hexStr.substring(i*2+1, i*2+2), 16); 
	                result[i] = (byte) (high * 16 + low); 
	        } 
	        return result; 
	} 



}

