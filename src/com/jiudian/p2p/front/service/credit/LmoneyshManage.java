package com.jiudian.p2p.front.service.credit;

import com.jiudian.framework.service.Service;
import com.jiudian.p2p.front.service.credit.entity.Lmoneysh;

/**
 * 审核页面
 * @author jiudian
 *
 */
public interface LmoneyshManage extends Service {
	/**
	 * 查询审核信息
	 * @return
	 */
	public abstract Lmoneysh getLmoneysh(String type) throws Throwable;
}
