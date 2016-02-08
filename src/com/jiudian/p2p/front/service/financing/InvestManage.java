package com.jiudian.p2p.front.service.financing;

import java.math.BigDecimal;

import com.jiudian.framework.service.Service;
import com.jiudian.framework.service.query.Paging;
import com.jiudian.framework.service.query.PagingResult;
import com.jiudian.p2p.common.enums.IsPass;
import com.jiudian.p2p.front.service.financing.entity.CreditInfo;
import com.jiudian.p2p.front.service.financing.entity.InvestStatistics;
import com.jiudian.p2p.front.service.financing.entity.Rewards;
import com.jiudian.p2p.front.service.financing.entity.TenderRecord;
import com.jiudian.p2p.front.service.financing.query.InvestQuery;

/**
 * 散标投资
 * 
 */
public interface InvestManage extends Service {

	/**
	 * 获取散标投资列表
	 * 
	 * @param query
	 * @param paging
	 * @return
	 * @throws Throwable
	 */
	public abstract PagingResult<CreditInfo> search(InvestQuery query,
			Paging paging) throws Throwable;
	
	public abstract CreditInfo[] search(int line) throws Throwable;
	
	
	public abstract int searchcount() throws Throwable;

	/**
	 * 获取投资统计信息.
	 * 
	 * @return {@link InvestStatistics}
	 * @throws Throwable
	 */
	public abstract InvestStatistics getStatistics() throws Throwable;

	/**
	 * 获取散标详细信息.
	 * 
	 * @param id
	 * @return {@link CreditInfo}
	 * @throws Throwable
	 */
	public abstract CreditInfo get(int id) throws Throwable;
	/**
	 * 查询机构名称
	 * @param jkbId
	 * @return
	 * @throws Throwable
	 */
	public String getJgName(int jkbId)throws Throwable;
	
	/**
	 * 获取奖励信息
	 * @param id
	 * @return
	 * @throws Throwable
	 */
	public abstract Rewards getRewards(int id) throws Throwable;
	
	
	/**
	 * 获取投标分数
	 * 
	 * @param id
	 * @return {@link int}
	 * @throws Throwable
	 */
	public abstract BigDecimal getTbcont(int id) throws Throwable;
	
	
	/**
	 * 获取奖励用户列表
	 * 
	 * @param id
	 * @return {@link TenderRecord[]}
	 * @throws Throwable
	 */
	public abstract TenderRecord[] getJllb(int id) throws Throwable;

	/**
	 * 网贷之家接口,获取当前正在进行投标中的标信息。
	 * @param paging
	 * @return
	 * @throws Throwable
	 */
	public abstract PagingResult<CreditInfo> getNowProjects(Paging paging) throws Throwable;

	/**
	 * 网贷之家接口,获取所有在’date’这一天成功借款（即满标时间为date）的标。date格式: ‘2013-09-01’
	 * @param date
	 * @param paging
	 * @return
	 * @throws Throwable
	 */
	public abstract PagingResult<CreditInfo> getProjectByDate(String date,
			Paging paging)throws Throwable;
	/**
	 * 判断是否开通金账户
	 * @return
	 * @throws Throwable
	 */
	public abstract IsPass sfktJzh() throws Throwable;
	
}
