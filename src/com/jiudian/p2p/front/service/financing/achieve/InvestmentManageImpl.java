package com.jiudian.p2p.front.service.financing.achieve;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.Set;

import com.jiudian.framework.config.ConfigureProvider;
import com.jiudian.framework.service.ServiceFactory;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.framework.service.query.ArrayParser;
import com.jiudian.framework.service.query.ItemParser;
import com.jiudian.framework.service.query.Paging;
import com.jiudian.framework.service.query.PagingResult;
import com.jiudian.p2p.S60.enums.T6056_F10;
import com.jiudian.p2p.common.enums.CompanyStatus;
import com.jiudian.p2p.common.enums.CreditCycle;
import com.jiudian.p2p.common.enums.CreditLevel;
import com.jiudian.p2p.common.enums.CreditStatus;
import com.jiudian.p2p.common.enums.CreditTerm;
import com.jiudian.p2p.common.enums.CreditType;
import com.jiudian.p2p.common.enums.InvestType;
import com.jiudian.p2p.common.enums.IsPass;
import com.jiudian.p2p.common.enums.Jkflx;
import com.jiudian.p2p.common.enums.OverdueStatus;
import com.jiudian.p2p.common.enums.ProductType;
import com.jiudian.p2p.common.enums.RepaymentPeriod;
import com.jiudian.p2p.common.enums.RepaymentType;
import com.jiudian.p2p.common.enums.RewardType;
import com.jiudian.p2p.front.config.FrontConst;
import com.jiudian.p2p.front.service.financing.InvestManage;
import com.jiudian.p2p.front.service.financing.entity.CreditInfo;
import com.jiudian.p2p.front.service.financing.entity.InvestStatistics;
import com.jiudian.p2p.front.service.financing.entity.Rewards;
import com.jiudian.p2p.front.service.financing.entity.TenderRecord;
import com.jiudian.p2p.front.service.financing.entity.Xyhk;
import com.jiudian.p2p.front.service.financing.query.InvestQuery;
import com.jiudian.p2p.variables.defines.SystemVariable;
import com.jiudian.util.parser.EnumParser;

