package com.jiudian.p2p.front.service.credit.achieve;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import com.jiudian.framework.config.ConfigureProvider;
import com.jiudian.framework.service.ServiceFactory;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.framework.service.exception.ParameterException;
import com.jiudian.framework.service.query.ItemParser;
import com.jiudian.p2p.common.enums.AttestationState;
import com.jiudian.p2p.common.enums.AttestationType;
import com.jiudian.p2p.common.enums.CreditType;
import com.jiudian.p2p.common.enums.IsPass;
import com.jiudian.p2p.common.enums.TenderRepayment;
import com.jiudian.p2p.front.service.credit.LmoneyManage;
import com.jiudian.p2p.front.service.credit.entity.Lmoney;
import com.jiudian.p2p.front.service.credit.entity.LmoneyDecide;
import com.jiudian.p2p.front.service.credit.entity.LmoneyQuery;
import com.jiudian.p2p.variables.defines.SystemVariable;
import com.jiudian.util.StringHelper;
import com.jiudian.util.parser.EnumParser;
import com.jiudian.util.parser.IntegerParser;

public class LmoneyManageImpl extends AbstractAccountService implements
		LmoneyManage {

	public LmoneyManageImpl(ServiceResource serviceResource) {
		super(serviceResource);
	}

	public static class LmoneyManageFactory implements
			ServiceFactory<LmoneyManage> {
		@Override
		public LmoneyManage newInstance(ServiceResource serviceResource) {
			return new LmoneyManageImpl(serviceResource);
		}
	}

	@Override
	public LmoneyDecide getLmoneyDecide(String type)
			throws Throwable {
		int acount = serviceResource.getSession().getAccountId();
		StringBuilder sb1 = new StringBuilder();
		sb1.append("SELECT T6011.F08,T6023.F02,T6011.F02,T6011.F28 FROM  T6011 left join T6023 on T6011.F01=T6023.F01 WHERE T6011.F01=?  ");
		StringBuilder sb2 = new StringBuilder();
		sb2.append("SELECT T6036.F01,T6036.F20 FROM T6036 WHERE T6036.F20 <> 'YJQ' AND T6036.F20 <> 'LB' AND T6036.F20 <> 'YFK' AND T6036.F02=?  ");
		LmoneyDecide lm = new LmoneyDecide();
		try (final Connection connection = getConnection()) {
			try (PreparedStatement ps = connection.prepareStatement(sb1.toString())) {
					ps.setInt(1, acount);
				try (ResultSet rs = ps.executeQuery()) {
					while (rs.next()) {
//						lm.isSmrz = rs.getString(1);
//						lm.password = rs.getString(2);
						lm.phoneNumber = rs.getString(3);
						lm.isPass = EnumParser.parse(IsPass.class, rs.getString(4));
					}
				}
			}
			try (PreparedStatement ps = connection.prepareStatement(sb2.toString())) {
				ps.setInt(1, acount);
//				ps.setString(2, type);
				try (ResultSet rs = ps.executeQuery()) {
					while (rs.next()) {
						lm.id = rs.getInt(1);
					}
				}
			}
		}
		return lm;
		
		
	}

	@Override
	public Lmoney getLmoney(int id, String type) throws Throwable {
		if (StringHelper.isEmpty(type) || id == 0) {
			throw new ParameterException("插入内容不合法，请检查插入内容是否正确！");
		}
		StringBuffer sb = new StringBuffer();
		List<Object> parameters = new ArrayList<Object>();
		sb.append("SELECT F01,F02,F04,F05,F06,F08,F09,F17,F20,F13,F16 FROM T6036 WHERE 1=1 ");
		if (id > 0) {
			sb.append(" AND F01=? ");
			parameters.add(id);
		}
		if (!StringHelper.isEmpty(type)) {
			sb.append(" AND F19=? ");
			parameters.add(type);
		}
		return select(getConnection(), new ItemParser<Lmoney>() {
			@Override
			public Lmoney parse(ResultSet rs) throws SQLException {
				Lmoney lm = new Lmoney();
				if (rs.next()) {
					lm.id = rs.getInt(1);
					lm.acount = rs.getInt(2);
					lm.title = rs.getString(3);
					lm.lmuse = rs.getString(4);
					lm.money = rs.getBigDecimal(5);
					lm.ctime = rs.getInt(6);
					lm.rating = rs.getBigDecimal(7);
					lm.describe = rs.getString(8);
					lm.Lstatus = rs.getString(9);
					lm.mmoney = rs.getBigDecimal(10);
					lm.gmmoney = rs.getBigDecimal(11);
				}
				return lm;
			}
		}, sb.toString(), parameters);
	}

	@Override
	public int addLmoney(LmoneyQuery query) throws Throwable {
		if (query == null) {
			throw new ParameterException("没有借款申请信息");
		}
		String title;
		BigDecimal money =  new BigDecimal(0);
		
		BigDecimal rating = new BigDecimal(0);
		//没有除100年利率
		BigDecimal trating = new BigDecimal(0);
		String describe;
		int isRead = 0;
		//每月本息(等额本息)
		BigDecimal mybx = new BigDecimal(0);
		//借款管理费
		BigDecimal jkglf = new BigDecimal(0);
		//借款期限
		int month = query.getCtime();
		String getType = query.getType();
		
		BigDecimal tbxe = new BigDecimal(0);
		
		//债权ID
		int zqid = 0;
		{
			title = query.getTitle();
			if (StringHelper.isEmpty(title)) {
				throw new ParameterException("标题不能为空");
			}
			if (title.length() > 15) {
				throw new ParameterException("借款标题不能超过15个字");
			}
			money = query.getMoney();
			if (money == null) {
				throw new ParameterException("借款金额不能为空");
			}
			final ConfigureProvider configureProvider =serviceResource.getResource(ConfigureProvider.class);
			
			int bs = IntegerParser.parse(configureProvider.format(SystemVariable.AUTO_BIDING_MULT_AMOUNT));
			
			int t = money.intValue();
			BigDecimal a = new BigDecimal("3000.00");
			BigDecimal b = new BigDecimal("500001.00");
			if (t % bs > 0 || money.compareTo(a) == -1
					|| money.compareTo(b) == 0) {
				throw new ParameterException("借款款金额范围3000-500000，且为"+bs+"的倍数");
			}
			trating = query.getRating();
			if (trating == null) {
				throw new ParameterException("年利率不能为空");
			}
			
			tbxe = query.getTbxe();
			if(tbxe == null){
				throw new ParameterException("投标限额不能为空");
			}
			
			rating = trating.divide(new BigDecimal("100"),3,BigDecimal.ROUND_HALF_DOWN);
			
			BigDecimal a1 = new BigDecimal("0.10");
			BigDecimal b2 = new BigDecimal("0.25");
			if (rating.compareTo(a1) == -1 || rating.compareTo(b2) == 0) {
				throw new ParameterException("您输入的借款年利率超出范围，请重新输入");
			}
			describe = query.getDescribe();
			if (StringHelper.isEmpty(describe)) {
				throw new ParameterException("借款描述不能为空");
			}
			if (describe.length() > 500 || describe.length() < 20) {
				throw new ParameterException("借款描述应限制在20-500字之间");
			}
			isRead = query.getIsread();
			if (isRead == 0) {
				 throw new ParameterException("请同意我们的条款");
			}
			String moneys = "100";
			//每份金额
			BigDecimal mfje = new BigDecimal(moneys);
			//获取份数
			BigDecimal size = money.divide(mfje,20,BigDecimal.ROUND_HALF_DOWN);
			double monthRate = query.getRating().doubleValue()/12/100;
			//月利率
			BigDecimal mln = new BigDecimal(monthRate);
			BigDecimal one = new BigDecimal(1);
			BigDecimal s1 = (one.add(mln)).pow(month);
			BigDecimal ylv = mfje.multiply(mln).multiply(s1).divide(s1.subtract(one),2,BigDecimal.ROUND_HALF_DOWN);
			
			
			if(getType.equals(TenderRepayment.MYHKDQHB2.name())){
				mybx = mln.multiply(mfje).setScale(2, BigDecimal.ROUND_HALF_DOWN).multiply(size).setScale(2, BigDecimal.ROUND_HALF_DOWN);
			}
			
			BigDecimal glfl = new BigDecimal(configureProvider.getProperty(SystemVariable.LMONEY_SUCCESS_RATION));
			jkglf = money.multiply(glfl).setScale(2, BigDecimal.ROUND_HALF_DOWN);
			
			//债权ID
			zqid = getCrid(CreditType.SYD.name());
			Calendar now = Calendar.getInstance();
			//当年年份获取后两位
			String dl = (now.get(Calendar.YEAR)+"").substring(2, 4);
			String mon = "";
			int m = now.get(Calendar.MONTH)+1;
			if(m<10){
				mon = "0"+m;
			}else{mon = m+"";}
			//当天月份
			String dy = mon;
			//当天几号
			int dt=now.get(Calendar.DATE);
			if(zqid<=0 || dt==1){
				zqid = IntegerParser.parse(dl+dy+"0001");
			}else{
				zqid = zqid+1;
			}
		}
		serviceResource.openTransactions();
		try (Connection connection = getConnection()) {
			int id = insert(
					connection,
					"INSERT INTO T6036 SET F02=?,F03=?,F04=?,F05=?,F06=?,F08=?,F09=?,F10=?,F11=?,F12=?,F13=?,F16=?,F17=?,F19=?,F20=?,F37=?,F42=?,F26=CURRENT_TIMESTAMP()",
					serviceResource.getSession().getAccountId(), zqid, query.getTitle(),
					query.getLmuse(), query.getMoney(), query.getCtime(),
					rating, query.getPeriod(), getType,
					query.getLtime(), mybx, jkglf,
					query.getDescribe(), query.getLtype(), query.getLstatus(),
					query.getOnemoney(),tbxe);
			if(id>0){
				execute(connection, "UPDATE  T6045 SET F08=F08+1 WHERE F01 = ?",serviceResource.getSession().getAccountId());	
			}
			return id;
		}
		
		
		
	}

	@Override
	public void update(LmoneyQuery query) throws Throwable {
		if (query == null) {
			throw new ParameterException("没有借款申请信息");
		}
		int account = 0;
		String title;
		BigDecimal money  = new BigDecimal(0);
		BigDecimal rating = new BigDecimal(0);
		//没有除100年利率
		BigDecimal trating = new BigDecimal(0);
		String describe;
		int isRead = 0;
		//每月本息(等额本息)
		BigDecimal mybx = new BigDecimal(0);
		//借款管理费
		BigDecimal jkglf = new BigDecimal(0);
		//还款方式
		String getType = query.getType();
		int month = query.getCtime();
		//债权ID
		int zqid = 0;
		{
			account = query.getAcount();
			if (account <= 0) {
				throw new ParameterException("不存在当前用户.");
			}
			title = query.getTitle();
			if (StringHelper.isEmpty(title)) {
				throw new ParameterException("标题不能为空");
			}
			if (title.length() > 15) {
				throw new ParameterException("借款标题不能超过15个字");
			}
			money = query.getMoney();
			if (money == null) {
				throw new ParameterException("借款金额不能为空");
			}
			
			final ConfigureProvider configureProvider =serviceResource.getResource(ConfigureProvider.class);
			int bs = IntegerParser.parse(configureProvider.format(SystemVariable.AUTO_BIDING_MULT_AMOUNT));
			
			int t = money.intValue();
			BigDecimal a = new BigDecimal("3000.00");
			BigDecimal b = new BigDecimal("500001.00");
			if (t % bs > 0 || money.compareTo(a) == -1
					|| money.compareTo(b) == 0) {
				throw new ParameterException("借款金额范围3000-500000，且为"+bs+"的倍数");
			}
			trating = query.getRating();
			if (trating == null) {
				throw new ParameterException("年利率不能为空");
			}
			
			rating = trating.divide(new BigDecimal("100"),3,BigDecimal.ROUND_HALF_DOWN);
			
			BigDecimal a1 = new BigDecimal("0.10");
			BigDecimal b2 = new BigDecimal("0.25");
			if (rating.compareTo(a1) == -1 || rating.compareTo(b2) == 0) {
				throw new ParameterException("您输入的借款年利率超出范围，请重新输入");
			}
			describe = query.getDescribe();
			if (StringHelper.isEmpty(describe)) {
				throw new ParameterException("借款描述不能为空");
			}
			if (describe.length() > 500 || describe.length() < 20) {
				throw new ParameterException("借款描述应限制在20-500字之间");
			}
			isRead = query.getIsread();
			if (isRead == 0) {
				throw new ParameterException("请同意我们的条款");
			}
			
			String moneys = "100";
			//每份金额
			BigDecimal mfje = new BigDecimal(moneys);
			//获取份数
			BigDecimal size = money.divide(mfje,2,BigDecimal.ROUND_HALF_DOWN);
			BigDecimal d = new BigDecimal(100);
			BigDecimal y = new BigDecimal(12);
			//月利率
			BigDecimal mln = trating.divide(y,2,BigDecimal.ROUND_HALF_DOWN).divide(d,2,BigDecimal.ROUND_HALF_DOWN);
			BigDecimal one = new BigDecimal(1);
			BigDecimal s1 = (one.add(mln)).pow(month);
			BigDecimal ylv = mfje.multiply(mln).multiply(s1).divide(s1.subtract(one),2,BigDecimal.ROUND_HALF_DOWN);
			
			if(getType.equals(TenderRepayment.MYHKDQHB2.name())){
				mybx = mln.multiply(mfje).setScale(2, BigDecimal.ROUND_HALF_DOWN).multiply(size).setScale(2, BigDecimal.ROUND_HALF_DOWN);
			}
			
			BigDecimal glfl = new BigDecimal(configureProvider.getProperty(SystemVariable.LMONEY_SUCCESS_RATION));
			jkglf = money.multiply(glfl).setScale(2, BigDecimal.ROUND_HALF_DOWN);
			
			
			//债权ID
			zqid = getCrid(CreditType.SYD.name());
			Calendar now = Calendar.getInstance();
			//当年年份获取后两位
			String dl = (now.get(Calendar.YEAR)+"").substring(2, 4);
			String mon = "";
			int m = now.get(Calendar.MONTH)+1;
			if(m<10){
				mon = "0"+m;
			}else{mon = m+"";}
			//当天月份
			String dy = mon;
			//当天几号
			int dt=now.get(Calendar.DATE);
			if(zqid<=0 || dt==1){
				zqid = IntegerParser.parse(dl+dy+"0001");
			}else{
				zqid = zqid+1;
			}
			
		}
		execute(getConnection(),
				"UPDATE  T6036 SET F02=?,F03=?,F04=?,F05=?,F06=?,F08=?,F09=?,F10=?,F11=?,F12=?,F13=?,F16=?,F17=?,F19=?,F20=?,F37=? WHERE F01 = ?",
				serviceResource.getSession().getAccountId(), zqid, query.getTitle(),
				query.getLmuse(), query.getMoney(), query.getCtime(),
				rating, query.getPeriod(), getType,
				query.getLtime(), mybx, jkglf,
				query.getDescribe(), query.getLtype(), query.getLstatus(),
				query.getOnemoney(), query.getId());
	}

	@Override
	public int getCrid(String type) throws Throwable {
		StringBuffer sb = new StringBuffer();
		sb.append(" select max(F03) from  ");
		sb.append(" T6036 where date_format(F26,'%Y-%m')=date_format(now(),'%Y-%m') ");
		List<Object> parameters = new ArrayList<Object>();
		if (!StringHelper.isEmpty(type)) {
//			sb.append(" AND T6036.F19=? ");
//			parameters.add(type);
		}
		return select(getConnection(), new ItemParser<Integer>() {
			@Override
			public Integer parse(ResultSet rs) throws SQLException {
				int id = 0;
				if (rs.next()) {
					id = rs.getInt(1);
				}
				return id;
			}
		}, sb.toString(), parameters);
	}

	@Override
	public void update(int id, String status) throws Throwable {
		execute(getConnection("S60"), "UPDATE  T6036 SET F20=? WHERE F01 = ?",
				status, id);
	}

	@Override
	public AttestationState getAttentiontype(AttestationType type)
			throws Throwable {
		return select(getConnection(), new ItemParser<AttestationState>() {
			@Override
			public AttestationState parse(ResultSet resultSet)
					throws SQLException {
				AttestationState state = null;
				if (resultSet.next()) {
					state = EnumParser.parse(AttestationState.class, resultSet.getString(1));
				}
				return state;
			}
		}, "select f04 from T6017 where f01 = ? and f02=?", serviceResource.getSession().getAccountId(),type.name());
	}

	@Override
	public boolean isyq() throws Throwable {
		return select(getConnection(), new ItemParser<Boolean>() {
			@Override
			public Boolean parse(ResultSet rs) throws SQLException {
				boolean is = false;
				if(rs.next()){
					int total = rs.getInt(1);
					if(total>0){
						is = true;
					}
				}
				return is;
			}
		}, "SELECT COUNT(*) total FROM T6041 WHERE F07>0 AND F12='WH' AND F03=?", serviceResource.getSession().getAccountId());
	}
}
