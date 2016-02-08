package com.jiudian.p2p.front.service.information.entity;

import java.sql.Timestamp;

import com.jiudian.p2p.common.enums.ArticleType;

/**
 * 推荐和最新
 * @author Xiaofan
 *
 */
public class TjzxVo {
	
	/**
	 * 文章ID
	 */
	public int id;
	
	/**
	 * 文章类型
	 */
	public ArticleType type;
	
	/**
	 * 文章名称
	 */
	public String name;
	
	/**
	 * 最后更新时间
	 */
	public Timestamp time;
	
	public String author;
}
