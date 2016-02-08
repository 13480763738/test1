package com.jiudian.p2p.front.service.common.achieve;

import java.math.BigDecimal;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.regex.Pattern;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.codec.digest.UnixCrypt;

import com.jiudian.framework.config.ConfigureProvider;
import com.jiudian.framework.config.Envionment;
import com.jiudian.framework.http.session.authentication.AuthenticationException;
import com.jiudian.framework.service.ServiceFactory;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.framework.service.exception.LogicalException;
import com.jiudian.framework.service.exception.ParameterException;
import com.jiudian.framework.service.query.ItemParser;
import com.jiudian.p2p.common.enums.AttestationType;
import com.jiudian.p2p.common.enums.ExperienceGoldStatus;
import com.jiudian.p2p.common.enums.IsPass;
import com.jiudian.p2p.common.enums.LetterStatus;
import com.jiudian.p2p.common.enums.LoginStatus;
import com.jiudian.p2p.common.enums.PlatformFundType;
import com.jiudian.p2p.common.enums.TradingType;
import com.jiudian.p2p.common.enums.UserSourceStatus;
import com.jiudian.p2p.common.enums.UserState;
import com.jiudian.p2p.front.config.FrontConst;
import com.jiudian.p2p.front.service.activity.entity.UserVo;
import com.jiudian.p2p.front.service.common.UserManage;
import com.jiudian.p2p.front.service.common.entity.UserInsert;
import com.jiudian.p2p.front.service.financing.entity.ExperiencePlan;
import com.jiudian.p2p.variables.P2PConst;
import com.jiudian.p2p.variables.defines.LetterVariable;
import com.jiudian.p2p.variables.defines.SystemVariable;
import com.jiudian.util.Formater;
import com.jiudian.util.StringHelper;
import com.jiudian.util.parser.DateParser;
import com.jiudian.util.parser.EnumParser;
import com.jiudian.util.parser.IntegerParser;

public class UserManageImpl extends AbstractCommonService implements UserManage {

	public static class UserManageFactory implements ServiceFactory<UserManage> {

		@Override
		public UserManage newInstance(ServiceResource serviceResource) {
			return new UserManageImpl(serviceResource);
		}
	}

	public UserManageImpl(ServiceResource serviceResource) {
		super(serviceResource);
	}

