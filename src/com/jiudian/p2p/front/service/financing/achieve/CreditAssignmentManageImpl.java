package com.jiudian.p2p.front.service.financing.achieve;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.Set;

import com.jiudian.framework.service.ServiceFactory;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.framework.service.query.ArrayParser;
import com.jiudian.framework.service.query.ItemParser;
import com.jiudian.framework.service.query.Paging;
import com.jiudian.framework.service.query.PagingResult;
import com.jiudian.p2p.common.enums.CompanyStatus;
import com.jiudian.p2p.common.enums.CreditCycle;
import com.jiudian.p2p.common.enums.CreditLevel;
import com.jiudian.p2p.common.enums.CreditStatus;
import com.jiudian.p2p.common.enums.CreditTerm;
import com.jiudian.p2p.common.enums.CreditType;
import com.jiudian.p2p.common.enums.InvestType;
import com.jiudian.p2p.common.enums.IsPass;
import com.jiudian.p2p.common.enums.OverdueStatus;
import com.jiudian.p2p.common.enums.RepaymentType;
import com.jiudian.p2p.common.enums.RewardType;
import com.jiudian.p2p.common.enums.TenderRepayment;
import com.jiudian.p2p.common.enums.TransferStatus;
import com.jiudian.p2p.front.config.FrontConst;
import com.jiudian.p2p.front.service.financing.CreditAssignmentManage;
import com.jiudian.p2p.front.service.financing.entity.CreditAssignment;
import com.jiudian.p2p.front.service.financing.entity.CreditAssignmentCount;
import com.jiudian.p2p.front.service.financing.query.CreditAssignmentQuery;
import com.jiudian.p2p.variables.P2PConst;
import com.jiudian.util.parser.EnumParser;

