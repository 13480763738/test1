package com.jiudian.p2p.front.service.financing.achieve;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.jiudian.framework.service.ServiceFactory;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.framework.service.query.ArrayParser;
import com.jiudian.framework.service.query.ItemParser;
import com.jiudian.p2p.common.enums.AttestationState;
import com.jiudian.p2p.common.enums.AttestationStatus;
import com.jiudian.p2p.common.enums.AttestationType;
import com.jiudian.p2p.common.enums.CreditType;
import com.jiudian.p2p.common.enums.IsHovestatus;
import com.jiudian.p2p.common.enums.MarriageStatus;
import com.jiudian.p2p.common.enums.OverdueStatus;
import com.jiudian.p2p.common.enums.RepayStatus;
import com.jiudian.p2p.common.enums.Sex;
import com.jiudian.p2p.common.enums.TransferStatus;
import com.jiudian.p2p.common.enums.Zystatus;
import com.jiudian.p2p.front.config.FrontConst;
import com.jiudian.p2p.front.service.financing.CreditAssignmentInfoManage;
import com.jiudian.p2p.front.service.financing.entity.AlsoMoney;
import com.jiudian.p2p.front.service.financing.entity.CreditHoldInfo;
import com.jiudian.p2p.front.service.financing.entity.CreditOutRecode;
import com.jiudian.p2p.front.service.financing.entity.CreditUserInfo;
import com.jiudian.p2p.front.service.financing.entity.TenderRecord;
import com.jiudian.p2p.front.service.financing.entity.UserRZInfo;
import com.jiudian.p2p.front.service.financing.entity.Xgzl;
import com.jiudian.util.parser.EnumParser;