public class InvestmentManageImpl extends AbstractFinancingManage implements
		InvestManage {

	public InvestmentManageImpl(ServiceResource serviceResource) {
		super(serviceResource);
	}

	public static class InvestmentManageFactory implements
			ServiceFactory<InvestManage> {
		@Override
		public InvestManage newInstance(ServiceResource serviceResource) {
			return new InvestmentManageImpl(serviceResource);
		}

	}

	protected static final String SELECT_ALL_SQL = "SELECT T6036.F01, T6036.F02, T6036.F04, T6036.F05, T6036.F06, T6036.F07, T6036.F08, T6036.F09, T6036.F10, T6036.F11, T6036.F13, T6036.F17, T6036.F19, T6036.F20, "
			+ "T6036.F23, T6036.F24, T6036.F32, T6036.F37, T6010.F02 AS F39, T6036.F40 AS F40, T6023.F05 AS kyMoney ,T6036.F28 AS shTime, T6036.F29 AS mbTime,ADDDATE(T6036.F28,INTERVAL T6036.F12 DAY) AS jsTime,T6036.F35,"
			+ "T6036.F10 AS T6036_F10,T6036.F42,T6036_1.F02 AS GSNAME,T6036.F43 JLZ,T6036.F41 fbsj,T6036.F45 pt,T7031.F14 jklx FROM T6036 INNER JOIN T6010 ON T6036.F02 = T6010.F01 INNER JOIN T6023 ON T6036.F02 = T6023.F01 "
			+ "LEFT JOIN T6036_1 ON T6036.F01=T6036_1.F01 LEFT JOIN "+FrontConst.DB_CONSOLE+".T7031 T7031 ON T6036.F25=T7031.F01 ";

	@Override
	public PagingResult<CreditInfo> search(InvestQuery query, Paging paging)
			throws Throwable {
		ArrayList<Object> parameters = new ArrayList<Object>();
		StringBuilder sql = new StringBuilder(SELECT_ALL_SQL);
		sql.append(" WHERE (T6036.F20 = ? OR T6036.F20 = ? OR T6036.F20 = ? OR T6036.F20 = ?) AND F18 = ?");
		parameters.add(CreditStatus.TBZ);
		parameters.add(CreditStatus.YMB);
		parameters.add(CreditStatus.YFK);
		parameters.add(CreditStatus.YJQ);
		parameters.add(OverdueStatus.S);
		if (query != null) {
			boolean notFirst = false;
			InvestType[] investTypes = query.getType();
			if (investTypes != null && investTypes.length > 0) {
				Set<CreditType> types = new LinkedHashSet<>();
				for (InvestType investType : investTypes) {
					if (investType == null) {
						continue;
					}
					switch (investType) {
					case XYRZB: {
						types.add(CreditType.SYD);
						types.add(CreditType.XJD);
						break;
					}
					case JGDBB: {
						types.add(CreditType.XYDB);
						break;
					}
					case SDRZB: {
						types.add(CreditType.SDRZ);
						break;
					}
//					case GYLB: {
//						types.add(CreditType.GYLB);
//						break;
//					}
					default:
						break;
					}
				}
				if (types.size() > 0) {
					notFirst = false;
					sql.append(" AND (");
					for (CreditType type : types) {
						if (notFirst) {
							sql.append(" OR ");
						} else {
							notFirst = true;
						}
						sql.append("T6036.F19 = ?");
						parameters.add(type);
					}
					sql.append(")");

				}
			}

			RepaymentType[] levels = query.getRepay();
			if (levels != null && levels.length > 0) {
				Set<RepaymentType> valieLevels = new LinkedHashSet<>();
				for (RepaymentType level : levels) {
					if (level == null) {
						continue;
					}
					switch (level) {
//					case DQYCXFQ: {
//						valieLevels.add(RepaymentType.DQYCXFQ);
//						break;
//					}
					case MYHKDQHB2: {
						valieLevels.add(RepaymentType.MYHKDQHB2);
						break;
					}
					case XYHK: {
						valieLevels.add(RepaymentType.XYHK);
						break;
					}
					default:
						break;
					}
				}
				if (valieLevels.size() > 0) {
					notFirst = false;
					sql.append(" AND (");
					for (RepaymentType valieLevel : valieLevels) {
						if (notFirst) {
							sql.append(" OR ");
						} else {
							notFirst = true;
						}
						sql.append("T6036.F11 = ?");
						parameters.add(valieLevel);
					}
					sql.append(")");
				}
			}
			CreditTerm[] terms = query.getTerm();
			if (terms != null && terms.length > 0) {
				Set<CreditTerm> validTerms = new LinkedHashSet<>();
				for (CreditTerm term : terms) {
					if (term == null) {
						continue;
					}
					validTerms.add(term);
				}
				if (validTerms.size() > 0) {
					notFirst = false;
					sql.append(" AND (");
					for (CreditTerm term : validTerms) {
						if (notFirst) {
							sql.append(" OR ");
						} else {
							notFirst = true;
						}
						switch (term) {
						case XYYGY: {
							sql.append("(T6036.F10 = ? OR T6036.F10 =? )");
							parameters.add(CreditCycle.TB);
							parameters.add(CreditCycle.MB);
							break;
						}
						case SDLGY: {
							sql.append("(T6036.F08 >= 1 AND T6036.F08 <= 6 AND T6036.F10 =? )");
							parameters.add(CreditCycle.AYHK);
							break;
						}
						case JDSEGY: {
							sql.append("(T6036.F08 >= 9 AND T6036.F08 <= 12 AND T6036.F10 =? )");
							parameters.add(CreditCycle.AYHK);
							break;
						}
						case SBDESSGY: {
							sql.append("(T6036.F08 >= 18 AND T6036.F08 <= 24 AND T6036.F10 =? )");
							parameters.add(CreditCycle.AYHK);
							break;
						}
						case ESSGYYS: {
							sql.append("T6036.F08 > 24  AND T6036.F10 =? ");
							parameters.add(CreditCycle.AYHK);
							break;
						}
						default:
							break;
						}
					}
					sql.append(")");

				}
			}
			ProductType pt = query.getProductType();
			if(pt != null){
				sql.append(" AND T6036.F45=?");
				parameters.add(pt.name());
			}
		}
		sql.append("  ORDER BY F20 DESC , F28 DESC");
		return selectPaging(getConnection(FrontConst.DB_USER),
				new ArrayParser<CreditInfo>() {
					public CreditInfo[] parse(ResultSet resultSet)
							throws SQLException {
						ArrayList<CreditInfo> list = null;
						while (resultSet.next()) {
							CreditInfo info = new CreditInfo();
							info.id = resultSet.getInt(1);
							info.userId = resultSet.getInt(2);
							info.title = resultSet.getString(3);
							info.purpose = resultSet.getString(4);
							info.amount = resultSet.getBigDecimal(5);
							info.remainAmount = resultSet.getBigDecimal(6);
							info.term = resultSet.getInt(7);
							info.rate = resultSet.getDouble(8);
							info.repaymentPeriod = EnumParser.parse(
									RepaymentPeriod.class,
									resultSet.getString(9));
							info.repaymentType = EnumParser.parse(
									RepaymentType.class,
									resultSet.getString(10));
							info.yhkAmount = resultSet.getBigDecimal(11);
							info.goalDesc = resultSet.getString(12);
							info.creditType = EnumParser.parse(
									CreditType.class, resultSet.getString(13));
							info.status = EnumParser.parse(CreditStatus.class,
									resultSet.getString(14));
							info.nextRepayDate = resultSet.getDate(15);
							info.remainTerms = resultSet.getInt(16);
							info.payedDate = resultSet.getTimestamp(17);
							info.perAmount = resultSet.getBigDecimal(18);
							info.userAccountName = resultSet.getString(19);
							info.creditLevel = EnumParser.parse(
									CreditLevel.class, resultSet.getString(20));
							info.kyMoney = resultSet.getBigDecimal(21);
							info.shTime = resultSet.getTimestamp(22);
							info.mbTime = resultSet.getTimestamp(23);
							info.jsTime = resultSet.getTimestamp(24);
							info.dfTime = resultSet.getTimestamp(25);
							info.creditCycle = EnumParser.parse(
									CreditCycle.class, resultSet.getString(26));
							info.tbxe = resultSet.getBigDecimal(27);

							info.progress = (int) (100 * (info.amount
									.doubleValue() - info.remainAmount
									.doubleValue()) / info.amount.doubleValue());

							if (info.progress == 0
									&& (info.amount.doubleValue() - info.remainAmount
											.doubleValue()) > 0) {
								info.progress = 1;
							}
							if (list == null) {
								list = new ArrayList<CreditInfo>();
							}
							info.companyStatus = EnumParser.parse(CompanyStatus.class, resultSet.getString(28));
							info.jlz = resultSet.getString(29);
							info.fbTime = resultSet.getTimestamp(30);
							list.add(info);
						}
						return list == null || list.size() == 0 ? null : list
								.toArray(new CreditInfo[list.size()]);
					}
				}, paging, sql.toString(), parameters);
	}

	@Override
	public InvestStatistics getStatistics() throws Throwable {
		InvestStatistics statistics = new InvestStatistics();
		String sql = "SELECT IFNULL(SUM(F06),0),COUNT(*) FROM T6036 WHERE F20 IN (?,?,?)";
		try (Connection conn = getConnection(FrontConst.DB_USER)) {
			try (PreparedStatement ps = conn.prepareStatement(sql);) {
				ps.setString(1, CreditStatus.YFK.name());
				ps.setString(2, CreditStatus.YJQ.name());
				ps.setString(3, CreditStatus.YDF.name());
				try (ResultSet rs = ps.executeQuery();) {
					if (rs.next()) {
						statistics.totleMoney = rs.getBigDecimal(1);
						statistics.totleCount = rs.getLong(2);
					}
				}
			}
		}

		statistics.userEarnMoney = getEarnMoney();
		return statistics;
	}

	private BigDecimal getEarnMoney() throws Throwable {
		BigDecimal wyj = new BigDecimal(0);
		try (Connection connection = getConnection(FrontConst.DB_USER)) {
			try (PreparedStatement ps = connection
					.prepareStatement("SELECT SUM(F09) FROM T6038")) {
				try (ResultSet rs = ps.executeQuery()) {
					if (rs.next()) {
						wyj = rs.getBigDecimal(1);
					}
				}
			}
		}
		BigDecimal yslx = new BigDecimal(0);
		try (Connection connection = getConnection(FrontConst.DB_USER)) {
			try (PreparedStatement ps = connection
					.prepareStatement("SELECT SUM(F06+F07) FROM T6056 WHERE F10=? AND F14=?")) {
				ps.setString(1, T6056_F10.YS.name());
				ps.setString(2, "F");
				try (ResultSet rs = ps.executeQuery()) {
					if (rs.next()) {
						yslx = rs.getBigDecimal(1);
					}
				}
			}
		}
		return wyj.add(yslx);
	}

	@Override
	public CreditInfo get(int id) throws Throwable {
		if (id <= 0) {
			return null;
		}
		ArrayList<Object> parameters = new ArrayList<Object>();
		StringBuffer sql = new StringBuffer(SELECT_ALL_SQL);
		sql.append(" WHERE T6036.F01 = ?");
		sql.append(" AND T6036.F20 <> ? AND T6036.F20 <>  ?");
		parameters.add(id);
		parameters.add(CreditStatus.SQZ);
		parameters.add(CreditStatus.DSH);
		
		CreditInfo ci = select(getConnection(FrontConst.DB_USER),
				new ItemParser<CreditInfo>() {

					@Override
					public CreditInfo parse(ResultSet resultSet)
							throws SQLException {
						CreditInfo info = null;
						if (resultSet.next()) {
							info = new CreditInfo();
							info.id = resultSet.getInt(1);
							info.userId = resultSet.getInt(2);
							info.title = resultSet.getString(3);
							info.purpose = resultSet.getString(4);
							info.amount = resultSet.getBigDecimal(5);
							info.remainAmount = resultSet.getBigDecimal(6);
							info.term = resultSet.getInt(7);
							info.rate = resultSet.getDouble(8);
							info.repaymentPeriod = EnumParser.parse(
									RepaymentPeriod.class,
									resultSet.getString(9));
							info.repaymentType = EnumParser.parse(
									RepaymentType.class,
									resultSet.getString(10));
							info.yhkAmount = resultSet.getBigDecimal(11);
							info.goalDesc = resultSet.getString(12);
							info.creditType = EnumParser.parse(
									CreditType.class, resultSet.getString(13));
							info.status = EnumParser.parse(CreditStatus.class,
									resultSet.getString(14));
							info.nextRepayDate = resultSet.getDate(15);
							info.remainTerms = resultSet.getInt(16);
							info.payedDate = resultSet.getTimestamp(17);
							info.perAmount = resultSet.getBigDecimal(18);
							info.userAccountName = resultSet.getString(19);
							info.kyMoney = resultSet.getBigDecimal(21);
							info.shTime = resultSet.getTimestamp(22);
							info.mbTime = resultSet.getTimestamp(23);
							info.jsTime = resultSet.getTimestamp(24);
							info.dfTime = resultSet.getTimestamp(25);
							info.progress = (int) (100 * (info.amount
									.doubleValue() - info.remainAmount
									.doubleValue()) / info.amount.doubleValue());
							if (info.progress == 0
									&& (info.amount.doubleValue() - info.remainAmount
											.doubleValue()) > 0) {
								info.progress = 1;
							}
							info.creditLevel = EnumParser.parse(
									CreditLevel.class, resultSet.getString(20));
							info.creditCycle = EnumParser.parse(
									CreditCycle.class, resultSet.getString(26));
							info.tbxe = resultSet.getBigDecimal(27);
							info.companyStatus = EnumParser.parse(CompanyStatus.class, resultSet.getString(28));
							info.fbTime = resultSet.getTimestamp(30);
							info.productType = EnumParser.parse(ProductType.class, resultSet.getString(31));
							info.jkflx = EnumParser.parse(Jkflx.class, resultSet.getString(32));
							ArrayList<Xyhk> hklist = null;
							if(RepaymentType.XYHK.name().equals(info.repaymentType.name())){
								hklist = new ArrayList<Xyhk>();
								try (Connection conn = getConnection(FrontConst.DB_USER)) {
									try (PreparedStatement ps = conn.prepareStatement("SELECT F03,F04,F05 FROM t6036_6 WHERE F02 = ?");) {
										ps.setInt(1, info.id);
										try (ResultSet rs = ps.executeQuery();) {
											while (rs.next()) {
												Xyhk hk = new Xyhk();
												hk.hksj = rs.getTimestamp(1);
												hk.bj = rs.getBigDecimal(2);
												hk.lx = rs.getBigDecimal(3);
												hklist.add(hk);
											}
										}
									}
								}
							}
							info.hkList = hklist;
						}
						return info;
					}
				}, sql.toString(), parameters);

		String s = "SELECT IFNULL(SUM(F05+F06),0) FROM T6041 WHERE F12='WH' AND F02 = ?";
		try (Connection conn = getConnection(FrontConst.DB_USER)) {
			try (PreparedStatement ps = conn.prepareStatement(s);) {
				ps.setInt(1, id);
				try (ResultSet rs = ps.executeQuery();) {
					if (rs.next()) {
						ci.toRepaymentAmount = rs.getBigDecimal(1);
					}
				}
			}
		}
		
		String _s = "SELECT F02,F03,F04,F05 FROM T6036_4 WHERE F01= ?";
		try (Connection conn = getConnection(FrontConst.DB_USER)) {
			try (PreparedStatement ps = conn.prepareStatement(_s);) {
				ps.setInt(1, id);
				try (ResultSet rs = ps.executeQuery();) {
					if (rs.next()) {
						ci.jllx = EnumParser.parse(RewardType.class, rs.getString(1));
						ci.jlll = rs.getBigDecimal(2);
						ci.xsxs = rs.getInt(3);
						ci.xsfz = rs.getInt(4);
					}
				}
			}
		}
		return ci;
	}

	@Override
	public String getJgName(int jkbId) throws Throwable {
		String sql = "SELECT T7029.F02 FROM T6036 INNER JOIN S70.T7031 ON T6036.F25 = T7031.F01 INNER JOIN S70.T7029 ON T7031.F02 = T7029.F01 WHERE T6036.F01 = ?";
		try (Connection conn = getConnection(FrontConst.DB_USER)) {
			try (PreparedStatement ps = conn.prepareStatement(sql);) {
				ps.setInt(1, jkbId);
				try (ResultSet rs = ps.executeQuery();) {
					if (rs.next()) {
						return rs.getString(1);
					}
				}
			}
		}
		return null;
	}

	@Override
	public BigDecimal getTbcont(int id) throws Throwable {
		if(!serviceResource.getSession().isAuthenticated()){
			return new BigDecimal("0");
		}
		int acount = serviceResource.getSession().getAccountId();
		if (id <= 0 || acount <= 0) {
			return new BigDecimal("0");
		}
		final ConfigureProvider configureProvider = serviceResource
				.getResource(ConfigureProvider.class);
		String sql = "SELECT SUM(F04) FROM T6037 WHERE F03=? AND F02=?";
		try (Connection conn = getConnection(FrontConst.DB_USER)) {
			try (PreparedStatement ps = conn.prepareStatement(sql);) {
				ps.setInt(1, acount);
				ps.setInt(2, id);
				try (ResultSet rs = ps.executeQuery();) {
					if (rs.next()) {
						BigDecimal gmje = rs.getBigDecimal(1);
						BigDecimal count = gmje
								.divide(new BigDecimal(
										configureProvider
												.getProperty(SystemVariable.AUTO_BIDING_MULT_AMOUNT)),
										0, BigDecimal.ROUND_DOWN);
						return count;
					}
				}
			}
		}

		return new BigDecimal("0");
	}

	@Override
	public Rewards getRewards(int id) throws Throwable {
		return select(getConnection(FrontConst.DB_USER), new ItemParser<Rewards>() {
			@Override
			public Rewards parse(ResultSet res)
					throws SQLException {
				if(res.next()){
					Rewards c = new Rewards();
					c.jllx = EnumParser.parse(RewardType.class, res.getString(1));
					c.jlbl = res.getBigDecimal(2);
					c.xs = res.getInt(3);
					c.fz = res.getInt(4);
					c.xyrs = res.getInt(5);
					return c;
				}else{
					return null;
				}
			}
		}, "SELECT F02,F03,F04,F05,F06 FROM T6036_4 WHERE F01=?", id);
	}

	@Override
	public TenderRecord[] getJllb(int id) throws Throwable {
		String _s = "SELECT T6010.F02,T6036_5.F04 FROM T6036_5 LEFT JOIN T6010 ON T6036_5.F03=T6010.F01 WHERE T6036_5.F02=? ORDER BY T6036_5.F01";
		return selectAll(getConnection(FrontConst.DB_USER), new ArrayParser<TenderRecord>() {
			@Override
			public TenderRecord[] parse(ResultSet res)
					throws SQLException {
				ArrayList<TenderRecord> list = new ArrayList<TenderRecord>();
				while(res.next()){
					TenderRecord c = new TenderRecord();
					c.tenderName = res.getString(1);
					c.tenderMoney = res.getBigDecimal(2);
					
					list.add(c);
				}
				return list == null || list.size() == 0 ? null : list
						.toArray(new TenderRecord[list.size()]);
			}
		}, _s, id);
	}

	@Override
	public PagingResult<CreditInfo> getNowProjects(Paging paging)
			throws Throwable {
		ArrayList<Object> parameters = new ArrayList<Object>();
		StringBuilder sql = new StringBuilder(SELECT_ALL_SQL);
		sql.append(" WHERE T6036.F20 = ? AND F18 = ?");
		parameters.add(CreditStatus.TBZ);
		parameters.add(OverdueStatus.S);
		sql.append("  ORDER BY F20 DESC , F28 DESC");
		return selectPaging(getConnection(FrontConst.DB_USER),
				new ArrayParser<CreditInfo>() {
					public CreditInfo[] parse(ResultSet resultSet)
							throws SQLException {
						ArrayList<CreditInfo> list = null;
						while (resultSet.next()) {
							CreditInfo info = new CreditInfo();
							info.id = resultSet.getInt(1);
							info.userId = resultSet.getInt(2);
							info.title = resultSet.getString(3);
							info.purpose = resultSet.getString(4);
							info.amount = resultSet.getBigDecimal(5);
							info.remainAmount = resultSet.getBigDecimal(6);
							info.term = resultSet.getInt(7);
							info.rate = resultSet.getDouble(8);
							info.repaymentPeriod = EnumParser.parse(
									RepaymentPeriod.class,
									resultSet.getString(9));
							info.repaymentType = EnumParser.parse(
									RepaymentType.class,
									resultSet.getString(10));
							info.yhkAmount = resultSet.getBigDecimal(11);
							info.goalDesc = resultSet.getString(12);
							info.creditType = EnumParser.parse(
									CreditType.class, resultSet.getString(13));
							info.status = EnumParser.parse(CreditStatus.class,
									resultSet.getString(14));
							info.nextRepayDate = resultSet.getDate(15);
							info.remainTerms = resultSet.getInt(16);
							info.payedDate = resultSet.getTimestamp(17);
							info.perAmount = resultSet.getBigDecimal(18);
							info.userAccountName = resultSet.getString(19);
							info.creditLevel = EnumParser.parse(
									CreditLevel.class, resultSet.getString(20));
							info.kyMoney = resultSet.getBigDecimal(21);
							info.shTime = resultSet.getTimestamp(22);
							info.mbTime = resultSet.getTimestamp(23);
							info.jsTime = resultSet.getTimestamp(24);
							info.dfTime = resultSet.getTimestamp(25);
							info.creditCycle = EnumParser.parse(
									CreditCycle.class, resultSet.getString(26));
							info.tbxe = resultSet.getBigDecimal(27);

							info.progress = (int) (100 * (info.amount
									.doubleValue() - info.remainAmount
									.doubleValue()) / info.amount.doubleValue());

							if (info.progress == 0
									&& (info.amount.doubleValue() - info.remainAmount
											.doubleValue()) > 0) {
								info.progress = 1;
							}
							if (list == null) {
								list = new ArrayList<CreditInfo>();
							}
							info.companyStatus = EnumParser.parse(CompanyStatus.class, resultSet.getString(28));
							info.jlz = resultSet.getString(29);
							info.fbTime = resultSet.getTimestamp(30);
							list.add(info);
						}
						return list == null || list.size() == 0 ? null : list
								.toArray(new CreditInfo[list.size()]);
					}
				}, paging, sql.toString(), parameters);
	}

	@Override
	public PagingResult<CreditInfo> getProjectByDate(String date, Paging paging)
			throws Throwable {
		ArrayList<Object> parameters = new ArrayList<Object>();
		StringBuilder sql = new StringBuilder(SELECT_ALL_SQL);
		sql.append(" WHERE (T6036.F20 = ? OR T6036.F20 = ? OR T6036.F20 = ? ) AND F18 = ?");
		parameters.add(CreditStatus.YMB);
		parameters.add(CreditStatus.YFK);
		parameters.add(CreditStatus.YJQ);
		parameters.add(OverdueStatus.S);
		
		if(date!=null){
			sql.append(" AND DATE(T6036.F29)=DATE(?)");
			parameters.add(date);
		}else{
			sql.append(" AND DATE(T6036.F29)=CURRENT_DATE()");
		}
		
		sql.append("  ORDER BY F20 DESC , F28 DESC");
		return selectPaging(getConnection(FrontConst.DB_USER),
				new ArrayParser<CreditInfo>() {
					public CreditInfo[] parse(ResultSet resultSet)
							throws SQLException {
						ArrayList<CreditInfo> list = null;
						while (resultSet.next()) {
							CreditInfo info = new CreditInfo();
							info.id = resultSet.getInt(1);
							info.userId = resultSet.getInt(2);
							info.title = resultSet.getString(3);
							info.purpose = resultSet.getString(4);
							info.amount = resultSet.getBigDecimal(5);
							info.remainAmount = resultSet.getBigDecimal(6);
							info.term = resultSet.getInt(7);
							info.rate = resultSet.getDouble(8);
							info.repaymentPeriod = EnumParser.parse(
									RepaymentPeriod.class,
									resultSet.getString(9));
							info.repaymentType = EnumParser.parse(
									RepaymentType.class,
									resultSet.getString(10));
							info.yhkAmount = resultSet.getBigDecimal(11);
							info.goalDesc = resultSet.getString(12);
							info.creditType = EnumParser.parse(
									CreditType.class, resultSet.getString(13));
							info.status = EnumParser.parse(CreditStatus.class,
									resultSet.getString(14));
							info.nextRepayDate = resultSet.getDate(15);
							info.remainTerms = resultSet.getInt(16);
							info.payedDate = resultSet.getTimestamp(17);
							info.perAmount = resultSet.getBigDecimal(18);
							info.userAccountName = resultSet.getString(19);
							info.creditLevel = EnumParser.parse(
									CreditLevel.class, resultSet.getString(20));
							info.kyMoney = resultSet.getBigDecimal(21);
							info.shTime = resultSet.getTimestamp(22);
							info.mbTime = resultSet.getTimestamp(23);
							info.jsTime = resultSet.getTimestamp(24);
							info.dfTime = resultSet.getTimestamp(25);
							info.creditCycle = EnumParser.parse(
									CreditCycle.class, resultSet.getString(26));
							info.tbxe = resultSet.getBigDecimal(27);

							info.progress = (int) (100 * (info.amount
									.doubleValue() - info.remainAmount
									.doubleValue()) / info.amount.doubleValue());

							if (info.progress == 0
									&& (info.amount.doubleValue() - info.remainAmount
											.doubleValue()) > 0) {
								info.progress = 1;
							}
							if (list == null) {
								list = new ArrayList<CreditInfo>();
							}
							info.companyStatus = EnumParser.parse(CompanyStatus.class, resultSet.getString(28));
							info.jlz = resultSet.getString(29);
							info.fbTime = resultSet.getTimestamp(30);
							list.add(info);
						}
						return list == null || list.size() == 0 ? null : list
								.toArray(new CreditInfo[list.size()]);
					}
				}, paging, sql.toString(), parameters);
	}

	@Override
	public CreditInfo[] search(int line) throws Throwable {
		/*public CreditInfo[] search(int line,ProductType pt) throws Throwable {*/
		if(line == 0){
			line = 5;
		}
		ArrayList<Object> parameters = new ArrayList<Object>();
		StringBuilder sql = new StringBuilder(SELECT_ALL_SQL);
		/*sql.append(" WHERE (T6036.F20 = ? OR T6036.F20 = ? OR T6036.F20 = ? ) AND F18 = ? AND T6036.F45=? ");*/
		sql.append(" WHERE (T6036.F20 = ? OR T6036.F20 = ? OR T6036.F20 = ? OR T6036.F20=?) AND F18 = ? ");
		parameters.add(CreditStatus.TBZ);
		parameters.add(CreditStatus.YMB);
		parameters.add(CreditStatus.YFK);
		parameters.add(CreditStatus.YJQ);
		parameters.add(OverdueStatus.S);
		//parameters.add(pt.name());
		sql.append("  ORDER BY F20 DESC , F28 DESC LIMIT ? ");
		parameters.add(line);
		return selectAll(getConnection(FrontConst.DB_USER),
				new ArrayParser<CreditInfo>() {
					public CreditInfo[] parse(ResultSet resultSet)
							throws SQLException {
						ArrayList<CreditInfo> list = new ArrayList<CreditInfo>();
						while (resultSet.next()) {
							CreditInfo info = new CreditInfo();
							info.id = resultSet.getInt(1);
							info.userId = resultSet.getInt(2);
							info.title = resultSet.getString(3);
							info.purpose = resultSet.getString(4);
							info.amount = resultSet.getBigDecimal(5);
							info.remainAmount = resultSet.getBigDecimal(6);
							info.term = resultSet.getInt(7);
							info.rate = resultSet.getDouble(8);
							info.repaymentPeriod = EnumParser.parse(
									RepaymentPeriod.class,
									resultSet.getString(9));
							info.repaymentType = EnumParser.parse(
									RepaymentType.class,
									resultSet.getString(10));
							info.yhkAmount = resultSet.getBigDecimal(11);
							info.goalDesc = resultSet.getString(12);
							info.creditType = EnumParser.parse(
									CreditType.class, resultSet.getString(13));
							info.status = EnumParser.parse(CreditStatus.class,
									resultSet.getString(14));
							info.nextRepayDate = resultSet.getDate(15);
							info.remainTerms = resultSet.getInt(16);
							info.payedDate = resultSet.getTimestamp(17);
							info.perAmount = resultSet.getBigDecimal(18);
							info.userAccountName = resultSet.getString(19);
							info.creditLevel = EnumParser.parse(
									CreditLevel.class, resultSet.getString(20));
							info.kyMoney = resultSet.getBigDecimal(21);
							info.shTime = resultSet.getTimestamp(22);
							info.mbTime = resultSet.getTimestamp(23);
							info.jsTime = resultSet.getTimestamp(24);
							info.dfTime = resultSet.getTimestamp(25);
							info.creditCycle = EnumParser.parse(
									CreditCycle.class, resultSet.getString(26));
							info.tbxe = resultSet.getBigDecimal(27);

							info.progress = (int) (100 * (info.amount
									.doubleValue() - info.remainAmount
									.doubleValue()) / info.amount.doubleValue());

							if (info.progress == 0
									&& (info.amount.doubleValue() - info.remainAmount
											.doubleValue()) > 0) {
								info.progress = 1;
							}
							info.companyStatus = EnumParser.parse(CompanyStatus.class, resultSet.getString(28));
							info.jlz = resultSet.getString(29);
							info.fbTime = resultSet.getTimestamp(30);
							list.add(info);
						}
						return list.toArray(new CreditInfo[list.size()]);
					}
				}, sql.toString(), parameters);
	}

	@Override
	public int searchcount() throws Throwable {
		ArrayList<Object> parameters = new ArrayList<Object>();
		StringBuilder sql = new StringBuilder("select count(*) from t6036 ");
		sql.append(" WHERE (T6036.F20 = ? OR T6036.F20 = ? OR T6036.F20 = ?  OR T6036.F20=?) AND F18 = ?");
		parameters.add(CreditStatus.TBZ);
		parameters.add(CreditStatus.YMB);
		parameters.add(CreditStatus.YFK);
		parameters.add(CreditStatus.YJQ);
		parameters.add(OverdueStatus.S);
		sql.append("  ORDER BY F20 DESC , F28 DESC ");
		
		return select(getConnection(FrontConst.DB_USER), new ItemParser<Integer>() {
			@Override
			public Integer parse(ResultSet res) throws SQLException {
				int i = 0;
				if(res.next()){
					i = res.getInt(1);
				}
				return i;
			}
		}, sql.toString(), parameters);
	}

	@Override
	public IsPass sfktJzh() throws Throwable {
		int userid = serviceResource.getSession().getAccountId();
		String is = selectString(FrontConst.DB_USER, "SELECT F13 FROM T6010 WHERE F01=?", userid);
		return EnumParser.parse(IsPass.class, is);
	}
}
