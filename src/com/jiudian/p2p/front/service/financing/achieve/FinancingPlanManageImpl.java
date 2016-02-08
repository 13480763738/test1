package com.jiudian.p2p.front.service.financing.achieve;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.jiudian.framework.config.ConfigureProvider;
import com.jiudian.framework.service.ServiceFactory;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.framework.service.exception.ParameterException;
import com.jiudian.framework.service.query.ArrayParser;
import com.jiudian.framework.service.query.ItemParser;
import com.jiudian.framework.service.query.Paging;
import com.jiudian.framework.service.query.PagingResult;
import com.jiudian.p2p.common.enums.EarningsWay;
import com.jiudian.p2p.common.enums.EnsureMode;
import com.jiudian.p2p.common.enums.ExperienceGoldStatus;
import com.jiudian.p2p.common.enums.IsPass;
import com.jiudian.p2p.common.enums.PlanInvestmenWay;
import com.jiudian.p2p.common.enums.PlanState;
import com.jiudian.p2p.common.enums.SignType;
import com.jiudian.p2p.front.config.FrontConst;
import com.jiudian.p2p.front.service.financing.FinancingPlanManage;
import com.jiudian.p2p.front.service.financing.entity.ExperiencePlan;
import com.jiudian.p2p.front.service.financing.entity.FinancingPlan;
import com.jiudian.p2p.front.service.financing.entity.FinancingPlanCount;
import com.jiudian.p2p.front.service.financing.entity.FinancingPlanInfo;
import com.jiudian.p2p.front.service.financing.entity.PlanRecode;
import com.jiudian.p2p.variables.defines.SystemVariable;
import com.jiudian.util.StringHelper;
import com.jiudian.util.parser.EnumParser;

