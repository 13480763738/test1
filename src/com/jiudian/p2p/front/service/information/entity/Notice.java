package com.jiudian.p2p.front.service.information.entity;

import java.sql.Timestamp;

import com.jiudian.p2p.common.enums.NoticeType;

public class Notice {
	/**
	 * 网站公告ID
	 */
	public int id;
	/**
	 * 网站公告类型
	 */
	public NoticeType type;
	/**
	 * 网站公告标题
	 */
	public String title;
	/**
	 * 内容
	 */
	public String content;
	/**
	 * 创建时间
	 */
	public Timestamp createtime;
	/**
	 * 最后更新时间
	 */
	public Timestamp lastTime;

}