	@Override
	public int addUser(UserInsert user) throws Throwable {
		serviceResource.openTransactions();
		/**
		 * 用户账号表
		 */
		String t6010 = "INSERT INTO T6010 SET F02=?,F03=?,F06=?,F07=?,F04=?,F11=?";
		/**
		 * 用户基础信息表
		 */
		String t6011 = "INSERT INTO T6011 SET F01=?,F10=?,F11=?,F12=?,F15=?,F02=?";
		/**
		 * 用户家庭信息表
		 */
		String t6012 = "INSERT INTO T6012 SET F01=?";
		/**
		 * 用户工作信息表
		 */
		String t6013 = "INSERT INTO T6013 SET F01=?";
		/**
		 * 用户公司信息表
		 */
		String t6014 = "INSERT INTO T6014 SET F01=?";
		/**
		 * 用户资产信息表
		 */
		String t6015 = "INSERT INTO T6015 SET F01=?";
		/**
		 * 用户其他信息表
		 */
		String t6016 = "INSERT INTO T6016 SET F01=?";

		/**
		 * 用户认证状态
		 */
		String t6017 = "INSERT INTO T6017 SET F01=?,F02=?";
		/**
		 * 用户信用积分表
		 */
		String t6021 = "INSERT INTO T6021 SET F01=?";
		/**
		 * 用户账号信息表
		 */
		String t6023 = "INSERT INTO T6023 SET F01=?,F03=?,F04=?,F05=?";
		/**
		 * 发站内信
		 */
		String t6035 = "INSERT INTO T6035 SET F02=?,F03=?,F04=?,F05=?,F06=?";
		/**
		 * 用户信用档案表
		 */
		String t6045 = "INSERT INTO T6045 SET F01=?";
		/**
		 * 债权统计表用
		 */
		String t6025 = "INSERT INTO T6025 SET F01=?";
		/**
		 * 理财体验统计表
		 */
		String t6026 = "INSERT INTO T6026 SET F01=?";
		/**
		 * 债权转让统计表
		 */
		String t6027 = "INSERT INTO T6027 SET F01=?";
		/**
		 * 我的借款统计表
		 */
		String t6029 = "INSERT INTO T6029 SET F01=?";
		/**
		 * 站内信内容
		 */
		String t6046 = "INSERT INTO T6046 SET F01=?,F02=?";
		/**
		 * 推广统计
		 */
		String t6053 = "INSERT INTO T6053 SET F01=?";
		/**
		 * 首次充值奖励
		 */
		String t6054 = "INSERT INTO T6054 SET F02=?,F03=?";
		if (user == null) {
			throw new ParameterException("参数不合法.");
		}
		if (isAccountExists(user.getAccountName())) {
			throw new LogicalException("该用户名已存在，请输入其他用户名.");
		}
		String phone = user.getPhone();
		if (StringHelper.isEmpty(phone)) {
			throw new LogicalException("手机号码不合法.");
		}
		if (isPhone(phone)) {
			throw new LogicalException("手机号码已存在.");
		}
		// 查询服务码
		String selectT6011 = "SELECT F11 FROM T6011";
		String myCode = getCode();
		String code = user.getCode();
		boolean isExists = false;
		try (Connection connection = getConnection(FrontConst.DB_USER)) {
			try (PreparedStatement ps = connection
					.prepareStatement(selectT6011)) {
				try (ResultSet rs = ps.executeQuery()) {
					while (rs.next()) {
						String s = rs.getString(1);
						if (!StringHelper.isEmpty(s) && s.equals(code)) {
							isExists = true;
						}
						if (!StringHelper.isEmpty(s) && s.equals(myCode)) {
							myCode = getCode();
						}
					}
				}
			}
		}
		if (!isExists) {
			code = "";
		}
		Connection connection = getConnection(FrontConst.DB_USER);
		String password = UnixCrypt.crypt(user.getPassword(),
				DigestUtils.sha256Hex(user.getPassword()));
		Timestamp now = new Timestamp(System.currentTimeMillis());

		UserSourceStatus stas = user.getUserSourceStatus();

		if (stas == null) {
			stas = UserSourceStatus.ZC;
		}

		int userId = insert(connection, t6010, user.getAccountName(), password,
				UserState.ZC, stas, phone, user.getXgmim());
		execute(connection, t6011, userId, code, myCode, now, user.getType(),
				phone);
		execute(connection, t6012, userId);
		execute(connection, t6013, userId);
		execute(connection, t6014, userId);
		execute(connection, t6015, userId);
		execute(connection, t6016, userId);
		for (AttestationType type : AttestationType.values()) {
			execute(connection, t6017, userId, type);
		}
		execute(connection, t6021, userId);
		execute(connection, t6023, userId, 0, 0, 0);
		execute(connection, t6045, userId);
		execute(connection, t6025, userId);
		execute(connection, t6026, userId);
		execute(connection, t6027, userId);
		execute(connection, t6029, userId);
		execute(connection, t6053, userId);
		ConfigureProvider configureProvider = serviceResource
				.getResource(ConfigureProvider.class);
		String template = configureProvider
				.getProperty(LetterVariable.REGESTER_SUCCESS);
		Envionment envionment = configureProvider.createEnvionment();
		envionment.set("name", user.getAccountName());
		int letterId = insert(connection, t6035, now, "注册成功", "", userId,
				LetterStatus.WD);
		execute(connection, t6046, letterId,
				StringHelper.format(template, envionment));
		int id = getIdByCode(code);
		if (id > 0) {
			String update = "INSERT INTO T6053(F01,F02) VALUES(?,?) ON DUPLICATE KEY UPDATE F02=F02+VALUES(F02)";
			execute(connection, update, id, 1);
			execute(connection, t6054, id, userId);

			// 添加推广注册奖励表记录
			String insertT6053_1 = "INSERT INTO t6053_1 SET F02=?,F03=?,F04=?,F05=?,F06=CURRENT_TIMESTAMP() ON DUPLICATE KEY UPDATE F04=?,F05=?,F03=?";
			insert(getConnection(P2PConst.DB_USER), insertT6053_1, id, userId,
					0, 0, 0, 0, userId);
		}

		return userId;
	}

