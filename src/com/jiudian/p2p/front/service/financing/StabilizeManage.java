package com.jiudian.p2p.front.service.financing;

import java.math.BigDecimal;

import com.jiudian.framework.service.Service;
import com.jiudian.framework.service.query.Paging;
import com.jiudian.framework.service.query.PagingResult;
import com.jiudian.p2p.common.enums.IsPass;
import com.jiudian.p2p.front.service.financing.entity.StabilizeTjVo;
import com.jiudian.p2p.front.service.financing.entity.StabilizeVo;
import com.jiudian.p2p.front.service.financing.entity.WjbJrjlTjVo;
import com.jiudian.p2p.front.service.financing.entity.WjbJrjlVo;
import com.jiudian.p2p.front.service.financing.entity.Xgzl;

public interface StabilizeManage  extends Service  {

	/**
	 * 查询稳赚保列表
	 * @param paging
	 * @return
	 * @throws Throwable
	 */
	public abstract PagingResult<StabilizeVo> getXzList(Paging paging) throws Throwable;
	
	/**
	 * 查询稳赚保列表统计信息
	 * @return
	 * @throws Throwable
	 */
	public abstract StabilizeTjVo getListTj() throws Throwable;
	
	/**
	 * 查询稳赚保头部详情
	 * @param id
	 * @return
	 * @throws Throwable
	 */
	public abstract StabilizeVo getHeaderDetail(int id) throws Throwable;
	
	/**
	 * 稳赚保获取项目文件
	 * @param id
	 * @return
	 * @throws Throwable
	 */
	public abstract Xgzl[] getXmwj(int id)throws Throwable;
	
	/**
	 * 加入稳赚保
	 * @param id 稳赚保ID
	 * @param jrje 加入金额
	 * @param isyd 是否预定
	 * @param jrid 加入id
	 * @throws Throwable
	 */
	public abstract int joinWjb(int id,BigDecimal dj,BigDecimal jrje,IsPass isyd,int jrid) throws Throwable;
	
	/**
	 * 获取稳赚保加入记录
	 * @param id
	 * @param isyd
	 * @return
	 * @throws Throwable
	 */
	public abstract WjbJrjlVo[] getJrjl(int id,IsPass isyd) throws Throwable;
	
	/**
	 * 预定记录
	 * @param id
	 * @param isyd
	 * @return
	 * @throws Throwable
	 */
	public abstract WjbJrjlVo[] getYdjl(int id,IsPass isyd) throws Throwable;
	/**
	 * 获取稳赚保计入记录统计
	 * @param id
	 * @param isyd
	 * @return
	 * @throws Throwable
	 */
	public abstract WjbJrjlTjVo getJrjlTj(int id,IsPass isyd)  throws Throwable;
	
	/**
	 * 获取首页显示数据
	 * @return
	 * @throws Throwable
	 */
	public abstract StabilizeVo get() throws Throwable;
	
}