public class CreditAssignmentManageImpl extends AbstractFinancingManage
		implements CreditAssignmentManage {

	public CreditAssignmentManageImpl(ServiceResource serviceResource) {
		super(serviceResource);
	}

	public static class CreditAssignmentManageFactory implements
			ServiceFactory<CreditAssignmentManage> {

		@Override
		public CreditAssignmentManage newInstance(
				ServiceResource serviceResource) {
			return new CreditAssignmentManageImpl(serviceResource);
		}

	}

	protected static final String SELECT_ALL_SQL = "SELECT T6036.F04 title, T6036.F19 creditType, T6036.F09 lilv, T6036.F08 jkqx, T6036.F24 syqx, T6036.F40 xydj, T6039.F05 zqjz, T6039.F06 zrjg, T6039.F08 syfs, T6039.F01 id ,T6036_1.F02 NAME,T6036.F01,T6036.F06 FROM T6039 INNER JOIN T6036 ON T6039.F03 = T6036.F01  LEFT JOIN T6036_1 ON T6039.F03 = T6036_1.F01  ";
	protected static final String SELECT_LIST_SQL = "SELECT T6036.F04 title, T6036.F19 creditType, T6036.F09 lilv, T6036.F08 jkqx, T6036.F24 syqx, T6036.F40 xydj, T6039.F05 zqjz, T6039.F06 zrjg, T6039.F08 syfs, T6039.F01 id ,T6036_1.F02 NAME,T6036.F01,T6036.F06 FROM T6039 INNER JOIN T6036 ON T6039.F03 = T6036.F01  LEFT JOIN T6036_1 ON T6039.F03 = T6036_1.F01  ";

	@Override
	public PagingResult<CreditAssignment> getList(CreditAssignmentQuery query,
			Paging paging) throws Throwable {
		ArrayList<Object> parameters = new ArrayList<Object>();
		StringBuilder sql = new StringBuilder(SELECT_ALL_SQL);
		sql.append(" WHERE T6039.F11 = ? AND T6039.F12 = ? AND T6036.F20 = ?");
		parameters.add(TransferStatus.YX);
		parameters.add(OverdueStatus.S);
		parameters.add(CreditStatus.YFK);
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
					valieLevels.add(level);
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
							sql.append(" 1=1 ");
							break;
						}
					}
					sql.append(")");

				}
			}
		}
		sql.append("  ORDER BY  T6039.F09 DESC");
		PagingResult<CreditAssignment> pr= selectPaging(getConnection(FrontConst.DB_USER),
				new ArrayParser<CreditAssignment>() {
					@Override
					public CreditAssignment[] parse(ResultSet resultSet)
							throws SQLException {
						ArrayList<CreditAssignment> list = null;
						while (resultSet.next()) {
							CreditAssignment credit = new CreditAssignment();
							credit.title = resultSet.getString(1);
							credit.creditType = EnumParser.parse(
									CreditType.class, resultSet.getString(2));
							credit.rate = resultSet.getDouble(3);
							credit.jkqx = resultSet.getString(4);
							credit.syqx = resultSet.getString(5);
							credit.creditLevel = EnumParser.parse(CreditLevel.class,
									resultSet.getString(6));
							credit.zqjz = resultSet.getBigDecimal(7);
							credit.zrjg = resultSet.getBigDecimal(8);
							credit.syfs = resultSet.getInt(9);
							credit.zcId = resultSet.getInt(10);
							credit.companyStatus = EnumParser.parse(CompanyStatus.class, resultSet.getString(11));
							credit.jkbId = resultSet.getInt(12);
							credit.jkje = resultSet.getBigDecimal(13); 
							if (list == null) {
								list = new ArrayList<>();
							}
							list.add(credit);
						}
						return list == null ? null : list
								.toArray(new CreditAssignment[list.size()]);
					}
				}, paging, sql.toString(), parameters);
		
		if (pr.getItems() != null)
			for (CreditAssignment l : pr.getItems()) {
				String _s = "SELECT F02,F03 FROM T6036_4 WHERE F01=?";
				try (Connection c = getConnection(P2PConst.DB_USER);
						PreparedStatement ps = c.prepareStatement(_s);) {
					ps.setInt(1, l.jkbId);
					try (ResultSet r = ps.executeQuery()) {
						if (r.next()) {
							l.rewardType = EnumParser.parse(RewardType.class,
									r.getString(1));
							l.jllr = r.getBigDecimal(2);
						}
					}
				}
				if (l.rewardType == null) {
					l.rewardType = RewardType.WJL;
				}
			}
		
		return pr;

	}

	@Override
	public CreditAssignmentCount getStatistics() throws Throwable {
		CreditAssignmentCount credit = new CreditAssignmentCount();
		String sql = "SELECT IFNULL(SUM(T6040.F04*T6039.F06),0),IFNULL(SUM(T6039.F05*T6040.F04),0), COUNT(T6040.F01) FROM T6039, T6040 WHERE T6039.F01 = T6040.F02";
		try (Connection conn = getConnection(FrontConst.DB_USER)) {
			try (PreparedStatement ps = conn.prepareStatement(sql);) {
				try (ResultSet rs = ps.executeQuery();) {
					if (rs.next()) {
						credit.totleMoney = rs.getBigDecimal(1);
						credit.userEarnMoney = rs.getBigDecimal(2).subtract(
								credit.totleMoney);
						credit.totleCount = rs.getLong(3);
					}
				}
			}
		}
		return credit;
	}

	@Override
	public CreditAssignment get(int id) throws Throwable {
		ArrayList<Object> parameters = new ArrayList<>();
		String str = "SELECT T6036.F04 title, T6036.F19 creditType, T6010.F02, T6036.F24 syqx, T6039.F06 zrjg, T6036.F23 nexthuan, T6039.F05 zqjz, T6037.F04 ystzje, T6039.F07 zcfs, T6039.F13 yjsy, T6036.F08 jkqx, T6036.F09 lilv, T6036.F11 huanType, T6036.F06 jkje, T6039.F08 syfs, T6039.F01 id, T6036.F17 jkDesc, T6036.F01, T6023.F05 kyye ,T6036.F02 userId ,T6010.F01 F50,(SELECT T6010.F02 FROM T6010 WHERE T6010.F01 = T6036.F02),T6036.F37,T6036.F05 jkyt,t6036_1.F02 gsname,T6036.F10 hkzq FROM T6036 LEFT JOIN T6039 ON T6039.F03 = T6036.F01 LEFT JOIN T6010 ON T6010.F01 = T6039.F04 LEFT JOIN T6037 ON T6036.F01 = T6037.F02 AND T6010.F01 = T6037.F03 LEFT JOIN T6023 ON T6036.F02 = T6023.F01 LEFT JOIN T6036_1 ON T6036.F01 = T6036_1.F01";
		StringBuilder sql = new StringBuilder(str);
		sql.append(" WHERE T6039.F01 = ?  AND T6039.F12 = ? AND T6036.F20 = ?");
		parameters.add(id);
		//parameters.add(TransferStatus.YX);
		parameters.add(OverdueStatus.S);
		parameters.add(CreditStatus.YFK);
		return select(getConnection(FrontConst.DB_USER),
				new ItemParser<CreditAssignment>() {
					@Override
					public CreditAssignment parse(ResultSet resultSet)
							throws SQLException {
						CreditAssignment credit = null;
						while (resultSet.next()) {
							if (credit == null) {
								credit = new CreditAssignment();
							}
							credit.title = resultSet.getString(1);
							credit.creditType = EnumParser.parse(
									CreditType.class, resultSet.getString(2));
							credit.zczName = resultSet.getString(3);
							credit.syqx = resultSet.getString(4);
							credit.zrjg = resultSet.getBigDecimal(5);
							credit.nexthk = resultSet.getTimestamp(6);
							credit.zqjz = resultSet.getBigDecimal(7);
							credit.zcfs = resultSet.getInt(9);
							// credit.ystzje = resultSet.getBigDecimal(8);

							credit.yjsy = resultSet.getBigDecimal(10);
							credit.jkqx = resultSet.getString(11);
							credit.rate = resultSet.getDouble(12);
							credit.hkfs = EnumParser.parse(
									TenderRepayment.class,
									resultSet.getString(13));
							credit.jkje = resultSet.getBigDecimal(14);
							credit.syfs = resultSet.getInt(15);
							credit.zcId = resultSet.getInt(16);
							credit.jkDesc = resultSet.getString(17);
							credit.jkbId = resultSet.getInt(18);
							credit.kyMoney = resultSet.getBigDecimal(19);
							credit.jkzId = resultSet.getInt(20);
							credit.zczId = resultSet.getInt(21);
							credit.jkyh = resultSet.getString(22);
							credit.ystzje = resultSet.getBigDecimal(23)
									.multiply(new BigDecimal(credit.zcfs));
							credit.purpose = resultSet.getString(24);
							credit.companyStatus = EnumParser.parse(CompanyStatus.class, resultSet.getString(25));
							credit.creditCycle = EnumParser.parse(CreditCycle.class, resultSet.getString(26));
						}

						return credit;
					}
				}, sql.toString(), parameters);

	}

	@Override
	public CreditAssignment[] zqList(int line) throws Throwable {
		if(line == 0){
			line = 5;
		}
		ArrayList<Object> parameters = new ArrayList<Object>();
		StringBuilder sql = new StringBuilder(SELECT_LIST_SQL);
		sql.append(" WHERE T6039.F11 = ? AND T6039.F12 = ? AND T6036.F20 = ?");
		parameters.add(TransferStatus.YX);
		parameters.add(OverdueStatus.S);
		parameters.add(CreditStatus.YFK);
		sql.append("  ORDER BY  T6039.F09 DESC LIMIT ?");
		parameters.add(line);
		CreditAssignment[] result= selectAll(getConnection(FrontConst.DB_USER),
				new ArrayParser<CreditAssignment>() {
					@Override
					public CreditAssignment[] parse(ResultSet resultSet)
							throws SQLException {
						ArrayList<CreditAssignment> list = null;
						while (resultSet.next()) {
							CreditAssignment credit = new CreditAssignment();
							credit.title = resultSet.getString(1);
							credit.creditType = EnumParser.parse(
									CreditType.class, resultSet.getString(2));
							credit.rate = resultSet.getDouble(3);
							credit.jkqx = resultSet.getString(4);
							credit.syqx = resultSet.getString(5);
							credit.creditLevel = EnumParser.parse(CreditLevel.class,
									resultSet.getString(6));
							credit.zqjz = resultSet.getBigDecimal(7);
							credit.zrjg = resultSet.getBigDecimal(8);
							credit.syfs = resultSet.getInt(9);
							credit.zcId = resultSet.getInt(10);
							credit.companyStatus = EnumParser.parse(CompanyStatus.class, resultSet.getString(11));
							credit.jkbId = resultSet.getInt(12);
							credit.jkje = resultSet.getBigDecimal(13); 
							if (list == null) {
								list = new ArrayList<>();
							}
							list.add(credit);
						}
						return list == null ? null : list
								.toArray(new CreditAssignment[list.size()]);
					}
				},  sql.toString(), parameters);
		
		if (result != null)
			for (CreditAssignment l : result) {
				String _s = "SELECT F02,F03 FROM T6036_4 WHERE F01=?";
				try (Connection c = getConnection(P2PConst.DB_USER);
						PreparedStatement ps = c.prepareStatement(_s);) {
					ps.setInt(1, l.jkbId);
					try (ResultSet r = ps.executeQuery()) {
						if (r.next()) {
							l.rewardType = EnumParser.parse(RewardType.class,
									r.getString(1));
							l.jllr = r.getBigDecimal(2);
						}
					}
				}
				if (l.rewardType == null) {
					l.rewardType = RewardType.WJL;
				}
			}
		
		return result;
	}

	@Override
	public int searchCount() throws Throwable {
		ArrayList<Object> parameters = new ArrayList<Object>();
		StringBuilder sql = new StringBuilder("select COUNT(T6039.F01) from T6039 INNER JOIN T6036 ON T6039.F03 = T6036.F01 ");
		sql.append(" WHERE T6039.F11 = ? AND T6039.F12 = ? AND T6036.F20 = ?");
		parameters.add(TransferStatus.YX);
		parameters.add(OverdueStatus.S);
		parameters.add(CreditStatus.YFK);
		sql.append("  ORDER BY T6039.F09 DESC");
		
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