	/**
	 * 注册成功按推广奖励 改到实名认证后才发放奖励
	 * 
	 * @param userid
	 * @param code
	 *            邀请码
	 * @throws Throwable
	 */
	@SuppressWarnings("unused")
	// 改到实名认证后才发放奖励
	private void zctgjl(int userId, String code) throws Throwable {
		if (userId > 0) {// 注册成功
			final ConfigureProvider config = serviceResource
					.getResource(ConfigureProvider.class);
			String sfqy = config.get(SystemVariable.TG_SFQY.getKey());

			int tgr_id = 0;// 推广人ID
			BigDecimal zcjl_tyj = new BigDecimal(0);// 注册奖励金额(体验金)
			BigDecimal zcjl_xj = new BigDecimal(0);// 注册奖励金额(现金)

			try (Connection con = getConnection(FrontConst.DB_USER)) {
				String sql = "SELECT t6011.F01,t6011_2.F08,t6011_2.F09 FROM t6011,t6011_2 WHERE t6011.F35 = t6011_2.F01 AND t6011.F11 = ?";
				try (PreparedStatement ps = con.prepareStatement(sql)) {
					ps.setString(1, code);
					try (ResultSet rs = ps.executeQuery()) {
						if (rs.next()) {
							tgr_id = rs.getInt(1);
							zcjl_tyj = rs.getBigDecimal(2);
							zcjl_xj = rs.getBigDecimal(3);
						}
					}
				}
			}

			if (tgr_id == 0) {
				return;
			}

			// 判断推广人是否可以获取发布的推广奖励
			String s = "SELECT COUNT(*) FROM T7053,T7054 WHERE T7053.F01 = T7054.F02 AND T7053.F04=? AND T7054.F01=?";
			int icount = selectInt(FrontConst.DB_CONSOLE, s, IsPass.F.name(),
					tgr_id);
			if (icount > 0) {// 是业务员不获取奖励
				// return;
				zcjl_tyj = new BigDecimal(0);
				zcjl_xj = new BigDecimal(0);
			}

			// 不启用则做
			if (!"true".equals(sfqy.toLowerCase().trim())) {
				// return;
				zcjl_tyj = new BigDecimal(0);
				zcjl_xj = new BigDecimal(0);
			}

			// 添加推广注册奖励表记录
			String insertT6053_1 = "INSERT INTO t6053_1 SET F02=?,F03=?,F04=?,F05=?,F06=CURRENT_TIMESTAMP() ON DUPLICATE KEY UPDATE F04=?,F05=?";
			insert(getConnection(FrontConst.DB_USER), insertT6053_1, tgr_id,
					userId, zcjl_tyj, zcjl_xj, zcjl_tyj, zcjl_xj);

			// 更新推广统计记录
			String updateT6053 = "INSERT INTO T6053 SET F01=?,F05=?,F06=? ON DUPLICATE KEY UPDATE F05=F05+?,F06=F06+?";
			execute(getConnection(FrontConst.DB_USER), updateT6053, tgr_id,
					zcjl_xj, zcjl_tyj, zcjl_xj, zcjl_tyj);

			if (zcjl_xj.compareTo(new BigDecimal(0)) > 0
					|| zcjl_tyj.compareTo(new BigDecimal(0)) > 0) {
				// 推广人奖励站内信
				sendTzrTg(tgr_id, zcjl_tyj, zcjl_xj);
			}

			// 奖励体验金
			if (zcjl_tyj.compareTo(new BigDecimal(0)) > 0) {
				int hdid = 17;// 推广注册奖励ID(确保有)

				String qh = createUUID(8);
				String insertT7051 = "INSERT INTO t7051 SET F01=?,F02=?,F03=CURRENT_TIMESTAMP(),F04=CURRENT_TIMESTAMP(),F05=ADDDATE(CURRENT_TIMESTAMP(),30),F06=?,F07=?,F08=CURRENT_TIMESTAMP(),F11=?";
				insert(getConnection(FrontConst.DB_CONSOLE), insertT7051, qh,
						hdid, zcjl_tyj, tgr_id, ExperienceGoldStatus.YLY);
			}

			// 奖励现金
			if (zcjl_xj.compareTo(new BigDecimal(0)) > 0) {
				// 添加推广人金额
				String updateT6023 = "UPDATE T6023 SET F03=F03+?,F05=F05+? WHERE F01=?";
				execute(getConnection(FrontConst.DB_USER), updateT6023,
						zcjl_xj, zcjl_xj, tgr_id);
				// 取推广人账户余额
				BigDecimal acountAmount = selectBigDecimal(P2PConst.DB_USER,
						"SELECT F03 FROM T6023 WHERE F01 = ?", tgr_id);
				// 插入推广人资金流水
				String insertT6032 = "INSERT INTO T6032 SET F02=?,F03=?,F04=?,F05=?,F07=?,F08=?,F09=?";
				execute(getConnection(FrontConst.DB_USER), insertT6032, tgr_id,
						TradingType.CXTGJL,
						new Timestamp(System.currentTimeMillis()), zcjl_xj,
						acountAmount, userId, "推广注册奖励");

				// 扣除平台账号金额
				String updateT7025 = "UPDATE T7025 SET F01=F01-?,F02=F02+?,F04=F04-?";
				execute(getConnection(FrontConst.DB_CONSOLE), updateT7025,
						zcjl_xj, zcjl_xj, zcjl_xj);
				String insertT7026 = "INSERT INTO T7026 SET F02=?,F04=?,F05=?,F06=?,F07=?,F08=?,F09=?";
				String selectT7025 = "SELECT F01 FROM T7025";
				BigDecimal ptTotalAmount = selectBigDecimal(
						FrontConst.DB_CONSOLE, selectT7025);
				execute(getConnection(FrontConst.DB_CONSOLE), insertT7026,
						new Timestamp(System.currentTimeMillis()), zcjl_xj,
						ptTotalAmount, PlatformFundType.TGCXJL, "推广注册奖励",
						userId, tgr_id);
			}
		}

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
	 * 投资人推广奖励站内信
	 * 
	 * @param id
	 * @throws Throwable
	 */
	private void sendTzrTg(int userId, BigDecimal tyj, BigDecimal xj)
			throws Throwable {
		ConfigureProvider configureProvider = serviceResource
				.getResource(ConfigureProvider.class);
		String template = configureProvider.getProperty(LetterVariable.TG_ZCJL);
		Timestamp now = new Timestamp(System.currentTimeMillis());
		Envionment envionment = configureProvider.createEnvionment();
		envionment.set("tyj", Formater.formatAmount(tyj));
		envionment.set("xj", Formater.formatAmount(xj));
		int letterId = insert(getConnection(FrontConst.DB_USER), t6035, now,
				LetterVariable.TG_ZCJL.getDescription(), "", userId,
				LetterStatus.WD);
		execute(getConnection(FrontConst.DB_USER), t6046, letterId,
				StringHelper.format(template, envionment));
	}

	/**
	 * 2014中秋活动体验金
	 */
	public void activity_1() throws Throwable {
		int userId = serviceResource.getSession().getAccountId();
		int hdId = 1;// 活动ID
		BigDecimal[] mz = { new BigDecimal(1000), new BigDecimal(2000),
				new BigDecimal(3000), new BigDecimal(100000) };// 面值
		int t_1000 = 1;// 1000体验金ID
		int t_2000 = 2;// 2000体验金ID
		int t_3000 = 3;// 3000体验金ID
		int t_100000 = 4;// 100000体验金ID
		Timestamp startTime = null;// 活动开始时间
		Timestamp endTime = null;// 活动结束时间

		try (Connection con = getConnection(FrontConst.DB_CONSOLE)) {
			// 查询活动
			String sqlOne = "SELECT F03,F04 FROM T7046 WHERE F01=? FOR UPDATE";
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
		// 参与人数加一
		execute(getConnection(FrontConst.DB_CONSOLE),
				"UPDATE T7046 SET F08=F08+1 WHERE F01=?", hdId);
		// 当前时间
		Timestamp currTime = new Timestamp(System.currentTimeMillis());
		// 判断活动时间是否小于当前时间
		if (startTime.after(currTime) || endTime.before(currTime)) {
			return;
		}

		int qiHao = 0;// 期号
		String qh = null;// 券号
		int yu = userId % 10;

		if (yu == 6) {
			qiHao = t_2000;
			qh = getQh(qiHao);
		}
		if (yu == 8) {
			qiHao = t_3000;
			qh = getQh(qiHao);
		}

		if (userId == 6888) {
			qiHao = t_100000;
			qh = getQh(qiHao);
		}

		if (qh == null) {
			qiHao = t_1000;
			qh = getQh(qiHao);
		}

		try (Connection con = getConnection(FrontConst.DB_CONSOLE)) {
			if (qh == null) {
				return;
			} else {
				String s = "SELECT F01 FROM T7051 WHERE F01 = ? FOR UPDATE";
				execute(con, s, qh);
				addTqj(qh, userId);
			}
		}
		// 受益人数加一
		execute(getConnection(FrontConst.DB_CONSOLE),
				"UPDATE T7046 SET F09=F09+? WHERE F01=?", 1, hdId);
		// 添加活动参与列表
		execute(getConnection(FrontConst.DB_CONSOLE),
				"INSERT INTO T7047 SET F02=?,F03=?,F04=?,F05=?,F06=?", hdId,
				userId, mz[qiHao - 1], IsPass.S, currTime);
		// 发站内信
		sendLetter(userId, mz[qiHao - 1], endTime);
	}

	/**
	 * 2014巡查员制活动体验金,注册送500
	 */
	public void activity_4() throws Throwable {
		int userId = serviceResource.getSession().getAccountId();
		int hdId = 4;// 活动ID
		Timestamp startTime = null;// 活动开始时间
		Timestamp endTime = null;// 活动结束时间

		try (Connection con = getConnection(FrontConst.DB_CONSOLE)) {
			// 查询活动
			String sqlOne = "SELECT F03,F04 FROM T7046 WHERE F01=? FOR UPDATE";
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
		if (startTime.after(currTime) || endTime.before(currTime)) {
			return;
		}

		// 参与人数加一
		execute(getConnection(FrontConst.DB_CONSOLE),
				"UPDATE T7046 SET F08=F08+1 WHERE F01=?", hdId);

		int hdid = 17;// 注册奖励ID(确保有)
		BigDecimal amt = new BigDecimal(500);

		String qh = createUUID(8);
		String insertT7051 = "INSERT INTO t7051 SET F01=?,F02=?,F03=CURRENT_TIMESTAMP(),F04=CURRENT_TIMESTAMP(),F05=ADDDATE(CURRENT_TIMESTAMP(),30),F06=?,F07=?,F08=CURRENT_TIMESTAMP(),F11=?";
		insert(getConnection(FrontConst.DB_CONSOLE), insertT7051, qh, hdid,
				amt, userId, ExperienceGoldStatus.YLY);

		// 受益人数加一
		execute(getConnection(FrontConst.DB_CONSOLE),
				"UPDATE T7046 SET F09=F09+? WHERE F01=?", 1, hdId);
		// 添加活动参与列表
		execute(getConnection(FrontConst.DB_CONSOLE),
				"INSERT INTO T7047 SET F02=?,F03=?,F04=?,F05=?,F06=?", hdId,
				userId, amt, IsPass.S, currTime);
		// 发站内信
		sendLetter(userId, amt, endTime);
	}

	/**
	 * 获取体验券密码
	 * 
	 * @param qiHao
	 * @return
	 * @throws Throwable
	 */
	private String getQh(int qiHao) throws Throwable {
		String qh = null;
		try (Connection con = getConnection(FrontConst.DB_CONSOLE)) {
			String sql = "SELECT F01 FROM T7051 WHERE F02=? AND F11=?";
			try (PreparedStatement ps = con.prepareStatement(sql)) {
				ps.setInt(1, qiHao);
				ps.setString(2, ExperienceGoldStatus.WLY.name());
				try (ResultSet rs = ps.executeQuery()) {
					if (rs.next()) {
						qh = rs.getString(1);
					}
				}
			}
		}
		return qh;
	}

	/**
	 * 发站内信
	 */
	private static final String t6035 = "INSERT INTO T6035 SET F02=?,F03=?,F04=?,F05=?,F06=?";
	/**
	 * 站内信内容
	 */
	private static final String t6046 = "INSERT INTO T6046 SET F01=?,F02=?";

	/**
	 * 发站内信
	 * 
	 * @param id
	 *            用户编号
	 * @param amount
	 *            钱
	 * @throws SQLException
	 */
	private void sendLetter(int id, BigDecimal amount, Timestamp yxTime)
			throws SQLException {
		ConfigureProvider configureProvider = serviceResource
				.getResource(ConfigureProvider.class);
		String template = configureProvider.getProperty(LetterVariable.ACT_1);
		Timestamp now = new Timestamp(System.currentTimeMillis());
		Envionment envionment = configureProvider.createEnvionment();
		envionment.set("date", DateParser.format(yxTime));
		envionment.set("amount", Formater.formatAmount(amount));
		int letterId = insert(getConnection(P2PConst.DB_USER), t6035, now,
				LetterVariable.ACT_1.getDescription(), "", id, LetterStatus.WD);
		execute(getConnection(P2PConst.DB_USER), t6046, letterId,
				StringHelper.format(template, envionment));
	}

	/**
	 * 用户获取体验券
	 * 
	 * @param experienceNum
	 * @throws Throwable
	 */
	private void addTqj(String experienceNum, int userId) throws Throwable {

		if (StringHelper.isEmpty(experienceNum)) {
			throw new ParameterException("券号错误！");
		}
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
						}
						return ex;
					}
				},
				"SELECT F01,F11,F06 FROM T7051 WHERE F01=? AND DATEDIFF(F05,CURRENT_DATE())>=0 FOR UPDATE ",
				experienceNum);

