package com.jiudian.p2p.front.service.financing.achieve;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.jiudian.framework.config.ConfigureProvider;
import com.jiudian.framework.config.Envionment;
import com.jiudian.framework.http.session.Session;
import com.jiudian.framework.http.session.authentication.AuthenticationException;
import com.jiudian.framework.http.session.authentication.VerifyCodeAuthentication;
import com.jiudian.framework.service.ServiceFactory;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.framework.service.exception.LogicalException;
import com.jiudian.framework.service.exception.ParameterException;
import com.jiudian.framework.service.query.ArrayParser;
import com.jiudian.framework.service.query.ItemParser;
import com.jiudian.framework.service.query.Paging;
import com.jiudian.framework.service.query.PagingResult;
import com.jiudian.p2p.common.enums.IsPass;
import com.jiudian.p2p.common.enums.LetterStatus;
import com.jiudian.p2p.common.enums.MzbHkzt;
import com.jiudian.p2p.common.enums.MzbJrlx;
import com.jiudian.p2p.common.enums.MzbSkzt;
import com.jiudian.p2p.common.enums.MzbStatus;
import com.jiudian.p2p.common.enums.OrganizationType;
import com.jiudian.p2p.common.enums.PlatformFundType;
import com.jiudian.p2p.common.enums.ShbType;
import com.jiudian.p2p.common.enums.TradingType;
import com.jiudian.p2p.front.config.FrontConst;
import com.jiudian.p2p.front.service.financing.MzbManage;
import com.jiudian.p2p.front.service.financing.entity.Bank;
import com.jiudian.p2p.front.service.financing.entity.ContractFileVo;
import com.jiudian.p2p.front.service.financing.entity.HfblxrVo;
import com.jiudian.p2p.front.service.financing.entity.Mzbjrjl;
import com.jiudian.p2p.front.service.financing.entity.MzbjsVo;
import com.jiudian.p2p.front.service.financing.entity.MzblistVo;
import com.jiudian.p2p.front.service.financing.entity.Mzbszfxx;
import com.jiudian.p2p.front.service.financing.entity.MzbtjVo;
import com.jiudian.p2p.front.service.financing.entity.MzbxmbxVo;
import com.jiudian.p2p.front.service.financing.entity.Mzbxq;
import com.jiudian.p2p.front.service.financing.entity.Tjvo;
import com.jiudian.p2p.front.service.financing.entity.XcyVo;
import com.jiudian.p2p.front.service.financing.query.HfblxrQuery;
import com.jiudian.p2p.front.service.financing.query.MzbjrQuery;
import com.jiudian.p2p.front.service.financing.query.MzbszfxxQuery;
import com.jiudian.p2p.variables.P2PConst;
import com.jiudian.p2p.variables.defines.LetterVariable;
import com.jiudian.p2p.variables.defines.SystemVariable;
import com.jiudian.util.Formater;
import com.jiudian.util.StringHelper;
import com.jiudian.util.parser.EnumParser;
import com.jiudian.util.parser.IntegerParser;
import com.jiudian.util.parser.TimestampParser;

public class MzbManageImpl extends AbstractFinancingManage implements MzbManage {

	public MzbManageImpl(ServiceResource serviceResource) {
		super(serviceResource);
	}

	public static class MzbManageImplFactory implements
			ServiceFactory<MzbManage> {
		@Override
		public MzbManage newInstance(ServiceResource serviceResource) {
			return new MzbManageImpl(serviceResource);
		}

	}

	@Override
	public MzbtjVo getMzbtj(int id, ShbType shbType) throws Throwable {
		ArrayList<Object> parameters = new ArrayList<>();
		StringBuffer sb = new StringBuffer("SELECT SUM(a.F04), ");
		sb.append("COUNT(a.F01)");
		sb.append(",(SELECT SUM(a.F07)  FROM T6063  a left join t6059 b on a.f02 = b.f01");
		sb.append(" where b.f21 = ?  group by b.f21 ");
		parameters.add(shbType);
		sb.append(" ),(SELECT SUM(a.F08) FROM T6062 a left join t6059 b on a.f02 = b.f01 where 1=1 ");
		if (id > 0) {
			sb.append(" AND a.F02 = ? ");
			parameters.add(id);
		}
		sb.append(" AND b.f21 = ?  group by b.f21 ");
		parameters.add(shbType);
		sb.append("),(SELECT SUM(a.F07) FROM T6063 a left join t6059 b on a.f02 = b.f01  ");
		sb.append("WHERE a.F11='YDK'");
		if (id > 0) {
			sb.append(" AND a.f02 = ? ");
			parameters.add(id);
		}
		sb.append(" AND b.f21 = ?  group by b.f21 ");
		parameters.add(shbType);
		sb.append(" ),(SELECT SUM(a.F08) FROM T6062 a left join t6059 b on a.f02 = b.f01 WHERE 1=1  ");
		if (id > 0) {
			sb.append(" AND a.f02 = ? ");
			parameters.add(id);
		}
		sb.append(" AND b.f21 = ?  group by b.f21 ");
		parameters.add(shbType);

		sb.append(" )");
		if (shbType.equals(ShbType.MZB)) {
			sb.append(",a.f01 ");
		}
		if (shbType.equals(ShbType.HFB)) {
			sb.append(",( select count(*) from t6067 )");
		}
		sb.append("  FROM T6060 a left join t6059 b on a.f02 = b.f01 WHERE 1=1  ");
		if (id > 0) {
			sb.append(" AND a.F02 = ? ");
			parameters.add(id);
		}
		sb.append(" AND b.f21 = ?  group by b.f21 ");
		parameters.add(shbType);
		
		
		
		

		return select(getConnection(FrontConst.DB_USER),
				new ItemParser<MzbtjVo>() {
					@Override
					public MzbtjVo parse(ResultSet res) throws SQLException {
						MzbtjVo m = new MzbtjVo();
						if (res.next()) {
							m.ljjrje = res.getBigDecimal(1);
							m.ljjrrc = res.getInt(2);
							m.ljmzje = res.getBigDecimal(3);
							m.ljzsy = res.getBigDecimal(4);
							m.ymzje = res.getBigDecimal(5);
							m.yjzsy = res.getBigDecimal(6);
							m.ljmhfrs = res.getInt(7);
						}
						return m;
					}
				}, sb.toString(), parameters);
	}

