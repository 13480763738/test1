package com.jiudian.p2p.front.service.information.achieve;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.jiudian.framework.service.ServiceFactory;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.framework.service.query.ArrayParser;
import com.jiudian.framework.service.query.ItemParser;
import com.jiudian.p2p.front.service.information.PartnerManage;
import com.jiudian.p2p.front.service.information.entity.Partner;

public class PartnerManageImpl extends AbstractInformationService implements
		PartnerManage {

	public static final class PartnerManageFactory implements
			ServiceFactory<PartnerManage> {

		@Override
		public PartnerManage newInstance(ServiceResource serviceResource) {
			return new PartnerManageImpl(serviceResource);
		}
	}

	public PartnerManageImpl(ServiceResource serviceResource) {
		super(serviceResource);
	}

	@Override
	public Partner[] getAll() throws Throwable {
		return selectAll(getConnection(), new ArrayParser<Partner>() {

			@Override
			public Partner[] parse(ResultSet resultSet) throws SQLException {
				ArrayList<Partner> list = null;
				while (resultSet.next()) {
					Partner partner = new Partner();
					partner.id = resultSet.getInt(1);
					partner.name = resultSet.getString(2);
					partner.url = resultSet.getString(3);
					partner.imageCode = resultSet.getString(4);
					if (list == null) {
						list = new ArrayList<>();
					}
					list.add(partner);
				}
				return list == null || list.size() == 0 ? null : list
						.toArray(new Partner[list.size()]);
			}
		}, "SELECT F01,F04,F05,F06 FROM T5013 ORDER BY F02 DESC");
	}

	@Override
	public Partner get(int id) throws Throwable {
		if (id <= 0) {
			return null;
		}
		return select(getConnection(), new ItemParser<Partner>() {

			@Override
			public Partner parse(ResultSet resultSet) throws SQLException {
				Partner partner = null;
				if (resultSet.next()) {
					partner = new Partner();
					partner.id = resultSet.getInt(1);
					partner.name = resultSet.getString(2);
					partner.url = resultSet.getString(3);
					partner.imageCode = resultSet.getString(4);

				}
				return partner;
			}
		}, "SELECT F01,F04,F05,F06 FROM T5013 WHERE F01 = ?", id);
	}

	@Override
	public void view(int id) throws Throwable {
		if (id <= 0) {
			return;
		}
		execute(getConnection(),
				"UPDATE T5013 SET F03 = F03 + 1 WHERE F01 = ?", id);

	}


}
