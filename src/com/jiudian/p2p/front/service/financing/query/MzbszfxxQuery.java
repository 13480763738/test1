package com.jiudian.p2p.front.service.financing.query;

/**
 * 免租宝收租方信息
 *
 */
public abstract interface MzbszfxxQuery {
	
	public abstract  int id();
	
	/**
	 * 开户名
	 */
	public abstract  String khm();
	
	/**
	 * 银行编号
	 */
	public abstract  int yhbh();
	
	/**
	 * 开户所在地
	 */
	public abstract  String khszd();
	
	/**
	 * 开户行
	 */
	public abstract  String khh();
	
	/**
	 * 银行卡
	 */
	public abstract  String bankcard();
	
	/**
	 * 确认银行卡
	 */
	public abstract  String obankcard();
	
	/**
	 * 免租宝加入ID
	 */
	public abstract int mzbid();
	
	
}
