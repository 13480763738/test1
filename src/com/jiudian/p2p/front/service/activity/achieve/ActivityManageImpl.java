package com.jiudian.p2p.front.service.activity.achieve;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import com.jiudian.framework.config.ConfigureProvider;
import com.jiudian.framework.config.Envionment;
import com.jiudian.framework.service.ServiceFactory;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.framework.service.exception.LogicalException;
import com.jiudian.framework.service.query.ArrayParser;
import com.jiudian.framework.service.query.ItemParser;
import com.jiudian.framework.service.query.Paging;
import com.jiudian.framework.service.query.PagingResult;
import com.jiudian.p2p.common.enums.ExperienceGoldStatus;
import com.jiudian.p2p.common.enums.IsPass;
import com.jiudian.p2p.common.enums.LetterStatus;
import com.jiudian.p2p.common.enums.PlatformFundType;
import com.jiudian.p2p.common.enums.TradingType;
import com.jiudian.p2p.front.config.FrontConst;
import com.jiudian.p2p.front.service.activity.ActivityManage;
import com.jiudian.p2p.front.service.activity.entity.Activity;
import com.jiudian.p2p.front.service.activity.entity.Gqcy;
import com.jiudian.p2p.front.service.activity.entity.Gqhd;
import com.jiudian.p2p.front.service.activity.entity.RedPacket;
import com.jiudian.p2p.variables.P2PConst;
import com.jiudian.util.StringHelper;
import com.jiudian.util.parser.EnumParser;

