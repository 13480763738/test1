package com.jiudian.p2p.front.service.credit.entity;

public interface WorkQuery {
	/**
	 * 用户ID
	 */
	public abstract int getAcount();
	/**
	 * 职业状态
	 * @return
	 */
	public abstract String getStatus();
	
	/**
	 * 单位名称
	 * @return
	 */
	public abstract String getName();
	
//	/**
//	 * 是否工作认证
//	 * @return
//	 */
//	public abstract String getIswork();
	
	/**
	 * 职位
	 * @return
	 */
	public abstract String getPost();
	
//	/**
//	 * 是否技术职称认证
//	 * @return
//	 */
//	public abstract String getIspst();
	
	/**
	 * 工作邮箱
	 * @return
	 */
	public abstract String getEmil();
	
	/**
	 * 工作城市
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
	public abstract String getType();
	
	/**
	 * 公司行业
	 * @return
	 */
	public abstract String getProfession();
	
	/**
	 * 公司规模
	 * @return
	 */
	public abstract String getScale();
	
	/**
	 * 工作年限
	 * @return
	 */
	public abstract String getGznew();
	
	/**
	 * 月收入
	 * @return
	 */
	public abstract String getMmoney();
	
//	/**
//	 * 是否月收入认证
//	 * @return
//	 */
//	public abstract String getIsmmoney();
	
	/**
	 * 公司电话
	 * @return
	 */
	public abstract String getCellnumber();
	
}
