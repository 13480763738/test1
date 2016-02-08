package com.jiudian.p2p.front.service.common;

import java.sql.SQLException;

import com.jiudian.framework.http.session.authentication.AuthenticationException;
import com.jiudian.framework.service.Service;
import com.jiudian.framework.service.exception.LogicalException;
import com.jiudian.framework.service.exception.ParameterException;
import com.jiudian.p2p.common.enums.IsPass;
import com.jiudian.p2p.common.enums.UserSourceStatus;
import com.jiudian.p2p.common.enums.UserState;
import com.jiudian.p2p.front.service.activity.entity.UserVo;
import com.jiudian.p2p.front.service.common.entity.UserInsert;

public abstract interface UserManage extends Service {

	/**
	 * 
	 * <dt>
	 * <dl>
	 * 描述：新增用户
	 * </dl>
	 * 
	 * <dl>
	 * 数据校验：
	 * <ol>
	 * <li>如果{@code user == null} 抛异常ParameterException</li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 逻辑校验：
	 * <ol>
	 * <li>校验输入用户名是否存在</li>
	 * <li>如果输入了服务码需要在{@code T6011}表判断是否存在,如果不存在则为空</li>
	 * <li>生成一个随机6位的服务码，且不能在{@code T6011}表中存在</li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 业务处理：
	 * <ol>
	 * <li>新增用户：插入{@code T6010}表</li>
	 * <li>{@link UserInsert#getAccountName()}对应{@code T6010.F02}</li>
	 * <li>{@link UserInsert#getPassword()}对应{@code T6010.F03}</li>
	 * <li>{@code T6010.F04},{@code T6010.F05}为空</li>
	 * <li>{@link UserState#ZC}对应{@code T6010.F06}</li>
	 * <li>{@link UserSourceStatus#ZC}对应{@code T6010.F07}</li>
	 * <li>{@code T6010.F08}为空</li>
	 * </ol>
	 * <ol>
	 * <li>新增用户：插入T6011表</li>
	 * <li>{@code T6011.F01}对应新增{@code T6010}表返回的自增ID}</li>
	 * <li>{@code T6011.F10}对应{@link UserInsert#getCode()}</li>
	 * <li>{@code T6010.F11}我的服务码对应随机生成的6为数号码</li>
	 * <li>{@code T6010.F12}注册时间为当前时间</li>
	 * <li>{@code T6010.F15}对应{@link UserInsert#getType()}</li>
	 * </ol>
	 * <ol>
	 * <li>依次新增{@code T6012}表,{@code T6013}表,{@code T6014}表,{@code T6015}表,
	 * {@code T6016}表,{@code T6021}表,{@code T6023}表</li>
	 * <li>依次新增{@code T6025}表,{@code T6026}表,{@code T6029}表,{@code T6045}表</li>
	 * <li>只插入一个字段用户id，对应新增{@code T6010}表返回的自增ID}</li>
	 * </ol>
	 * <ol>
	 * <li>发送站内信</li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 返回结果说明：
	 * <ol>
	 * <li>返回新增后的自增用户ID</li>
	 * </ol>
	 * </dl>
	 * </dt>
	 * 
	 * @param user
	 *            用户信息
	 * @return 自增ID
	 * @throws ParameterException
	 *             输入参数错误
	 * @throws LogicalException
	 *             业务逻辑异常
	 * @throws SQLException
	 *             数据库操作异常
	 */
	public abstract int addUser(UserInsert user) throws Throwable;

	/**
	 * 
	 * <dt>
	 * <dl>
	 * 描述：获取用户未读站内信
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
	 * <li>...</li>
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
	 * @return
	 * @throws Throwable
	 */
	public abstract int getUnReadLetter() throws Throwable;
	
	/**
	 * 获取头像
	 * @return
	 * @throws Throwable
	 */
	public abstract String getHeadphoto() throws Throwable;

	/**
	 * 
	* <dt>
	* <dl>
	* 描述：获取当前登录用户账户名称.
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
	* <li>...</li>
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
	* @return
	* @throws Throwable
	 */
	public abstract String getAccountName() throws Throwable;
	
	
	public abstract String getNickName() throws Throwable;

	/**
	 * 查询用户名是否存在
	 * 
	 * @param accountName
	 *            用户名
	 * @return
	 * @throws SQLException
	 *             数据库操作异常
	 */
	public abstract boolean isAccountExists(String accountName)
			throws Throwable;

	/**
	 * 读取用户ID
	 * 
	 * @param condition
	 * @param password
	 * @return
	 * @throws AuthenticationException
	 * @throws SQLException
	 */
	public int readAccountId(String condition, String password)
			throws AuthenticationException, SQLException;

	/**
	 * 写日志
	 * 
	 * @param accountId
	 * @throws Throwable
	 */
	public void log(int accountId, String ip) throws Throwable;
	

	/**
	 * 判断手机号是否存在
	 * @param idCard
	 * @return
	 * @throws Throwable
	 */
	public abstract boolean isPhone(String idCard) throws Throwable;
	
	/**
	 * 修改发送记录
	 * @param phone
	 * @param code 
	 * 
	 * @return
	 * @throws Throwable
	 */
	public abstract void updateSend(String phone,String code) throws Throwable;
	
	/**
	 * 查询发送记录
	 * @param phone
	 * @param code 
	 * 
	 * @return
	 * @throws Throwable
	 */
	public abstract int getSend(String phone) throws Throwable;
	
	/**
	 * 查询服务码
	 * @param phone
	 * @param code 
	 * 
	 * @return
	 * @throws Throwable
	 */
	public abstract String getYqm() throws Throwable;
	
	public abstract String getYqm(int id) throws Throwable;
	
	
	/**
	 * 2014中秋活动体验金
	 */
	public void activity_1() throws Throwable;
	
	/**
	 * 2014巡查员制活动体验金
	 */
	public void activity_4() throws Throwable;
	
	public UserVo getUser() throws Throwable;
	
	/**
	 * 注册送红包活动
	 * @throws Throwable
	 */
	public void activity_5() throws Throwable;
	
	/**
	 * 报错意见反馈
	 * @throws Throwable
	 */
	public void addIdea(String idea,String lxfs) throws Throwable;
	
	/**
	 * 修改密码
	 * @param password
	 * @throws Throwable
	 */
	public abstract void updatePassword(String password) throws Throwable;
	
	
	/**
	 * 是否修改密码
	 * @throws Throwable
	 */
	public abstract IsPass sfxgmm() throws Throwable;
	/**
	 * 注册加密签名
	 * @return
	 */
	public abstract String getSign(String s1, String s2)throws Throwable;
}
