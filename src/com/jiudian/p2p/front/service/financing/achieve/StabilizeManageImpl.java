package com.jiudian.p2p.front.service.financing.achieve;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.jiudian.framework.service.ServiceFactory;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.framework.service.exception.ParameterException;
import com.jiudian.framework.service.query.ArrayParser;
import com.jiudian.framework.service.query.ItemParser;
import com.jiudian.framework.service.query.Paging;
import com.jiudian.framework.service.query.PagingResult;
import com.jiudian.p2p.common.enums.IsPass;
import com.jiudian.p2p.common.enums.StabilizeCycle;
import com.jiudian.p2p.common.enums.TenderRepayment;
import com.jiudian.p2p.common.enums.WjbStatus;
import com.jiudian.p2p.common.enums.WjbXmxq;
import com.jiudian.p2p.common.enums.ZfStatus;
import com.jiudian.p2p.front.config.FrontConst;
import com.jiudian.p2p.front.service.financing.StabilizeManage;
import com.jiudian.p2p.front.service.financing.entity.StabilizeTjVo;
import com.jiudian.p2p.front.service.financing.entity.StabilizeVo;
import com.jiudian.p2p.front.service.financing.entity.WjbJrjlTjVo;
import com.jiudian.p2p.front.service.financing.entity.WjbJrjlVo;
import com.jiudian.p2p.front.service.financing.entity.Xgzl;
import com.jiudian.util.parser.EnumParser;

