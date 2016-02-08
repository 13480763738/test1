package com.jiudian.p2p.front.service.credit;

import com.jiudian.framework.service.Service;
import com.jiudian.p2p.common.enums.AttestationState;
import com.jiudian.p2p.common.enums.AttestationType;
import com.jiudian.p2p.front.service.credit.entity.Lmoney;
import com.jiudian.p2p.front.service.credit.entity.LmoneyDecide;
import com.jiudian.p2p.front.service.credit.entity.LmoneyQuery;

/**
 * 借款申请
 * @author jiudian
 *
 */
public interface LmoneyManage extends Service {
	
	
	/**
	 * 查询能借款必要信息（并且判断跳转）
	 * @param acount 用户ID
	 * @param type 借款表类型
	 * @return
	 */
	public abstract LmoneyDecide getLmoneyDecide(String type) throws Throwable;
	
	/**
	 * 查询借款申请
	 * @param acount 借款ID
	 * @param type 借款表类型
	 * @return
	 */
	public abstract Lmoney getLmoney(int id,String type) throws Throwable;
	
	/**
	 * 添加借款申请
	 * @param account 用户ID
	 * @param query 借款申请信息
	 * @return
	 */
	public abstract int addLmoney(LmoneyQuery query) throws Throwable;
	
	
	/**
	 * 修改借款申请
	 * @param query 修改内容
	 */
	public abstract void update(LmoneyQuery query) throws Throwable;
	
	/**
	 * 获取当月最大债权ID
	 * @param 
	 */
	public abstract int getCrid(String type) throws Throwable;
	
	/**
	 * 修改借款状态
	 * @param id 借款ID
	 * @param status 状态
	 */
	public abstract void update(int id,String status) throws Throwable;
	
	/**
	 * 查询当前用户认证信息
	 * @param type 认证类型
	 */
	public abstract AttestationState getAttentiontype(AttestationType type) throws Throwable;
	
	/**
	 * 查询当前用户借款是否逾期
	 * @param 
	 */
	public abstract boolean isyq() throws Throwable;
	
}
