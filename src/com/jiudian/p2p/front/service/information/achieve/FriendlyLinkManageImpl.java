package com.jiudian.p2p.front.service.information.achieve;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.jiudian.framework.service.ServiceFactory;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.framework.service.query.ArrayParser;
import com.jiudian.framework.service.query.ItemParser;
import com.jiudian.p2p.front.service.information.FriendlyLinkManage;
import com.jiudian.p2p.front.service.information.entity.FriendlyLink;

public class FriendlyLinkManageImpl extends AbstractInformationService
		implements FriendlyLinkManage {

	public static class FriendlyLinkManageFactory implements
			ServiceFactory<FriendlyLinkManage> {

		@Override
		public FriendlyLinkManage newInstance(ServiceResource serviceResource) {
			return new FriendlyLinkManageImpl(serviceResource);
		}

	}

	public FriendlyLinkManageImpl(ServiceResource serviceResource) {
		super(serviceResource);
	}

	@Override
	public FriendlyLink[] getAll() throws Throwable {
		return selectAll(getConnection(), new ArrayParser<FriendlyLink>() {

			@Override
			public FriendlyLink[] parse(ResultSet resultSet)
					throws SQLException {
				ArrayList<FriendlyLink> list = null;
				while (resultSet.next()) {
					FriendlyLink friendlyLink = new FriendlyLink();
					friendlyLink.id = resultSet.getInt(1);
					friendlyLink.name = resultSet.getString(2);
					friendlyLink.url = resultSet.getString(3);
					friendlyLink.imageCode = resultSet.getString(4);
					if (list == null) {
						list = new ArrayList<>();
					}
					list.add(friendlyLink);
				}
				return list == null || list.size() == 0 ? null : list
						.toArray(new FriendlyLink[list.size()]);
			}
		}, "SELECT F01,F04,F05,F09 FROM T5014 ORDER BY F03 DESC");
	}

	@Override
	public FriendlyLink get(int id) throws Throwable {
		if (id <= 0) {
			return null;
		}
		return select(getConnection(), new ItemParser<FriendlyLink>() {

			@Override
			public FriendlyLink parse(ResultSet resultSet) throws SQLException {
				FriendlyLink friendlyLink = null;
				if (resultSet.next()) {
					friendlyLink = new FriendlyLink();
					friendlyLink.id = resultSet.getInt(1);
					friendlyLink.name = resultSet.getString(2);
					friendlyLink.url = resultSet.getString(3);

				}
				return friendlyLink;
			}
		}, "SELECT F01,F04,F05 FROM T5014 WHERE F01 = ?", id);
	}

	@Override
	public void view(int id) throws Throwable {
		if (id <= 0) {
			return;
		}
		execute(getConnection(),
				"UPDATE T5014 SET F02 = F02 + 1 WHERE F01 = ? ", id);

	}

}
