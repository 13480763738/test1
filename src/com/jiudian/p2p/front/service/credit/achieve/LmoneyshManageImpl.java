package com.jiudian.p2p.front.service.credit.achieve;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.jiudian.framework.service.ServiceFactory;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.framework.service.exception.ParameterException;
import com.jiudian.framework.service.query.ItemParser;
import com.jiudian.p2p.common.enums.CreditCycle;
import com.jiudian.p2p.front.service.credit.LmoneyshManage;
import com.jiudian.p2p.front.service.credit.entity.Lmoneysh;
import com.jiudian.util.StringHelper;
import com.jiudian.util.parser.EnumParser;

public class LmoneyshManageImpl extends AbstractAccountService implements
		LmoneyshManage {

	public LmoneyshManageImpl(ServiceResource serviceResource) {
		super(serviceResource);
	}

	public static class LmoneyshManageFactory implements
			ServiceFactory<LmoneyshManage> {
		@Override
		public LmoneyshManage newInstance(ServiceResource serviceResource) {
			return new LmoneyshManageImpl(serviceResource);
		}
	}

	@Override
	public Lmoneysh getLmoneysh(String type) throws Throwable {
		int id = serviceResource.getSession().getAccountId();
		if (id == 0) {
			throw new ParameterException("不能存在当前用户！");
		}
		StringBuffer sb = new StringBuffer();
		List<Object> parameters = new ArrayList<Object>();
		sb.append(" SELECT r.F06,r.F09,u.F01,r.F08,u.F03,u.F09,u.F18,u.F25,c.F04,w.F04,w.F06,w.F15,z.F02,z.F05,z.F07,a.F02,le.F02,r.F20,gs.F04,gs.F12,gs.F14,r.F10 FROM  ");
		sb.append(" T6011 AS u,T6012 AS c,T6013 AS w,T6014 AS gs,T6015 AS z,T6016 AS a,T6036 AS r,T6021 AS le ");
		sb.append(" where u.F01=c.F01 AND u.F01 = w.F01 AND u.F01 = gs.F01 AND u.F01=z.F01 AND u.F01 = a.F01 AND u.F01=le.F01 ");
		sb.append(" AND u.F01 = r.F02 AND r.F20 <> 'YJQ' AND r.F20 <> 'LB' AND r.F20 <> 'YFK' ");
		if (id > 0) {
			sb.append(" AND r.F02=? ");
			parameters.add(id);
		}
		if (!StringHelper.isEmpty(type)) {
			sb.append(" AND r.F19=? ");
			parameters.add(type);
		}
		return select(getConnection(), new ItemParser<Lmoneysh>() {
			@Override
			public Lmoneysh parse(ResultSet rs) throws SQLException {
				Lmoneysh l = new Lmoneysh();
				if (rs.next()) {
					l.money = rs.getBigDecimal(1);
					l.rating = rs.getBigDecimal(2);
					l.acount = rs.getInt(3);
					l.Ctime = rs.getInt(4);
					l.Isphone = rs.getString(5);
					l.Isidcard = rs.getString(6);
					l.Iseducation = rs.getString(7);
					l.Isjuzhu = rs.getString(8);
					l.Ismarrige = rs.getString(9);
					l.Iswork = rs.getString(10);
					l.Ispst = rs.getString(11);
					l.Ismmoney = rs.getString(12);
					l.IsCredit = rs.getString(13);
					l.Ishousean = rs.getString(14);
					l.Iscaran = rs.getString(15);
					l.Iswoboan = rs.getString(16);
					l.integral = rs.getInt(17);
					l.type = rs.getString(18);
					l.isgs = rs.getString(19);
					l.isgssr = rs.getString(20);
					l.isgsjszc = rs.getString(21);
					l.creditCycle = EnumParser.parse(CreditCycle.class,
							rs.getString(22));
				}
				return l;
			}
		}, sb.toString(), parameters);
	}

}
