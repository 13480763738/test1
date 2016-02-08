package com.jiudian.p2p.front.service.credit;

import com.jiudian.framework.service.Service;
import com.jiudian.p2p.front.service.credit.entity.AccessoryQuery;

/**
 * 认证附件
 * @author jiudian
 *
 */
public interface AccessoryManage extends Service {
	
	/**
	 * 获取认证信息ID
	 * @param account
	 * @param type
	 * @return
	 * @throws Throwable
	 */
	public abstract int getId(String type) throws Throwable;
	
	/**
	 * 添加认证信息
	 * @param query
	 * @return
	 * @throws Throwable
	 */
	public abstract int addAccessory(AccessoryQuery query) throws Throwable;
	
	
}
