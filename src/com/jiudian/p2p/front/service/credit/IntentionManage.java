package com.jiudian.p2p.front.service.credit;

import com.jiudian.framework.service.Service;
import com.jiudian.p2p.front.service.credit.entity.GrjkQuery;
import com.jiudian.p2p.front.service.credit.entity.IntentionQuery;
import com.jiudian.p2p.front.service.credit.entity.QyjkQuery;

/**
 * 借款意向
 * @author jiudian
 *
 */
public interface IntentionManage extends Service {
	
	/**
	 * 添加借款意向
	 * @param query
	 * @throws Throwable
	 */
	public abstract void addIntention(IntentionQuery query) throws Throwable;
	/**
	 * 添加个人借款意向
	 * @param query
	 * @throws Throwable
	 */
	public abstract void addGrjk(GrjkQuery query) throws Throwable;
	/**
	 * 添加企业借款意向
	 * @param query
	 * @throws Throwable
	 */
	public abstract void addQyjk(QyjkQuery query) throws Throwable;
	
}
