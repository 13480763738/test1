package com.jiudian.p2p.front.servlets.m;

public final class AEStest {

	public AEStest() {

	}

	public static void main(String[] args) throws Exception {

		String encrytStr = parseByte2HexStr(enCrypt("1", ""));
		System.out.println("加密后：" + encrytStr);

		// 加密过的16进制的字符串转化成二进制数组
		byte[] encrytByte = parseHexStr2Byte("7175317169616E");
		System.out.println("解密后：" + deCrypt(encrytByte, ""));

	}

	/**
	 * 加密函数
	 */
	public static byte[] enCrypt(String content, String strKey)
			throws Exception {
		String s = "qu" + content + "qian";
		return s.getBytes();
	}

	public static String MDkey(String str) throws Exception {
		return parseByte2HexStr(enCrypt(str, ""));
	}

	/**
	 * 解密函数
	 */
	public static String deCrypt(byte[] src, String strKey) throws Exception {
		String s = new String(src);
		if (s.indexOf("qu") > -1 && s.indexOf("qian") > -1) {
			s = s.replace("qu", "");
			s = s.replace("qian", "");
			return s;
		}
		return null;

	}

	/**
	 * 2进制转化成16进制
	 * 
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

	/**
	 * 将16进制转换为二进制
	 * 
	 * @param hexStr
	 * @return
	 */
	public static byte[] parseHexStr2Byte(String hexStr) {
		if (hexStr.length() < 1)
			return null;
		byte[] result = new byte[hexStr.length() / 2];
		for (int i = 0; i < hexStr.length() / 2; i++) {
			int high = Integer.parseInt(hexStr.substring(i * 2, i * 2 + 1), 16);
			int low = Integer.parseInt(hexStr.substring(i * 2 + 1, i * 2 + 2),
					16);
			result[i] = (byte) (high * 16 + low);
		}
		return result;
	}

}