	@Override
	public PagingResult<MzblistVo> search(Paging paging, ShbType shbType)
			throws Throwable {
		StringBuffer sb = new StringBuffer(
				" SELECT A.F04 AS MZBMC,C.F02 AS JGMC,C.F03 AS JGZT,A.F07 AS NLL,A.F08 AS XMQX,A.F06 AS SYJE,A.F12 AS ZT,");
		sb.append(" A.F20 AS FXSJ,A.F05 AS FXJE,A.F09 ZDTZE,A.F01 MZBID FROM T6059 AS A LEFT JOIN s70.T7031 AS B ON A.F02 = B.F01 LEFT JOIN s70.T7029 AS C ON B.F02 = C.F01 ");
		sb.append(" WHERE A.F12 != 'SQZ' AND A.F12 != 'SHSB' AND A.F21=? ");
		sb.append(" ORDER BY A.F20 DESC ");

		return selectPaging(getConnection(FrontConst.DB_USER),
				new ArrayParser<MzblistVo>() {
					@Override
					public MzblistVo[] parse(ResultSet res) throws SQLException {
						List<MzblistVo> list = new ArrayList<MzblistVo>();
						while (res.next()) {
							MzblistVo m = new MzblistVo();
							m.mzbmc = res.getString(1);
							m.jgmc = res.getString(2);
							m.jglx = EnumParser.parse(OrganizationType.class,
									res.getString(3));
							m.nll = res.getBigDecimal(4);
							m.mzqx = res.getInt(5);
							m.syfxje = res.getBigDecimal(6);
							m.zt = EnumParser.parse(MzbStatus.class,
									res.getString(7));
							m.fssj = res.getTimestamp(8);
							m.fxje = res.getBigDecimal(9);
							m.zdtze = res.getBigDecimal(10);
							m.id = res.getInt(11);
							list.add(m);
						}
						return list.toArray(new MzblistVo[list.size()]);
					}
				}, paging, sb.toString(), shbType);
	}

	@Override
	public Mzbxq getMzbxq(int id) throws Throwable {
		StringBuffer sb = new StringBuffer(
				"SELECT A.F04 AS MZBMC, A.F05 AS FXJE, A.F07 AS NLL, C.F02 AS JGMC, A.F12 AS ZT, A.F20 AS FXSJ, ");
		sb.append(" A.F18 AS MESJ, A.F08 AS XMQX, A.F09 ZDTZE, A.F06 AS SYJE,A.F19 AS CKQX,A.F03 AS JKRID  ");
		sb.append(" FROM T6059 AS A LEFT JOIN s70.T7031 AS B ON A.F02 = B.F01 LEFT JOIN s70.T7029 AS C ON B.F02 = C.F01 WHERE A.F12 != 'SQZ' AND A.F01 = ? ");
		return select(getConnection(FrontConst.DB_USER),
				new ItemParser<Mzbxq>() {
					@Override
					public Mzbxq parse(ResultSet res) throws SQLException {
						Mzbxq m = new Mzbxq();
						if (res.next()) {
							m.mzbmc = res.getString(1);
							m.xmjhje = res.getBigDecimal(2);
							m.nll = res.getBigDecimal(3);
							m.dbjg = res.getString(4);
							m.xmzt = EnumParser.parse(MzbStatus.class,
									res.getString(5));
							m.fxsj = res.getTimestamp(6);
							m.mesj = res.getTimestamp(7);
							m.sdqx = res.getInt(8);
							m.zdjre = res.getBigDecimal(9);
							m.syje = res.getBigDecimal(10);
							m.ckqx = res.getInt(11);
							m.jkrid = res.getInt(12);
						}
						return m;
					}
				}, sb.toString(), id);
	}

	@Override
	public Mzbszfxx getMzbszfxx(int id) throws Throwable {

		return select(
				getConnection(FrontConst.DB_USER),
				new ItemParser<Mzbszfxx>() {
					@Override
					public Mzbszfxx parse(ResultSet res) throws SQLException {

						Mzbszfxx m = new Mzbszfxx();
						if (res.next()) {
							m.id = res.getInt(1);
							m.khm = res.getString(2);
							m.yhbh = res.getInt(3);
							m.bankcard = res.getString(4);
							m.khh = res.getString(5);
							m.khszd = res.getString(6);
						}
						return m;
					}
				},
				" SELECT F01,F03,F04,F05,F06,F08 FROM T6061 WHERE F09='QY' AND F01=? ",
				id);
	}

	@Override
	public HfblxrVo getHfblxr(int id) throws Throwable {

		return select(
				getConnection(FrontConst.DB_USER),
				new ItemParser<HfblxrVo>() {
					@Override
					public HfblxrVo parse(ResultSet res) throws SQLException {
						HfblxrVo h = new HfblxrVo();
						if (res.next()) {
							h.id = res.getInt(1);
							h.xm = res.getString(2);
							h.sjh = res.getString(3);
							h.myhf = res.getBigDecimal(4);
						}
						return h;
					}
				},
				" SELECT F01,F03,F04,F05 FROM T6065 WHERE F06 = 'QY' AND F01=? ",
				id);
	}

	@Override
	public void addMzbszfxx(MzbszfxxQuery query) throws Throwable {
		if (query == null) {
			throw new ParameterException("信息为空");
		}
		serviceResource.openTransactions();
		String khm;
		int xzyh;
		String khhszd;
		String khh;
		String bankcard;
		String obankcard;
		int accountid = serviceResource.getSession().getAccountId();
		{
			khm = query.khm();
			if (StringHelper.isEmpty(khm)) {
				throw new ParameterException("开户名不能为空");
			}

			xzyh = query.yhbh();
			if (xzyh <= 0) {
				throw new ParameterException("银行类型不能为空");
			}

			khhszd = query.khszd();
			if (StringHelper.isEmpty(khhszd)) {
				throw new ParameterException("开户行所在地不能为空");
			}

			khh = query.khh();
			if (StringHelper.isEmpty(khh)) {
				throw new ParameterException("开户行不能为空");
			}

			bankcard = query.bankcard();
			obankcard = query.obankcard();
			if (StringHelper.isEmpty(bankcard)
					|| StringHelper.isEmpty(obankcard)) {
				throw new ParameterException("银行卡号不能为空");
			}

			if (!bankcard.equals(obankcard)) {
				throw new ParameterException("两次输入银行卡号不相同");
			}
		}

		if (query.id() > 0) {
			execute(getConnection(FrontConst.DB_USER),
					" UPDATE T6061 SET F07=CURRENT_TIMESTAMP(),F09='TY' WHERE F01=? ",
					query.id());
		}

		execute(getConnection(FrontConst.DB_USER),
				"INSERT INTO T6061 SET F02=?,F03=?,F04=?,F05=?,F06=?,F07=CURRENT_TIMESTAMP(),F08=? ",
				accountid, khm, xzyh, bankcard, khh, khhszd);
	}

