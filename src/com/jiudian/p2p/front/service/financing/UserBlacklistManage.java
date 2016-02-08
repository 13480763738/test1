package com.jiudian.p2p.front.service.financing;

import com.jiudian.framework.service.Service;
import com.jiudian.framework.service.query.Paging;
import com.jiudian.framework.service.query.PagingResult;
import com.jiudian.p2p.front.service.financing.entity.UserBlack;

public interface UserBlacklistManage  extends Service {
	/**
	 * 黑名单列表
	 * @param paging
	 * @return
	 * @throws Throwable
	 */
	public abstract PagingResult<UserBlack> search(Paging paging) throws Throwable;

}
