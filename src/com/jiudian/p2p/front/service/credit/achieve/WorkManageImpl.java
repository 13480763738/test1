package com.jiudian.p2p.front.service.credit.achieve;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.jiudian.framework.service.ServiceFactory;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.framework.service.exception.ParameterException;
import com.jiudian.framework.service.query.ItemParser;
import com.jiudian.p2p.front.service.credit.WorkManage;
import com.jiudian.p2p.front.service.credit.entity.Work;
import com.jiudian.p2p.front.service.credit.entity.WorkQuery;

public class WorkManageImpl extends AbstractAccountService implements
		WorkManage {

	public WorkManageImpl(ServiceResource serviceResource) {
		super(serviceResource);
	}

	public static class WorkManageFactory implements ServiceFactory<WorkManage> {
		@Override
		public WorkManage newInstance(ServiceResource serviceResource) {
			return new WorkManageImpl(serviceResource);
		}
	}

	@Override
	public Work getWork() throws Throwable {
		int acount = serviceResource.getSession().getAccountId();
		if (acount == 0) {
			throw new ParameterException("不能存在当前用户！");
		}
		StringBuffer sb = new StringBuffer();
		List<Object> parameters = new ArrayList<Object>();
		sb.append("SELECT F01,F02,F03,F04,F05,F06,F07,F08,F09,F10,F11,F12,F13,F14,F15,F16  FROM T6013 WHERE 1=1 ");
		if (acount > 0) {
			sb.append(" AND F01=? ");
			parameters.add(acount);
		}
		return select(getConnection(), new ItemParser<Work>() {
			@Override
			public Work parse(ResultSet rs) throws SQLException {
				Work w = null;
				if (rs.next()) {
					w = new Work();
					w.acount = rs.getInt(1);
					w.Status = rs.getString(2);
					w.Name = rs.getString(3);
					w.Iswork = rs.getString(4);
					w.Post = rs.getString(5);
					w.Ispst = rs.getString(6);
					w.Emil = rs.getString(7);
					w.City = rs.getString(8);
					w.Address = rs.getString(9);
					w.Type = rs.getString(10);
					w.Profession = rs.getString(11);
					w.Scale = rs.getString(12);
					w.Gznew = rs.getString(13);
					w.Mmoney = rs.getString(14);
					w.Ismmoney = rs.getString(15);
					w.Cellnumber = rs.getString(16);
				}
				return w;
			}
		}, sb.toString(), parameters);
	}

	@Override
	public void update(WorkQuery query) throws Throwable {
		if (query == null) {
			throw new ParameterException("没有工作信息");
		}
		execute(getConnection(),
				"UPDATE  T6013 SET F02=?,F03=?,F05=?,F07=?,F08=?,F09=?,F10=?,F11=?,F12=?,F13=?,F14=?,F16=? WHERE F01 = ?",
				query.getStatus(), query.getName(), query.getPost(),
				query.getEmil(), query.getCity(), query.getAddress(),
				query.getType(), query.getProfession(), query.getScale(),
				query.getGznew(), query.getMmoney(), query.getCellnumber(),
				serviceResource.getSession().getAccountId());
	}

}
