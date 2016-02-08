package com.jiudian.p2p.front.service.financing.query;

import java.math.BigDecimal;
import java.sql.Timestamp;

import com.jiudian.p2p.common.enums.MzbJrlx;
import com.jiudian.p2p.common.enums.ShbType;

/**
 * 加入免租宝
 *
 */
public abstract interface MzbjrQuery {
	
	/**
	 * 免租宝ID
	 * @return
	 */
	public abstract  int mzbid();
	
	/**
	 * 免租宝类型
	 * @return
	 */
	public abstract MzbJrlx status();
	
	/**
	 * 免租金额
	 */
	public abstract BigDecimal mzje();
	
	/**
	 * 收租方帐户id
	 */
	public abstract int szfid();
	
	/**
	 * 首个免租日
	 */
	public abstract Timestamp sgmzr();
	
	/**
	 * 交租商户地址
	 */
	public abstract String shdz();
	
	/**
	 * 免租月数
	 */
	public abstract int mzys();
	
	public abstract ShbType shbType();
	
	public abstract String[] lxrid();
	
	
}
