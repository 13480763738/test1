package com.jiudian.p2p.front.service.common;

import java.sql.SQLException;

import com.jiudian.framework.service.Service;

public abstract interface PasswordManage extends Service {
	/**
	 * <dt>
	 * <dl>
	 * 用户邮箱是否存在
	 * </dl>
	 * <dl>
	 * <ol>
	 * <li>若邮箱地址输入为空串或null值，则返回0</li>
	 * <li>查询T6010.F05,若记录存在则返回实体id，否则返回0</li>
	 * </ol>
	 * </dl>
	 * </dt>
	 * 
	 * @param email
	 *            邮箱地址
	 * @return 实体id
	 * @throws Throwable
	 */
	public abstract int emailExist(String email) throws Throwable;

	/**
	 * <dt>
	 * <dl>
	 * 用户手机号是否存在
	 * </dl>
	 * <dl>
	 * <ol>
	 * <li>若手机号输入为空串或null值，则返回0</li>
	 * <li>查询T6010.F04,若记录存在则返回实体id，否则返回0</li>
	 * </ol>
	 * </dl>
	 * </dt>
	 * 
	 * @param phone
	 *            手机号码
	 * @return
	 * @throws Throwable
	 */
	public abstract int phoneExist(String phone) throws Throwable;

	/**
	 * <dt>
	 * <dl>
	 * 更新用户密码
	 * </dl>
	 * <dl><ol>更新T6010.F03,注意加密<ol></dl>
	 * </dt>
	 * 
	 * @param password
	 *            密码
	 * @param userId
	 *            用户id
	 * @throws ParameterException
	 *             password为空串或null，userId小于等于0
	 * @throws SQLException
	 *             数据库操作异常
	 */
	public abstract void updatePassword(String password, int userId) throws Throwable;
}
