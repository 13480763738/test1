package com.jiudian.p2p.front.service.financing;

import java.math.BigDecimal;

import com.jiudian.framework.service.Service;
import com.jiudian.framework.service.query.Paging;
import com.jiudian.framework.service.query.PagingResult;
import com.jiudian.p2p.common.enums.ExperienceGoldStatus;
import com.jiudian.p2p.front.service.financing.entity.ExperiencePlan;
import com.jiudian.p2p.front.service.financing.entity.FinancingPlan;
import com.jiudian.p2p.front.service.financing.entity.FinancingPlanCount;
import com.jiudian.p2p.front.service.financing.entity.FinancingPlanInfo;
import com.jiudian.p2p.front.service.financing.entity.PlanRecode;

/**
 * 理财体验
 * 
 * 
 */
public interface FinancingPlanManage extends Service {
	/**
	 * <dt>
	 * <dl>
	 * 描述：默认查最新一期的理财体验.
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
	 * <li>查询{@code T6042}表,查询条件:{@code T6042.F01 DESC LIMIT 1 }
	 * </li>
	 * <li>
	 * 查询字段列表
	 * <ol>
	 * <li>{@code T6042.F02}</li>
	 * <li>{@code T6042.F25}</li>
	 * <li>{@code T6042.F05}</li>
	 * <li>{@code T6042.F06}</li>
	 * <li>{@code T6042.F24}</li>
	 * <li>{@code T6042.F07}</li>
	 * <li>{@code T6042.F08}</li>
	 * <li>{@code T6042.F11}</li>
	 * <li>{@code T6042.F10}</li>
	 * <li>{@code T6042.F14}</li>
	 * <li>{@code T6042.F15}</li>
	 * <li>{@code T6042.F16}</li>
	 * <li>{@code T6042.F17}</li>
	 * <li>{@code T6042.F22}</li>
	 * <li>{@code T6042.F23}</li>
	 * <li>{@code T6042.F01}</li>
	 * <li>{@code T6042.F13}</li>
	 * <li>{@code T6042.F04}</li>
	 * <li>{@code T6042.F18}</li>
	 * </ol>
	 * </li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 返回结果说明：
	 * <ol>
	 * <li>{@link FinancingPlanInfo#planTitle}对应{@code T6042.F02}</li>
	 * <li>{@link FinancingPlanInfo#planMoney}对应{@code T6042.F25}</li>
	 * <li>{@link FinancingPlanInfo#yqsy}对应{@code T6042.F05}</li>
	 * <li>{@link FinancingPlanInfo#signType}对应{@code T6042.F06}</li>
	 * <li>{@link FinancingPlanInfo#ensureMode}对应{@code T6042.F24}</li>
	 * <li>{@link FinancingPlanInfo#planState}对应{@code T6042.F07}</li>
	 * <li>{@link FinancingPlanInfo#fullTime}对应{@code T6042.F08}</li>
	 * <li>{@link FinancingPlanInfo#lockqx}对应{@code T6042.F11}</li>
	 * <li>{@link FinancingPlanInfo#earningsWay}对应{@code T6042.F10}</li>
	 * <li>{@link FinancingPlanInfo#jrfl}对应{@code T6042.F14}</li>
	 * <li>{@link FinancingPlanInfo#fwfl}对应{@code T6042.F15}</li>
	 * <li>{@link FinancingPlanInfo#tcfl}对应{@code T6042.F16}</li>
	 * <li>{@link FinancingPlanInfo#maxMoney}对应{@code T6042.F17}</li>
	 * <li>{@link FinancingPlanInfo#minMoney}对应{@code T6042.F22}</li>
	 * <li>{@link FinancingPlanInfo#id}对应{@code T6042.F23}</li>
	 * <li>{@link FinancingPlanInfo#fromSale}对应{@code T6042.F01}</li>
	 * <li>{@link FinancingPlanInfo#lockEnd}对应{@code T6042.F13}</li>
	 * <li>{@link FinancingPlanInfo#syMoney}对应{@code T6042.F04}</li>
	 * <li>{@link FinancingPlanInfo#introduce}对应{@code T6042.F18}</li>
	 * <li>{@link FinancingPlanInfo#proess}对应{@code (credit.planMoney-credit.syMoney)/credit.planMoney}</li>
	 * </ol>
	 * </dl>
	 * </dt>
	 * 
	 * 
	 * @return {@link FinancingPlanInfo} 理财体验,如果不存在则返回{@code null}
	 * @throws Throwable
	 */
	public abstract FinancingPlanInfo getNewPlan() throws Throwable;
	/**
	 * <dt>
	 * <dl>
	 * 描述：根据id查询理财计划详情.
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
	 * <li>查询{@code T6042}表,查询条件:{@code T6042.F01 = }
	 * </li>
	 * <li>
	 * 查询字段列表
	 * <ol>
	 * <li>{@code T6042.F02}</li>
	 * <li>{@code T6042.F25}</li>
	 * <li>{@code T6042.F05}</li>
	 * <li>{@code T6042.F06}</li>
	 * <li>{@code T6042.F24}</li>
	 * <li>{@code T6042.F07}</li>
	 * <li>{@code T6042.F08}</li>
	 * <li>{@code T6042.F11}</li>
	 * <li>{@code T6042.F10}</li>
	 * <li>{@code T6042.F14}</li>
	 * <li>{@code T6042.F15}</li>
	 * <li>{@code T6042.F16}</li>
	 * <li>{@code T6042.F17}</li>
	 * <li>{@code T6042.F22}</li>
	 * <li>{@code T6042.F23}</li>
	 * <li>{@code T6042.F01}</li>
	 * <li>{@code T6042.F13}</li>
	 * <li>{@code T6042.F04}</li>
	 * <li>{@code T6042.F18}</li>
	 * </ol>
	 * </li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 返回结果说明：
	 * <ol>
	 * <li>{@link FinancingPlanInfo#planTitle}对应{@code T6042.F02}</li>
	 * <li>{@link FinancingPlanInfo#planMoney}对应{@code T6042.F25}</li>
	 * <li>{@link FinancingPlanInfo#yqsy}对应{@code T6042.F05}</li>
	 * <li>{@link FinancingPlanInfo#signType}对应{@code T6042.F06}</li>
	 * <li>{@link FinancingPlanInfo#ensureMode}对应{@code T6042.F24}</li>
	 * <li>{@link FinancingPlanInfo#planState}对应{@code T6042.F07}</li>
	 * <li>{@link FinancingPlanInfo#fullTime}对应{@code T6042.F08}</li>
	 * <li>{@link FinancingPlanInfo#lockqx}对应{@code T6042.F11}</li>
	 * <li>{@link FinancingPlanInfo#earningsWay}对应{@code T6042.F10}</li>
	 * <li>{@link FinancingPlanInfo#jrfl}对应{@code T6042.F14}</li>
	 * <li>{@link FinancingPlanInfo#fwfl}对应{@code T6042.F15}</li>
	 * <li>{@link FinancingPlanInfo#tcfl}对应{@code T6042.F16}</li>
	 * <li>{@link FinancingPlanInfo#maxMoney}对应{@code T6042.F17}</li>
	 * <li>{@link FinancingPlanInfo#minMoney}对应{@code T6042.F22}</li>
	 * <li>{@link FinancingPlanInfo#id}对应{@code T6042.F23}</li>
	 * <li>{@link FinancingPlanInfo#fromSale}对应{@code T6042.F01}</li>
	 * <li>{@link FinancingPlanInfo#lockEnd}对应{@code T6042.F13}</li>
	 * <li>{@link FinancingPlanInfo#syMoney}对应{@code T6042.F04}</li>
	 * <li>{@link FinancingPlanInfo#introduce}对应{@code T6042.F18}</li>
	 * </ol>
	 * </dl>
	 * </dt>
	 * @param id
	 * 			理财体验ID
	 * @return {@link FinancingPlanInfo} 理财体验,如果不存在则返回{@code null}
	 * @throws Throwable
	 */
	public abstract FinancingPlanInfo getPlan(int id) throws Throwable;

