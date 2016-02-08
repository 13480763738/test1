package com.jiudian.p2p.front.service.information;

import com.jiudian.framework.service.Service;
import com.jiudian.p2p.common.enums.CustomerServiceType;
import com.jiudian.p2p.front.service.information.entity.CustomerService;

/**
 * 在线客服管理
 * 
 */
public interface CustomerServiceManage extends Service {

	/**
	 * <dt>
	 * <dl>
	 * 描述：按照在线客服类型查询所有在线客服信息.
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
	 * <li>如果{@code customerServiceType==null}则返回{@code null}</li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 业务处理：
	 * <ol>
	 * <li>查询{@code T5012}表,查询条件:{@code T5012.F03 = customerServiceType}</li>
	 * <li>按照{@code T5012.F04}字段降序排序</li>
	 * <li>
	 * 查询字段列表:
	 * <ol>
	 * <li>{@code T5012.F01}</li>
	 * <li>{@code T5012.F02}</li>
	 * <li>{@code T5012.F03}</li>
	 * <li>{@code T5012.F05}</li>
	 * <li>{@code T5012.F06}</li>
	 * <li>{@code T5012.F07}</li>
	 * </ol>
	 * </li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 返回结果说明：
	 * <ol>
	 * <li>{@link CustomerService#id}对应{@code T5012.F01}</li>
	 * <li>{@link CustomerService#viewTimes}对应{@code T5012.F02}</li>
	 * <li>{@link CustomerService#type}对应{@code T5012.F03}</li>
	 * <li>{@link CustomerService#name}对应{@code T5012.F05}</li>
	 * <li>{@link CustomerService#number}对应{@code T5012.F06}</li>
	 * <li>{@link CustomerService#imageCode}对应{@code T5012.F07}</li>
	 * </ol>
	 * </dl>
	 * </dt>
	 * 
	 * @param customerServiceType
	 *            客服类型
	 * @return {@link CustomerService}{@code []}客服列表,如果不存在则返回{@code null}
	 * @throws Throwable
	 */
	public abstract CustomerService[] getAll(
			CustomerServiceType customerServiceType) throws Throwable;

	/**
	 * <dt>
	 * <dl>
	 * 描述：根据ID获取客服信息.
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
	 * <li>查询{@code T5012}表,查询条件:{@code T5012.F01 = id}</li>
	 * <li>
	 * 查询字段列表:
	 * <ol>
	 * <li>{@code T5012.F01}</li>
	 * <li>{@code T5012.F02}</li>
	 * <li>{@code T5012.F03}</li>
	 * <li>{@code T5012.F05}</li>
	 * <li>{@code T5012.F06}</li>
	 * <li>{@code T5012.F07}</li>
	 * </ol>
	 * </li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 返回结果说明：
	 * <ol>
	 * <li>{@link CustomerService#id}对应{@code T5012.F01}</li>
	 * <li>{@link CustomerService#viewTimes}对应{@code T5012.F02}</li>
	 * <li>{@link CustomerService#type}对应{@code T5012.F03}</li>
	 * <li>{@link CustomerService#name}对应{@code T5012.F05}</li>
	 * <li>{@link CustomerService#number}对应{@code T5012.F06}</li>
	 * <li>{@link CustomerService#imageCode}对应{@code T5012.F07}</li>
	 * </ol>
	 * </dl>
	 * </dt>
	 * 
	 * @param id
	 *            客户ID
	 * @return {@link CustomerService} 客服信息,如果不存在则返回{@code null}
	 * @throws Throwable
	 */
	public abstract CustomerService get(int id) throws Throwable;

	/**
	 * <dt>
	 * <dl>
	 * 描述：累加客服点击次数.
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
	 * <li>修改{@code T5012.F02=F02+1},修改条件:{@code T5012.F01=id}</li>
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
	 *            客服ID
	 * @throws Throwable
	 */
	public abstract void view(int id) throws Throwable;
}
