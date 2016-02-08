package com.jiudian.p2p.front.service.credit.entity;

import java.util.List;

import com.jiudian.framework.http.upload.UploadFile;

public interface AccessoryQuery {
	/**
	 * 认证信息ID
	 */
	public abstract int getId();

	/**
	 * 用户ID
	 * 
	 * @return
	 */
	public abstract int getAcount();

	/**
	 * 用户认证信息
	 * 
	 * @return
	 */
	public abstract String getCount();

	/**
	 * 用户认证类型
	 */
	public abstract String getType();

	/**
	 * 附件集合\
	 * 
	 * @return
	 * @throws Throwable
	 */
	public abstract List<UploadFile> getAccessory() throws Throwable;

}
