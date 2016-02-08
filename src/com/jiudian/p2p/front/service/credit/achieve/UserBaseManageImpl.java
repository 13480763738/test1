package com.jiudian.p2p.front.service.credit.achieve;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.jiudian.framework.service.ServiceFactory;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.framework.service.exception.ParameterException;
import com.jiudian.framework.service.query.ItemParser;
import com.jiudian.p2p.front.service.credit.UserBaseManage;
import com.jiudian.p2p.front.service.credit.entity.UserBase;
import com.jiudian.p2p.front.service.credit.entity.UserBaseQuery;

public class UserBaseManageImpl extends AbstractAccountService implements
		UserBaseManage {

	public UserBaseManageImpl(ServiceResource serviceResource) {
		super(serviceResource);
	}

	public static class UserBaseManageFactory implements
			ServiceFactory<UserBaseManage> {
		@Override
		public UserBaseManage newInstance(ServiceResource serviceResource) {
			return new UserBaseManageImpl(serviceResource);
		}
	}

	@Override
	public UserBase getUsebase() throws Throwable {
		int acount = serviceResource.getSession().getAccountId();
		if (acount == 0) {
			throw new ParameterException("不能存在当前用户！");
		}
		StringBuffer sb = new StringBuffer();
		List<Object> parameters = new ArrayList<Object>();
		sb.append("SELECT F01,F06,F07,F02,F16,F17,F20,F21,F22,F23,F24,F26,F27,F09,F03,F18,F25 FROM T6011 WHERE 1=1 ");
		if (acount > 0) {
			sb.append(" AND F01=? ");
			parameters.add(acount);
		}
		return select(getConnection(), new ItemParser<UserBase>() {
			@Override
			public UserBase parse(ResultSet rs) throws SQLException {
				UserBase base = null;
				if (rs.next()) {
					base = new UserBase();
					base.acount = rs.getInt(1);
					base.Name = rs.getString(2);
					base.Idcard = rs.getString(3);
					base.Phonenumber = rs.getString(4);
					base.Sex = rs.getString(5);
					base.Education = rs.getString(6);
					base.Schooldata = rs.getInt(7);
					base.School = rs.getString(8);
					base.Jiguan = rs.getString(9);
					base.Hkszd = rs.getString(10);
					base.Region = rs.getString(11);
					base.Postcode = rs.getString(12);
					base.Cellnumber = rs.getString(13);
					base.Isidcard = rs.getString(14);
					base.Isphone = rs.getString(15);
					base.Iseducation = rs.getString(16);
					base.Isjuzhu = rs.getString(17);
				}
				return base;
			}
		}, sb.toString(), parameters);
	}

	@Override
	public void update(UserBaseQuery query) throws Throwable {
		if (query == null) {
			throw new ParameterException("没有基本信息");
		}
		execute(getConnection(),
				"UPDATE  T6011 SET F17=?,F20=?,F21=?,F22=?,F23=?,F24=?,F26=?,F27=? WHERE F01 = ?",
				query.getEducation(), query.getSchooldata(), query.getSchool(),
				query.getJiguan(), query.getHkszd(), query.getRegion(),
				query.getPostcode(), query.getCellnumber(), serviceResource.getSession().getAccountId());
	}
}
