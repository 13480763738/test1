package com.jiudian.p2p.front.service.credit;

import com.jiudian.framework.service.Service;
import com.jiudian.p2p.front.service.credit.entity.Work;
import com.jiudian.p2p.front.service.credit.entity.WorkQuery;

/**
 * 工作信息
 * @author jiudian
 *
 */
public interface WorkManage extends Service {
	/**
	 * 查询工作信息
	 * @param acount 用户ID
	 * @return
	 */
	public abstract Work getWork() throws Throwable;
	
	/**
	 * 修改工作信息
	 * @param query 修改内容
	 */
	public abstract void update(WorkQuery query) throws Throwable;
}
