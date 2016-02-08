package com.jiudian.p2p.front.service.credit;

import com.jiudian.framework.service.Service;
import com.jiudian.p2p.front.service.credit.entity.Family;
import com.jiudian.p2p.front.service.credit.entity.FamilyQuery;

/**
 * 家庭信息
 * @author jiudian
 *
 */
public interface FamilyManage extends Service {
	
	/**
	 * 查询家庭信息
	 * @param acount 用户ID
	 * @return
	 */
	public abstract Family getFamily() throws Throwable;
	
	/**
	 * 修改家庭信息
	 * @param query 修改内容
	 */
	public abstract void update(FamilyQuery query) throws Throwable;
}