public class CreditAssignmentInfoManageImpl extends AbstractFinancingManage
		implements CreditAssignmentInfoManage {

	public CreditAssignmentInfoManageImpl(ServiceResource serviceResource) {
		super(serviceResource);
	}

	public static class CreditAssignmentInfoManageFactory implements
			ServiceFactory<CreditAssignmentInfoManage> {
		@Override
		public CreditAssignmentInfoManage newInstance(
				ServiceResource serviceResource) {
			return new CreditAssignmentInfoManageImpl(serviceResource);
		}

	}

	@Override
	public CreditUserInfo getUser(int id, CreditType creditType)
			throws Throwable {
		if (id <= 0) {
			return null;
		}
		String sql = "";
		ArrayList<Object> parameters = new ArrayList<>();
		
		if (creditType == CreditType.XYDB || creditType == CreditType.SDRZ) {
			try (Connection conn = getConnection(FrontConst.DB_USER)) {
				try (PreparedStatement ps = conn
						.prepareStatement("SELECT T6036_1.F02 FROM T6039 LEFT JOIN T6036_1 ON T6036_1.F01 = T6039.f03 WHERE  T6039.F01 = ?");) {
					ps.setInt(1, id);
					try (ResultSet rs = ps.executeQuery();) {
						if (rs.next()) {
							Zystatus status = EnumParser.parse(Zystatus.class,
									rs.getString(1));
							if (status == Zystatus.SYQYZ) {
								creditType = CreditType.SYD;
							}
						}
					}
				}
			}
		}
		
		if (creditType == CreditType.SYD) {
			sql = "SELECT T6010.F02, T6011.F17, T6011.F21, T6012.F02, T6014.F09, T6014.F07, T6014.F05, T6014.F13, T6014.F10, T6014.F11, T6015.F03, T6015.F04, T6015.F06, T6015.F08, T6010.F01, T6011.F16, T6011.F07, he.F08 htje, jg.F02 dbmc, T6014.F03 gsmc FROM T6011, T6010, T6012, T6014, T6015, T6039, T6036 LEFT JOIN "+FrontConst.DB_CONSOLE+".t7031 he ON T6036.F25 = he.F01 LEFT JOIN "+FrontConst.DB_CONSOLE+".t7029 jg ON he.F02 = jg.F01 WHERE T6036.F02 = T6010.F01 AND T6039.F03 = T6036.F01 AND T6010.F01 = T6011.F01 AND T6010.F01 = T6012.F01 AND T6010.F01 = T6014.F01 AND T6010.F01 = T6015.F01 AND T6039.F01 = ? ";
		} else {
			sql = "SELECT T6010.F02, T6011.F17, T6011.F21, T6012.F02, T6013.F12, T6013.F10, T6013.F08, T6013.F05, T6013.F13, T6013.F14, T6015.F03, T6015.F04, T6015.F06, T6015.F08, T6010.F01, T6011.F16, T6011.F07, he.F08 htje, jg.F02 dbmc, t6013.F03 gsmc FROM T6011, T6010, T6012, T6013, T6015, T6039, T6036 LEFT JOIN "+FrontConst.DB_CONSOLE+".t7031 he ON T6036.F25 = he.F01 LEFT JOIN "+FrontConst.DB_CONSOLE+".t7029 jg ON he.F02 = jg.F01 WHERE T6036.F02 = T6010.F01 AND T6039.F03 = T6036.F01 AND T6010.F01 = T6011.F01 AND T6010.F01 = T6012.F01 AND T6010.F01 = T6013.F01 AND T6010.F01 = T6015.F01 AND T6039.F01 = ? ";
		}

		parameters.add(id);
		return select(getConnection(FrontConst.DB_USER),
				new ItemParser<CreditUserInfo>() {
					@Override
					public CreditUserInfo parse(ResultSet resultSet)
							throws SQLException {
						CreditUserInfo credit = null;
						while (resultSet.next()) {
							if (credit == null) {
								credit = new CreditUserInfo();
							}
							credit.userName = resultSet.getString(1);
							credit.xueli = resultSet.getString(2);
							credit.university = resultSet.getString(3);
							credit.hunyin = EnumParser.parse(
									MarriageStatus.class,
									resultSet.getString(4));
							credit.companySize = resultSet.getString(5);
							credit.companyType = resultSet.getString(6);
							credit.city = resultSet.getString(7);
							credit.gwzz = resultSet.getString(8);
							credit.workAge = resultSet.getString(9);
							credit.earnMoey = resultSet.getString(10);
							credit.isHouse = EnumParser.parse(
									IsHovestatus.class, resultSet.getString(11));
							credit.isHouseCredit = EnumParser.parse(
									IsHovestatus.class, resultSet.getString(12));
							credit.isCar = EnumParser.parse(IsHovestatus.class,
									resultSet.getString(13));
							credit.isCarCredit = EnumParser.parse(
									IsHovestatus.class, resultSet.getString(14));
							credit.userId = resultSet.getInt(15);
							credit.sex = EnumParser.parse(Sex.class,
									resultSet.getString(16));
							credit.card = resultSet.getString(17);
							credit.htje = resultSet.getBigDecimal(18);
							credit.dbgs = resultSet.getString(19);
							credit.gsmc = resultSet.getString(20);
							
							
						}

						return credit;
					}
				}, sql, parameters);
	}

	@Override
	public TenderRecord[] getRecord(int id) throws Throwable {
		if (id < 0) {
			return null;
		}
		String sql = "SELECT T6037.F04, T6037.F05, T6010.F02 FROM T6037, T6010, T6039 WHERE T6039.F01 = ? AND T6037.F02 = T6039.F03 AND T6037.F03 = T6010.F01 ORDER BY T6037.F05 DESC";
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(id);
		return selectAll(getConnection(FrontConst.DB_USER),
				new ArrayParser<TenderRecord>() {
					@Override
					public TenderRecord[] parse(ResultSet resultSet)
							throws SQLException {
						ArrayList<TenderRecord> list = null;
						while (resultSet.next()) {
							TenderRecord credit = new TenderRecord();
							credit.tenderMoney = resultSet.getBigDecimal(1);
							credit.tenderTime = resultSet.getTimestamp(2);
							credit.tenderName = resultSet.getString(3);
							if (list == null) {
								list = new ArrayList<>();
							}
							list.add(credit);
						}
						return list == null ? null : list
								.toArray(new TenderRecord[list.size()]);
					}
				}, sql, parameters);
	}

	@Override
	public AlsoMoney[] getAlso(int id) throws Throwable {
		if (id < 0) {
			return null;
		}
		String sql = "SELECT T6041.F10, T6041.F12, T6041.F05, T6041.F07, T6041.F11, T6041.F06 FROM T6041, T6039 WHERE T6039.F01 = ? AND T6041.F02 = T6039.F03 ORDER BY T6041.F10 ASC";
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(id);
		return selectAll(getConnection(FrontConst.DB_USER),
				new ArrayParser<AlsoMoney>() {
					@Override
					public AlsoMoney[] parse(ResultSet resultSet)
							throws SQLException {
						ArrayList<AlsoMoney> list = null;
						while (resultSet.next()) {
							AlsoMoney credit = new AlsoMoney();
							credit.hyhkrq = resultSet.getTimestamp(1);
							credit.status = EnumParser.parse(RepayStatus.class,
									resultSet.getString(2));
							credit.yhbj = resultSet.getBigDecimal(3);
							credit.yffx = resultSet.getBigDecimal(4);
							credit.sjhkTime = resultSet.getTimestamp(5);
							credit.yhlx = resultSet.getBigDecimal(6);
							credit.yhbx = credit.yhbj.add(credit.yhlx);
							if (list == null) {
								list = new ArrayList<>();
							}
							list.add(credit);
						}
						return list == null ? null : list
								.toArray(new AlsoMoney[list.size()]);
					}
				}, sql, parameters);
	}

	@Override
	public CreditHoldInfo[] getHoldInfo(int id) throws Throwable {
		if (id < 0) {
			return null;
		}
		String sql = "SELECT T6010.F02, T6038.F04, T6039.F05 ,T6038.F08 FROM T6038, T6010, T6039 WHERE T6039.F01 = ? AND T6039.F03 = T6038.F02 AND T6038.F03 = T6010.F01 AND T6038.F04 > 0 ORDER BY T6038.F01 DESC";
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(id);
		return selectAll(getConnection(FrontConst.DB_USER),
				new ArrayParser<CreditHoldInfo>() {
					@Override
					public CreditHoldInfo[] parse(ResultSet resultSet)
							throws SQLException {
						ArrayList<CreditHoldInfo> list = null;
						while (resultSet.next()) {
							CreditHoldInfo credit = new CreditHoldInfo();
							credit.userName = resultSet.getString(1);
							credit.touzje = resultSet.getBigDecimal(2);
							credit.mfje = resultSet.getBigDecimal(3);
							credit.cyfs = resultSet.getInt(4);
							if (list == null) {
								list = new ArrayList<>();
							}
							list.add(credit);
						}
						return list == null ? null : list
								.toArray(new CreditHoldInfo[list.size()]);
					}
				}, sql, parameters);
	}

	@Override
	public CreditOutRecode[] getOutRecode(int id) throws Throwable {
		if (id < 0) {
			return null;
		}
		String sql = "SELECT ( SELECT T6010.F02 FROM T6010 WHERE T6010.F01 = T6039.F04 ), T6010.F02, T6040.F04, T6039.F06, T6040.F05 FROM T6040, T6039, T6010 WHERE T6039.F03 = (SELECT T6039.F03 FROM T6039 WHERE T6039.F01= ?) AND T6040.F02 = T6039.F01 AND T6040.F03 = T6010.F01 ORDER BY T6040.F05 DESC ";
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(id);
		return selectAll(getConnection(FrontConst.DB_USER),
				new ArrayParser<CreditOutRecode>() {
					@Override
					public CreditOutRecode[] parse(ResultSet resultSet)
							throws SQLException {
						ArrayList<CreditOutRecode> list = null;
						while (resultSet.next()) {
							CreditOutRecode credit = new CreditOutRecode();
							credit.creditSell = resultSet.getString(1);
							credit.creditBuy = resultSet.getString(2);
							credit.jyfs = resultSet.getInt(3);
							credit.jydj = resultSet.getBigDecimal(4);
							credit.sellTime = resultSet.getTimestamp(5);
							credit.sellMoney = new BigDecimal(credit.jyfs)
									.multiply(credit.jydj);
							if (list == null) {
								list = new ArrayList<>();
							}
							list.add(credit);
						}
						return list == null ? null : list
								.toArray(new CreditOutRecode[list.size()]);
					}
				}, sql, parameters);
	}

	@Override
	public UserRZInfo[] getRZInfo(int id) throws Throwable {
		if (id < 0) {
			return null;
		}
		final List<UserRZInfo> userRZInfoList = new ArrayList<>();
		String sql = "SELECT T6017.F02, T6017.F04, T6018.F06 " +
				" FROM T6039 INNER JOIN T6036 ON T6039.F03 = T6036.F01 INNER JOIN T6017 ON T6017.F01 = T6036.F02 LEFT JOIN T6018 ON T6017.F03 = T6018.F01 WHERE T6039.F01 = ? AND T6017.F04 = ? AND T6017.F02 <> ?";
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(id);
		parameters.add(AttestationStatus.YYZ);
		parameters.add(AttestationType.JBXXRZ.name());
		return selectAll(getConnection(FrontConst.DB_USER),
				new ArrayParser<UserRZInfo>() {
					@Override
					public UserRZInfo[] parse(ResultSet resultSet)
							throws SQLException {
						while (resultSet.next()) {
							UserRZInfo credit = new UserRZInfo();
							credit.attestationType = EnumParser.parse(
									AttestationType.class,
									resultSet.getString(1));
							credit.rzStatus = EnumParser.parse(
									AttestationState.class,
									resultSet.getString(2));
							credit.rzDate = resultSet.getTimestamp(3);
							userRZInfoList.add(credit);
						}
						return userRZInfoList == null ? null : userRZInfoList
								.toArray(new UserRZInfo[userRZInfoList.size()]);
					}
				}, sql, parameters);
	}

	@Override
	public BigDecimal getDjyMoney(int id) throws Throwable {
		if (id < 0) {
			return null;
		}
		BigDecimal djyMoney = new BigDecimal(0);
		try (Connection conn = getConnection(FrontConst.DB_USER)) {
			try (PreparedStatement ps = conn
					.prepareStatement("SELECT IFNULL(SUM(T6039.F08*T6039.F06),0) FROM T6039 WHERE F01 = ? AND F11 = ? AND F12 = ?");) {
				ps.setInt(1, id);
				ps.setString(2, TransferStatus.YX.name());
				ps.setString(3, OverdueStatus.S.name());
				try (ResultSet rs = ps.executeQuery();) {
					if (rs.next()) {
						djyMoney = rs.getBigDecimal(1);
					}
				}
			}
		}
		return djyMoney;
	} 

	@Override
	public BigDecimal getyjyMoney(int id) throws Throwable {
		if (id < 0) {
			return null;
		}
		BigDecimal yjyMoney = new BigDecimal(0);
		try (Connection conn = getConnection(FrontConst.DB_USER)) {
			try (PreparedStatement ps = conn
					.prepareStatement("SELECT IFNULL(SUM(T6040.F04*T6039.F06),0) FROM T6039, T6040 WHERE T6039.F01 = ? AND T6039.F01 = T6040.F02");) {
				ps.setInt(1, id);
				try (ResultSet rs = ps.executeQuery();) {
					if (rs.next()) {
						yjyMoney = rs.getBigDecimal(1);
					}
				}
			}
		}
		return yjyMoney;
	}

	@Override
	public Xgzl[] getXgzl(int idd) throws Throwable {
		if (idd < 0) {
			return null;
		}
		int id = selectInt(FrontConst.DB_USER,
				"SELECT F03 FROM T6039 WHERE F01=?", idd);
		if (id < 0) {
			return null;
		}
		final List<Xgzl> list = new ArrayList<>();
		String sql = "SELECT F03,F04 FROM T6036_2 WHERE F02 = ? ORDER BY F05 ASC ";
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(id);
		ArrayList<Xgzl> rs = new ArrayList<>();
		Xgzl[] xgzls = selectAll(getConnection(FrontConst.DB_USER),
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
						return list == null ? null : list.toArray(new Xgzl[list
								.size()]);
					}
				}, sql, parameters);
		for (Xgzl l : xgzls) {
			rs.add(l);
		}
		int contid = selectInt(FrontConst.DB_USER,
				"SELECT F25 FROM T6036 WHERE F01=?", id);
		if (contid > 0) {
			String _s = "SELECT F03,F04 FROM T7031_1 WHERE F02 = ? ORDER BY F05 ASC";
			Xgzl[] htxgzls = selectAll(getConnection(FrontConst.DB_CONSOLE),
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
							return list == null ? null : list
									.toArray(new Xgzl[list.size()]);
						}
					}, _s, contid);
			for (Xgzl l : htxgzls) {
				rs.add(l);
			}
		}

		return rs == null ? null : rs.toArray(new Xgzl[rs.size()]);
	}

	@Override
	public String getFkxx(int id) throws Throwable {
		return select(getConnection(FrontConst.DB_USER), new ItemParser<String>() {
			@Override
			public String parse(ResultSet res) throws SQLException {
				if(res.next()){
					return res.getString(1);
				}
				return "";
			}
		}, "SELECT T6036_3.F02 FROM T6039 LEFT JOIN T6036_3 ON T6036_3.F01 = T6039.f03 WHERE  T6039.F01 = ?  ",id);
	}

}