	/**
	 * <dt>
	 * <dl>
	 * 描述：分页查询理财计划列表.
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
	 * <li>分页查询{@code T6042}{@code T6043}{@code T6044}表
	 * </li>
	 * <li>按照{@code T6042.F01}字段分组，按照{@code T6042.F09}字段降序排序</li>
	 * <li>
	 * 查询字段列表
	 * <ol>
	 * <li>{@code T6042.F02}</li>
	 * <li>{@code T6042.F25}</li>
	 * <li>{@code count(T6043.F03)}</li>
	 * <li>{@code T6042.F05}</li>
	 * <li>{@code sum(T6044.F05)}</li>
	 * <li>{@code T6042.F09}</li>
	 * <li>{@code T6042.F01}</li>
	 * </ol>
	 * </li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 返回结果说明：
	 * <ol>
	 * <li>{@link FinancingPlan#planTitle}对应{@code T6042.F02}</li>
	 * <li>{@link FinancingPlan#planMoney}对应{@code T6042.F25}</li>
	 * <li>{@link FinancingPlan#joinCount}对应{@code count(T6043.F03)}</li>
	 * <li>{@link FinancingPlan#avgYield}对应{@code T6042.F05}</li>
	 * <li>{@link FinancingPlan#totleEarn}对应{@code sum(T6044.F05)}</li>
	 * <li>{@link FinancingPlan#releaseTime}对应{@code T6042.F09}</li>
	 * <li>{@link FinancingPlan#id}对应{@code T6042.F01}</li>
	 * </ol>
	 * </dl>
	 * </dt>
	 * 
	 * @param paging
	 *            分页查询参数
	 * @return {@link PagingResult} 分页查询结果
	 * @throws Throwable
	 */
	public abstract PagingResult<FinancingPlan> search(Paging paging)
			throws Throwable;
	
	
	/**
	 * 查询Wap列表
	 * @param paging
	 * @return
	 * @throws Throwable
	 */
	public abstract FinancingPlan[] searchWap(int line)
			throws Throwable;
	
