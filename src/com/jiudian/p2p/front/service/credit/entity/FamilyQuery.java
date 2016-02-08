package com.jiudian.p2p.front.service.credit.entity;

/**
 * 家庭信息(更具用户ID进行修改)
 * @author jiudian
 *
 */
public interface FamilyQuery {
	
	/**
	 * 用户ID
	 */
	public abstract int getAcount();
	/**
	 * 婚姻状况
	 */
	public abstract String getMarriagestatus();
	
	/**
	 * 有无子女
	 */
	public abstract String getIschildren();
	
//	/**
//	 * 结婚认证
//	 */
//	public abstract String getIsmarrige();
	
	/**
	 * 直系亲属姓名',
	 */
	public abstract String getZxname();
	
	/**
	 * '关系',
	 */
	public abstract String getZxrelation();
	/**
	 * '手机',
	 */
	public abstract String getZxphone();
	/**
	 * '其他联系人姓名',
	 */
	public abstract String getQtname();
	/**
	 * '关系',
	 */
	public abstract String getQtrelation();
	/**
	 * '手机',
	 */
	public abstract String getQtphone();
}
