package com.jiudian.p2p.front.service.information.entity;

import com.jiudian.p2p.common.enums.CustomerServiceType;

public class CustomerService {

	/**
	 * 客服ID
	 */
	public int id;

	/**
	 * 浏览次数
	 */
	public int viewTimes;

	/**
	 * 客服类型
	 */
	public CustomerServiceType type;

	/**
	 * 客服名称
	 */
	public String name;

	/**
	 * 客服号码
	 */
	public String number;

	/**
	 * 客服图片编码
	 */
	public String imageCode;

}