	@Override
	public void addHfblxr(HfblxrQuery query) throws Throwable {
		if (query == null) {
			throw new ParameterException("信息为空");
		}
		serviceResource.openTransactions();
		String xm;
		String sjh;
		String yzm;
		BigDecimal myhf;
		int accountid = serviceResource.getSession().getAccountId();
		{
			xm = query.xm();
			if (StringHelper.isEmpty(xm)) {
				throw new ParameterException("姓名不能为空");
			}

			sjh = query.sjh();
			if (StringHelper.isEmpty(sjh)) {
				throw new ParameterException("手机号不能为空");
			}

			yzm = query.yzm();
			if (StringHelper.isEmpty(yzm)) {
				throw new ParameterException("验证码错误");
			}

			Session session = serviceResource.getSession();
			String type = "hfb" + sjh;
			VerifyCodeAuthentication verfycode = new VerifyCodeAuthentication();
			verfycode.setVerifyCodeType(type);
			verfycode.setVerifyCode(yzm);
			try {
				session.authenticateVerifyCode(verfycode);
			} catch (AuthenticationException e) {
				throw new ParameterException("验证码错误");
			}
			session.invalidVerifyCode(type);
			myhf = query.myhf();
			if (myhf.compareTo(new BigDecimal("0")) == 0) {
				throw new ParameterException("金额错误");
			}

		}

		if (query.id() > 0) {
			execute(getConnection(FrontConst.DB_USER),
					" UPDATE t6065 SET F08=CURRENT_TIMESTAMP(),F06='TY' WHERE F01=? ",
					query.id());
		}

		execute(getConnection(FrontConst.DB_USER),
				"INSERT INTO t6065 SET F02=?,F03=?,F04=?,F05=?,F08=CURRENT_TIMESTAMP()",
				accountid, xm, sjh, myhf);
	}

	@Override
	public Mzbszfxx[] getMzbszfxxlist() throws Throwable {
		return selectAll(
				getConnection(FrontConst.DB_USER),
				new ArrayParser<Mzbszfxx>() {
					@Override
					public Mzbszfxx[] parse(ResultSet res) throws SQLException {
						List<Mzbszfxx> list = new ArrayList<Mzbszfxx>();
						while (res.next()) {
							Mzbszfxx m = new Mzbszfxx();
							m.id = res.getInt(1);
							m.khm = res.getString(2);
							m.yhbh = res.getInt(3);
							m.bankcard = res.getString(4);
							m.khh = res.getString(5);
							m.khszd = res.getString(6);
							m.yhmc = res.getString(7);
							list.add(m);
						}
						return list.toArray(new Mzbszfxx[list.size()]);
					}
				},
				" SELECT F01,F03,F04,F05,F06,F08,(SELECT F02 FROM T6052 WHERE F01=T6061.F04) AS YHMC FROM T6061 WHERE F09='QY' AND F02=?  ORDER BY F07 DESC ",
				serviceResource.getSession().getAccountId());
	}

	@Override
	public HfblxrVo[] getHfblxrlist() throws Throwable {
		return selectAll(
				getConnection(FrontConst.DB_USER),
				new ArrayParser<HfblxrVo>() {
					@Override
					public HfblxrVo[] parse(ResultSet res) throws SQLException {
						List<HfblxrVo> list = new ArrayList<HfblxrVo>();
						while (res.next()) {
							HfblxrVo h = new HfblxrVo();
							h.id = res.getInt(1);
							h.xm = res.getString(2);
							h.sjh = res.getString(3);
							h.myhf = res.getBigDecimal(4);
							list.add(h);
						}
						return list.toArray(new HfblxrVo[list.size()]);
					}
				},
				" SELECT F01,F03,F04,F05 FROM T6065 WHERE F06 = 'QY' AND F02=? ",
				serviceResource.getSession().getAccountId());
	}

