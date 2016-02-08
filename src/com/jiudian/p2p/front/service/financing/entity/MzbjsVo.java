package com.jiudian.p2p.front.service.financing.entity;

import java.math.BigDecimal;


/**
 * 免租宝介绍
 *
 */
public class MzbjsVo {
	
	/**
	 * 项目介绍
	 */
	public String xmjs;
	
	/**
	 * 融资企业名称
	 */
	public String rzqymc;
	
	/**
	 * 项目地址
	 */
	public String xmdz;
	
	/**
	 * 融资代理人
	 */
	public String rzdlr;
	
	/**
	 * 企业注册年限
	 */
	public int qyzcnx;
	
	/**
	 * 资产净值
	 */
	public BigDecimal zcjz = new BigDecimal("0");
	
	/**
	 * 企业注册资金
	 */
	public BigDecimal qyzczj = new BigDecimal("0");
	
	/**
	 * 行业
	 */
	public String hy;
	
	/**
	 * 还款来源
	 */
	public String hkly;
	
	/**
	 * 企业经营情况
	 */
	public String qyjyqk;
	
	/**
	 * 涉诉情况
	 */
	public String ssqk;
	
	
	
}
