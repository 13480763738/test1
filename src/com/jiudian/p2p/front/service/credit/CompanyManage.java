package com.jiudian.p2p.front.service.credit;

import com.jiudian.framework.service.Service;
import com.jiudian.p2p.front.service.credit.entity.Company;
import com.jiudian.p2p.front.service.credit.entity.CompanyQuery;

/**
 * 公司信息
 * @author jiudian
 *
 */
public interface CompanyManage extends Service {
	
	/**
	 * 查询公司信息
	 * @param acount 用户ID
	 * @return
	 */
	public abstract Company getCompany() throws Throwable;
	
	/**
	 * 修改公司信息
	 * @param query 修改内容
	 */
	public abstract void update(CompanyQuery query) throws Throwable;
}
