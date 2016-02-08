package com.jiudian.p2p.front.service.financing.entity;

import java.sql.Timestamp;

/**
 * 合同文件列表
 * @author jiudian
 *
 */
public class ContractFileVo {
	
	/**
	 * id
	 */
	public int id;

	/**
	 * 名称
	 */
	public String name;
	
	/**
	 * 创建人
	 */
	public String author;
	
	/**
	 * 创建时间
	 * 
	 */
	public Timestamp createTime;
	
	/**
	 * 排序值
	 */
	public int order;
	
	/**
	 * 图片地址
	 */
	public String url;
	
	/**
	 * 合同ID
	 */
	public int contractId;
	
}
