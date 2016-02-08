package com.jiudian.p2p.front.service.credit.achieve;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.jiudian.framework.service.ServiceFactory;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.framework.service.exception.ParameterException;
import com.jiudian.framework.service.query.ItemParser;
import com.jiudian.p2p.front.service.credit.CompanyManage;
import com.jiudian.p2p.front.service.credit.entity.Company;
import com.jiudian.p2p.front.service.credit.entity.CompanyQuery;

public class CompanyManageImpl extends AbstractAccountService implements
		CompanyManage {

	public CompanyManageImpl(ServiceResource serviceResource) {
		super(serviceResource);
	}

	public static class CompanyManageFactory implements
			ServiceFactory<CompanyManage> {
		@Override
		public CompanyManage newInstance(ServiceResource serviceResource) {
			return new CompanyManageImpl(serviceResource);
		}
	}

	@Override
	public Company getCompany() throws Throwable {
		int acount = serviceResource.getSession().getAccountId();
		if (acount == 0) {
			throw new ParameterException("不能存在当前用户！");
		}
		StringBuffer sb = new StringBuffer();
		List<Object> parameters = new ArrayList<Object>();
		sb.append("SELECT F01,F02,F03,F04,F05,F06,F07,F08,F09,F10,F11,F12,F13,F14,F15,F16  FROM T6014 WHERE 1=1 ");
		if (acount > 0) {
			sb.append(" AND F01=? ");
			parameters.add(acount);
		}
		return select(getConnection(), new ItemParser<Company>() {
			@Override
			public Company parse(ResultSet rs) throws SQLException {
				Company co = null;
				if (rs.next()) {
					co = new Company();
					co.Id = rs.getInt(1);
					co.Status = rs.getString(2);
					co.name = rs.getString(3);
					co.Isattestation = rs.getString(4);
					co.City = rs.getString(5);
					co.Address = rs.getString(6);
					co.CompanyType = rs.getString(7);
					co.Companyhy = rs.getString(8);
					co.Companygm = rs.getString(9);
					co.Companytime = rs.getString(10);
					co.Mmoney = rs.getString(11);
					co.IsMmoney = rs.getString(12);
					co.Companyzy = rs.getString(13);
					co.Iscompanyzy = rs.getString(14);
					co.Call = rs.getString(15);
					co.Emil = rs.getString(16);
				}
				return co;
			}
		}, sb.toString(), parameters);
	}

	@Override
	public void update(CompanyQuery query) throws Throwable {
		if (query == null) {
			throw new ParameterException("没有其他信息");
		}
		execute(getConnection(),
				"UPDATE  T6014 SET F02=?,F03=?,F05=?,F06=?,F07=?,F08=?,F09=?,F10=?,F11=?,F13=?,F15=?,F16=? WHERE F01 = ?",
				query.getStatus(), query.getName(), query.getCity(),
				query.getAddress(), query.getCompanyType(),
				query.getCompanyhy(), query.getCompanygm(),
				query.getCompanytime(), query.getMmoney(),
				query.getCompanyzy(), query.getCall(), query.getEmil(),
				serviceResource.getSession().getAccountId());

	}

}
