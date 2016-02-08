package com.jiudian.p2p.front.service.information;

import com.jiudian.framework.service.Service;
import com.jiudian.framework.service.query.Paging;
import com.jiudian.framework.service.query.PagingResult;
import com.jiudian.p2p.common.enums.NoticePublishStatus;
import com.jiudian.p2p.front.service.information.entity.Notice;

/**
 * 网站公告
 * 
 * 
 */
public interface NoticeManage extends Service {

	/**
	 * <dt>
	 * <dl>
	 * 描述：分页查询已发布网站公告信息列表.
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
	 * <li>查询{@code T5015}表,查询条件:{@code T5015.F04 = }
	 * {@link NoticePublishStatus#YFB}</li>
	 * <li>按照{@code T5015.F09}字段降序排序</li>
	 * <li>
	 * 查询字段列表:
	 * <ol>
	 * <li>{@code T5015.F01}</li>
	 * <li>{@code T5015.F02}</li>
	 * <li>{@code T5015.F05}</li>
	 * <li>{@code T5015.F06}</li>
	 * <li>{@code T5015.F08}</li>
	 * <li>{@code T5015.F09}</li>
	 * </ol>
	 * </li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 返回结果说明：
	 * <ol>
	 * <li>{@link Notice#id}对应{@code T5015.F01}</li>
	 * <li>{@link Notice#type}对应{@code T5015.F02}</li>
	 * <li>{@link Notice#title}对应{@code T5015.F05}</li>
	 * <li>{@link Notice#content}对应{@code T5015.F06}</li>
	 * <li>{@link Notice#createtime}对应{@code T5015.F08}</li>
	 * <li>{@link Notice#lastTime}对应{@code T5015.F09}</li>
	 * </ol>
	 * </dl>
	 * </dt>
	 * 
	 * @param paging
	 *            分页参数
	 * @return {@link PagingResult}{@code <}{@link Notice}{@code >} 分页查询结果
	 * @throws Throwable
	 */
	public abstract PagingResult<Notice> search(Paging paging) throws Throwable;

	/**
	 * <dt>
	 * <dl>
	 * 描述：根据公告ID获取已发布公告信息.
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
	 * <li>如果{@code id<=0}则返回{@code null}</li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 业务处理：
	 * <ol>
	 * <li>查询{@code T5015}表,查询条件:{@code T5015.F01 = id AND T5015.F04 = }
	 * {@link NoticePublishStatus#YFB}</li>
	 * <li>
	 * 查询字段列表:
	 * <ol>
	 * <li>{@code T5015.F01}</li>
	 * <li>{@code T5015.F02}</li>
	 * <li>{@code T5015.F05}</li>
	 * <li>{@code T5015.F06}</li>
	 * <li>{@code T5015.F08}</li>
	 * <li>{@code T5015.F09}</li>
	 * </ol>
	 * </li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 返回结果说明：
	 * <ol>
	 * <li>{@link Notice#id}对应{@code T5015.F01}</li>
	 * <li>{@link Notice#type}对应{@code T5015.F02}</li>
	 * <li>{@link Notice#title}对应{@code T5015.F05}</li>
	 * <li>{@link Notice#content}对应{@code T5015.F06}</li>
	 * <li>{@link Notice#createtime}对应{@code T5015.F08}</li>
	 * <li>{@link Notice#lastTime}对应{@code T5015.F09}</li>
	 * </ol>
	 * </dl>
	 * </dt>
	 * 
	 * @param id
	 *            公告ID
	 * @return {@link Notice} 公告信息,不存在则返回{@code null}
	 * @throws Throwable
	 */
	public abstract Notice get(int id) throws Throwable;

	/**
	 * <dt>
	 * <dl>
	 * 描述：累加已发布公告点击次数.
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
	 * <li>修改{@code T5015.F03=F03+1},修改条件:{@code T5015.F01 = id AND T5015.F04 = }
	 * {@link NoticePublishStatus#YFB}</li>
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
	 *            公告ID
	 * @throws Throwable
	 */
	public abstract void view(int id) throws Throwable;
	
	public abstract Notice getUp(int id) throws Throwable;
	
	public abstract Notice getDown(int id) throws Throwable;
}