		if (ex == null) {
			throw new ParameterException("券号错误！");
		} else {
			if (!ex.experienceGoldStatus.equals(ExperienceGoldStatus.WLY)) {
				throw new ParameterException("券号"
						+ ex.experienceGoldStatus.getName());
			}
		}

		// 判断用户是否可以领取
		final ConfigureProvider configureProvider = serviceResource
				.getResource(ConfigureProvider.class);
		// 距离上次领取的时间
		int dats = Integer.parseInt(configureProvider
				.format(SystemVariable.TYJ_LQ_DAY));

		if (select(
				getConnection(FrontConst.DB_CONSOLE),
				new ItemParser<Boolean>() {
					@Override
					public Boolean parse(ResultSet rs) throws SQLException {
						if (rs.next()) {
							int total = rs.getInt(1);
							if (total > 0) {
								return true;
							}
						}
						return false;
					}
				},
				" SELECT COUNT(F01) FROM T7051 WHERE F07=? AND (TO_DAYS(NOW())-TO_DAYS(F08)) < ? ",
				serviceResource.getSession().getAccountId(), dats)) {
			throw new ParameterException(" 您已获取过体验金，" + dats + "天内不能再次获取！");
		}

		// 用户领用
		execute(getConnection(FrontConst.DB_CONSOLE),
				" UPDATE T7051 SET F07=?,F08=now(),F11=? WHERE F01=? ", userId,
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
					"INSERT INTO T7049 SET F01=?,F02=?", userId, ex.amount);
		}

	}

	private int getIdByCode(String code) throws SQLException {
		if (StringHelper.isEmpty(code)) {
			return 0;
		}
		String sql = "SELECT F01 FROM T6011 WHERE F11=?";
		try (Connection connection = getConnection(FrontConst.DB_USER)) {
			try (PreparedStatement ps = connection.prepareStatement(sql)) {
				ps.setString(1, code);
				try (ResultSet rs = ps.executeQuery()) {
					if (rs.next()) {
						return rs.getInt(1);
					}
				}
			}
		}
		return 0;
	}

	@Override
	public boolean isAccountExists(String accountName) throws Throwable {
		String sql = "SELECT F01 FROM T6010 WHERE F02=?";
		try (PreparedStatement ps = getConnection(FrontConst.DB_USER)
				.prepareStatement(sql)) {
			ps.setString(1, accountName);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return true;
				}
			}
		}
		return false;
	}

	@Override
	public int getUnReadLetter() throws Throwable {
		String sql = "SELECT COUNT(*) FROM T6035 WHERE F05=? AND F06=?";
		return select(getConnection(FrontConst.DB_USER),
				new ItemParser<Integer>() {

					@Override
					public Integer parse(ResultSet resultSet)
							throws SQLException {
						if (resultSet.next()) {
							return resultSet.getInt(1);
						}
						return 0;
					}
				}, sql, serviceResource.getSession().getAccountId(),
				LetterStatus.WD);
	}

	@Override
	public String getAccountName() throws Throwable {
		try (Connection connection = getConnection(FrontConst.DB_USER)) {
			try (PreparedStatement pstmt = connection
					.prepareStatement("SELECT F02 FROM T6010 WHERE F01 = ?")) {
				pstmt.setInt(1, serviceResource.getSession().getAccountId());
				try (ResultSet resultSet = pstmt.executeQuery()) {
					if (resultSet.next()) {
						return resultSet.getString(1);
					}
					return null;
				}
			}
		}
	}

	@Override
	public int readAccountId(String condition, String password)
			throws AuthenticationException, SQLException {
		int accountId = 0;
		String sql = "SELECT F01,F03,F06 FROM T6010 WHERE F02=? OR F04=? OR F05=?";
		try (Connection connection = getConnection(FrontConst.DB_USER)) {
			try (PreparedStatement ps = connection.prepareStatement(sql)) {
				ps.setString(1, condition);
				ps.setString(2, condition);
				ps.setString(3, condition);
				try (ResultSet rs = ps.executeQuery()) {
					if (rs.next()) {
						accountId = rs.getInt(1);
						String pwd = rs.getString(2);
						String status = rs.getString(3);
						if ("SD".equals(status)) {
							throw new AuthenticationException("该帐号被锁定，禁止登录。");
						}
						if (!UnixCrypt.crypt(password,
								DigestUtils.sha256Hex(password)).equals(pwd)) {
							throw new AuthenticationException("用户名或密码错误.");
						}
					} else {
						throw new AuthenticationException("用户名或密码错误.");
					}
				}
			}
		}
		return accountId;
	}

	@Override
	public void log(int accountId, String ip) throws Throwable {
		String t6051 = "INSERT INTO T6051 SET F02=?,F03=?,F04=?,F05=?";
		String t6010 = "SELECT F02 FROM T6010 WHERE F01=?";
		String updateT6011 = "UPDATE T6011 SET F13=?,F14=? WHERE F01=?";
		Timestamp now = new Timestamp(System.currentTimeMillis());
		String name = "";
		try (Connection connection = getConnection(FrontConst.DB_USER)) {
			try (PreparedStatement ps = connection.prepareStatement(t6010)) {
				ps.setInt(1, accountId);
				try (ResultSet rs = ps.executeQuery()) {
					if (rs.next()) {
						name = rs.getString(1);
					}
				}
			}
			try (PreparedStatement ps = connection.prepareStatement(t6051)) {
				ps.setString(1, name);
				ps.setTimestamp(2, now);
				ps.setString(3, ip);
				ps.setString(4, accountId <= 0 ? LoginStatus.SB.name()
						: LoginStatus.CG.name());
				ps.execute();
			}
		}
		execute(getConnection(FrontConst.DB_USER), updateT6011, now, ip,
				accountId);
	}

	private String getCode() {
		char[] chs = { 'a', 'c', '3', '4', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
				'k', 'm', 'n', 'p', 'r', 't', 'u', 'v', 'w', 'x', 'y', '7', '8' };
		SecureRandom random = new SecureRandom();
		final char[] value = new char[6];
		for (int i = 0; i < 6; i++) {
			value[i] = (char) chs[random.nextInt(chs.length)];
		}
		final String code = new String(value);
		return code;
	}

	@Override
	public String getHeadphoto() throws Throwable {
		String photo = null;
		try (PreparedStatement ps = getConnection(FrontConst.DB_USER)
				.prepareStatement("SELECT F29 FROM T6011 WHERE F01=?")) {
			ps.setInt(1, serviceResource.getSession().getAccountId());
			try (ResultSet resultSet = ps.executeQuery()) {
				if (resultSet.next()) {
					photo = resultSet.getString(1);
				}
			}
		}
		return photo;
	}

	@Override
	public boolean isPhone(String idCard) throws Throwable {
		return select(getConnection(FrontConst.DB_USER),
				new ItemParser<Boolean>() {
					@Override
					public Boolean parse(ResultSet rs) throws SQLException {
						boolean is = false;
						if (rs.next()) {
							is = true;
						}
						return is;
					}
				}, "SELECT F01 FROM T6010 WHERE F04=?", idCard);
	}

	@Override
	public void updateSend(String phone, String code) throws Throwable {
		
		int count = selectInt(FrontConst.DB_USER, "SELECT COUNT(*) FROM T6058 WHERE F02=? AND DATE(F04) = CURRENT_DATE()", phone);
		ConfigureProvider conf = serviceResource.getResource(ConfigureProvider.class);
		int num = IntegerParser.parse(conf.format(SystemVariable.DX_RZCS));
		if(count >= num ){
			throw new ParameterException("您今天的请求次数超限!");
		}
		serviceResource.openTransactions();
		insert(getConnection(FrontConst.DB_USER),
				"INSERT INTO T6058 SET F02=?,F03=?,F04=NOW(),F05=NOW(),F06=? ",
				phone, code, "999999999");
	}

	@Override
	public int getSend(String phone) throws Throwable {
		return select(
				getConnection(FrontConst.DB_USER),
				new ItemParser<Integer>() {
					@Override
					public Integer parse(ResultSet rs) throws SQLException {
						int is = 0;
						if (rs.next()) {
							is = rs.getInt(1);
						}
						return is;
					}
				},
				"SELECT COUNT(F01) FROM T6058 WHERE F02=? AND DATE(F05) = CURRENT_DATE()",
				phone);
	}

	@Override
	public String getYqm() throws Throwable {
		String sql = "SELECT F11 FROM T6011 WHERE F01 = ?";
		return select(getConnection(FrontConst.DB_USER),
				new ItemParser<String>() {
					@Override
					public String parse(ResultSet resultSet)
							throws SQLException {
						String str = "";
						while (resultSet.next()) {
							str = resultSet.getString(1);
						}
						return str;
					}
				}, sql, serviceResource.getSession().getAccountId());
	}

	@Override
	public String getYqm(int id) throws Throwable {
		String sql = "SELECT F11 FROM T6011 WHERE F01 = ?";
		return select(getConnection(FrontConst.DB_USER),
				new ItemParser<String>() {
					@Override
					public String parse(ResultSet resultSet)
							throws SQLException {
						String str = "";
						while (resultSet.next()) {
							str = resultSet.getString(1);
						}
						return str;
					}
				}, sql, id);
	}

	@Override
	public String getNickName() throws Throwable {
		try (Connection connection = getConnection(FrontConst.DB_USER)) {
			try (PreparedStatement pstmt = connection
					.prepareStatement("SELECT F37 FROM T6011 WHERE F01 = ?")) {
				pstmt.setInt(1, serviceResource.getSession().getAccountId());
				try (ResultSet resultSet = pstmt.executeQuery()) {
					if (resultSet.next()) {
						return resultSet.getString(1);
					}
					return null;
				}
			}
		}
	}

	@Override
	public UserVo getUser() throws Throwable {
		return select(getConnection(FrontConst.DB_USER),
				new ItemParser<UserVo>() {
					@Override
					public UserVo parse(ResultSet res) throws SQLException {
						UserVo vo = new UserVo();
						if (res.next()) {
							vo.sjh = res.getString(1);
							vo.name = res.getString(2);
						}
						return vo;
					}
				}, "SELECT F02,F06 FROM T6011 WHERE F01=? ", serviceResource
						.getSession().getAccountId());
	}

	@Override
	public void activity_5() throws Throwable {
		int userId = serviceResource.getSession().getAccountId();
		int hdId = 6;// 活动ID
		Timestamp startTime = null;// 活动开始时间
		Timestamp endTime = null;// 活动结束时间

		try (Connection con = getConnection(FrontConst.DB_CONSOLE)) {
			// 查询活动
			String sqlOne = "SELECT F03,F04 FROM T7046 WHERE F01=? FOR UPDATE";
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
		if (startTime.after(currTime) || endTime.before(currTime)) {
			return;
		}

		// 参与人数加一
		BigDecimal amt = new BigDecimal(100);
		BigDecimal tze = new BigDecimal(0);

		insert(getConnection(FrontConst.DB_USER),
				"INSERT INTO T6068 SET F02=?,F03=?,F04=CURRENT_TIMESTAMP(),F07=?,F08=?",
				hdId, userId, amt, tze);

	}

	@Override
	public void addIdea(String idea,String lxfs) throws Throwable {
		int accountid = 0;

		if (serviceResource.getSession().isAuthenticated()) {
			accountid = serviceResource.getSession().getAccountId();
		}

		insert(getConnection(FrontConst.DB_USER),
				"insert into t6069 SET f02=?,f03=?,f04=CURRENT_TIMESTAMP(),f07=?",
				accountid, idea,lxfs);
	}

	@Override
	public void updatePassword(String password) throws Throwable {
		int acount = serviceResource.getSession().getAccountId();
		if (StringHelper.isEmpty(password) || acount <= 0) {
			throw new ParameterException("参数错误");
		}
		execute(getConnection(P2PConst.DB_USER),
				"UPDATE  T6010 SET F03=?,F11=? WHERE F01 = ?", password,
				IsPass.F, acount);

	}

	public IsPass sfxgmm() throws Throwable {
		int userId = serviceResource.getSession().getAccountId();
		String sql = "SELECT F11 FROM T6010 WHERE F01 = ?";
		return select(getConnection(FrontConst.DB_USER),
				new ItemParser<IsPass>() {
					@Override
					public IsPass parse(ResultSet resultSet)
							throws SQLException {
						IsPass str = IsPass.F;
						while (resultSet.next()) {
							str = EnumParser.parse(IsPass.class,
									resultSet.getString(1));
						}
						return str;
					}
				}, sql, userId);
	}
	
	public String getSign(String s1, String s2)
			throws Throwable{
		String sql="SELECT MD5(CONCAT(?,?)) ";
		String r = selectString(FrontConst.DB_USER, sql, s1,s2);
		if(StringHelper.isEmpty(r)){
		throw new ParameterException("参数错误");
		}
		return r;
		
	}
}
