package com.jiudian.p2p.front.service.information;

import com.jiudian.framework.service.Service;
import com.jiudian.p2p.front.service.information.entity.Partner;

/**
 * 合作伙伴
 * 
 */
public interface PartnerManage extends Service {
	/**
	 * <dt>
	 * <dl>
	 * 描述：查询所有合作伙伴列表.
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
	 * <li>查询{@code T5013}表</li>
	 * <li>
	 * 查询字段列表:
	 * <ol>
	 * <li>{@code T5013.F01}</li>
	 * <li>{@code T5013.F04}</li>
	 * <li>{@code T5013.F05}</li>
	 * <li>{@code T5013.F06}</li>
	 * </ol>
	 * </li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 返回结果说明：
	 * <ol>
	 * <li>{@link Partner#id}对应{@code T5013.F01}</li>
	 * <li>{@link Partner#name}对应{@code T5013.F04}</li>
	 * <li>{@link Partner#url}对应{@code T5013.F05}</li>
	 * <li>{@link Partner#imageCode}对应{@code T5013.F06}</li>
	 * </ol>
	 * </dl>
	 * </dt>
	 * 
	 * @return {@link Partner}{@code []} 如果没有任何记录则返回{@code null}
	 * @throws Throwable
	 *             操作失败
	 */
	public abstract Partner[] getAll() throws Throwable;

	/**
	 * <dt>
	 * <dl>
	 * 描述：根据合作伙伴ID,查询合作伙伴信息.
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
	 * <li>如果{@code id<=0}则直接返回{@code null}</li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 业务处理：
	 * <ol>
	 * <li>查询{@code T5013}表,查询条件:{@code T5013.F01=id}</li>
	 * <li>
	 * 查询字段列表:
	 * <ol>
	 * <li>{@code T5013.F01}</li>
	 * <li>{@code T5013.F04}</li>
	 * <li>{@code T5013.F05}</li>
	 * <li>{@code T5013.F06}</li>
	 * </ol>
	 * </li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 返回结果说明：
	 * <ol>
	 * <li>{@link Partner#id}对应{@code T5013.F01}</li>
	 * <li>{@link Partner#name}对应{@code T5013.F04}</li>
	 * <li>{@link Partner#url}对应{@code T5013.F05}</li>
	 * <li>{@link Partner#imageCode}对应{@code T5013.F06}</li>
	 * </ol>
	 * </dl>
	 * </dt>
	 * 
	 * @param id
	 *            合作伙伴ID
	 * @return {@link Partner} 如果不存在记录则返回null.
	 * @throws Throwable
	 */
	public abstract Partner get(int id) throws Throwable;

	/**
	 * <dt>
	 * <dl>
	 * 描述：累加给定ID合作伙伴的浏览次数.
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
	 * <li>如果{@code id<=0}则直接返回</li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 业务处理：
	 * <ol>
	 * <li>修改{@code T5013.F03=F03+1},修改条件:{@code T5013.F01=id}</li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 返回结果说明：
	 * <ol>
	 * <li>无</li>
	 * </ol>
	 * </dl>
	 * </dt>
	 * 
	 * @param id
	 *            合作伙伴ID
	 * @throws Throwable
	 */
	public abstract void view(int id) throws Throwable;
	
}
