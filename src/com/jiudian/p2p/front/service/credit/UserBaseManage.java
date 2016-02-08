package com.jiudian.p2p.front.service.credit;

import com.jiudian.framework.service.Service;
import com.jiudian.p2p.front.service.credit.entity.UserBase;
import com.jiudian.p2p.front.service.credit.entity.UserBaseQuery;

/**
 * 基本信息
 * @author jiudian
 *
 */
public interface UserBaseManage extends Service {
	
	/**
	 * 查询基本信息
	 * @param acount 用户ID
	 * @return
	 */
	public abstract UserBase getUsebase() throws Throwable;
	
	/**
	 * 修改基本信息
	 * @param query 修改内容
	 */
	public abstract void update(UserBaseQuery query) throws Throwable;
}
