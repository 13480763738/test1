package com.jiudian.p2p.front.service.credit.entity;

/**
 * 公司信息认证
 * @author jiudian
 *
 */
public interface CompanyQuery {
	
	/**
	 * 用户ID
	 * @return
	 */
	public abstract int getId();
	/**
	 * 职业状态
	 */
	public abstract String getStatus();
	/**
	 * 公司名称
	 * @return
	 */
	public abstract String getName();
//	/**
//	 * 公司是否认证
//	 * @return
//	 */
//	public abstract String getIsattestation();
	/**
	 * 所在城市
	 * @return
	 */
	public abstract String getCity();
	/**
	 * 公司地址
	 * @return
	 */
	public abstract String getAddress();
	/**
	 * 公司类别
	 * @return
	 */
	public abstract String getCompanyType();
	/**
	 * 公司行业
	 * @return
	 */
	public abstract String getCompanyhy();
	/**
	 * 公司规模
	 * @return
	 */
	public abstract String getCompanygm();
	/**
	 * 公司经营年限
	 * @return
	 */
	public abstract String getCompanytime();
	/**
	 * 月收入
	 * @return
	 */
	public abstract String getMmoney();
//	/**
//	 * 收入认证
//	 * @return
//	 */
//	public abstract String getIsMmoney();
	/**
	 * 职位
	 * @return
	 */
	public abstract String getCompanyzy();
//	/**
//	 * 职位认证
//	 * @return
//	 */
//	public abstract String getIscompanyzy();
	/**
	 * 公司电话
	 * @return
	 */
	public abstract String getCall();
	/**
	 * 工作邮箱
	 * @return
	 */
	public abstract String getEmil();
	
	
}