public class ActivityManageImpl extends AbstractActivityService implements
		ActivityManage {

	public ActivityManageImpl(ServiceResource serviceResource) {
		super(serviceResource);
	}

	public static class ActivityManageFactory implements
			ServiceFactory<ActivityManage> {
		@Override
		public ActivityManage newInstance(ServiceResource serviceResource) {
			return new ActivityManageImpl(serviceResource);
		}

	}

	/**
	 * 发站内信
	 */
	private static final String t6035 = "INSERT INTO T6035 SET F02=?,F03=?,F04=?,F05=?,F06=?";
	/**
	 * 站内信内容
	 */
	private static final String t6046 = "INSERT INTO T6046 SET F01=?,F02=?";

	@Override
	public PagingResult<Activity> serachActivityRanking(Paging ping)
			throws Throwable {
		return selectPaging(getConnection(FrontConst.DB_CONSOLE),
				new ArrayParser<Activity>() {
					@Override
					public Activity[] parse(ResultSet rs) throws SQLException {

						List<Activity> listActivity = null;
						while (rs.next()) {
							Activity activity = new Activity();
							activity.ranking = rs.getInt(1);
							activity.userName = rs.getString(2);
							activity.number = rs.getInt(3);
							if (listActivity == null) {
								listActivity = new ArrayList<Activity>();
							}
							listActivity.add(activity);
						}
						return listActivity == null ? null : listActivity
								.toArray(new Activity[listActivity.size()]);
					}

				}, ping, "SELECT F01,F03,F04 FROM T7052");
	}

	@Override
	public Gqhd get() throws Throwable {
		int account = 0;
		if (serviceResource.getSession().isAuthenticated()) {
			account = serviceResource.getSession().getAccountId();
		}
		return select(
				getConnection(FrontConst.DB_CONSOLE),
				new ItemParser<Gqhd>() {
					@Override
					public Gqhd parse(ResultSet res) throws SQLException {
						Gqhd g = new Gqhd();
						if (res.next()) {
							g.ggkf = EnumParser.parse(IsPass.class,
									res.getString(1));
							g.jhje = EnumParser.parse(IsPass.class,
									res.getString(2));
							g.wyh = EnumParser.parse(IsPass.class,
									res.getString(3));
							g.xhjs = EnumParser.parse(IsPass.class,
									res.getString(4));
							g.zgts = EnumParser.parse(IsPass.class,
									res.getString(5));
							g.sgdb = EnumParser.parse(IsPass.class,
									res.getString(6));
							g.shzy = EnumParser.parse(IsPass.class,
									res.getString(7));
							g.order = res.getInt(8);
							g.je = res.getBigDecimal(9);
							g.zh = res.getString(10);
						}
						return g;
					}
				},
				"SELECT T7052_02.F02, T7052_02.F03, T7052_02.F04, T7052_02.F05, T7052_02.F06, T7052_02.F07, T7052_02.F08, T7052_01.F01 PM, T7052_01.F04 TZJE,T7052_01.F03 ZH FROM T7052_02 LEFT JOIN T7052_01 ON T7052_02.F01 = T7052_01.F02 WHERE T7052_01.F02=?",
				account);
	}

	@Override
	public Gqcy[] serach() throws Throwable {
		return selectAll(
				getConnection(FrontConst.DB_CONSOLE),
				new ArrayParser<Gqcy>() {
					@Override
					public Gqcy[] parse(ResultSet res) throws SQLException {
						List<Gqcy> list = null;
						while (res.next()) {
							if (list == null) {
								list = new ArrayList<Gqcy>();
							}
							Gqcy g = new Gqcy();
							g.order = res.getInt(1);
							g.id = res.getInt(2);
							g.zh = res.getString(3);
							g.je = res.getBigDecimal(4);
							list.add(g);
						}
						return list == null ? null : list.toArray(new Gqcy[list
								.size()]);
					}
				},
				" SELECT F01,F02,F03,F04 FROM T7052_01 ORDER BY F01 ASC  LIMIT 120 ");
	}

	@Override
	public String getTyj(int dj) throws Throwable {
		String qh = select(
				getConnection(FrontConst.DB_CONSOLE),
				new ItemParser<String>() {
					@Override
					public String parse(ResultSet res) throws SQLException {
						if (res.next()) {
							return res.getString(1);
						} else {
							return "";
						}
					}
				},
				"SELECT F01 FROM T7051 WHERE F02=? AND F11=? LIMIT 1 FOR UPDATE",
				dj, ExperienceGoldStatus.WLY);
		return qh;
	}

	@Override
	public void update51(String colum) throws Throwable {
		execute(getConnection(FrontConst.DB_CONSOLE), "UPDATE T7052_02 SET "
				+ colum + " WHERE F01=?", IsPass.S, serviceResource
				.getSession().getAccountId());
	}

	/**
	 * 如果大于0,为抽中的奖品,如果为0则抽奖次数已用完
	 */
	public int getLottery2014() throws Throwable {
		int account = 0;
		if (serviceResource.getSession().isAuthenticated()) {
			account = serviceResource.getSession().getAccountId();
		}
		String S_T7052_03 = "";
		if (account == 0) {// 未登陆抽奖
			S_T7052_03 = "SELECT SUM(F03),SUM(F04) FROM S70.t7052_03";
		} else {// 登陆后抽奖
			int hdId = 3;// 活动ID
			Timestamp startTime = null;// 活动开始时间
			Timestamp endTime = null;// 活动结束时间
			try (Connection con = getConnection(P2PConst.DB_CONSOLE)) {
				// 查询活动
				String sqlOne = "SELECT F03,F04 FROM T7046 WHERE F01=?";
				try (PreparedStatement ps = con.prepareStatement(sqlOne)) {
					ps.setInt(1, hdId);
					try (ResultSet rs = ps.executeQuery()) {
						if (rs.next()) {
							startTime = rs.getTimestamp(1);
							endTime = rs.getTimestamp(2);
						}
					}
				}
			}
			// 如果活动起止时间为空，return
			if (startTime == null || endTime == null) {
				return 0;
			}

			// 当前时间
			Timestamp currTime = new Timestamp(System.currentTimeMillis());
			// 判断活动时间是否小于当前时间
			if (startTime.after(currTime) || endTime.before(currTime)) {
				return 0;
			}

			S_T7052_03 = "SELECT SUM(F05),SUM(F06) FROM S70.t7052_03";
			// 判断抽奖次数是否满足
			String S_T7052_04 = "SELECT F03,F04 FROM T7052_04 WHERE F01=? FOR UPDATE";
			int k = 0;
			int y = 0;
			try (Connection con = getConnection(FrontConst.DB_CONSOLE)) {
				try (PreparedStatement ps = con.prepareStatement(S_T7052_04)) {
					ps.setInt(1, account);
					try (ResultSet rs = ps.executeQuery()) {
						if (rs.next()) {
							k = rs.getInt(1);
							y = rs.getInt(2);
						}
					}
				}
			}

			if (k > y) {
				String U_T7052_04 = "UPDATE T7052_04 SET F04=F04+1 WHERE F01=? ";
				execute(getConnection(FrontConst.DB_CONSOLE), U_T7052_04,
						account);
			} else {
				return 0;
			}
		}
		int _t = 0;
		int _d = 0;
		try (Connection con = getConnection(FrontConst.DB_CONSOLE)) {
			try (PreparedStatement ps = con.prepareStatement(S_T7052_03)) {
				try (ResultSet rs = ps.executeQuery()) {
					if (rs.next()) {
						_t = rs.getInt(1);
						_d = rs.getInt(2);
					}
				}
			}
		}

		int r = 0;
		Map<Integer, BigDecimal> map_zjjl = new HashMap<>();// 中奖几率
		Map<Integer, BigDecimal> map_sjzj = new HashMap<>();// 实际几率
		if (account == 0) {// 未登陆抽奖
			try (Connection con = getConnection(FrontConst.DB_CONSOLE)) {
				String _T7052_03 = "SELECT F03/?,F04/?,F01 FROM S70.t7052_03 ";
				try (PreparedStatement ps = con.prepareStatement(_T7052_03)) {
					ps.setInt(1, _t);
					ps.setInt(2, _d);
					try (ResultSet rs = ps.executeQuery()) {
						while (rs.next()) {
							BigDecimal _zjjl = rs.getBigDecimal(1);
							BigDecimal _sjzb = rs.getBigDecimal(2);
							int clazz = rs.getInt(3);
							map_zjjl.put(clazz, _zjjl);
							map_sjzj.put(clazz, _sjzb);
						}
					}
				}
			}

			r = getLottery2014NoLogin(map_zjjl, map_sjzj);
			String U_T7052_03 = "UPDATE S70.t7052_03 SET F04 = F04 + 1 WHERE F01 = ?";
			execute(getConnection(FrontConst.DB_CONSOLE), U_T7052_03, r);
		} else {// 登陆后抽奖
			// 中奖限制条件
			int times_4w = selectInt(FrontConst.DB_CONSOLE,
					"SELECT COUNT(*) FROM S70.t7052_05 WHERE F02=? AND F03=4 ",
					account);
			int times_5w = selectInt(FrontConst.DB_CONSOLE,
					"SELECT COUNT(*) FROM S70.t7052_05 WHERE F02=? AND F03=5 ",
					account);
			int times = selectInt(FrontConst.DB_CONSOLE,
					"SELECT F03 FROM S70.t7052_04 WHERE F01=? ", account);
			// (1)只有一次机会的只给九万
			if (times == 1) {
				r = 9;
			} else {
				try (Connection con = getConnection(FrontConst.DB_CONSOLE)) {
					String _T7052_03 = "SELECT F05/?,F06/?,F01 FROM S70.t7052_03 ";
					try (PreparedStatement ps = con.prepareStatement(_T7052_03)) {
						ps.setInt(1, _t);
						ps.setInt(2, _d);
						try (ResultSet rs = ps.executeQuery()) {
							while (rs.next()) {
								BigDecimal _zjjl = rs.getBigDecimal(1);
								BigDecimal _sjzb = rs.getBigDecimal(2);
								int clazz = rs.getInt(3);
								map_zjjl.put(clazz, _zjjl);
								map_sjzj.put(clazz, _sjzb);
							}
						}
					}
				}

				r = getLottery2014Login(map_zjjl, map_sjzj, times_4w, times_5w);
			}

			String U_T7052_03 = "UPDATE S70.t7052_03 SET F06 = F06 + 1 WHERE F01 = ?";
			execute(getConnection(FrontConst.DB_CONSOLE), U_T7052_03, r);
			// 添加中奖记录
			String I_T7052_05 = "INSERT INTO t7052_05 SET F02=?,F03=?,F04=CURRENT_TIMESTAMP()";
			execute(getConnection(FrontConst.DB_CONSOLE), I_T7052_05, account,
					r);
			// 发放奖励
			String title = "双11投资抽大奖";
			String mb_hf = "恭喜您，获得${amt_hf}元话费！奖品将在活动结束后7个工作日内发放，届时将有麒麟通宝工作人员与您联系。";
			String mb_tyj = "恭喜您，获得${amt_tyj}元体验金！体验金已到账，有效期${start}至${end}，请前往理财体验专区免费申请加入。";
			String mb_hb = "恭喜您，获得${amt_hb}元现金红包！红包已到账，请前往个人中心查收。";

			ConfigureProvider configureProvider = serviceResource
					.getResource(ConfigureProvider.class);
			Envionment envionment = configureProvider.createEnvionment();

			BigDecimal amt_tyj = new BigDecimal(0);
			BigDecimal amt_hb = new BigDecimal(0);
			BigDecimal amt_hf = new BigDecimal(0);

			try (Connection con = getConnection(FrontConst.DB_CONSOLE)) {
				String _T7052_03 = "SELECT F07,F08,F09 FROM S70.t7052_03 WHERE F01 = ?";
				try (PreparedStatement ps = con.prepareStatement(_T7052_03)) {
					ps.setInt(1, r);
					try (ResultSet rs = ps.executeQuery()) {
						if (rs.next()) {
							amt_tyj = rs.getBigDecimal(1);
							amt_hb = rs.getBigDecimal(2);
							amt_hf = rs.getBigDecimal(3);
						}
					}
				}
			}

			if (amt_tyj.compareTo(new BigDecimal(0)) > 0) {// 体验金奖励
				int hdid = 18;// 2014双十一活动ID(确保有)
				String qh = createUUID(8);
				String insertT7051 = "INSERT INTO t7051 SET F01=?,F02=?,F03=CURRENT_TIMESTAMP(),F04=CURRENT_TIMESTAMP(),F05=ADDDATE(CURRENT_TIMESTAMP(),30),F06=?,F07=?,F08=CURRENT_TIMESTAMP(),F11=?";
				insert(getConnection(FrontConst.DB_CONSOLE), insertT7051, qh,
						hdid, new BigDecimal(3000), account,
						ExperienceGoldStatus.YLY);
				Calendar _c = Calendar.getInstance();
				StringBuffer start = new StringBuffer();
				start.append(_c.get(Calendar.YEAR)).append("年");
				start.append(_c.get(Calendar.MONTH) + 1).append("月");
				start.append(_c.get(Calendar.DAY_OF_MONTH)).append("日");
				StringBuffer end = new StringBuffer();
				_c.add(Calendar.DAY_OF_MONTH, 30);
				end.append(_c.get(Calendar.YEAR)).append("年");
				end.append(_c.get(Calendar.MONTH) + 1).append("月");
				end.append(_c.get(Calendar.DAY_OF_MONTH)).append("日");

				envionment.set("start", start.toString());
				envionment.set("end", end.toString());
				envionment.set("amt_tyj", amt_tyj.toString());

				sendLetter(account, title,
						StringHelper.format(mb_tyj, envionment));// 发站内信
			}

			if (amt_hf.compareTo(new BigDecimal(0)) > 0) {// 话费奖励
				envionment.set("amt_hf", amt_hf.toString());

				sendLetter(account, title,
						StringHelper.format(mb_hf, envionment));// 发站内信
			}

			if (amt_hb.compareTo(new BigDecimal(0)) > 0) {// 红包奖励
				envionment.set("amt_hb", amt_hb.toString());

				// 扣除平台账号金额
				String S_T7025 = "SELECT F01 FROM T7025 FOR UPDATE";
				BigDecimal ptTotalAmount = selectBigDecimal(
						FrontConst.DB_CONSOLE, S_T7025);
				String U_T7025 = "UPDATE T7025 SET F01=F01-?,F02=F02+?,F04=F04-?";
				execute(getConnection(FrontConst.DB_CONSOLE), U_T7025, amt_hb,
						amt_hb, amt_hb);
				String I_T7026 = "INSERT INTO T7026 SET F02=?,F04=?,F05=?,F06=?,F07=?,F08=?,F09=?";
				ptTotalAmount = ptTotalAmount.subtract(amt_hb);
				execute(getConnection(FrontConst.DB_CONSOLE), I_T7026,
						new Timestamp(System.currentTimeMillis()), amt_hb,
						ptTotalAmount, PlatformFundType.HDFY, "2014双十一活动奖励红包",
						3, account);

				// 取账户余额
				String S_T6023 = "SELECT F03 FROM T6023 WHERE F01 = ? FOR UPDATE";
				BigDecimal acountAmount = selectBigDecimal(P2PConst.DB_USER,
						S_T6023, account);
				// 更新账户金额
				String U_T6023 = "UPDATE T6023 SET F03=F03+?,F05=F05+? WHERE F01=?";
				execute(getConnection(FrontConst.DB_USER), U_T6023, amt_hb,
						amt_hb, account);

				// 插入推广人资金流水
				acountAmount = acountAmount.add(amt_hb);
				String I_T6032 = "INSERT INTO T6032 SET F02=?,F03=?,F04=?,F05=?,F07=?,F08=?,F09=?";
				execute(getConnection(FrontConst.DB_USER), I_T6032, account,
						TradingType.HDJL,
						new Timestamp(System.currentTimeMillis()), amt_hb,
						acountAmount, 3, "2014双十一活动奖励红包");

				sendLetter(account, title,
						StringHelper.format(mb_hb, envionment));// 发站内信
			}
		}
		return r;
	}

	/**
	 * 产生券号
	 * 
	 * @param len
	 *            长度
	 * @return 字符串
	 */
	private static String createUUID(int len) {
		String str = "";
		while (true) {
			String uuid = java.util.UUID.randomUUID().toString()
					.replaceAll("-", "");
			Pattern pattern = Pattern.compile("[0-9]*");
			str = uuid.substring(0, len);
			if (!pattern.matcher(str.replace("e", "")).matches()) {
				break;
			}
		}
		return str;
	}

	/**
	 * 发站内信
	 * 
	 * @param loginId
	 *            用户编号
	 * @param title
	 *            标题
	 * @param content
	 *            内容
	 * @throws SQLException
	 */
	private void sendLetter(int loginId, String title, String content)
			throws SQLException {
		Timestamp now = new Timestamp(System.currentTimeMillis());
		int letterId = insert(getConnection(P2PConst.DB_USER), t6035, now,
				title, "", loginId, LetterStatus.WD);
		execute(getConnection(P2PConst.DB_USER), t6046, letterId, content);
	}

	private int getLottery2014Login(Map<Integer, BigDecimal> _zjjl,
			Map<Integer, BigDecimal> _sjzb, int times_4w, int times_5w)
			throws Throwable {
		ArrayList<Integer> rs = new ArrayList<Integer>();
		// 四万五万只能中一次
		if (times_4w == 0) {
			rs.add(4);
		}
		if (times_5w == 0) {
			rs.add(5);
		}
		rs.add(6);
		rs.add(7);
		rs.add(8);
		rs.add(9);

		int _r = (int) Math.floor(Math.random() * (rs.size()));
		int rt = rs.get(_r);
		if (rt == 9) {
			return rs.get(_r);
		}

		if (_zjjl != null && _sjzb != null
				&& _sjzb.get(rt).compareTo(_zjjl.get(rt)) > 0
				|| _zjjl.get(rt).compareTo(new BigDecimal(0)) == 0) {
			return getLottery2014Login(_zjjl, _sjzb, times_4w, times_5w);
		}

		return rt;
	}

	private int getLottery2014NoLogin(Map<Integer, BigDecimal> _zjjl,
			Map<Integer, BigDecimal> _sjzb) throws Throwable {
		int _s = 1, _e = 8;
		int _r = (int) Math.floor(_s + Math.random() * (_e - _s + 1));

		if (_zjjl != null && _sjzb != null
				&& _sjzb.get(_r).compareTo(_zjjl.get(_r)) == 1
				|| _zjjl.get(_r).compareTo(new BigDecimal(0)) == 0) {
			return getLottery2014NoLogin(_zjjl, _sjzb);
		}
		return _r;
	}

	@Override
	public int getLottery2014Times() throws Throwable {
		int account = 0;
		int t = 1;
		if (serviceResource.getSession().isAuthenticated()) {
			int hdId = 3;// 活动ID
			Timestamp startTime = null;// 活动开始时间
			Timestamp endTime = null;// 活动结束时间
			try (Connection con = getConnection(P2PConst.DB_CONSOLE)) {
				// 查询活动
				String sqlOne = "SELECT F03,F04 FROM T7046 WHERE F01=?";
				try (PreparedStatement ps = con.prepareStatement(sqlOne)) {
					ps.setInt(1, hdId);
					try (ResultSet rs = ps.executeQuery()) {
						if (rs.next()) {
							startTime = rs.getTimestamp(1);
							endTime = rs.getTimestamp(2);
						}
					}
				}
			}
			// 如果活动起止时间为空，return
			if (startTime == null || endTime == null) {
				return 0;
			}

			// 当前时间
			Timestamp currTime = new Timestamp(System.currentTimeMillis());
			// 判断活动时间是否小于当前时间
			if (startTime.after(currTime) || endTime.before(currTime)) {
				return 0;
			}

			account = serviceResource.getSession().getAccountId();
			String sql = "SELECT F03-F04 FROM T7052_04 WHERE F01=?";
			t = selectInt(FrontConst.DB_CONSOLE, sql, account);
		}
		return t;
	}

	@Override
	public int getLottery2014Amt() throws Throwable {
		int account = 0;
		int a = 0;
		if (serviceResource.getSession().isAuthenticated()) {
			account = serviceResource.getSession().getAccountId();
			String sql = "SELECT F02 FROM T7052_04 WHERE F01=?";
			a = selectInt(FrontConst.DB_CONSOLE, sql, account);
			if (a < 1000) {
				a = 1000 - a;
			} else if (a < 5000) {
				a = 5000 - a;
			} else if (a < 10000) {
				a = 10000 - a;
			} else {
				a = 10000 - a % 10000;
			}
		}
		return a;
	}	
	
	@Override
	public BigDecimal getHd5Jbye() throws Throwable {
		BigDecimal ye  = new BigDecimal("0");
		
		int hdId = 5;// 活动ID
		Timestamp startTime = null;// 活动开始时间
		Timestamp endTime = null;// 活动结束时间
		try (Connection con = getConnection(P2PConst.DB_CONSOLE)) {
			// 查询活动
			String sqlOne = "SELECT F03,F04 FROM T7046 WHERE F01=?";
			try (PreparedStatement ps = con.prepareStatement(sqlOne)) {
				ps.setInt(1, hdId);
				try (ResultSet rs = ps.executeQuery()) {
					if (rs.next()) {
						startTime = rs.getTimestamp(1);
						endTime = rs.getTimestamp(2);
					}
				}
			}
		}
		// 如果活动起止时间为空，return
		if (startTime == null || endTime == null) {
			return ye;
		}
		
		// 当前时间
		Timestamp currTime = new Timestamp(System.currentTimeMillis());
		// 判断活动时间是否小于当前时间
		if (startTime.after(currTime) || endTime.before(currTime)) {
			return ye;
		}
		String s = "SELECT F02 FROM t7052_09 WHERE F01=? ";
		ye = selectBigDecimal(P2PConst.DB_CONSOLE, s,
				serviceResource.getSession().getAccountId());
		return ye;
	}

	@Override
	public Gqcy[] serach2014sd() throws Throwable {
		return selectAll(
				getConnection(FrontConst.DB_CONSOLE),
				new ArrayParser<Gqcy>() {
					@Override
					public Gqcy[] parse(ResultSet res) throws SQLException {
						List<Gqcy> list = new ArrayList<Gqcy>();
						while (res.next()) {
							Gqcy g = new Gqcy();
							g.order = list.size() + 1;
							g.id = res.getInt(1);
							g.zh = res.getString(2);
							g.je = res.getBigDecimal(3);
							list.add(g);
						}
						return list.toArray(new Gqcy[list.size()]);
					}
				},
				" SELECT F01,(SELECT T6010.F02 FROM S60.T6010 WHERE T6010.F01=T7052_09.F01),F03 FROM T7052_09 WHERE F03>=10000 ORDER BY F03 DESC,F05 ASC ");
	}
	
	@Override
	public BigDecimal getHd5Jlje(int type) throws Throwable {
		int account = serviceResource.getSession().getAccountId();
		BigDecimal jlje = new BigDecimal(0);
		int hdId = 5;// 活动ID
		Timestamp startTime = null;// 活动开始时间
		Timestamp endTime = null;// 活动结束时间
		try (Connection con = getConnection(P2PConst.DB_CONSOLE)) {
			// 查询活动
			String sqlOne = "SELECT F03,F04 FROM T7046 WHERE F01=?";
			try (PreparedStatement ps = con.prepareStatement(sqlOne)) {
				ps.setInt(1, hdId);
				try (ResultSet rs = ps.executeQuery()) {
					if (rs.next()) {
						startTime = rs.getTimestamp(1);
						endTime = rs.getTimestamp(2);
					}
				}
			}
		}
		// 如果活动起止时间为空，return
		if (startTime == null || endTime == null) {
			return jlje;
		}
		
		// 当前时间
		Timestamp currTime = new Timestamp(System.currentTimeMillis());
		// 判断活动时间是否小于当前时间
		if (startTime.after(currTime) || endTime.before(currTime)) {
			return jlje;
		}
		
		String SELECT_09 = "SELECT F02 FROM T7052_09 WHERE F01=? FOR UPDATE ";
		//用户金币余额
		BigDecimal jbye = selectBigDecimal(P2PConst.DB_CONSOLE, SELECT_09, account);
		String SELECT_07 = "SELECT F02 FROM T7052_07 WHERE F01=?";
		//扣减金额
		BigDecimal kjje = selectBigDecimal(P2PConst.DB_CONSOLE, SELECT_07, type);
		if(jbye.compareTo(kjje)<0){
			return jlje;
		}
		
		String UPDATE_09 = "UPDATE T7052_09 SET F02=F02-?,F04=F04+? WHERE F01=?";
		execute(getConnection(P2PConst.DB_CONSOLE), UPDATE_09, kjje, kjje,account);
		
		
		int _t = 0;
		int _d = 0;
		String S_T7052_08 = "SELECT SUM(F03),SUM(F04) FROM T7052_08 WHERE F02=?";
		try (Connection con = getConnection(P2PConst.DB_CONSOLE)) {
			try (PreparedStatement ps = con.prepareStatement(S_T7052_08)) {
				ps.setInt(1, type);
				try (ResultSet rs = ps.executeQuery()) {
					if (rs.next()) {
						_t = rs.getInt(1);
						_d = rs.getInt(2);
					}
				}
			}
		}
		
		//计算获得奖励
		ArrayList<Zjqk> list = new ArrayList<>();
		try (Connection con = getConnection(P2PConst.DB_CONSOLE)) {
			String _T7052_08 = "SELECT F03/?,F04/?,F01,F06,(SELECT COUNT(*) FROM S70.T7052_10 WHERE DATE(T7052_10.F04)=DATE(NOW()) AND T7052_10.F03=T7052_08.F01) cur_cs FROM S70.T7052_08 WHERE F02=? ORDER BY F01 ASC";
			try (PreparedStatement ps = con.prepareStatement(_T7052_08)) {
				ps.setInt(1, _t);
				ps.setInt(2, _d);
				ps.setInt(3, type);
				try (ResultSet rs = ps.executeQuery()) {
					while (rs.next()) {
						BigDecimal _zjjl = rs.getBigDecimal(1);
						BigDecimal _sjzb = rs.getBigDecimal(2);
						int clazz = rs.getInt(3);
						IsPass sf = EnumParser.parse(IsPass.class, rs.getString(4));//是否当天只能出一次
						int cs = rs.getInt(5);//当天次数
						
						//排除当天已经中了一次的情况
						if((sf.equals(IsPass.S)&&cs>0)||_zjjl.compareTo(new BigDecimal(0))<=0){
							
						}else{
							Zjqk qk = new Zjqk();
							qk.id = clazz;
							qk._zjjl= _zjjl;
							qk._sjzb = _sjzb;
							list.add(qk);
						}
					}
				}
			}
		}
		
		int rt = getLottery(list);//中奖ID
		String SELECT_08 = "SELECT F05 FROM T7052_08 WHERE F01=? FOR UPDATE";
		//中奖金额
		jlje = selectBigDecimal(P2PConst.DB_CONSOLE, SELECT_08, rt);
		
		String UPDATE_08 = "UPDATE T7052_08 SET F04=F04+1 WHERE F01=?";
		execute(getConnection(P2PConst.DB_CONSOLE), UPDATE_08, rt);
		
		String INSERT_10 = "INSERT INTO T7052_10 SET F02=?,F03=?,F04=CURRENT_TIMESTAMP()";
		insert(getConnection(P2PConst.DB_CONSOLE), INSERT_10, account,rt);
		
		ConfigureProvider configureProvider = serviceResource
				.getResource(ConfigureProvider.class);
		Envionment envionment = configureProvider.createEnvionment();
		
		String title = "双蛋联庆";
		String mb_hb = "恭喜您，获得${amt_hb}元双蛋联庆红包！红包已到账，请前往个人中心查收。";
		BigDecimal amt_hb = jlje;
		envionment.set("amt_hb", amt_hb.toString());
		// 扣除平台账号金额
		String S_T7025 = "SELECT F01 FROM T7025 FOR UPDATE";
		BigDecimal ptTotalAmount = selectBigDecimal(P2PConst.DB_CONSOLE, S_T7025);
		String U_T7025 = "UPDATE T7025 SET F01=F01-?,F02=F02+?,F04=F04-?";
		execute(getConnection(P2PConst.DB_CONSOLE), U_T7025, amt_hb, amt_hb,amt_hb);
		String I_T7026 = "INSERT INTO T7026 SET F02=?,F04=?,F05=?,F06=?,F07=?,F08=?,F09=?";
		ptTotalAmount = ptTotalAmount.subtract(amt_hb);
		execute(getConnection(P2PConst.DB_CONSOLE), I_T7026,new Timestamp(System.currentTimeMillis()), amt_hb,
				ptTotalAmount, PlatformFundType.HDFY,title, 3, account);
		
		// 取账户余额
		String S_T6023 = "SELECT F03 FROM T6023 WHERE F01 = ? FOR UPDATE";
		BigDecimal acountAmount = selectBigDecimal(P2PConst.DB_USER,S_T6023, account);
		// 更新账户金额
		String U_T6023 = "UPDATE T6023 SET F03=F03+?,F05=F05+? WHERE F01=?";
		execute(getConnection(P2PConst.DB_USER), U_T6023, amt_hb, amt_hb,account);
		
		// 插入推广人资金流水
		acountAmount = acountAmount.add(amt_hb);
		String I_T6032 = "INSERT INTO T6032 SET F02=?,F03=?,F04=?,F05=?,F07=?,F08=?,F09=?";
		execute(getConnection(P2PConst.DB_USER), I_T6032, account,TradingType.HDJL,
				new Timestamp(System.currentTimeMillis()), amt_hb,acountAmount,3, title);

		sendLetter(account, title, StringHelper.format(mb_hb, envionment));// 发站内信
		
		return jlje;
	}
	
	
	class Zjqk{
		/**
		 * 奖品ID
		 */
		public int id;
		/**
		 * 中奖几率
		 */
		public BigDecimal _zjjl = new BigDecimal(0);
		/**
		 * 实际几率
		 */
		public BigDecimal _sjzb = new BigDecimal(0);
	}
	
	
	private int getLottery(ArrayList<Zjqk> rs)
			throws Throwable {
		int _r = (int) Math.floor(Math.random() * (rs.size()));
		int rt = rs.get(_r).id;
		if(_r == 0){
			return rt;
		}
		
		if (rs.get(_r)._sjzb.compareTo(rs.get(_r)._zjjl) > 0) {
			return getLottery(rs);
		}
		
		return rt;
	}
	

	@Override
	public String sdMsg() throws Throwable {
		StringBuffer rs = new StringBuffer("");
		if (serviceResource.getSession().isAuthenticated()) {
			int account = serviceResource.getSession().getAccountId();
			int[] mc = { 1, 2, 3, 8, 12, 20, 28, 36, 44, 52 };
			String[] jp = { "华为mate7", "Sony微单", "Bose音响", "1000元现金", "888元现金",
					"500元现金", "移动硬盘", "充电宝", "腊肉4斤", "小米健康手环" };
			String s = "SELECT F03 FROM T7052_09 WHERE F01=?";
			BigDecimal tzje = selectBigDecimal(FrontConst.DB_CONSOLE, s,
					account);

			Gqcy[] pm = serach2014sd();
			Gqcy pp = null;
			for (Gqcy p : pm) {
				if (p.id == account) {
					pp = p;
					for (int i=0;i<mc.length;i++) {
						if (mc[i] == p.order) {
							rs.append("<p class='pm_num'>我的排名："+pp.order+"</p>");
							rs.append("<p>保持当前排名将获得"+jp[i]+"</p>");
							return rs.toString();
						}
					}
				}
			}
			int idx = 1;
			if (pp == null) {
				rs.append("<p class='pm_num'>我的排名：暂无排名</p>");
				if(pm.length==0){
					return rs.append("<p>投资10000元,即可成为第1名(华为mate7)</p>").toString();
				}
				for (int i=0;i<mc.length;i++) {
					if(pm.length>=mc[i]){
						idx=i;
					}else{
						break;
					}
				}
				
			}else{
				for (int i=0;i<mc.length;i++) {
					if(pp.order>=mc[i]){
						idx=i;
					}else{
						break;
					}
				}
				rs.append("<p class='pm_num'>我的排名："+pp.order+"</p>");
			}
			
			BigDecimal zjje = pm[mc[idx]-1].je;//最近获奖者金额
			BigDecimal deta = zjje.subtract(tzje);
			if(deta.compareTo(new BigDecimal(0))==0){
				deta  = new BigDecimal(100);
			}
			rs.append("<p>再投资").append(deta.intValue()).append("元,即可成为第").append(mc[idx]).append("名(").append(jp[idx]).append(")</p>");
		}
		return rs.toString();
	}

	
	@Override
	public boolean getTreeMoney() throws Throwable {
		int accountid = serviceResource.getSession().getAccountId();
		RedPacket r = getRedPacket();
		
		if(r.isGet.equals(IsPass.S)){
			return false;
		}
		
		int hdId = 7;// 活动ID
		Timestamp startTime = null;// 活动开始时间
		Timestamp endTime = null;// 活动结束时间
		try (Connection con = getConnection(FrontConst.DB_CONSOLE)) {
			// 锁T7046活动表
			String sql = "SELECT * FROM T7046 WHERE F01 = ? FOR UPDATE";
			execute(con, sql, hdId);
			// 查询活动
			String sqlOne = "SELECT F03,F04 FROM T7046 WHERE F01=?";
			try (PreparedStatement ps = con.prepareStatement(sqlOne)) {
				ps.setInt(1, hdId);
				try (ResultSet rs = ps.executeQuery()) {
					if (rs.next()) {
						startTime = rs.getTimestamp(1);
						endTime = rs.getTimestamp(2);
					}
				}
			}
		}
		// 如果活动起止时间为空，return
		if (startTime == null || endTime == null) {
			throw new LogicalException("活动不存在。");
		}
		// 当前时间
		Timestamp currTime = new Timestamp(System.currentTimeMillis());
		// 判断活动时间是否小于当前时间
		if (startTime.after(currTime)) {
			throw new LogicalException("活动未开始。");
		}
		if ( endTime.before(currTime)) {
			throw new LogicalException("活动已结束。");
		}
		
		BigDecimal money = r.money;
		
		if(money.compareTo(new BigDecimal(0))<=0 || money.compareTo(new BigDecimal(5000))<0){
			throw new LogicalException("人家还是一颗LV0的小树苗呢，请耐心浇灌我到LV1以上再领取。");
		}
		
		if(r.redPacketNum>0){
			String sql = "UPDATE T7052_11 SET F03=?,F04=?,F05=CURRENT_TIMESTAMP(),F07=?,F08=? WHERE F01=?";
			execute(getConnection(FrontConst.DB_CONSOLE), sql,r.treeMoney,IsPass.S,r.redPacketNum,r.redPacketMoney,accountid);
		}
		return true;
	}
	

	@Override
	public RedPacket getRedPacket() throws Throwable {
		return select(getConnection(FrontConst.DB_CONSOLE), new ItemParser<RedPacket>() {
			@Override
			public RedPacket parse(ResultSet res)
					throws SQLException {
				RedPacket r = new RedPacket();
				if(res.next()){
					r.money = res.getBigDecimal(1);
					r.treeMoney = res.getBigDecimal(2);
					r.isGet = EnumParser.parse(IsPass.class, res.getString(3));
					r.getTime = res.getTimestamp(4);
					r.getBounsTime = res.getTimestamp(5);
					r.redPacketNum = res.getInt(6);
					r.redPacketMoney = res.getBigDecimal(7);
					r.jqje = res.getBigDecimal(8);
					if(r.isGet.equals(IsPass.F)){
						if(r.money.compareTo(new BigDecimal(5000))>=0 && r.money.compareTo(new BigDecimal(10000))<0){
							r.redPacketNum = 5;
							r.redPacketMoney = new BigDecimal(0.8);
							r.treeMoney = r.jqje.multiply(new BigDecimal(0.01)).setScale(2, BigDecimal.ROUND_HALF_DOWN);
						}else if(r.money.compareTo(new BigDecimal(10000))>=0 && r.money.compareTo(new BigDecimal(20000))<0){
							r.redPacketNum = 10;
							r.redPacketMoney = new BigDecimal(1);
							r.treeMoney = r.jqje.multiply(new BigDecimal(0.012)).setScale(2, BigDecimal.ROUND_HALF_DOWN);
						}else if(r.money.compareTo(new BigDecimal(20000))>=0 && r.money.compareTo(new BigDecimal(50000))<0){
							r.redPacketNum = 20;
							r.redPacketMoney = new BigDecimal(1.66);
							r.treeMoney = r.jqje.multiply(new BigDecimal(0.015)).setScale(2, BigDecimal.ROUND_HALF_DOWN);
						}else if(r.money.compareTo(new BigDecimal(50000))>=0 && r.money.compareTo(new BigDecimal(100000))<0){
							r.redPacketNum = 30;
							r.redPacketMoney = new BigDecimal(2.78);
							r.treeMoney = r.jqje.multiply(new BigDecimal(0.02)).setScale(2, BigDecimal.ROUND_HALF_DOWN);
						}else if(r.money.compareTo(new BigDecimal(100000))>=0 && r.money.compareTo(new BigDecimal(500000))<0){
							r.redPacketNum = 50;
							r.redPacketMoney = new BigDecimal(4.17);
							r.treeMoney = r.jqje.multiply(new BigDecimal(0.025)).setScale(2, BigDecimal.ROUND_HALF_DOWN);
						}else if(r.money.compareTo(new BigDecimal(500000))>=0){
							r.redPacketNum = 80;
							r.redPacketMoney = new BigDecimal(15.63);
							r.treeMoney = r.jqje.multiply(new BigDecimal(0.03)).setScale(2, BigDecimal.ROUND_HALF_DOWN);
						}
					}
				}
				return r;
			}
		}, " SELECT F02,F03,F04,F05,F06,F07,F08,F09 FROM T7052_11  WHERE F01 = ? ", serviceResource.getSession().getAccountId());
	}

	@Override
	public RedPacket[] getRedPacketList(int id) throws Throwable {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT (SELECT F02 FROM S60.T6010 WHERE F01 = B.F03) YHM,(SELECT F08 FROM T7052_11 WHERE F01=B.F02) money,F04 FROM T7052_12 B WHERE B.F02=? AND F04 IS NOT NULL");
		return selectAll(getConnection(FrontConst.DB_CONSOLE), new ArrayParser<RedPacket>() {
			@Override
			public RedPacket[] parse(ResultSet res)
					throws SQLException {
				List<RedPacket> list = new ArrayList<RedPacket>();
				while(res.next()){
					RedPacket r = new RedPacket();
					r.userName = res.getString(1);
					r.redPacketMoney = res.getBigDecimal(2);
					r.getTime = res.getTimestamp(3);
					list.add(r);
				}
				return list.toArray(new RedPacket[list.size()]);
			}
		}, sb.toString(), id);
	}

	@Override
	public void getRedPacket(int id, int userid) throws Throwable {
		serviceResource.openTransactions();
		try {
			
			int hdId = 7;// 活动ID
			Timestamp startTime = null;// 活动开始时间
			Timestamp endTime = null;// 活动结束时间
			try (Connection con = getConnection(FrontConst.DB_CONSOLE)) {
				// 锁T7046活动表
				String sql = "SELECT * FROM T7046 WHERE F01 = ? FOR UPDATE";
				execute(con, sql, hdId);
				// 查询活动
				String sqlOne = "SELECT F03,F04 FROM T7046 WHERE F01=?";
				try (PreparedStatement ps = con.prepareStatement(sqlOne)) {
					ps.setInt(1, hdId);
					try (ResultSet rs = ps.executeQuery()) {
						if (rs.next()) {
							startTime = rs.getTimestamp(1);
							endTime = rs.getTimestamp(2);
						}
					}
				}
			}
			// 如果活动起止时间为空，return
			if (startTime == null || endTime == null) {
				return;
			}
			// 当前时间
			Timestamp currTime = new Timestamp(System.currentTimeMillis());
			// 判断活动时间是否小于当前时间
			if (startTime.after(currTime)) {
				return;
			}
			if ( endTime.before(currTime)) {
				return;
			}
			
			int count = selectInt(FrontConst.DB_CONSOLE, "SELECT F03 FROM T7052_12 WHERE F03=? LIMIT 1", userid);
			if(count>0){
				serviceResource.rollback();
				return;
			}
			
			RedPacket p = select(getConnection(FrontConst.DB_CONSOLE), new ItemParser<RedPacket>() {
				@Override
				public RedPacket parse(ResultSet res)
						throws SQLException {
					RedPacket r = new RedPacket();
					if(res.next()){
						r.money = res.getBigDecimal(1);
						r.treeMoney = res.getBigDecimal(2);
						r.isGet = EnumParser.parse(IsPass.class, res.getString(3));
						r.getTime = res.getTimestamp(4);
						r.getBounsTime = res.getTimestamp(5);
						r.redPacketNum = res.getInt(6);
						r.redPacketMoney = res.getBigDecimal(7);
						r.jqje = res.getBigDecimal(8);
					}
					return r;
				}
			}, " SELECT F02,F03,F04,F05,F06,F07,F08,F09 FROM T7052_11  WHERE F01 = ? FOR UPDATE ", id);
			
			if(p.redPacketNum<=0){
				String T7052_12 = "INSERT INTO T7052_12 SET F02=?,F03=?";
				insert(getConnection(FrontConst.DB_CONSOLE), T7052_12, id,userid);
				return;
			}
			
			String yecx = " SELECT F03 FROM T6023 WHERE F01=? FOR UPDATE ";
			String sql_it_T6032 = "INSERT INTO T6032 SET F02=?,F03=?,F04=CURRENT_TIMESTAMP(),F05=?,F06=?,F07=?,F08=?,F09=?";
			String sql_ut_T6023 = " UPDATE T6023 SET F05=F05+?,F03=F03+? WHERE F01=? ";
			String sql_pt_T7026 = " INSERT INTO T7026 SET F02=CURRENT_TIMESTAMP(),F03=?,F04=?,F05=?,F06=?,F07=?,F08=?,F09=?";
			String sql_pzj = " SELECT F01 FROM T7025 FOR UPDATE";
			String sql_pt_T7025 = " UPDATE T7025 SET F01=F01-?,F02=F02+?,F03=F03-?,F04=F04-?,F05=CURRENT_TIMESTAMP()";
			String T7052_12 = "INSERT INTO T7052_12 SET F02=?,F03=?,F04=CURRENT_TIMESTAMP()";
			
			//给当前用户添加金额
			execute(getConnection(FrontConst.DB_USER), sql_ut_T6023, p.redPacketMoney,
					p.redPacketMoney, userid);
			//添加当前用户资金流水
			BigDecimal new_zhye = yhye(yecx,userid);
			execute(getConnection(FrontConst.DB_USER), sql_it_T6032, userid,TradingType.HDJL, p.redPacketMoney, 0, new_zhye, userid, "疯狂摇钱树活动红包");
			
			String _tzr_znx = "恭喜您，获得"+p.redPacketMoney+"元现金红包！红包已到账，请前往个人中心查收。";
			sendLetter(userid, "疯狂摇钱树活动", _tzr_znx);
			
			//扣除平台资金
			execute(getConnection(FrontConst.DB_CONSOLE),
					sql_pt_T7025, p.redPacketMoney, p.redPacketMoney, 0, p.redPacketMoney);
			//扣除平台资金流水
			BigDecimal _ptzj = ptye(sql_pzj);
			execute(getConnection(FrontConst.DB_CONSOLE),sql_pt_T7026, 0, p.redPacketMoney, _ptzj,
					PlatformFundType.HDFY, "疯狂摇钱树活动红包",
					userid, userid);
			
			if(p.redPacketNum == 1){
				//红包领完
				execute(getConnection(FrontConst.DB_CONSOLE), "UPDATE T7052_11 SET F07=F07-1,F04='S' WHERE F01=? ", id);
				
				//添加金额
				execute(getConnection(FrontConst.DB_USER), sql_ut_T6023, p.treeMoney,
						p.treeMoney, id);
				
				BigDecimal _new_zhye = yhye(yecx,id);
				//添加资金流水
				execute(getConnection(FrontConst.DB_USER), sql_it_T6032, id,TradingType.HDJL, p.treeMoney, 0, _new_zhye, id, "疯狂摇钱树活动现金");
				// 投资用户站内信
				String tzr_znx = "恭喜您，您的摇钱树收获"+p.treeMoney+"元现金奖励，现金已到账，请前往个人中心查收。";
				sendLetter(id, "疯狂摇钱树活动", tzr_znx);
				
				
				//扣除平台资金
				execute(getConnection(FrontConst.DB_CONSOLE),
						sql_pt_T7025, p.treeMoney, p.treeMoney, 0, p.treeMoney);
				
				//添加平台资金流水
				BigDecimal ptzj = ptye(sql_pzj);
				execute(getConnection(FrontConst.DB_CONSOLE),sql_pt_T7026, 0, p.treeMoney, ptzj,
						PlatformFundType.HDFY, "疯狂摇钱树活动现金",
						id, id);
				
			}else{
				execute(getConnection(FrontConst.DB_CONSOLE), "UPDATE T7052_11 SET F07=F07-1 WHERE F01=? ", id);
			}
			
			insert(getConnection(FrontConst.DB_CONSOLE), T7052_12, id,userid);
		} catch (Throwable e) {
			serviceResource.rollback();
			throw new LogicalException("参数错误");
		}
	}
	
	
	private BigDecimal yhye(String sql, int id) throws SQLException {
		// 借款人帐户余额
		return select(getConnection(FrontConst.DB_USER),
				new ItemParser<BigDecimal>() {
					@Override
					public BigDecimal parse(ResultSet res) throws SQLException {
						if (res.next()) {
							return res.getBigDecimal(1);
						} else {
							return new BigDecimal("0");
						}
					}
				}, sql, id);
	}
	
	private BigDecimal ptye(String sql_pt) throws SQLException {
		// 平台帐户额
		return select(getConnection(FrontConst.DB_CONSOLE),
				new ItemParser<BigDecimal>() {
					@Override
					public BigDecimal parse(ResultSet res) throws SQLException {
						if (res.next()) {
							return res.getBigDecimal(1);
						} else {
							return new BigDecimal("0");
						}
					}
				}, sql_pt);
	}

	@Override
	public void putRedPacket() throws Throwable {
		execute(getConnection(FrontConst.DB_CONSOLE), "UPDATE T7052_12 SET F05='S' WHERE F03=? ", serviceResource.getSession().getAccountId());
	}

	@Override
	public RedPacket getRedPacketContent() throws Throwable {
		return select(getConnection(FrontConst.DB_CONSOLE), new ItemParser<RedPacket>() {
			@Override
			public RedPacket parse(ResultSet res)
					throws SQLException {
				RedPacket r = new RedPacket();
				if(res.next()){
					r.isGet = EnumParser.parse(IsPass.class, res.getString(1));
					r.getTime = res.getTimestamp(2);
					r.redPacketMoney = res.getBigDecimal(3);
				}
				return r;
			}
		}, " SELECT A.F05,A.F04,B.F08 FROM T7052_12 A LEFT JOIN T7052_11 B  ON A.F02 = B.F01 WHERE A.F03=? ", serviceResource.getSession().getAccountId());
	}

	@Override
	public boolean isEnd(int id) throws Throwable {
		int hdId = id;// 活动ID
		Timestamp startTime = null;// 活动开始时间
		Timestamp endTime = null;// 活动结束时间
		try (Connection con = getConnection(FrontConst.DB_CONSOLE)) {
			// 锁T7046活动表
			String sql = "SELECT * FROM T7046 WHERE F01 = ? FOR UPDATE";
			execute(con, sql, hdId);
			// 查询活动
			String sqlOne = "SELECT F03,F04 FROM T7046 WHERE F01=?";
			try (PreparedStatement ps = con.prepareStatement(sqlOne)) {
				ps.setInt(1, hdId);
				try (ResultSet rs = ps.executeQuery()) {
					if (rs.next()) {
						startTime = rs.getTimestamp(1);
						endTime = rs.getTimestamp(2);
					}
				}
			}
		}
		// 如果活动起止时间为空，return
		if (startTime == null || endTime == null) {
			return false;
		}
		// 当前时间
		Timestamp currTime = new Timestamp(System.currentTimeMillis());
		// 判断活动时间是否小于当前时间
		if (startTime.after(currTime)) {
			return false;
		}
		if ( endTime.before(currTime)) {
			return false;
		}
		return true;
	}

	@Override
	public RedPacket[] getRedPacketList() throws Throwable {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT (SELECT F02 FROM S60.T6010 WHERE F01 = B.F01) YHM,F03  money,F05 FROM T7052_11 B WHERE F04='S' ");
		return selectAll(getConnection(FrontConst.DB_CONSOLE), new ArrayParser<RedPacket>() {
			@Override
			public RedPacket[] parse(ResultSet res)
					throws SQLException {
				List<RedPacket> list = new ArrayList<RedPacket>();
				while(res.next()){
					RedPacket r = new RedPacket();
					r.userName = res.getString(1);
					r.redPacketMoney = res.getBigDecimal(2);
					r.getTime = res.getTimestamp(3);
					list.add(r);
				}
				return list.toArray(new RedPacket[list.size()]);
			}
		}, sb.toString());
	}
	
	
	
	
}
