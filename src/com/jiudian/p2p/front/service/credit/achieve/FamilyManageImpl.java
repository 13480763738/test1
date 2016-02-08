package com.jiudian.p2p.front.service.credit.achieve;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.jiudian.framework.service.ServiceFactory;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.framework.service.exception.ParameterException;
import com.jiudian.framework.service.query.ItemParser;
import com.jiudian.p2p.front.service.credit.FamilyManage;
import com.jiudian.p2p.front.service.credit.entity.Family;
import com.jiudian.p2p.front.service.credit.entity.FamilyQuery;

public class FamilyManageImpl extends AbstractAccountService implements
		FamilyManage {

	public FamilyManageImpl(ServiceResource serviceResource) {
		super(serviceResource);
	}

	public static class FamilyManageFactory implements
			ServiceFactory<FamilyManage> {
		@Override
		public FamilyManage newInstance(ServiceResource serviceResource) {
			return new FamilyManageImpl(serviceResource);
		}
	}

	@Override
	public Family getFamily() throws Throwable {
		int acount = serviceResource.getSession().getAccountId();
		if (acount == 0) {
			throw new ParameterException("不能存在当前用户！");
		}
		StringBuffer sb = new StringBuffer();
		List<Object> parameters = new ArrayList<Object>();
		sb.append("SELECT F01,F02,F03,F04,F05,F06,F07,F08,F09,F10  FROM T6012 WHERE 1=1 ");
		if (acount > 0) {
			sb.append(" AND F01=? ");
			parameters.add(acount);
		}
		return select(getConnection(), new ItemParser<Family>() {
			@Override
			public Family parse(ResultSet rs) throws SQLException {
				Family family = null;
				if (rs.next()) {
					family = new Family();
					family.acount = rs.getInt(1);
					family.Marriagestatus = rs.getString(2);
					family.Ischildren = rs.getString(3);
					family.Ismarrige = rs.getString(4);
					family.Zxname = rs.getString(5);
					family.Zxrelation = rs.getString(6);
					family.Zxphone = rs.getString(7);
					family.Qtname = rs.getString(8);
					family.Qtrelation = rs.getString(9);
					family.Qtphone = rs.getString(10);
				}
				return family;
			}
		}, sb.toString(), parameters);
	}

	@Override
	public void update(FamilyQuery query) throws Throwable {
		if (query == null) {
			throw new ParameterException("没有家庭信息");
		}
		execute(getConnection(),
				"UPDATE  T6012 SET F02=?,F03=?,F05=?,F06=?,F07=?,F08=?,F09=?,F10=? WHERE F01 = ?",
				query.getMarriagestatus(), query.getIschildren(),
				query.getZxname(), query.getZxrelation(), query.getZxphone(),
				query.getQtname(), query.getQtrelation(), query.getQtphone(),
				serviceResource.getSession().getAccountId());
	}

}
