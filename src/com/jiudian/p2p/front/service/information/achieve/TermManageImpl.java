package com.jiudian.p2p.front.service.information.achieve;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.jiudian.framework.service.ServiceFactory;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.framework.service.query.ItemParser;
import com.jiudian.p2p.common.enums.TermType;
import com.jiudian.p2p.front.service.information.TermManage;
import com.jiudian.p2p.front.service.information.entity.Term;

public class TermManageImpl extends AbstractInformationService implements
		TermManage {

	public static class TermManageFactory implements ServiceFactory<TermManage> {

		@Override
		public TermManage newInstance(ServiceResource serviceResource) {
			return new TermManageImpl(serviceResource);
		}
	}

	public TermManageImpl(ServiceResource serviceResource) {
		super(serviceResource);
	}

	@Override
	public Term get(final TermType termType) throws Throwable {
		if (termType == null) {
			return null;
		}
		return select(getConnection(), new ItemParser<Term>() {
			@Override
			public Term parse(ResultSet resultSet) throws SQLException {
				Term term = null;
				if (resultSet.next()) {
					term = new Term();
					term.termType = termType;
					term.content = resultSet.getString(1);
					term.updateTime = resultSet.getTimestamp(2);
				}
				return term;
			}
		}, "SELECT F03, F06 FROM T5017 WHERE F01 = ?", termType);
	}

	@Override
	public String[] getAttachments(TermType termType) throws Throwable {
		if (termType == null) {
			return null;
		}
		try (Connection connection = getConnection();
				PreparedStatement pstmt = connection
						.prepareStatement("SELECT F02 FROM T5017_1 WHERE F01 = ?");) {
			pstmt.setString(1, termType.name());
			try (ResultSet resultSet = pstmt.executeQuery()) {
				ArrayList<String> list = null;
				while (resultSet.next()) {
					if (list == null) {
						list = new ArrayList<>();
					}
					list.add(resultSet.getString(1));
				}
				return list == null || list.size() == 0 ? null
						: new String[list.size()];
			}
		}
	}

	@Override
	public void view(TermType termType) throws Throwable {
		if (termType == null) {
			return;
		}
		execute(getConnection(),
				"UPDATE T5017 SET F02 = F02 + 1 WHERE F01 = ? ", termType);
	}
}
