package com.jiudian.p2p.front.service.credit.entity;

/**
 * 资产信息(更具用户ID修改)
 * @author jiudian
 *
 */
public class Property {
	
	/**
	 * 用户ID
	 */
	public int acount;
	/**
	 * 是否信用报告认证
	 * @return
	 */
	public  String IsCredit;
	
	/**
	 * 是否有房
	 * @return
	 */
	public  String Ishouse;
	/**
	 * 有无房贷
	 * @return
	 */
	public  String Ishouseloan;
	/**
	 * 是否房产认证
	 * @return
	 */
	public  String Ishousean;
	/**
	 * 是否有车
	 * @return
	 */
	public  String Iscar;
	/**
	 * 是否购车认证
	 * @return
	 */
	public  String Iscaran;
	/**
	 * 是否有车贷
	 * @return
	 */
	public  String Iscarloan;
	
	/**
	 * 购车年份
	 * @return
	 */
	public  int gcnf;
	
	/**
	 * 汽车品牌
	 * @return
	 */
	public  String qcpp;
	
	/**
	 * 车牌号码
	 * @return
	 */
	public  String cphm;
	
	
}
