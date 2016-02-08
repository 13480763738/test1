package com.jiudian.p2p.front.service.credit;

import com.jiudian.framework.service.Service;
import com.jiudian.p2p.front.service.credit.entity.Property;
import com.jiudian.p2p.front.service.credit.entity.PropertyQuery;

/**
 * 资产信息
 * @author jiudian
 *
 */
public interface PropertyMange extends Service {
	
	/**
	 * 查询资产信息
	 * @param acount 用户ID
	 * @return
	 */
	public abstract Property getProperty() throws Throwable;
	
	/**
	 * 修改资产信息
	 * @param query 修改内容
	 */
	public abstract void update(PropertyQuery query) throws Throwable;
}
