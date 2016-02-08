package com.jiudian.p2p.front.service.credit.entity;

import java.math.BigDecimal;

import com.jiudian.p2p.common.enums.CreditCycle;

/**
 * 审核页面显示
 * @author jiudian
 *
 */
public class Lmoneysh {
	
	/**
	 * 用户ID
	 */
	public int acount;
	/**
	 * 借款金额
	 */
	public BigDecimal money = new BigDecimal(0);
	/**
	 * 借款年利率
	 */
	public BigDecimal rating = new BigDecimal(0);
	/**
	 * 借款期限代表月份 3、6、9、12、18、24个月
	 */
	public int Ctime;
	/**
	 * 信用等级(积分)
	 */
	public int integral;
	/**
	 * 借款状态
	 */
	public String type;
	
	/**
	 * 是否身份证认证
	 */
	public  String Isidcard;
	/**
	 * 是否手机实名认证
	 */
	public  String Isphone;
	/**
	 * 是否学历认证
	 */
	public  String Iseducation;
	/**
	 * 是否居住证认证
	 */
	public  String Isjuzhu;
	/**
	 * 结婚认证
	 */
	public  String Ismarrige;
	/**
	 * 是否工作认证
	 * @return
	 */
	public  String Iswork;
	/**
	 * 是否技术职称认证
	 * @return
	 */
	public  String Ispst;
	/**
	 * 是否月收入认证
	 * @return
	 */
	public  String Ismmoney;
	/**
	 * 是否信用报告认证
	 * @return
	 */
	public  String IsCredit;
	/**
	 * 是否房产认证
	 * @return
	 */
	public  String Ishousean;
	/**
	 * 是否购车认证
	 * @return
	 */
	public  String Iscaran;
	/**
	 * 是否微博认证
	 * @return
	 */
	public String Iswoboan;
	
	
	/**
	 * 是否公司认证,
	 * @return
	 */
	public String isgs;
	
	/**
	 * 公司信息收入证明
	 * @return
	 */
	public String isgssr;
	
	/**
	 * 公司信息技术职称认证
	 * @return
	 */
	public String isgsjszc;
	
	/**
	 * 还款周期
	 */
	public CreditCycle creditCycle;
	
}