public class FinancingPlanManageImpl extends AbstractFinancingManage implements
		FinancingPlanManage {

	public FinancingPlanManageImpl(ServiceResource serviceResource) {
		super(serviceResource);
	}

	public static class FinancingPlanManageFactory implements
			ServiceFactory<FinancingPlanManage> {
		@Override
		public FinancingPlanManage newInstance(ServiceResource serviceResource) {
			return new FinancingPlanManageImpl(serviceResource);
		}

	}

	@Override
	public FinancingPlanInfo getPlan(int id) throws Throwable {
		if (id < 0) {
			return null;
		}
		String sql = "SELECT T6042.F02 title, T6042.F25 jhje, T6042.F05 yqsy, T6042.f06 tbfw, T6042.F24 bzfs, T6042.F07 jhzt, T6042.f08 meys, T6042.F11 sdqx, ADDDATE(T6042.F10,INTERVAL 1 DAY) jhjz, T6042.F14 sycl, T6042.F15 jrfl, T6042.F16 fwfl, T6042.F17 tcfl, T6042.F22 minmoney, T6042.F23 maxmoney,T6042.F01,T6042.F09,T6042.F13 ,T6042.F04,T6042.F18 jhjs,CURRENT_TIMESTAMP(),T6042.F26 FROM T6042 WHERE T6042.F01 = ?";
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(id);
		return select(getConnection(FrontConst.DB_USER),
				new ItemParser<FinancingPlanInfo>() {
					@Override
					public FinancingPlanInfo parse(ResultSet resultSet)
							throws SQLException {
						FinancingPlanInfo credit = null;
						while (resultSet.next()) {
							if (credit == null) {
								credit = new FinancingPlanInfo();
							}
							credit.planTitle = resultSet.getString(1);
							credit.planMoney = resultSet.getBigDecimal(2);
							credit.yqsy = resultSet.getBigDecimal(3);
							credit.signType = EnumParser.parse(SignType.class,
									resultSet.getString(4));
							credit.ensureMode = EnumParser.parse(
									EnsureMode.class, resultSet.getString(5));
							credit.planState = EnumParser.parse(
									PlanState.class, resultSet.getString(6));
							credit.fullTime = resultSet.getInt(7);
							credit.lockqx = resultSet.getInt(8);
							credit.cutoff = resultSet.getTimestamp(9);
							credit.earningsWay = EnumParser.parse(
									EarningsWay.class, resultSet.getString(10));
							credit.jrfl = resultSet.getDouble(11);
							credit.fwfl = resultSet.getDouble(12);
							credit.tcfl = resultSet.getDouble(13);
							credit.minMoney = resultSet.getBigDecimal(14);
							credit.maxMoney = resultSet.getBigDecimal(15);
							credit.id = resultSet.getInt(16);

							credit.fromSale = resultSet.getTimestamp(17);
							credit.lockEnd = resultSet.getTimestamp(18);
							credit.syMoney = resultSet.getBigDecimal(19);
							credit.introduce = resultSet.getString(20);
							credit.currentTime = resultSet.getTimestamp(21);
							credit.planInvestmenWay = EnumParser.parse(
									PlanInvestmenWay.class,
									resultSet.getString(22));
						}
						return credit;
					}
				}, sql, parameters);
	}

	@Override
	public PagingResult<FinancingPlan> search(Paging paging) throws Throwable {
		String sql = "SELECT T6042.F02 title, T6042.F25 jhje, count(T6043.F01) joinCount, T6042.F05, ( SELECT IFNULL(sum(T6057.F06), 0) FROM T6057 WHERE T6057.F02 = T6042.F01) earnMoney, T6042.F09 fabusj, T6042.F01 FROM T6042, T6043 WHERE T6043.F02 = T6042.F01 AND T6042.F01 <> (SELECT MAX(F01) FROM T6042) GROUP BY T6042.F01 ORDER BY T6042.F01 DESC";
		return selectPaging(getConnection(FrontConst.DB_USER),
				new ArrayParser<FinancingPlan>() {
					@Override
					public FinancingPlan[] parse(ResultSet resultSet)
							throws SQLException {
						ArrayList<FinancingPlan> list = null;
						while (resultSet.next()) {
							FinancingPlan credit = new FinancingPlan();
							credit.planTitle = resultSet.getString(1);
							credit.planMoney = resultSet.getString(2);
							credit.joinCount = resultSet.getInt(3);
							credit.avgYield = resultSet.getDouble(4);
							credit.totleEarn = resultSet.getBigDecimal(5);
							credit.releaseTime = resultSet.getTimestamp(6);
							credit.id = resultSet.getInt(7);
							credit.moneyUtilization = 1;
							if (list == null) {
								list = new ArrayList<>();
							}
							list.add(credit);
						}
						return list == null ? null : list
								.toArray(new FinancingPlan[list.size()]);
					}
				}, paging, sql);
	}

	@Override
	public FinancingPlanInfo getNewPlan() throws Throwable {
		String sql = "SELECT T6042.F02, T6042.F25, T6042.F05, T6042.F06, T6042.F24, T6042.F07, T6042.F08, T6042.F11, ADDDATE(T6042.F10,INTERVAL 1 DAY), T6042.F14, T6042.F15, T6042.F16, T6042.F17, T6042.F22, T6042.F23, T6042.F01, T6042.F09, T6042.F13, T6042.F04, T6042.F18, T6042.F03,CURRENT_TIMESTAMP(),T6042.F26 FROM T6042 ORDER BY T6042.F01 DESC LIMIT 1";
		ArrayList<Object> parameters = new ArrayList<>();
		return select(getConnection(FrontConst.DB_USER),
				new ItemParser<FinancingPlanInfo>() {
					@Override
					public FinancingPlanInfo parse(ResultSet resultSet)
							throws SQLException {
						FinancingPlanInfo credit = null;
						while (resultSet.next()) {
							if (credit == null) {
								credit = new FinancingPlanInfo();
							}
							credit.planTitle = resultSet.getString(1);
							credit.planMoney = resultSet.getBigDecimal(2);
							credit.yqsy = resultSet.getBigDecimal(3);
							credit.signType = EnumParser.parse(SignType.class,
									resultSet.getString(4));
							credit.ensureMode = EnumParser.parse(
									EnsureMode.class, resultSet.getString(5));
							credit.planState = EnumParser.parse(
									PlanState.class, resultSet.getString(6));
							credit.fullTime = resultSet.getInt(7);
							credit.lockqx = resultSet.getInt(8);
							credit.cutoff = resultSet.getTimestamp(9);
							credit.earningsWay = EnumParser.parse(
									EarningsWay.class, resultSet.getString(10));
							credit.jrfl = resultSet.getDouble(11);
							credit.fwfl = resultSet.getDouble(12);
							credit.tcfl = resultSet.getDouble(13);
							credit.minMoney = resultSet.getBigDecimal(14);
							credit.maxMoney = resultSet.getBigDecimal(15);
							credit.id = resultSet.getInt(16);
							credit.fromSale = resultSet.getTimestamp(17);
							credit.lockEnd = resultSet.getTimestamp(18);
							credit.syMoney = resultSet.getBigDecimal(19);
							credit.introduce = resultSet.getString(20);
							credit.ActualMoney = resultSet.getBigDecimal(21);
							credit.currentTime = resultSet.getTimestamp(22);
							
							credit.proess = (int)((credit.planMoney.doubleValue()-credit.syMoney.doubleValue())*100
									/ credit.planMoney.doubleValue());
		
							if(credit.proess==0 && ((credit.planMoney.doubleValue()-credit.syMoney.doubleValue())>0)){
								credit.proess = 1;
							}
							credit.planInvestmenWay = EnumParser.parse(
									PlanInvestmenWay.class,
									resultSet.getString(23));

						}
						return credit;
					}
				}, sql, parameters);
	}

	@Override
	public FinancingPlanCount getStatistics() throws Throwable {
		FinancingPlanCount fc = new FinancingPlanCount();
		try (Connection conn = getConnection(FrontConst.DB_CONSOLE)) {
			try (PreparedStatement ps = conn
					.prepareStatement("SELECT F01,F02,F04 FROM T7048");) {
				try (ResultSet rs = ps.executeQuery();) {
					if (rs.next()) {
						fc.totleMoney = rs.getBigDecimal(1);
						fc.userEarnMoney = rs.getBigDecimal(2);
						fc.joinCount = rs.getLong(3);
						if (fc.totleMoney.compareTo(BigDecimal.ZERO) > 0) {
							fc.moneyUse = 1;
						} else {
							fc.moneyUse = 0;
						}
					}
				}
			}
		}

		return fc;
	}

	@Override
	public PlanRecode[] search(int id) throws Throwable {
		if (id < 0) {
			return null;
		}
		String sql = "SELECT T6010.F02, T6043.F04, T6043.F05 FROM T6043 INNER JOIN T6010 ON T6043.F03 = T6010.F01 WHERE T6043.F02 = ? ORDER BY T6043.F05 DESC";
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(id);
		return selectAll(getConnection(FrontConst.DB_USER),
				new ArrayParser<PlanRecode>() {
					@Override
					public PlanRecode[] parse(ResultSet resultSet)
							throws SQLException {
						ArrayList<PlanRecode> list = null;
						while (resultSet.next()) {
							PlanRecode pr = new PlanRecode();
							pr.tzrName = resultSet.getString(1);
							pr.tzMoney = resultSet.getBigDecimal(2);
							pr.tzTime = resultSet.getTimestamp(3);
							if (list == null) {
								list = new ArrayList<>();
							}
							list.add(pr);
						}
						return list == null ? null : list
								.toArray(new PlanRecode[list.size()]);
					}
				}, sql, parameters);
	}

	@Override
	public BigDecimal tzMoney(int planId) throws Throwable {
		if (planId < 0) {
			return null;
		}
		BigDecimal bd = new BigDecimal(0);
		try (Connection conn = getConnection(FrontConst.DB_USER)) {
			try (PreparedStatement ps = conn
					.prepareStatement("SELECT F04 FROM T6043 WHERE F02 = ? AND F03 = ?");) {
				ps.setInt(1, planId);
				ps.setInt(2, serviceResource.getSession().getAccountId());
				try (ResultSet rs = ps.executeQuery();) {
					if (rs.next()) {
						bd = rs.getBigDecimal(1);
					}
				}
			}
		}
		return bd;
	}

	@Override
	public ExperiencePlan[] getTyj() throws Throwable {
		return selectAll(
				getConnection(FrontConst.DB_CONSOLE),
				new ArrayParser<ExperiencePlan>() {
					@Override
					public ExperiencePlan[] parse(ResultSet rest)
							throws SQLException {
						List<ExperiencePlan> list = new ArrayList<ExperiencePlan>();

						while (rest.next()) {
							ExperiencePlan experiencePlan = new ExperiencePlan();
							experiencePlan.experienceNum = rest.getString(1);
							experiencePlan.amount = rest.getBigDecimal(2);
							list.add(experiencePlan);
						}

						return list.toArray(new ExperiencePlan[list.size()]);
					}
				},
				"SELECT F01,F06 FROM T7051 WHERE F07=? AND F11=? AND DATEDIFF(F05,CURRENT_DATE())>=0  ",
				serviceResource.getSession().getAccountId(),
				ExperienceGoldStatus.YLY.toString());
	}

	@Override
	public PagingResult<ExperiencePlan> getTyjList(ExperienceGoldStatus status,
			Paging paging) throws Throwable {
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT F01,F06,F04,F05,F08,F09,F11 FROM T7051 WHERE 1=1 ");
		List<Object> parameters = new ArrayList<Object>();
		if (status != null) {
			sql.append(" AND F11 = ? ");
			parameters.add(status);
		}
		sql.append(" AND F07 = ? ");
		parameters.add(serviceResource.getSession().getAccountId());

		return selectPaging(getConnection(FrontConst.DB_CONSOLE),
				new ArrayParser<ExperiencePlan>() {
					@Override
					public ExperiencePlan[] parse(ResultSet rest)
							throws SQLException {

						List<ExperiencePlan> list = new ArrayList<ExperiencePlan>();

						while (rest.next()) {
							ExperiencePlan ex = new ExperiencePlan();
							ex.experienceNum = rest.getString(1);
							ex.amount = rest.getBigDecimal(2);
							ex.starTime = rest.getDate(3);
							ex.endTime = rest.getDate(4);
							ex.getTime = rest.getTimestamp(5);
							ex.useTime = rest.getTimestamp(6);
							ex.experienceGoldStatus = EnumParser.parse(
									ExperienceGoldStatus.class,
									rest.getString(7));
							list.add(ex);
						}

						return list.toArray(new ExperiencePlan[list.size()]);
					}
				}, paging, sql.toString(), parameters);
	}

	@Override
	public BigDecimal addTyj(String experienceNum) throws Throwable {
		if (StringHelper.isEmpty(experienceNum)) {
			throw new ParameterException("券号错误！");
		}
		serviceResource.openTransactions();
		// 判断当前券号状态是否为未领用且未过期
		ExperiencePlan ex = null;
		ex = select(
				getConnection(FrontConst.DB_CONSOLE),
				new ItemParser<ExperiencePlan>() {
					@Override
					public ExperiencePlan parse(ResultSet rest)
							throws SQLException {
						ExperiencePlan ex = null;
						while (rest.next()) {
							ex = new ExperiencePlan();
							ex.experienceNum = rest.getString(1);
							ex.experienceGoldStatus = EnumParser.parse(
									ExperienceGoldStatus.class,
									rest.getString(2));
							ex.amount = rest.getBigDecimal(3);
							ex.qh = rest.getInt(4);
						}
						return ex;
					}
				},
				"SELECT F01,F11,F06,F02 FROM T7051 WHERE F01=? AND DATEDIFF(F05,CURRENT_DATE())>=0 FOR UPDATE ",
				experienceNum);

		if (ex == null) {
			throw new ParameterException("券号错误！");
		} else {
			if (!ex.experienceGoldStatus.equals(ExperienceGoldStatus.WLY)) {
				throw new ParameterException("券号"
						+ ex.experienceGoldStatus.getName());
			}
		}
		
		String _s = "SELECT COUNT(*) FROM T7051 WHERE F02=? AND F07=?";
		int count = selectInt(FrontConst.DB_CONSOLE, _s, ex.qh,serviceResource.getSession().getAccountId());
		
		String _vip = "SELECT F14 FROM T7050 WHERE F01=?";
		IsPass sfvip = EnumParser.parse(IsPass.class, selectString(FrontConst.DB_CONSOLE, _vip, ex.qh));
		
		if(count>0&&sfvip.equals(IsPass.F)){
			throw new ParameterException("同批次体验金已经领过!");
		}

		// 判断用户是否可以领取
		final ConfigureProvider configureProvider =serviceResource.getResource(ConfigureProvider.class);
		//距离上次领取的时间
		int dats = Integer.parseInt(configureProvider.format(SystemVariable.TYJ_LQ_DAY));
		
		if(select(getConnection(FrontConst.DB_CONSOLE), new ItemParser<Boolean>() {
			@Override
			public Boolean parse(ResultSet rs) throws SQLException {
				if(rs.next()){
					int total = rs.getInt(1);
					if(total >0){
						return true;
					}
				}
				return false;
			}
		}, " SELECT COUNT(F01) FROM T7051 WHERE F07=? AND (TO_DAYS(NOW())-TO_DAYS(F08)) < ? ", 
			serviceResource.getSession().getAccountId(),dats)){
			throw new ParameterException(" 您已获取过体验金，"+dats+"天内不能再次获取！");
		}
			
		if (getTyj().length >= 3) {
			throw new ParameterException("最多可持有三张体验券，您可以先使用再领取");
		}

		// 用户领用
		execute(getConnection(FrontConst.DB_CONSOLE),
				" UPDATE T7051 SET F07=?,F08=now(),F11=? WHERE F01=? ",
				serviceResource.getSession().getAccountId(),
				ExperienceGoldStatus.YLY.toString(), experienceNum);

		// 添加用户体验金 判断用户是否添加过 未添加过添加。已添加过修改
		boolean is = select(getConnection(FrontConst.DB_CONSOLE),
				new ItemParser<Boolean>() {
					@Override
					public Boolean parse(ResultSet rest) throws SQLException {
						if (rest.next()) {
							return true;
						} else {
							return false;
						}
					}
				}, "SELECT F01 FROM T7049 WHERE F01=?  FOR UPDATE ",
				serviceResource.getSession().getAccountId());

		if (is) {
			// 添加金额
			execute(getConnection(FrontConst.DB_CONSOLE),
					" UPDATE T7049 SET F02=(F02+?) WHERE F01=? ", ex.amount,
					serviceResource.getSession().getAccountId());
		} else {
			insert(getConnection(FrontConst.DB_CONSOLE),
					"INSERT INTO T7049 SET F01=?,F02=?", serviceResource
							.getSession().getAccountId(), ex.amount);
		}
		
		return ex.amount;
	}

	@Override
	public FinancingPlan[] searchWap(int line) throws Throwable {
		if(line == 0){
			line = 3;
		}
		String sql = "SELECT T6042.F02, T6042.F25, T6042.F05, T6042.F07, T6042.F11, T6042.F01, T6042.F09,T6042.F04,CURRENT_TIMESTAMP() FROM T6042 ORDER BY T6042.F01 DESC LIMIT ?";
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(line);
		return selectAll(getConnection(FrontConst.DB_USER), new ArrayParser<FinancingPlan>() {
			@Override
			public FinancingPlan[] parse(ResultSet res)
					throws SQLException {
				List<FinancingPlan> list = new ArrayList<FinancingPlan>();
				while (res.next()) {
					FinancingPlan credit = new FinancingPlan();
					credit.planTitle = res.getString(1);
					credit.planMoney_wap = res.getBigDecimal(2);
					credit.yqsy = res.getBigDecimal(3);
					credit.planState = EnumParser.parse(PlanState.class, res.getString(4));
					credit.lockqx = res.getInt(5);
					credit.id = res.getInt(6);
					credit.fromSale = res.getTimestamp(7);
					credit.syMoney = res.getBigDecimal(8);
					credit.currentTime = res.getTimestamp(9);
					
					credit.proess = (int)((credit.planMoney_wap.doubleValue()-credit.syMoney.doubleValue())*100
							/ credit.planMoney_wap.doubleValue());

					if(credit.proess==0 && ((credit.planMoney_wap.doubleValue()-credit.syMoney.doubleValue())>0)){
						credit.proess = 1;
					}
					list.add(credit);
				}
				return list.toArray(new FinancingPlan[list.size()]);
			}
		}, sql, parameters);
	}

	@Override
	public int getcount() throws Throwable {
		return selectInt(FrontConst.DB_USER, "select count(*) from t6042 ");
	}

}
