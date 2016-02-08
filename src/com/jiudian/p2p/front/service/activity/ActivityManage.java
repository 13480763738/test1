package com.jiudian.p2p.front.service.activity;

import java.math.BigDecimal;

import com.jiudian.framework.service.Service;
import com.jiudian.framework.service.query.Paging;
import com.jiudian.framework.service.query.PagingResult;
import com.jiudian.p2p.front.service.activity.entity.Activity;
import com.jiudian.p2p.front.service.activity.entity.Gqcy;
import com.jiudian.p2p.front.service.activity.entity.Gqhd;
import com.jiudian.p2p.front.service.activity.entity.RedPacket;

public abstract interface ActivityManage extends Service {
	/**
	 * 查询活动排名
	 * 
	 * @param ping
	 * @return
	 */
	public abstract PagingResult<Activity> serachActivityRanking(Paging ping)
			throws Throwable;
	
	/**
	 * 获取当前登录用户国庆投资信息
	 * @return
	 */
	public abstract Gqhd get() throws Throwable;
	
	/**
	 * 查询活动排行榜
	 * @return
	 * @throws Throwable
	 */
	public abstract Gqcy[] serach() throws Throwable;
	
	/**
	 * 领取体验金
	 * 
	   '改革开放,F:未领取;S:已领取;',
	   '计划经济,F:未领取;S:已领取;',
	   '万元户,F:未领取;S:已领取;',
	   '下海经商,F:未领取;S:已领取;',
	   '中国特色,F:未领取;S:已领取;',
	   '三个代表,F:未领取;S:已领取;',
	   '社会主义,F:未领取;S:已领取;',
	 */
	public abstract String getTyj(int dj) throws Throwable;
	
	
	public abstract void update51(String colum) throws Throwable;
	
	/**
	 * 2014年双十一抽奖
	 * @return
	 * @throws Throwable
	 */
	public abstract int getLottery2014() throws Throwable;

	/**
	 * 2014年双十一抽奖
	 * @return
	 * @throws Throwable
	 */
	public abstract int getLottery2014Times()throws Throwable;

	/**
	 * 2014年双十一抽奖
	 * @return
	 * @throws Throwable
	 */
	public abstract int getLottery2014Amt()throws Throwable;
	
	public abstract BigDecimal getHd5Jbye() throws Throwable;
	
	/**
	 * 查询2014双蛋排行榜
	 * @return
	 * @throws Throwable
	 */
	public abstract Gqcy[] serach2014sd() throws Throwable;
	
	/**
	 * 2014双蛋活动获得奖励金额
	 * @return
	 * @throws Throwable
	 */
	public abstract BigDecimal getHd5Jlje(int type) throws Throwable;
	
	/**
	 * 查询2014双蛋排用户情况
	 * @return
	 * @throws Throwable
	 */
	public abstract String sdMsg() throws Throwable;
	
	/**
	 * 领取摇钱树
	 * @throws Throwable
	 */
	public abstract boolean getTreeMoney() throws Throwable;
	
	/**
	 * 获取摇钱树红包信息
	 * @return
	 * @throws Throwable
	 */
	public abstract RedPacket getRedPacket() throws Throwable;
	
	/**
	 * 获取红包信息
	 * @return
	 * @throws Throwable
	 */
	public abstract RedPacket getRedPacketContent() throws Throwable;
	
	/**
	 * 获取摇钱树红包
	 * @return
	 * @throws Throwable
	 */
	public abstract void getRedPacket(int id,int userid) throws Throwable;
	
	
	/**
	 * 拆红包
	 * @return
	 * @throws Throwable
	 */
	public abstract void putRedPacket() throws Throwable;
	
	/**
	 * 获取红包用户列表
	 * @return
	 * @throws Throwable
	 */
	public abstract RedPacket[] getRedPacketList(int id) throws Throwable;
	
	/**
	 * 获取领红包列表
	 * @return
	 * @throws Throwable
	 */
	public abstract RedPacket[] getRedPacketList() throws Throwable;
	
	/**
	 * 查询活动是否结束
	 * @param id
	 * @return
	 * @throws Throwable
	 */
	public abstract boolean isEnd(int id) throws Throwable;
	
}
