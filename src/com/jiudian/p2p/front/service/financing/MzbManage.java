package com.jiudian.p2p.front.service.financing;

import java.math.BigDecimal;

import com.jiudian.framework.service.Service;
import com.jiudian.framework.service.query.Paging;
import com.jiudian.framework.service.query.PagingResult;
import com.jiudian.p2p.common.enums.ShbType;
import com.jiudian.p2p.front.service.financing.entity.Bank;
import com.jiudian.p2p.front.service.financing.entity.ContractFileVo;
import com.jiudian.p2p.front.service.financing.entity.HfblxrVo;
import com.jiudian.p2p.front.service.financing.entity.Mzbjrjl;
import com.jiudian.p2p.front.service.financing.entity.MzbjsVo;
import com.jiudian.p2p.front.service.financing.entity.MzblistVo;
import com.jiudian.p2p.front.service.financing.entity.Mzbszfxx;
import com.jiudian.p2p.front.service.financing.entity.MzbtjVo;
import com.jiudian.p2p.front.service.financing.entity.MzbxmbxVo;
import com.jiudian.p2p.front.service.financing.entity.Mzbxq;
import com.jiudian.p2p.front.service.financing.entity.Tjvo;
import com.jiudian.p2p.front.service.financing.entity.XcyVo;
import com.jiudian.p2p.front.service.financing.query.HfblxrQuery;
import com.jiudian.p2p.front.service.financing.query.MzbjrQuery;
import com.jiudian.p2p.front.service.financing.query.MzbszfxxQuery;

public interface MzbManage extends Service {
	
	/**
	 * 免租宝统计
	 * @return
	 * @throws Throwable
	 */
	public abstract MzbtjVo getMzbtj(int id,ShbType shbType) throws Throwable;
	
	
	/**
	 * 查询免租宝列表信息
	 * @param paging
	 * @return
	 * @throws Throwable
	 */
	public abstract PagingResult<MzblistVo> search(Paging paging,ShbType shbType) throws Throwable;
	
	/**
	 * 获取免租宝详情
	 * @param id
	 * @return
	 * @throws Throwable
	 */
	public abstract Mzbxq getMzbxq(int id) throws Throwable;
	
	/**
	 * 查询免租宝收租方信息
	 * @param id
	 * @return
	 * @throws Throwable
	 */
	public abstract Mzbszfxx getMzbszfxx(int id) throws Throwable;
	
	
	public abstract HfblxrVo getHfblxr(int id) throws Throwable;
		
	/**
	 * 添加免租宝收租方信息
	 * @param query
	 * @throws Throwable
	 */
	public abstract void addMzbszfxx(MzbszfxxQuery query) throws Throwable;
	
	/**
	 * 添加话费宝联系人信息
	 * @param query
	 * @throws Throwable
	 */
	public abstract void addHfblxr(HfblxrQuery query) throws Throwable;
	
	/**
	 * 删除话费宝联系人
	 * @param id
	 * @throws Throwable
	 */
	public abstract void deleteHfblxr(int id) throws Throwable;
	
	/**
	 * 查询免租宝收租方信息集合
	 * @return
	 * @throws Throwable
	 */
	public abstract Mzbszfxx[] getMzbszfxxlist() throws Throwable;
	
	/**
	 * 查询话费宝联系人信息集合
	 * @return
	 * @throws Throwable
	 */
	public abstract HfblxrVo[] getHfblxrlist() throws Throwable;
	
	/**
	 * 查询银行
	 * @param
	 * @return
	 * @throws Throwable
	 */
	public abstract Bank[] getBank() throws Throwable;
	
	
	/**
	 * 用户加入免租宝
	 * @param kyje 可用金额
	 * @throws Throwable
	 */
	/*public abstract void jrmzb(MzbjrQuery query,BigDecimal kyje) throws Throwable;*/
	
	/**
	 * 查询免租宝介绍
	 * @param id
	 * @return
	 * @throws Throwable
	 */
	public abstract MzbjsVo getMzbjsVo(int id) throws Throwable;
	
	/**
	 * 查询相关文件
	 * @param id
	 * @return
	 * @throws Throwable
	 */
	public abstract ContractFileVo[] getFileList(int id) throws Throwable;
	
	/**
	 * 查询免租宝加入记录
	 * @param mzbid
	 * @param paging
	 * @return
	 * @throws Throwable
	 */
	public abstract PagingResult<Mzbjrjl> searchMzbjrjl(int mzbid,Paging paging) throws Throwable;
	
	/**
	 * 查询项目表现
	 * @param mzbid
	 * @param paging
	 * @return
	 * @throws Throwable
	 */
	public abstract PagingResult<MzbxmbxVo> searchMzbxmbx(int mzbid,Paging paging) throws Throwable;
	
	/**
	 * 查询首页统计
	 * @return
	 * @throws Throwable
	 */
	public abstract Tjvo getTj() throws Throwable;
	
	/**
	 * 获取巡查员
	 * @return
	 */
	public abstract XcyVo[] getXcy() throws Throwable;
	
}
