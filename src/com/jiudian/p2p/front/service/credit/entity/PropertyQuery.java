package com.jiudian.p2p.front.service.credit.entity;

/**
 * 资产信息(更具用户ID修改)
 * @author jiudian
 *
 */
public interface PropertyQuery {
	
	/**
	 * 用户ID
	 */
	public abstract int getAcount();
	
	/**
	 * 是否有房
	 * @return
	 */
	public abstract String getIshouse();
	/**
	 * 有无房贷
	 * @return
	 */
	public abstract String getIshouseloan();
	/**
	 * 是否有车
	 * @return
	 */
	public abstract String getIscar();
	/**
	 * 是否有车贷
	 * @return
	 */
	public abstract String getIscarloan();
	
	/**
	 * 购车年份
	 * @return
	 */
	public abstract int getGcnf();
	
	/**
	 * 汽车品牌
	 * @return
	 */
	public abstract String getQcpp();
	
	/**
	 * 车牌号码
	 * @return
	 */
	public abstract String getCphm();
	
}