public class StabilizeManageImpl extends AbstractFinancingManage implements
		StabilizeManage {

	public StabilizeManageImpl(ServiceResource serviceResource) {
		super(serviceResource);
	}

	public static class StabilizeManageImplFactory implements
			ServiceFactory<StabilizeManage> {
		@Override
		public StabilizeManage newInstance(ServiceResource serviceResource) {
			return new StabilizeManageImpl(serviceResource);
		}

	}

	@Override
	public PagingResult<StabilizeVo> getXzList(Paging paging) throws Throwable {
		StringBuilder sb = new StringBuilder();
		sb.append(" SELECT F01,F05,F07,(SELECT COUNT(*) FROM T6071 AS E WHERE E.F07='YZF' AND ");
		sb.append(" E.F02 = B.F01) JRRC,F16,F09,F20,F21,F22,F23,F24,F25,(SELECT COUNT(*) FROM  ");
		sb.append(" T6071 AS C WHERE C.F08<B.F23 AND C.F02 = B.F01) YDRS,F19,B.F08 FROM T6070 AS ");
		sb.append(" B WHERE 1=1 AND F19<>'DD' AND F19<>'QD' AND F19<>'ZF' AND F20<now() AND F25>now() OR (F19='YSD' AND F25<now()) OR (F19='YDQ' AND F25<now()) ORDER BY F20 DESC ");
		List<Object> parameters = new ArrayList<>();
		
		
		return selectPaging(getConnection(FrontConst.DB_USER),
				new ArrayParser<StabilizeVo>() {
					@Override
					public StabilizeVo[] parse(ResultSet res)
							throws SQLException {
						List<StabilizeVo> slist = new ArrayList<>();
						while (res.next()) {
							StabilizeVo s = new StabilizeVo();
							s.id = res.getInt(1);
							s.xmmc = res.getString(2);
							s.jhje = res.getBigDecimal(3);
							s.jrrc = res.getInt(4);
							s.nll = res.getBigDecimal(5);
							s.syje = res.getBigDecimal(6);
							s.fbsj = res.getTimestamp(7);
							s.ydkssj = res.getTimestamp(8);
							s.ydjssj = res.getTimestamp(9);
							s.zfjzsj = res.getTimestamp(10);
							s.jrkfsj = res.getTimestamp(11);
							s.sdkssj = res.getTimestamp(12);
							s.ydrs = res.getInt(13);
							s.status = EnumParser.parse(WjbStatus.class, res.getString(14));
							s.ydsyje = res.getBigDecimal(15);
							slist.add(s);
						}
						return slist.toArray(new StabilizeVo[slist.size()]);
					}
				}, paging, sb.toString(), parameters);
	}

	@Override
	public StabilizeTjVo getListTj() throws Throwable{
		return select(getConnection(FrontConst.DB_USER), new ItemParser<StabilizeTjVo>() {
			@Override
			public StabilizeTjVo parse(ResultSet res)
					throws SQLException {
				StabilizeTjVo s = new StabilizeTjVo();
				if(res.next()){
					s.ljzje = res.getBigDecimal(1);
					s.jrzrc = res.getInt(2);
					s.ljzqje = res.getBigDecimal(3);
				}
				return s;
			}
		}, "SELECT (SELECT SUM(F06) FROM T6071 WHERE F07='YZF') JRJE,(SELECT COUNT(*) FROM T6071 WHERE F07='YZF') JRRC,(SELECT SUM(F06+F07) FROM T6074 WHERE F10='YS') LJZQ");
	}

	@Override
	public StabilizeVo getHeaderDetail(int id) throws Throwable {
		StringBuilder sb = new StringBuilder("SELECT W.F01,W.F07,W.F16,W.F14,W.F15,W.F18,W.F25,W.F10,W.F08,W.F20,W.F21,W.F22,W.F23,W.F24,W.F11,W.F12,W.F05,W.F09");
		sb.append(",W.F19,W.F32,W.F33,(SELECT COUNT(*) FROM T6071 AS C WHERE C.F08<W.F23 AND C.F02 = W.F01 ) YDRS,(SELECT COUNT(*) FROM T6071 WHERE F07='YZF' AND F02 = W.F01 ) JRRC ");
		sb.append(",(SELECT SUM(D.F06) FROM T6074 AS D WHERE D.F02 = W.F01) YQZSY,(SELECT SUM(E.F06+E.F07) FROM T6074 AS E WHERE E.F02 = W.F01 ) ZSY,W.F03 htid ");
		sb.append(",W.F04 RZFMC,(SELECT Y.F02 FROM S70.T7029 AS Y ");
		sb.append(" WHERE  Y.F01 = (SELECT P.F02 FROM S70.T7031 AS P WHERE P.F01 = W.F03 )) JGMC,W.F06 XMJS,W.F13 FHBL  ");
		sb.append(" FROM T6070 AS W WHERE 1=1  AND F19<>'DD' AND F19<>'QD' AND F19<>'ZF' AND F01=?");
		return select(getConnection(FrontConst.DB_USER), new ItemParser<StabilizeVo>() {
			@Override
			public StabilizeVo parse(ResultSet res)
					throws SQLException {
				StabilizeVo s = new StabilizeVo();
				if(res.next()){
					s.id = res.getInt(1);
					s.jhje = res.getBigDecimal(2);
					s.nll = res.getBigDecimal(3);
					s.xmqx = res.getInt(4);
					s.xmqxlx = EnumParser.parse(StabilizeCycle.class, res.getString(5));
					s.hkfs = EnumParser.parse(TenderRepayment.class, res.getString(6));
					s.sdkssj = res.getTimestamp(7);
					s.tzzde = res.getBigDecimal(8);
					s.ydsyje = res.getBigDecimal(9);
					s.fbsj = res.getTimestamp(10);
					s.ydkssj = res.getTimestamp(11);
					s.ydjssj = res.getTimestamp(12);
					s.zfjzsj = res.getTimestamp(13);
					s.jrkfsj = res.getTimestamp(14);
					s.djbl = res.getBigDecimal(15);
					s.djsx = res.getBigDecimal(16);
					s.xmmc = res.getString(17);
					s.syje = res.getBigDecimal(18);
					s.status = EnumParser.parse(WjbStatus.class, res.getString(19));
					s.ydmeys = res.getTimestamp(20);
					s.meys = res.getTimestamp(21);
					s.ydrs = res.getInt(22);
					s.jrrc = res.getInt(23);
					s.yqzsy = res.getBigDecimal(24);
					s.zsy = res.getBigDecimal(25);
					s.htid = res.getInt(26);
					s.rzfmc = res.getString(27);
					s.dbjg = res.getString(28);
					s.xmjs = res.getString(29);
					s.fhbl = res.getBigDecimal(30);
					 
					if (s.xmqxlx.equals(StabilizeCycle.AY)) {
						Calendar calendar = Calendar.getInstance();
						calendar.setTimeInMillis(s.sdkssj.getTime());
						calendar.add(Calendar.MONTH, s.xmqx);
						s.tcrq = new Timestamp(calendar
								.getTimeInMillis());
					}
					if (s.xmqxlx.equals(StabilizeCycle.AT)) {
						Calendar calendar = Calendar.getInstance();
						calendar.setTimeInMillis(s.sdkssj.getTime());
						calendar.add(Calendar.DATE, s.xmqx);
						s.tcrq = new Timestamp(calendar
								.getTimeInMillis());
					}
				}
				return s;
			}
		}, sb.toString(), id);
	}

	@Override
	public Xgzl[] getXmwj(int id) throws Throwable {
		final List<Xgzl> list = new ArrayList<>();
		String _s = "SELECT F03,F04 FROM T7031_1 WHERE F02 = ? ORDER BY F05 ASC";
		selectAll(getConnection(FrontConst.DB_CONSOLE),
				new ArrayParser<Xgzl>() {
					@Override
					public Xgzl[] parse(ResultSet resultSet)
							throws SQLException {
						while (resultSet.next()) {
							Xgzl x = new Xgzl();
							x.name = resultSet.getString(1);
							x.imge = resultSet.getString(2);
							list.add(x);
						}
						return null;
					}
				}, _s, id);

		return list.toArray(new Xgzl[list.size()]);
	}

	@Override
	public int joinWjb(int id,BigDecimal dj,BigDecimal jrje, IsPass isyd, int jrid)
			throws Throwable {
		serviceResource.openTransactions();
		try {
			int new_jrid = 0;
			
			StabilizeVo stabilizeVo = this.getHeaderDetail(id);
			
			WjbXmxq wjbXmxq = checkStatus(stabilizeVo);
			
			//支付余额
			if(jrid>0 && isyd.equals(IsPass.S) ){
				if(wjbXmxq.equals(WjbXmxq.YDZ) || wjbXmxq.equals(WjbXmxq.YDJS) || wjbXmxq.equals(WjbXmxq.YDME)){
					int fs = 0;//购买分数
					//重新获取定金
					//判断余额是否正确
					BigDecimal old_dj = new BigDecimal(0);
					BigDecimal old_jrje = new BigDecimal(0);
					String sql = "SELECT F05,F06 FROM T6071 WHERE F01=?";
					try (Connection conn = getConnection(FrontConst.DB_USER)) {
						try (PreparedStatement ps = conn.prepareStatement(sql);) {
							ps.setInt(1, jrid);
							try (ResultSet res = ps.executeQuery();) {
								if (res.next()) {
									old_dj = res.getBigDecimal(1);
									old_jrje = res.getBigDecimal(2);
								}
							}
						}
					}
					if(old_dj.compareTo(new BigDecimal(0))==0){
						throw new ParameterException("不存在当前预定记录");
					}
					
					if(old_jrje.subtract(old_dj).compareTo(jrje)!=0){
						throw new ParameterException("支付余额有误！");
					}
					fs = old_jrje.divide(new BigDecimal(10000),0,BigDecimal.ROUND_HALF_DOWN).intValue();//购买分数
					/**
					 * 冻结用户支付余额
					 */
					this.djje(old_jrje.subtract(old_dj));
					//修改计入记录
					new_jrid = addJoinjl(jrid, id, isyd, old_dj, old_jrje, ZfStatus.YZF,stabilizeVo);
					if(new_jrid<=0){
						new_jrid = jrid;
					}
					//添加债权
					addZq(id, fs);
				}else{
					throw new ParameterException("当前状态是"+wjbXmxq.getName()+",不能支付余额！");
				}
			}
			
			//预定
			if(jrid==0 && isyd.equals(IsPass.S) ){
				if(wjbXmxq.equals(WjbXmxq.YDZ)){
					if(stabilizeVo.djsx.compareTo(new BigDecimal(0)) >0 && dj.compareTo(stabilizeVo.djsx)>0){
						dj = stabilizeVo.djsx;
					}
					
					if(jrje.intValue() % stabilizeVo.tzzde.intValue() !=0 || stabilizeVo.tzzde.compareTo(jrje)>0){
						throw new ParameterException("加入金额必须从"+stabilizeVo.tzzde.intValue()+"元起，且为"+stabilizeVo.tzzde.intValue()+"元的倍数递增");
					}
					
					/**
					 * 冻结用户定金
					 */
					this.djje(dj);
					new_jrid = addJoinjl(jrid, id, isyd, dj, jrje, ZfStatus.WZF,stabilizeVo);
				}else{
					throw new ParameterException("当前状态是"+wjbXmxq.getName()+",不能参与预定！");
				}
			}
			
			//加入
			if(isyd.equals(IsPass.F)){
				if(wjbXmxq.equals(WjbXmxq.KFJR)){
					
					if(jrje.intValue() % stabilizeVo.tzzde.intValue() !=0 || stabilizeVo.tzzde.compareTo(jrje)>0){
						throw new ParameterException("加入金额必须从"+stabilizeVo.tzzde.intValue()+"元起，且为"+stabilizeVo.tzzde.intValue()+"元的倍数递增");
					}
					
					int fs = jrje.divide(new BigDecimal(10000),0,BigDecimal.ROUND_HALF_DOWN).intValue();//购买分数
					/**
					 * 添加加入记录
					 */
					this.djje(jrje);
					
					new_jrid = addJoinjl(jrid, id, isyd, new BigDecimal(0), jrje, ZfStatus.YZF,stabilizeVo);
					addZq(id, fs);
				}else{
					throw new ParameterException("当前状态是"+wjbXmxq.getName()+",不能 加入！");
				}
			}
			
			if(new_jrid<=0){
				throw new ParameterException("项目加入失败");
			}
			return new_jrid;
		} catch (Throwable e) {
			serviceResource.rollback();
			throw new ParameterException(e.getMessage());
		}
	}

	/**
	 * 检查项目状态
	 * @param stabilizeVo
	 * @return
	 * @throws Throwable
	 */
	private WjbXmxq checkStatus (StabilizeVo stabilizeVo) throws Throwable{
		Timestamp now = new Timestamp(new Date().getTime());
		WjbXmxq wjbXmxq = null;
		if(stabilizeVo.status.equals(WjbStatus.YSD)){
			wjbXmxq = WjbXmxq.SYZ;
		}else if(stabilizeVo.status.equals(WjbStatus.YME)){
			wjbXmxq = WjbXmxq.YME;
		}else if(stabilizeVo.status.equals(WjbStatus.YDQ)){
			wjbXmxq = WjbXmxq.YDQ;
		}else if(stabilizeVo.status.equals(WjbStatus.YSH)){
			if(stabilizeVo.fbsj.compareTo(now)<=0 && stabilizeVo.ydkssj.compareTo(now)>0){
				wjbXmxq = WjbXmxq.JJYD;
			}else if(stabilizeVo.ydkssj.compareTo(now)<=0 && stabilizeVo.ydjssj.compareTo(now)>0 && stabilizeVo.ydsyje.intValue() > 0){
				wjbXmxq = WjbXmxq.YDZ;
			}else if(stabilizeVo.ydkssj.compareTo(now)<=0 && stabilizeVo.ydjssj.compareTo(now)>0 && stabilizeVo.ydsyje.intValue() == 0){
				wjbXmxq = WjbXmxq.YDME;
			}else if(stabilizeVo.ydjssj.compareTo(now)<=0 && stabilizeVo.zfjzsj.compareTo(now)>0 ){
				wjbXmxq = WjbXmxq.YDJS;
			}else if(stabilizeVo.zfjzsj.compareTo(now)<=0 && stabilizeVo.jrkfsj.compareTo(now)>0 ){
				wjbXmxq = WjbXmxq.ZFJZ;
			}else if(stabilizeVo.jrkfsj.compareTo(now)<=0 && stabilizeVo.sdkssj.compareTo(now)>0 && stabilizeVo.syje.intValue() > 0){
				wjbXmxq = WjbXmxq.KFJR;
			}else if(stabilizeVo.jrkfsj.compareTo(now)<=0 && stabilizeVo.sdkssj.compareTo(now)>0 && stabilizeVo.syje.intValue() == 0){
				wjbXmxq = WjbXmxq.YME;
			}
		}
		
		if((wjbXmxq!=null &&( wjbXmxq.equals(WjbXmxq.SYZ) || wjbXmxq.equals(WjbXmxq.YME) || wjbXmxq.equals(WjbXmxq.YDQ)))){
			throw new ParameterException("当前状态错误");
		}
		
		return wjbXmxq;
	}
	
	/**
	 * 添加计入记录
	 * @param jrid
	 * @param id
	 * @param isyd
	 * @param dj
	 * @param jrje
	 * @param status
	 * @throws Throwable
	 */
	private int addJoinjl(int jrid,int id,IsPass isyd,BigDecimal dj,BigDecimal jrje,ZfStatus status,StabilizeVo stabilizeVo) throws Throwable{
		int new_jrid = 0;
		int accountid = serviceResource.getSession().getAccountId();
		/**
		 * 修改预定剩余余额
		 */
		if(isyd.equals(IsPass.S)){
			if(status.equals(ZfStatus.WZF)){
				if(jrje.compareTo(stabilizeVo.ydsyje)>0){
					throw new ParameterException("超过预定剩余金额");
				}
				BigDecimal new_ydsyje = stabilizeVo.ydsyje.subtract(jrje);
				StringBuilder sb = new StringBuilder();
				List<Object> param = new ArrayList<Object>();
				sb.append("UPDATE T6070 SET F08=f08-?");
				param.add(jrje);
				if(new_ydsyje.compareTo(new BigDecimal(0))==0){
					sb.append(",F32 = CURRENT_TIMESTAMP");
				}
				sb.append(" WHERE F01=? ");
				param.add(id);
				execute(getConnection(FrontConst.DB_USER), sb.toString(), param);
				
			}
		}
		
		/**
		 * 修改剩余余额
		 */
		if(status.equals(ZfStatus.YZF)){
			if(jrje.compareTo(stabilizeVo.syje)>0){
				throw new ParameterException("超过剩余金额");
			}
			BigDecimal new_syje = stabilizeVo.syje.subtract(jrje);
			StringBuilder sb = new StringBuilder();
			List<Object> param = new ArrayList<Object>();
			sb.append("UPDATE T6070 SET F09=f09-?");
			param.add(jrje);
			if(new_syje.compareTo(new BigDecimal(0))==0){
				sb.append(",F33 = CURRENT_TIMESTAMP,F19='YME' ");
			}
			sb.append(" WHERE F01=? ");
			param.add(id);
			execute(getConnection(FrontConst.DB_USER), sb.toString(), param);
		}
		
		/**
		 * 添加修改加入记录
		 */
		StringBuilder sb = new StringBuilder();
		sb.append("INSERT INTO T6071 SET F01=?,F02=?,F03=?,F04=?,F05=?,F06=?,F07=?");
		if(isyd.equals(IsPass.S)){
			sb.append(",F08=CURRENT_TIMESTAMP()");
		}
		if(status.equals(ZfStatus.YZF)){
			sb.append(",F09=CURRENT_TIMESTAMP()");
		}
		sb.append(" ON DUPLICATE KEY UPDATE ");
		sb.append(" F01=?,F02=?,F03=?,F04=?,F05=?,F06=?,F07=?");
		if(status.equals(ZfStatus.YZF)){
			sb.append(",F09=CURRENT_TIMESTAMP()");
		}
		
		new_jrid = insert(getConnection(FrontConst.DB_USER), sb.toString(),jrid,id,accountid,isyd,dj,jrje,status,jrid,id,accountid,isyd,dj,jrje,status);
		
		return new_jrid;
	}
	
	/**
	 * 添加债权记录
	 * @param id
	 * @param fs
	 * @throws Throwable
	 */
	private void addZq(int id,int fs) throws Throwable{
		int accountid = serviceResource.getSession().getAccountId();
		StringBuilder sb = new StringBuilder();
		sb.append("INSERT INTO T6072 SET F02=?,F03=?,F04=?,F05=CURRENT_TIMESTAMP() ");
		sb.append(" ON DUPLICATE KEY UPDATE ");
		sb.append(" F02=?,F03=?,F04=f04+?,F05=CURRENT_TIMESTAMP() ");
		insert(getConnection(FrontConst.DB_USER), sb.toString(), id,accountid,fs,id,accountid,fs);
	}
	
	private void djje(BigDecimal djje) throws Throwable{
		execute(getConnection(FrontConst.DB_USER), "UPDATE T6023 SET F04=f04+?,F05=f05-? WHERE F01=?",djje,djje,serviceResource.getSession().getAccountId());
	}

	@Override
	public WjbJrjlVo[] getYdjl(int id, IsPass isyd) throws Throwable {
		return selectAll(getConnection(FrontConst.DB_USER), new ArrayParser<WjbJrjlVo>() {
			@Override
			public WjbJrjlVo[] parse(ResultSet res)
					throws SQLException {
				List<WjbJrjlVo> list = new ArrayList<WjbJrjlVo>();
				while(res.next()){
					WjbJrjlVo w = new WjbJrjlVo();
					w.tzr = res.getString(1);
					w.jrje = res.getBigDecimal(2);
					w.ydsj = res.getTimestamp(3);
					w.jrsj = res.getTimestamp(4);
					w.status = EnumParser.parse(ZfStatus.class, res.getString(5));
					list.add(w);
				}
				return list.toArray(new WjbJrjlVo[list.size()]);
			}
		}, "SELECT (SELECT B.F02 FROM T6010 AS B WHERE  B.F01 = A.F03) TZR,F06,F08,F09,F07 FROM T6071 AS A WHERE F02=? AND F04=?", id,isyd);
	}
	
	@Override
	public WjbJrjlVo[] getJrjl(int id, IsPass isyd) throws Throwable {
		return selectAll(getConnection(FrontConst.DB_USER), new ArrayParser<WjbJrjlVo>() {
			@Override
			public WjbJrjlVo[] parse(ResultSet res)
					throws SQLException {
				List<WjbJrjlVo> list = new ArrayList<WjbJrjlVo>();
				while(res.next()){
					WjbJrjlVo w = new WjbJrjlVo();
					w.tzr = res.getString(1);
					w.jrje = res.getBigDecimal(2);
					w.ydsj = res.getTimestamp(3);
					w.jrsj = res.getTimestamp(4);
					w.status = EnumParser.parse(ZfStatus.class, res.getString(5));
					list.add(w);
				}
				return list.toArray(new WjbJrjlVo[list.size()]);
			}
		}, "SELECT (SELECT B.F02 FROM T6010 AS B WHERE  B.F01 = A.F03) TZR,F06,F08,F09,F07 FROM T6071 AS A WHERE F02=? AND F07=?", id,ZfStatus.YZF);
	}

	@Override
	public WjbJrjlTjVo getJrjlTj(int id, IsPass isyd) throws Throwable {
		WjbJrjlTjVo w = new WjbJrjlTjVo();
		if(isyd.equals(IsPass.S)){
			w = select(getConnection(FrontConst.DB_USER), new ItemParser<WjbJrjlTjVo>() {
				@Override
				public WjbJrjlTjVo parse(ResultSet res)
						throws SQLException {
					WjbJrjlTjVo w = new WjbJrjlTjVo();
					if(res.next()){
						w.ydrs = res.getInt(1);
						w.wzfje = res.getBigDecimal(2);
					}
					return w;
				}
			}, "SELECT (SELECT COUNT(*) FROM T6071 WHERE F02 = ? AND F04='S' ) YDRS,(SELECT SUM(F06) FROM T6071 WHERE F02 =? AND F07='WZF' AND F04='S')", id,id);
		}else if(isyd.equals(IsPass.F)){
			w = select(getConnection(FrontConst.DB_USER), new ItemParser<WjbJrjlTjVo>() {
				@Override
				public WjbJrjlTjVo parse(ResultSet res)
						throws SQLException {
					WjbJrjlTjVo w = new WjbJrjlTjVo();
					if(res.next()){
						w.zjrrc = res.getInt(1); 
						w.jrje = res.getBigDecimal(2);
					}
					return w;
				}
			}, "SELECT (SELECT COUNT(*) FROM T6071 WHERE F02 =? AND F07='YZF' ) JRRC,(SELECT SUM(F06) FROM T6071 WHERE F02 =? AND F07='YZF')", id,id);
		}
		return w;
	}

	@Override
	public StabilizeVo get() throws Throwable {
		StringBuilder sb = new StringBuilder();
		sb.append(" SELECT F01,F05,F07,(SELECT COUNT(*) FROM T6071 AS E WHERE E.F07='YZF' AND ");
		sb.append(" E.F02 = B.F01) JRRC,F16,F09,F20,F21,F22,F23,F24,F25,(SELECT COUNT(*) FROM  ");
		sb.append(" T6071 AS C WHERE C.F08<B.F23 AND C.F02 = B.F01) YDRS,F19,B.F08,B.F10 TZZDE,(SELECT Y.F02 FROM S70.T7029 AS Y  WHERE  Y.F01 = (SELECT P.F02 FROM S70.T7031 AS P WHERE P.F01 = B.F03 )) JGMC FROM T6070 AS ");
		sb.append(" B WHERE 1=1 AND F19<>'DD' AND F19<>'QD' AND F19<>'ZF' AND F20<now() AND F25>now() OR (F19='YSD' AND F25<now()) OR (F19='YDQ' AND F25<now()) ORDER BY F20 DESC LIMIT 1 ");
		return select(getConnection(FrontConst.DB_USER), new ItemParser<StabilizeVo>() {
			@Override
			public StabilizeVo parse(ResultSet res)
					throws SQLException {
				StabilizeVo s = null;
				if(res.next()){
					s = new StabilizeVo();
					s.id = res.getInt(1);
					s.xmmc = res.getString(2);
					s.jhje = res.getBigDecimal(3);
					s.jrrc = res.getInt(4);
					s.nll = res.getBigDecimal(5);
					s.syje = res.getBigDecimal(6);
					s.fbsj = res.getTimestamp(7);
					s.ydkssj = res.getTimestamp(8);
					s.ydjssj = res.getTimestamp(9);
					s.zfjzsj = res.getTimestamp(10);
					s.jrkfsj = res.getTimestamp(11);
					s.sdkssj = res.getTimestamp(12);
					s.ydrs = res.getInt(13);
					s.status = EnumParser.parse(WjbStatus.class, res.getString(14));
					s.ydsyje = res.getBigDecimal(15);
					s.tzzde = res.getBigDecimal(16);
					s.dbjg = res.getString(17);
				}
				return s;
			}
		}, sb.toString());
	}
	
}
