package com.jiudian.p2p.front.service.information.entity;

import java.sql.Timestamp;

import com.jiudian.p2p.common.enums.ArticleType;

public class Article {
	/**
	 * 文章ID
	 */
	public int id;

	/**
	 * 浏览次数
	 */
	public int viewTimes;

	/**
	 * 文章标题
	 */
	public String title;

	/**
	 * 创建时间
	 */
	public Timestamp createtime;

	/**
	 * 发布时间
	 */
	public Timestamp publishTime;
	/**
	 * 文章来源
	 */
	public String source;
	/**
	 * 摘要
	 */
	public String summary;
	/**
	 * 封面图片编码
	 */
	public String imageCode;
	/**
	 * 创建人
	 */
	public String creater;
	
	/**
	 * 文章内容
	 */
	public ArticleType type;

}