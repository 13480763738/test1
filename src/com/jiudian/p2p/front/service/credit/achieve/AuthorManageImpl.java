package com.jiudian.p2p.front.service.credit.achieve;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.jiudian.framework.service.ServiceFactory;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.framework.service.exception.ParameterException;
import com.jiudian.framework.service.query.ItemParser;
import com.jiudian.p2p.front.service.credit.AuthorManage;
import com.jiudian.p2p.front.service.credit.entity.Author;
import com.jiudian.p2p.front.service.credit.entity.AuthorQuery;

public class AuthorManageImpl extends AbstractAccountService implements
		AuthorManage {

	public AuthorManageImpl(ServiceResource serviceResource) {
		super(serviceResource);
	}

	public static class AuthorManageFactory implements
			ServiceFactory<AuthorManage> {
		@Override
		public AuthorManage newInstance(ServiceResource serviceResource) {
			return new AuthorManageImpl(serviceResource);
		}
	}

	@Override
	public Author getAuthor() throws Throwable {
		int acount = serviceResource.getSession().getAccountId();
		if (acount == 0) {
			throw new ParameterException("不能存在当前用户！");
		}
		StringBuffer sb = new StringBuffer();
		List<Object> parameters = new ArrayList<Object>();
		sb.append("SELECT F01,F02 FROM T6016 WHERE 1=1 ");
		if (acount > 0) {
			sb.append(" AND F01=? ");
			parameters.add(acount);
		}
		return select(getConnection(), new ItemParser<Author>() {
			@Override
			public Author parse(ResultSet rs) throws SQLException {
				Author ar = null;
				if (rs.next()) {
					ar = new Author();
					ar.acount = rs.getInt(1);
					ar.Iswoboan = rs.getString(2);
				}
				return ar;
			}
		}, sb.toString(), parameters);
	}

	@Override
	public void update(AuthorQuery query) throws Throwable {
		if (query == null) {
			throw new ParameterException("没有其他信息");
		}
		execute(getConnection(),
				"UPDATE  T6016 SET F02=? WHERE F01 = ?",
				query.getIswoboan(), query.getAcount());
	}

}
