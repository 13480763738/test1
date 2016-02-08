package com.jiudian.p2p.front.service.credit;

import com.jiudian.framework.service.Service;
import com.jiudian.p2p.front.service.credit.entity.Author;
import com.jiudian.p2p.front.service.credit.entity.AuthorQuery;

/**
 * 其他信息
 * @author jiudian
 *
 */
public interface AuthorManage extends Service {
	/**
	 * 查询其他信息
	 * @param acount 用户ID
	 * @return
	 */
	public abstract Author getAuthor() throws Throwable;
	
	/**
	 * 修改其他信息
	 * @param query 修改内容
	 */
	public abstract void update(AuthorQuery query) throws Throwable;
	
	/**
	 * 需要一个认证信息完整度。
	 */
}
