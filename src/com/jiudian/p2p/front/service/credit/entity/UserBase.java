package com.jiudian.p2p.front.service.credit.entity;

/**
 * 借款信息(基础信息，只需要更具ID进行修改)
 * @author jiudian
 *
 */
public class UserBase {
	
	/**
	 * 用户ID
	 */
	public int acount;
	/**
	 * 真实姓名
	 */
	public  String Name;
	/**
	 * 身份证
	 */
	public  String Idcard;
	/**
	 * 手机号
	 */
	public  String Phonenumber;
	/**
	 * 性别
	 */
	public  String Sex;
	/**
	 * 出生日期
	 */
	public  String Birthday;
	/**
	 * 学历
	 */
	public  String Education;
	/**
	 * 入学你年份
	 */
	public  int Schooldata;
	/**
	 * 毕业院校
	 */
	public  String School;
	/**
	 * 籍贯
	 */
	public  String Jiguan;
	/**
	 * 户口所在地
	 */
	public  String Hkszd;
	/**
	 * 居住地区
	 */
	public  String Region;
	/**
	 * 居住编码
	 */
	public  String Postcode;
	/**
	 * 居住地电话
	 */
	public  String Cellnumber;
	
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
	
}
