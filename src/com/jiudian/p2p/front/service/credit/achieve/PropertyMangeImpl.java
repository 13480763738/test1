package com.jiudian.p2p.front.service.credit.achieve;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.jiudian.framework.service.ServiceFactory;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.framework.service.exception.ParameterException;
import com.jiudian.framework.service.query.ItemParser;
import com.jiudian.p2p.front.service.credit.PropertyMange;
import com.jiudian.p2p.front.service.credit.entity.Property;
import com.jiudian.p2p.front.service.credit.entity.PropertyQuery;

public class PropertyMangeImpl extends AbstractAccountService implements
		PropertyMange {

	public PropertyMangeImpl(ServiceResource serviceResource) {
		super(serviceResource);
	}

	public static class PropertyMangeFactory implements
			ServiceFactory<PropertyMange> {
		@Override
		public PropertyMange newInstance(ServiceResource serviceResource) {
			return new PropertyMangeImpl(serviceResource);
		}
	}

	@Override
	public Property getProperty() throws Throwable {
		int acount = serviceResource.getSession().getAccountId();
		if (acount == 0) {
			throw new ParameterException("不能存在当前用户！");
		}
		StringBuffer sb = new StringBuffer();
		List<Object> parameters = new ArrayList<Object>();
		sb.append("SELECT F01,F02,F03,F04,F05,F06,F07,F08,F09,F10,F11 FROM T6015 WHERE 1=1 ");
		if (acount > 0) {
			sb.append(" AND F01=? ");
			parameters.add(acount);
		}
		return select(getConnection(), new ItemParser<Property>() {
			@Override
			public Property parse(ResultSet rs) throws SQLException {
				Property p = null;
				if (rs.next()) {
					p = new Property();
					p.acount = rs.getInt(1);
					p.IsCredit = rs.getString(2);
					p.Ishouse = rs.getString(3);
					p.Ishouseloan = rs.getString(4);
					p.Ishousean = rs.getString(5);
					p.Iscar = rs.getString(6);
					p.Iscaran = rs.getString(7);
					p.Iscarloan = rs.getString(8);
					p.gcnf = rs.getInt(9);
					p.qcpp = rs.getString(10);
					p.cphm = rs.getString(11);
					
				}
				return p;
			}
		}, sb.toString(), parameters);
	}

	@Override
	public void update(PropertyQuery query) throws Throwable {
		if (query == null) {
			throw new ParameterException("没有资产信息");
		}
		execute(getConnection(),
				"UPDATE  T6015 SET F03=?,F04=?,F06=?,F08=?,F09=?,F10=?,F11=? WHERE F01 = ?",
				query.getIshouse(), query.getIshouseloan(), query.getIscar(),
				query.getIscarloan(),query.getGcnf(),query.getQcpp(),query.getCphm(),serviceResource.getSession().getAccountId());

	}

}
