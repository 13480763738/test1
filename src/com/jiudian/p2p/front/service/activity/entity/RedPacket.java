package com.jiudian.p2p.front.service.activity.entity;

import java.math.BigDecimal;
import java.sql.Timestamp;

import com.jiudian.p2p.common.enums.IsPass;

public class RedPacket{
	
	public BigDecimal money = new BigDecimal(0);
	
	public BigDecimal treeMoney = new BigDecimal(0);
	
	public IsPass isGet;
	
	public Timestamp getTime;
	
	public Timestamp getBounsTime;
	
	public int redPacketNum;
	
	public BigDecimal redPacketMoney = new BigDecimal(0);
	
	public BigDecimal jqje = new BigDecimal(0);
	
	public String userName;
	
}
