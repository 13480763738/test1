package com.jiudian.p2p.front.service.information;

import com.jiudian.framework.service.Service;
import com.jiudian.p2p.S50.entities.T5016;
import com.jiudian.p2p.common.enums.Sblx;
import com.jiudian.p2p.front.service.information.entity.Advertisement;

/**
 * 广告管理.
 * 
 */
public abstract interface AdvertisementManage extends Service {

	/**
	 * <dt>
	 * <dl>
	 * 描述：查询所有发布的焦点图广告信息列表.
	 * </dl>
	 * 
	 * <dl>
	 * 数据校验：
	 * <ol>
	 * <li>无</li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 逻辑校验：
	 * <ol>
	 * <li>无</li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 业务处理：
	 * <ol>
	 * <li>查询{@link T5016}表</li>
	 * <li>查询条件: {@link T5016#F07} {@code <= CURRENT_TIMESTAMP() AND F08 >=
	 * CURRENT_TIMESTAMP()}</li>
	 * <li>按照{@link T5016#F02}字段降序排序</li>
	 * <li>
	 * 查询字段列表:
	 * <ol>
	 * <li>{@link T5016#F01}</li>
	 * <li>{@link T5016#F03}</li>
	 * <li>{@link T5016#F04}</li>
	 * <li>{@link T5016#F05}</li>
	 * </ol>
	 * </li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 返回结果说明：
	 * <ol>
	 * <li>{@link Advertisement#id}对应{@link T5016#F01}</li>
	 * <li>{@link Advertisement#title}对应{@link T5016#F03}</li>
	 * <li>{@link Advertisement#url}对应{@link T5016#F04}</li>
	 * <li>{@link Advertisement#imageCode}对应{@link T5016#F05}</li>
	 * </ol>
	 * </dl>
	 * </dt>
	 * 
	 * @return {@link Advertisement}{@code []} 广告列表,没有记录则返回{@code null}
	 * @throws Throwable
	 */
	public abstract Advertisement[] getAll(Sblx sblx) throws Throwable;
	/**
	 * 获取用户人数
	 * @return
	 * @throws Throwable
	 */
	public abstract int getUserNum() throws Throwable;
}