	public abstract int getcount()
			throws Throwable;
	
	/**
	 * <dt>
	 * <dl>
	 * 描述：获取理财体验的投资效果统计.
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
	 * <li>无
	 * </li>
	 * <li>
	 * 查询字段列表
	 * <ol>
	 * </ol>
	 * </li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 返回结果说明：
	 * <ol>
	 * </ol>
	 * </dl>
	 * </dt>
	 * @return {@link FinancingPlanCount} 理财体验,如果不存在则返回{@code null}
	 * @throws Throwable
	 */
	public abstract FinancingPlanCount getStatistics()throws Throwable;
	
	/**
	 * <dt>
	 * <dl>
	 * 描述：根据理财体验ID查询投资记录.
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
	 * <li>查询{@code T6043}{@code T6010}表，{@code T6043.F02 = }
	 * </li>
	 * <li>按照{@code T6043.F05 DESC}字段降序排序</li>
	 * <li>
	 * 查询字段列表
	 * <ol>
	 * <li>{@code T6010.F02}</li>
	 * <li>{@code T6043.F04}</li>
	 * <li>{@code T6043.F05}</li>
	 * </ol>
	 * </li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 返回结果说明：
	 * <ol>
	 * <li>{@link PlanRecode#tzrName}对应{@code T6010.F02}</li>
	 * <li>{@link PlanRecode#tzMoney}对应{@code T6043.F04}</li>
	 * <li>{@link PlanRecode#tzTime}对应{@code T6043.F05}</li>
	 * </ol>
	 * </dl>
	 * </dt>
	 * @param id
	 * 			理财体验ID
	 * @return {@link PlanRecode[]} 查询列表结果
	 * @throws Throwable
	 */
	public abstract PlanRecode[] search(int id)  throws Throwable;
	
	/**
	 * <dt>
	 * <dl>
	 * 描述：根据planID查询用户已投资该理财体验的金额.
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
	 * <li>分页查询{@code T6043}
	 * {@code T6043.F02 =? AND T6043.F03 = ?}
	 * </li>
	 * <li>
	 * 查询字段列表
	 * <ol>
	 * <li>{@code T6043.F04}</li>
	 * </ol>
	 * </li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 返回结果说明：
	 * <ol>
	 * <li>{@link BigDecimal}对应{@code T6043.F04}</li>
	 * </ol>
	 * </dl>
	 * </dt>
	 * @param planId
	 * 			理财体验ID
	 * @return {@link BigDecimal} 用户的投资的金额
	 * @throws Throwable
	 */
	public abstract BigDecimal tzMoney(int planId) throws Throwable;
	
	/**
	 * 查询用户可用体验券
	 * @return {@link ExperiencePlan} 用户可使用体验券
	 * @throws Throwable
	 */
	public abstract ExperiencePlan[] getTyj() throws Throwable;
	
	/**
	 * 分页查询用户体验券
	 * @param status
	 * @param paging
	 * @return {@link PagingResult} 分页查询结果
	 * @throws Throwable
	 */
	public abstract PagingResult<ExperiencePlan> getTyjList(ExperienceGoldStatus status, Paging paging)
			throws Throwable;
	
	/**
	 * 用户获取体验券
	 * @param experienceNum
	 * @throws Throwable
	 */
	public abstract BigDecimal addTyj(String experienceNum) throws Throwable;
	
}
