package com.jiudian.p2p.front.service.credit.entity;

/**
 * 借款信息(基础信息，只需要更具ID进行修改)
 * @author jiudian
 *
 */
public interface UserBaseQuery {

	/**
	 * 用户ID
	 */
	public abstract int getAcount();
	/**
	 * 学历
	 */
	public abstract String getEducation();
	/**
	 * 入学你年份
	 */
	public abstract int getSchooldata();
	/**
	 * 毕业院校
	 */
	public abstract String getSchool();
	/**
	 * 籍贯
	 */
	public abstract String getJiguan();
	/**
	 * 户口所在地
	 */
	public abstract String getHkszd();
	/**
	 * 居住地区
	 */
	public abstract String getRegion();
	/**
	 * 居住编码
	 */
	public abstract String getPostcode();
	/**
	 * 居住地电话
	 */
	public abstract String getCellnumber();
	
//	/**
//	 * 是否身份证认证
//	 */
//	public abstract String getIsidcard();
//	/**
//	 * 是否手机实名认证
//	 */
//	public abstract String getIsphone();
//	/**
//	 * 是否学历认证
//	 */
//	public abstract String getIseducation();
//	/**
//	 * 是否居住证认证
//	 */
//	public abstract String getIsjuzhu();
	
}