	@Override
	public Bank[] getBank() throws Throwable {
		return selectAll(getConnection(FrontConst.DB_USER),
				new ArrayParser<Bank>() {
					@Override
					public Bank[] parse(ResultSet rs) throws SQLException {
						List<Bank> list = new ArrayList<Bank>();
						while (rs.next()) {
							Bank b = new Bank();
							b.id = rs.getInt(1);
							b.name = rs.getString(2);
							list.add(b);
						}
						return list.toArray(new Bank[list.size()]);
					}
				}, "SELECT * FROM T6052");
	}
/*
	@Override
	public void jrmzb(MzbjrQuery query, BigDecimal kyje) throws Throwable {
		serviceResource.openTransactions();
		try {
			if (query == null) {
				throw new ParameterException("参数错误！");
			}

			if (kyje.compareTo(new BigDecimal("0")) <= 0) {
				throw new ParameterException("用户金额不正确！");
			}

			BigDecimal mzje = query.mzje();
			int mzbdzid = 0;
			String jzdz = null;
			int mzbid = query.mzbid();
			MzbJrlx mzlx = null;
			Timestamp time = query.sgmzr();
			int mzys = query.mzys();
			ShbType shbType = null;
			String[] lxrids = null;

			if (mzbid <= 0) {
				throw new ParameterException("没有选择投资产品！");
			}
			
			if (ShbType.MZB.equals(shbType)) {
				if (mzje.compareTo(new BigDecimal("0")) <= 0) {
					throw new ParameterException("免租金额没有填写！");
				}
			}
			if (ShbType.HFB.equals(shbType)) {
				if (mzje.compareTo(new BigDecimal("0")) <= 0) {
					throw new ParameterException("没有选择需要交话费的手机号！");
				}
			}

			if (ShbType.MZB.equals(shbType)) {
				if (time == null) {
					throw new ParameterException("免租日没有选择！");
				}
			}
			if (ShbType.HFB.equals(shbType)) {
				if (time == null) {
					throw new ParameterException("免话费日没有选择！");
				}
			}
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			String nowTime = sf.format(new Date());
			if (time.before(sf.parse(nowTime))) {
				throw new ParameterException("不能选择过去时间！");
			}
			if (mzys <= 0) {
				throw new ParameterException("请选择免租月数！");
			}

			shbType = query.shbType();
			if (shbType == null) {
				throw new ParameterException("参数错误！");
			}

			if (ShbType.MZB.equals(shbType)) {
				jzdz = query.shdz();
				if (StringHelper.isEmpty(jzdz)) {
					throw new ParameterException("交租方地址不能为空！");
				}
				mzbdzid = query.szfid();
				if (mzbdzid <= 0) {
					throw new ParameterException("没有选择收租方银行帐户！");
				}
				mzlx = query.status();
				if (mzlx == null) {
					throw new ParameterException("选择需要免租类型！");
				}
			}
			if (ShbType.HFB.equals(shbType)) {
				lxrids = query.lxrid();
				if (lxrids == null) {
					throw new ParameterException("没有填写联系人信息！");
				}
				if (lxrids.length <= 0) {
					throw new ParameterException("没有填写联系人信息！");
				}
			}

			Mzbxq mzbxq = getMzbxq(mzbid);
			// 免租加入费率
			final ConfigureProvider configureProvider = serviceResource
					.getResource(ConfigureProvider.class);
			BigDecimal jrfl = new BigDecimal(
					configureProvider.getProperty(SystemVariable.MZB_JRFL));
			// 免租利息收益服务费率
			BigDecimal syfwfl = new BigDecimal(
					configureProvider.getProperty(SystemVariable.TZSYFWF_RATE));
			BigDecimal one = new BigDecimal("1");
			BigDecimal _100 = new BigDecimal("100");
			BigDecimal ylv = new BigDecimal(mzbxq.nll.doubleValue() / 12);
			BigDecimal jrje = mzje.divide((ylv.multiply(one.subtract(syfwfl))),
					2, BigDecimal.ROUND_HALF_UP);
			BigDecimal remainder = jrje.remainder(_100);
			// 加入金额
			BigDecimal ijrje = jrje.add(_100.subtract(remainder));
			// 加入费率
			BigDecimal jrf = ijrje.multiply(jrfl);
			// 加入总金额
			BigDecimal sxje = ijrje.add(jrf);
			// 利息
			BigDecimal lx = ijrje.multiply(ylv).setScale(2,
					BigDecimal.ROUND_HALF_UP);

			if (sxje.compareTo(kyje) > 0) {
				throw new ParameterException("用户资金不足！");
			}

			if (ijrje.compareTo(mzbxq.syje) > 0) {
				throw new LogicalException("加入金额超过项目剩余金额！");
			}

			BigDecimal zdje = mzbxq.zdjre;

			if (zdje.compareTo(ijrje) > 0) {
				throw new LogicalException("加入金额低于最低投资金额！");
			}

			int sdqx = mzbxq.sdqx;
			
			if (ShbType.MZB.equals(shbType)) {
				if (mzys <= 0 || mzys > sdqx) {
					throw new LogicalException("免租月数不再指定范围内！");
				}
			}
			if (ShbType.HFB.equals(shbType)) {
				if (mzys <= 0 || mzys > sdqx) {
					throw new LogicalException("免话费月数不再指定范围内！");
				}
			}

			// 扣除免租宝剩余金额
			String T6059 = " UPDATE T6059 SET F06=F06-? WHERE F01=? ";
			execute(getConnection(FrontConst.DB_USER), T6059, ijrje, mzbid);

			// 当前用户
			int accountid = serviceResource.getSession().getAccountId();
			// 借款用户
			int jkid = mzbxq.jkrid;

			String yecx = " SELECT F03 FROM T6023 WHERE F01=? FOR UPDATE ";

			String sql_pt = " SELECT F01 FROM T7025 FOR UPDATE";

			BigDecimal jrrye = new BigDecimal("0");
			BigDecimal jkrye = new BigDecimal("0");
			BigDecimal ptye = new BigDecimal("0");
			String sql_ut_T6023 = " UPDATE T6023 SET F05=F05-?,F03=F03-? WHERE F01=? ";
			String sql_aj_T6023 = " UPDATE T6023 SET F05=F05+?,F03=F03+? WHERE F01=? ";
			String sql_pt_T7025 = " UPDATE T7025 SET F01=F01+?,F02=F02+?,F03=F03+?,F04=F04+?,F05=CURRENT_TIMESTAMP()";
			String sql_pt_T7026 = " INSERT INTO T7026 SET F02=CURRENT_TIMESTAMP(),F03=?,F04=?,F05=?,F06=?,F07=?,F08=?,F09=?";
			String sql_dk_T6063 = " INSERT INTO T6063 SET F02=?,F03=?,F04=?,F05=?,F06=?,F07=?";
			String sql_it_T6032 = "INSERT INTO T6032 SET F02=?,F03=?,F04=CURRENT_TIMESTAMP(),F05=?,F06=?,F07=?,F08=?,F09=?";
			// 扣除加入人资金
			execute(getConnection(FrontConst.DB_USER), sql_ut_T6023, ijrje,
					ijrje, accountid);
			// 免租加入记录
			String sql_t_T6060 = "INSERT INTO T6060 SET F02=?,F03=?,F04=?,F05=?,F06=?,F07=CURRENT_TIMESTAMP(),F08=CURRENT_TIMESTAMP(),F11=?,F12=?,F13=?,F14=?,F16=?";
			int mzbjrid = insert(getConnection(FrontConst.DB_USER),
					sql_t_T6060, mzbid, accountid, ijrje, mzje, mzys, mzlx,
					mzbdzid, time, jzdz, jrf);

			if (ShbType.HFB.equals(shbType)) {
				for (String lxrid : lxrids) {
					int _id = IntegerParser.parse(lxrid);
					insert(getConnection(FrontConst.DB_USER),
							"INSERT INTO T6067 SET F02=?,F03=?,F04=?", mzbjrid,
							_id,_id);
				}
			}

			// 添加加入人加入金额资金流水
			jrrye = jrrye(yecx, accountid);
			execute(getConnection(FrontConst.DB_USER), sql_it_T6032, accountid,
					TradingType.JRMZB, 0, ijrje, jrrye, mzbjrid, mzbxq.mzbmc);

			if (ShbType.MZB.equals(shbType)) {
				String tzr_znx = "尊敬的用户，恭喜您成功投资免租宝" + mzbxq.mzbmc + "，金额为￥"
						+ ijrje.doubleValue() + "。免租详情可查看“个人中心-免租宝-参与中”相关项目信息。";
				// 投资用户站内信
				sendLetter(accountid, "加入免租宝", tzr_znx);
			}
			if (ShbType.HFB.equals(shbType)) {
				String tzr_znx = "尊敬的用户，恭喜您成功加入话费宝" + mzbxq.mzbmc + "，金额为￥"
						+ ijrje.doubleValue() + "。免租详情可查看“个人中心-话费宝-参与中”相关项目信息。";
				// 投资用户站内信
				sendLetter(accountid, "话费宝加入", tzr_znx);
			}

			if (ShbType.MZB.equals(shbType)) {
				String rzr_znx = "尊敬的用户，恭喜您通过免租宝" + mzbxq.mzbmc + "成功融资￥"
						+ ijrje.doubleValue()
						+ "。融资详情可查看“个人中心-免租宝-融资详情”相关项目信息。";
				// 融资用户站内信
				sendLetter(jkid, "免租宝融资", rzr_znx);
			}
			if (ShbType.HFB.equals(shbType)) {
				String rzr_znx = "尊敬的用户，恭喜您通过话费宝" + mzbxq.mzbmc + "成功融资￥"
						+ ijrje.doubleValue()
						+ "。融资详情可查看“个人中心-话费宝-融资详情”相关项目信息。";
				// 融资用户站内信
				sendLetter(jkid, "话费宝融资", rzr_znx);
			}

			if (jrf.compareTo(new BigDecimal("0")) > 0) {
				// 扣除加入人费
				execute(getConnection(FrontConst.DB_USER), sql_ut_T6023, jrf,
						jrf, accountid);
				jrrye = jrrye(yecx, accountid);
				execute(getConnection(FrontConst.DB_USER), sql_it_T6032,
						accountid, TradingType.MZBJRF, 0, jrf, jrrye, mzbjrid,
						mzbxq.mzbmc);

				// 加入费平台资金
				execute(getConnection(FrontConst.DB_CONSOLE), sql_pt_T7025,
						jrf, 0, jrf, jrf);
				// 加入费平台资金流水
				ptye = ptye(sql_pt);
				execute(getConnection(FrontConst.DB_CONSOLE), sql_pt_T7026,
						jrf, 0, ptye, PlatformFundType.MZBJRF, mzbxq.mzbmc,
						mzbjrid, accountid);
			}

			// 加入借款人用户资金
			execute(getConnection(FrontConst.DB_USER), sql_aj_T6023, ijrje,
					ijrje, jkid);
			jkrye = jkrye(yecx, jkid);
			// 加入借款人用户资金流水
			execute(getConnection(FrontConst.DB_USER), sql_it_T6032, jkid,
					TradingType.MZBRZ, ijrje, 0, jkrye, mzbjrid, mzbxq.mzbmc);

			// 还款借款记录
			String sql_t_T6062 = "INSERT INTO T6062 SET F02=?,F03=?,F04=?,F05=?,F06=?,F07=?,F08=?,F11=?,F12=DATE_ADD(CURRENT_DATE(),INTERVAL ? MONTH),F17=? ";
			SimpleDateFormat sb = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Timestamp nowtime = TimestampParser.parse(sb.format(new Date()));

			for (int i = 0; i <= (sdqx); i++) {
				BigDecimal bj = new BigDecimal("0");
				BigDecimal _lx = lx;
				BigDecimal _fwf = new BigDecimal("0");
				BigDecimal _jkglf = new BigDecimal("0");
				if (i == (sdqx)) {
					// 还款记录
					bj = ijrje;
					_lx = new BigDecimal("0");
				}
				_fwf = _lx.multiply(syfwfl).setScale(2,
						BigDecimal.ROUND_HALF_UP);
				int jlid = insert(getConnection(FrontConst.DB_USER),
						sql_t_T6062, mzbid, mzbjrid, jkid, accountid, i, bj,
						_lx, _jkglf, (i), _fwf);
				if (i == 0) {
					// 第一期免租还款记录
					execute(getConnection(FrontConst.DB_USER),
							"UPDATE T6062 SET F13=?,F14=?,F15=?,F16=? WHERE F01=?",
							nowtime, nowtime, MzbHkzt.YH, MzbSkzt.YS, jlid);
					// 添加打款记录
					execute(getConnection(FrontConst.DB_USER), sql_dk_T6063,
							mzbid, mzbjrid, jlid, mzbdzid, time, mzje);

					// 扣除借款人第一期利息
					execute(getConnection(FrontConst.DB_USER), sql_ut_T6023,
							_lx, _lx, jkid);
					// 扣除借款人第一期利息流水
					jkrye = jkrye(yecx, jkid);
					execute(getConnection(FrontConst.DB_USER), sql_it_T6032,
							jkid, TradingType.MZBHK, 0, _lx, jkrye, mzbjrid,
							mzbxq.mzbmc);
					// 免租收益
					BigDecimal mzbsy = _lx.subtract(mzje);
					// 加入加入第一期免租宝收益
					execute(getConnection(FrontConst.DB_USER), sql_aj_T6023,
							mzbsy, mzbsy, accountid);
					// 加入加入第一期免租宝收益流水
					jrrye = jrrye(yecx, accountid);
					execute(getConnection(FrontConst.DB_USER), sql_it_T6032,
							accountid, TradingType.MZBSY, mzbsy, 0, jrrye,
							mzbjrid, mzbxq.mzbmc);

					if (ShbType.MZB.equals(shbType)) {
						// 借款人收款站内信
						String jkrsz_znx = "尊敬的用户，您投资的免租宝" + mzbxq.mzbmc
								+ "获得一笔回款，金额为￥" + mzbsy.doubleValue() + "。";
						sendLetter(accountid, "免租宝回款", jkrsz_znx);
					}
					if (ShbType.HFB.equals(shbType)) {
						// 借款人收款站内信
						String jkrsz_znx = "尊敬的用户，您投资的话费宝" + mzbxq.mzbmc
								+ "获得一笔回款，金额为￥" + mzbsy.doubleValue() + "。";
						sendLetter(accountid, "话费宝回款", jkrsz_znx);
					}

					if (ShbType.MZB.equals(shbType)) {
						// 融资人还款站内信
						String rzrhk_znx = "尊敬的用户，您的账户有一笔还款支出，金额为￥"
								+ _lx.doubleValue() + "，备注：免租宝" + mzbxq.mzbmc
								+ "。";
						sendLetter(jkid, "话费宝还款", rzrhk_znx);
					}
					if (ShbType.HFB.equals(shbType)) {
						// 融资人还款站内信
						String rzrhk_znx = "尊敬的用户，您的账户有一笔还款支出，金额为￥"
								+ _lx.doubleValue() + "，备注：话费宝" + mzbxq.mzbmc
								+ "。";
						sendLetter(jkid, "话费宝还款", rzrhk_znx);
					}

					if (syfwfl.compareTo(new BigDecimal("0")) > 0) {
						// 扣除加入人第一期投资服务费
						execute(getConnection(FrontConst.DB_USER),
								sql_ut_T6023, _fwf, _fwf, accountid);
						// 扣除加入人第一期投资服务费流水
						jrrye = jrrye(yecx, accountid);
						execute(getConnection(FrontConst.DB_USER),
								sql_it_T6032, accountid, TradingType.MZBSYFWF,
								0, _fwf, jrrye, mzbjrid, mzbxq.mzbmc);
						// 加入平台资金
						execute(getConnection(FrontConst.DB_CONSOLE),
								sql_pt_T7025, _fwf, 0, _fwf, _fwf);
						// 加入平台资金流水
						ptye = ptye(sql_pt);
						execute(getConnection(FrontConst.DB_CONSOLE),
								sql_pt_T7026, _fwf, 0, ptye,
								PlatformFundType.MZBSYFWF, mzbxq.mzbmc,
								mzbjrid, accountid);

					}

					// 生成话费订单
					if (ShbType.HFB.equals(shbType)) {
						for (String lxrid : lxrids) {
							HfblxrVo lxrvo = select(
									getConnection(FrontConst.DB_USER),
									new ItemParser<HfblxrVo>() {
										@Override
										public HfblxrVo parse(ResultSet res)
												throws SQLException {
											HfblxrVo v = new HfblxrVo();
											if (res.next()) {
												v.xm = res.getString(1);
												v.sjh = res.getString(2);
												v.myhf = res.getBigDecimal(3);
											}
											return v;
										}
									},
									"SELECT F03,F04,F05 FROM T6065 WHERE F01=?",
									IntegerParser.parse(lxrid));
							insert(getConnection(FrontConst.DB_USER),
									"INSERT INTO T6066 SET F02=?,F03=?,F04=?,F06=?,F07=CURRENT_DATE(),F10=?,F05=?",
									lxrvo.sjh, lxrvo.myhf, time, mzbjrid,
									lxrvo.xm,serviceResource.getSession().getAccountId());

						}
					}

				}

			}

			// 添加推广奖励
			final ConfigureProvider config = serviceResource
					.getResource(ConfigureProvider.class);
			String sfqy = config.get(SystemVariable.TG_SFQY.getKey());
			int jr_Id = mzbjrid;// 免租宝加入ID
			int btg_Id = accountid;// 被推广人ID
			int tg_Id = 0;// 推广人ID
			BigDecimal tg_amount = ijrje;
			int tg_limit = mzbxq.sdqx;// 加入期限

			String title = "";
			if (ShbType.MZB.equals(shbType)) {
				title = "免租宝" + mzbxq.mzbmc;// 免租宝加入标题
			}
			if (ShbType.HFB.equals(shbType)) {
				title = "话费宝" + mzbxq.mzbmc;// 免租宝加入标题
			}
			String S_BTGR = "SELECT a.F01 FROM t6011 a WHERE a.F11 = (SELECT b.F10 FROM t6011 b WHERE b.F01=?)";
			tg_Id = selectInt(P2PConst.DB_USER, S_BTGR, btg_Id);
			addTg(jr_Id, btg_Id, tg_Id, tg_amount, tg_limit, sfqy, title);
			
			*//**
			 * 2014双蛋活动
			 *//*
			activity_5(ijrje);
			
		} catch (Throwable t) {
			serviceResource.rollback();
			throw new LogicalException(t.getMessage());
		}
	}
	*/
	/**
	 * 2014双蛋活动
	 */
	private void activity_5(BigDecimal money) throws Throwable {
		int account = serviceResource.getSession().getAccountId();
		int hdId = 5;// 活动ID
		BigDecimal xe = new BigDecimal(1000);//累计投资限额-注册送20元红包激活条件
		Timestamp startTime = null;// 活动开始时间
		Timestamp endTime = null;// 活动结束时间
		try (Connection con = getConnection(P2PConst.DB_CONSOLE)) {
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
		if (startTime.after(currTime) || endTime.before(currTime)) {
			return;
		}
		
		//注册送20元红包激活
		String U_T6068 = "UPDATE T6068 SET F08=F08+? WHERE F02=? AND F03=?";
		execute(getConnection(P2PConst.DB_USER), U_T6068, money,hdId,account);
		
		String S_T6068 = "SELECT F01,F07 FROM T6068 WHERE F02=? AND F03=? AND F08>=? AND F06=?";
		Zcs20hb[] hbs = selectAll(getConnection(P2PConst.DB_USER), new ArrayParser<Zcs20hb>() {
			@Override
			public Zcs20hb[] parse(ResultSet rs)
					throws SQLException {
				List<Zcs20hb> list = new ArrayList<Zcs20hb>();
				while (rs.next()) {
					Zcs20hb m = new Zcs20hb();
					m.id = rs.getInt(1);
					m.hbje = rs.getBigDecimal(2);
					list.add(m);
				}
				return list.toArray(new Zcs20hb[list.size()]);
			}
		}, S_T6068, hdId,account,xe,IsPass.F);
		
		ConfigureProvider configureProvider = serviceResource
				.getResource(ConfigureProvider.class);
		Envionment envionment = configureProvider.createEnvionment();
		if(hbs!=null&&hbs.length>0){
			String title = "注册就送20元红包";
			String mb_hb = "恭喜您，获得${amt_hb}元注册现金红包！红包已到账，请前往个人中心查收。";
			for(Zcs20hb hb:hbs){
				BigDecimal amt_hb = hb.hbje;
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
				
				String U_T6068_F06 = "UPDATE T6068 SET F06=? WHERE F01=?";
				execute(getConnection(P2PConst.DB_USER), U_T6068_F06, IsPass.S,hb.id);
			}
		}
		
		//双蛋活动投资金额累加
		String I_T7052_09 = "INSERT INTO T7052_09 SET F01=?,F02=?,F03=?,F05=CURRENT_TIMESTAMP() ON DUPLICATE KEY UPDATE F02=F02+?,F03=F03+?";
		execute(getConnection(P2PConst.DB_CONSOLE), I_T7052_09, account,money,money,money,money);
	}
	
	class Zcs20hb{
		public int id;
		public BigDecimal hbje = new BigDecimal(0);
	}

	/**
	 * 
	 * @param jrId
	 *            免租宝加入ID
	 * @param btgId
	 *            被推广人ID
	 * @param tgId
	 *            推广人ID
	 * @param amount
	 *            加入金额
	 * @param sfqy
	 *            推广是否启用
	 * @param tgLimit
	 *            加入期限
	 * @param title
	 *            免租宝加入标题
	 * @throws Throwable
	 */
	private void addTg(int jr_Id, int btg_Id, int tg_Id, BigDecimal tg_amount,
			int tg_limit, String sfqy, String title) throws Throwable {
		if (tg_Id <= 0) {
			return;
		}
		// 判断推广人是否可以获取发布的推广奖励
		String s = "SELECT COUNT(*) FROM T7053,T7054 WHERE T7053.F01 = T7054.F02 AND T7053.F04=? AND T7054.F01=?";
		int icount = selectInt(P2PConst.DB_CONSOLE, s, IsPass.F.name(), tg_Id);
		BigDecimal jlAmount = new BigDecimal(0);
		if (icount > 0) {// 大于0是不拿对外奖励(业务员),但是要记录推广记录
			BigDecimal jqywl = new BigDecimal(tg_limit
					* tg_amount.doubleValue() / 12).setScale(2,
					BigDecimal.ROUND_HALF_UP);
			// 添加推广表记录
			String insertT6055 = "INSERT INTO T6055 SET F02=?,F03=?,F04=?,F05=?,F06=CURRENT_TIMESTAMP(),F08=?";
			insert(getConnection(P2PConst.DB_USER), insertT6055, tg_Id, btg_Id,
					tg_amount, jlAmount, jr_Id);
			// 更新推广统计
			String updateT6053 = "UPDATE T6053 SET F03=F03+?,F04=F04+? WHERE F01=?";
			execute(getConnection(P2PConst.DB_USER), updateT6053, tg_amount,
					jlAmount, tg_Id);

			String updateT7054 = "UPDATE T7054 SET F04=F04+? WHERE F01=?";
			execute(getConnection(P2PConst.DB_CONSOLE), updateT7054, tg_amount,
					tg_Id);

			String updateT7055 = "INSERT INTO T7055 SET F01=?,F02=YEAR(now()),F03=MONTH(now()),F04=?,F05=? ON DUPLICATE KEY UPDATE F01=?,F02=YEAR(now()),F03=MONTH(now()),F04=F04+?,F05=F05+?";
			execute(getConnection(P2PConst.DB_CONSOLE), updateT7055, tg_Id,
					jqywl, tg_amount, tg_Id, jqywl, tg_amount);
			return;
		}

		String t6011_2 = "SELECT t6011_2.F10 FROM t6011,t6011_2 WHERE t6011.F35 = t6011_2.F01 AND t6011.F01 = ?";
		BigDecimal tzjlll = selectBigDecimal(P2PConst.DB_USER, t6011_2, tg_Id);
		// 不启用则做
		if (!"true".equals(sfqy.toLowerCase().trim())) {
			tzjlll = new BigDecimal(0);
		}

		// 计算奖励金额
		// 推广奖励金额 = ∑（好友成功投标金额 * 标的期限/12个月）* 2%, 例如:您推广的好友投资一个借款期限为3个月的
		// 标的并成功放款，投标金额为10000.00元，您将获得50.00元（=10000 * 3 / 12 * 2%）奖励。
		jlAmount = new BigDecimal(tg_limit * tg_amount.doubleValue()
				* tzjlll.doubleValue() / 1200).setScale(2,
				BigDecimal.ROUND_HALF_UP);
		// 添加推广表记录
		String insertT6055 = "INSERT INTO T6055 SET F02=?,F03=?,F04=?,F05=?,F06=CURRENT_TIMESTAMP(),F08=?";
		insert(getConnection(P2PConst.DB_USER), insertT6055, tg_Id, btg_Id,
				tg_amount, jlAmount, jr_Id);

		String updateT6053 = "UPDATE T6053 SET F03=F03+?,F04=F04+? WHERE F01=?";
		execute(getConnection(P2PConst.DB_USER), updateT6053, tg_amount,
				jlAmount, tg_Id);

		if (jlAmount.compareTo(new BigDecimal(0)) > 0) {
			// 添加推广人金额
			String updateT6023 = "UPDATE T6023 SET F03=F03+?,F05=F05+? WHERE F01=?";
			execute(getConnection(P2PConst.DB_USER), updateT6023, jlAmount,
					jlAmount, tg_Id);
			BigDecimal acountAmount = selectBigDecimal(P2PConst.DB_USER,
					"SELECT F03 FROM T6023 WHERE F01 = ?", tg_Id);
			String insertT6032 = "INSERT INTO T6032 SET F02=?,F03=?,F04=?,F05=?,F07=?,F08=?,F09=?";
			execute(getConnection(P2PConst.DB_USER), insertT6032, tg_Id,
					TradingType.CXTGJL,
					new Timestamp(System.currentTimeMillis()), jlAmount,
					acountAmount, jr_Id, title);
			// 投资人推广奖励站内信
			sendTzrTg(tg_Id, tg_amount, jlAmount);
			// 扣除平台账号金额
			String updateT7025 = "UPDATE T7025 SET F01=F01-?,F02=F02+?,F04=F04-?";
			execute(getConnection(P2PConst.DB_CONSOLE), updateT7025, jlAmount,
					jlAmount, jlAmount);
			String insertT7026 = "INSERT INTO T7026 SET F02=?,F04=?,F05=?,F06=?,F07=?,F08=?,F09=?";
			String selectT7025 = "SELECT F01 FROM T7025";
			BigDecimal ptTotalAmount = selectBigDecimal(P2PConst.DB_CONSOLE,
					selectT7025);
			execute(getConnection(P2PConst.DB_CONSOLE), insertT7026,
					new Timestamp(System.currentTimeMillis()), jlAmount,
					ptTotalAmount, PlatformFundType.TGCXJL, "推广投资励扣除:"
							+ Formater.formatAmount(jlAmount) + "元", jr_Id,
					tg_Id);
		}

	}

	/**
	 * 投资人推广奖励站内信
	 * 
	 * @param id
	 * @throws Throwable
	 */
	private void sendTzrTg(int userId, BigDecimal amount, BigDecimal jlAmount)
			throws Throwable {
		ConfigureProvider configureProvider = serviceResource
				.getResource(ConfigureProvider.class);
		String template = configureProvider.getProperty(LetterVariable.TG_CXJL);
		Timestamp now = new Timestamp(System.currentTimeMillis());
		Envionment envionment = configureProvider.createEnvionment();
		envionment.set("tz", Formater.formatAmount(amount));
		envionment.set("jl", Formater.formatAmount(jlAmount));
		int letterId = insert(getConnection(P2PConst.DB_USER), t6035, now,
				LetterVariable.TG_CXJL.getDescription(), "", userId,
				LetterStatus.WD);
		execute(getConnection(P2PConst.DB_USER), t6046, letterId,
				StringHelper.format(template, envionment));
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
		int letterId = insert(getConnection(FrontConst.DB_USER), t6035, now,
				title, "", loginId, LetterStatus.WD);
		execute(getConnection(FrontConst.DB_USER), t6046, letterId, content);
	}

	private BigDecimal jrrye(String yecx, int accountid) throws SQLException {
		// 加入人余额
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
				}, yecx, accountid);
	}

	private BigDecimal jkrye(String yecx, int jkid) throws SQLException {
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
				}, yecx, jkid);
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
	public MzbjsVo getMzbjsVo(int id) throws Throwable {
		StringBuffer sb = new StringBuffer(
				"SELECT A.F10 XMJS, A.F02 RZQY, A.F09 XMDZ, ( SELECT F02 FROM T6010 WHERE F01 = B.F03 ) RZDLR, A.F04 ZCNX, ");
		sb.append(" A.F06 ZCJZ, A.F05 ZCZJ, A.F03 HY, B.F11 HKLY, A.F07 JYQK, A.F08 SSQK FROM T6059 AS B LEFT JOIN S70.T7031_2 AS A ON B.F02 = A.F01 WHERE B.F01=? ");
		return select(getConnection(FrontConst.DB_USER),
				new ItemParser<MzbjsVo>() {
					@Override
					public MzbjsVo parse(ResultSet res) throws SQLException {
						MzbjsVo m = new MzbjsVo();
						if (res.next()) {
							m.xmjs = res.getString(1);
							m.rzqymc = res.getString(2);
							m.xmdz = res.getString(3);
							m.rzdlr = res.getString(4);
							m.qyzcnx = res.getInt(5);
							m.zcjz = res.getBigDecimal(6);
							m.qyzczj = res.getBigDecimal(7);
							m.hy = res.getString(8);
							m.hkly = res.getString(9);
							m.qyjyqk = res.getString(10);
							m.ssqk = res.getString(11);
						}
						return m;
					}
				}, sb.toString(), id);
	}

	@Override
	public ContractFileVo[] getFileList(int id) throws Throwable {
		StringBuilder sql = new StringBuilder(
				"SELECT T7031_1.F01,T7031_1.F03,T7031_1.F04,T7031_1.F05,T7031_1.F06,tes.F02,T7031_1.F02 AS HTID FROM T7031_1 LEFT JOIN T7011 tes ON T7031_1.F07 = tes.F01 ");
		sql.append(" WHERE T7031_1.F02 = (SELECT F02 FROM s60.T6059 WHERE F01=?) ");
		sql.append(" ORDER BY T7031_1.F05 DESC");

		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(id);

		return selectAll(getConnection(FrontConst.DB_CONSOLE),
				new ArrayParser<ContractFileVo>() {
					@Override
					public ContractFileVo[] parse(ResultSet res)
							throws SQLException {
						List<ContractFileVo> list = new ArrayList<ContractFileVo>();
						while (res.next()) {
							ContractFileVo x = new ContractFileVo();
							x.id = res.getInt(1);
							x.name = res.getString(2);
							x.url = res.getString(3);
							x.order = res.getInt(4);
							x.createTime = res.getTimestamp(5);
							x.author = res.getString(6);
							x.contractId = res.getInt(7);
							list.add(x);
						}
						return list.toArray(new ContractFileVo[list.size()]);
					}
				}, sql.toString(), parameters);
	}

	@Override
	public PagingResult<Mzbjrjl> searchMzbjrjl(int mzbid, Paging paging)
			throws Throwable {
		StringBuffer sb = new StringBuffer(
				"SELECT ( SELECT F02 FROM T6010 WHERE F01 = A.F03 ) JRR, A.F04 JRJE, A.F07 JRSJ, A.F05 MZJE FROM T6060 A WHERE A.F02 =? ORDER BY A.F07 DESC");
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(mzbid);
		return selectPaging(getConnection(FrontConst.DB_USER),
				new ArrayParser<Mzbjrjl>() {
					@Override
					public Mzbjrjl[] parse(ResultSet res) throws SQLException {
						List<Mzbjrjl> list = new ArrayList<Mzbjrjl>();
						while (res.next()) {
							Mzbjrjl m = new Mzbjrjl();
							m.mzyh = res.getString(1);
							m.jrje = res.getBigDecimal(2);
							m.jrsj = res.getTimestamp(3);
							m.mzje = res.getBigDecimal(4);
							list.add(m);
						}
						return list.toArray(new Mzbjrjl[list.size()]);
					}
				}, paging, sb.toString(), parameters);
	}

	@Override
	public PagingResult<MzbxmbxVo> searchMzbxmbx(int mzbid, Paging paging)
			throws Throwable {
		StringBuffer sb = new StringBuffer(
				"SELECT ( SELECT F02 FROM T6010 WHERE F01 = B.F03 ) JRR,C.YMZJE,C.YMQH,C.MZRQ,( SELECT SUM(F08) FROM T6062 WHERE F03 = B.F01 ) YJSY  ");
		sb.append(" FROM T6060 AS B LEFT JOIN (SELECT SUM(A.F07) YMZJE,COUNT(A.F12) YMQH, MAX(A.F06) MZRQ,   ");
		sb.append(" A.F03 FROM T6063 AS A WHERE A.F11='YDK' GROUP BY F03) AS C ON B.F01 = C.F03 WHERE B.F02=? ");
		ArrayList<Object> parameters = new ArrayList<>();
		parameters.add(mzbid);
		return selectPaging(getConnection(FrontConst.DB_USER),
				new ArrayParser<MzbxmbxVo>() {
					@Override
					public MzbxmbxVo[] parse(ResultSet res) throws SQLException {
						List<MzbxmbxVo> list = new ArrayList<MzbxmbxVo>();
						while (res.next()) {
							MzbxmbxVo m = new MzbxmbxVo();
							m.mzyh = res.getString(1);
							m.ymzje = res.getBigDecimal(2);
							m.ymzqs = res.getInt(3);
							m.mzjzrq = res.getTimestamp(4);
							m.yjzsy = res.getBigDecimal(5);
							list.add(m);
						}
						return list.toArray(new MzbxmbxVo[list.size()]);
					}
				}, paging, sb.toString(), parameters);
	}

	@Override
	public Tjvo getTj() throws Throwable {
		return select(getConnection(FrontConst.DB_CONSOLE),
				new ItemParser<Tjvo>() {
					@Override
					public Tjvo parse(ResultSet res) throws SQLException {
						Tjvo t = new Tjvo();
						if (res.next()) {
							t.ljcje = res.getBigDecimal(1);
							t.fxbyj = res.getBigDecimal(2);
							t.zqsy = res.getBigDecimal(3);
						}
						return t;
					}
				}, "SELECT F16,F17,F18 FROM T7010 ");
	}

	@Override
	public XcyVo[] getXcy() throws Throwable {
		return selectAll(
				getConnection(FrontConst.DB_USER),
				new ArrayParser<XcyVo>() {
					@Override
					public XcyVo[] parse(ResultSet res) throws SQLException {
						List<XcyVo> list = new ArrayList<XcyVo>();
						while (res.next()) {
							XcyVo x = new XcyVo();
							x.yhm = res.getString(1);
							x.name = res.getString(2);
							x.sjh = res.getString(3);
							x.spsj = res.getTimestamp(4);
							list.add(x);
						}
						return list.toArray(new XcyVo[list.size()]);
					}
				},
				"SELECT A.F02,B.F06,B.F02,B.F39 FROM T6011 AS B LEFT JOIN T6010 AS A ON B.F01 = A.F01 WHERE F38='S' ");
	}

	@Override
	public void deleteHfblxr(int id) throws Throwable {
		if (id > 0) {
			execute(getConnection(FrontConst.DB_USER),
					" UPDATE t6065 SET F08=CURRENT_TIMESTAMP(),F06='TY' WHERE F01=? ",
					id);
		}
	}

}
