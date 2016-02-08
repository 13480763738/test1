package com.jiudian.p2p.front.service.information.entity;

import java.sql.Timestamp;

import com.jiudian.p2p.common.enums.TermType;

/**
 * 协议条款.
 */
public class Term {

	/**
	 * 协议类型
	 */
	public TermType termType;
	/**
	 * 协议内容
	 */
	public String content;

	/**
	 * 最后更新时间
	 */
	public Timestamp updateTime;
}
