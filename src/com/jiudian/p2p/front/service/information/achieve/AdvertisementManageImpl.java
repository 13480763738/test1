package com.jiudian.p2p.front.service.information.achieve;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.jiudian.framework.service.ServiceFactory;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.framework.service.query.ArrayParser;
import com.jiudian.p2p.common.enums.Sblx;
import com.jiudian.p2p.front.config.FrontConst;
import com.jiudian.p2p.front.service.information.AdvertisementManage;
import com.jiudian.p2p.front.service.information.entity.Advertisement;

public class AdvertisementManageImpl extends AbstractInformationService
		implements AdvertisementManage {
	public static class AdvertisementManageFactory implements
			ServiceFactory<AdvertisementManage> {

		@Override
		public AdvertisementManage newInstance(ServiceResource serviceResource) {
			return new AdvertisementManageImpl(serviceResource);
		}

	}

	public AdvertisementManageImpl(ServiceResource serviceResource) {
		super(serviceResource);
	}

	@Override
	public Advertisement[] getAll(Sblx sblx) throws Throwable {
		return selectAll(
				getConnection(),
				new ArrayParser<Advertisement>() {

					@Override
					public Advertisement[] parse(ResultSet resultSet)
							throws SQLException {
						ArrayList<Advertisement> list = null;
						while (resultSet.next()) {
							Advertisement adv = new Advertisement();
							adv.id = resultSet.getInt(1);
							adv.title = resultSet.getString(2);
							adv.url = resultSet.getString(3);
							adv.imageCode = resultSet.getString(4);
							if (list == null) {
								list = new ArrayList<>();
							}
							list.add(adv);
						}
						return list == null || list.size() == 0 ? null : list
								.toArray(new Advertisement[list.size()]);
					}
				},
				"SELECT F01, F03, F04, F05 FROM T5016 WHERE F11=? AND F07 <= CURRENT_TIMESTAMP() AND F08 >= CURRENT_TIMESTAMP() ORDER BY F02 DESC",sblx);
	}

	@Override
	public int getUserNum() throws Throwable {
		int num = 0;
		try (Connection conn = getConnection(FrontConst.DB_USER)) {
			try (PreparedStatement pst = conn
					.prepareStatement("SELECT COUNT(*) FROM T6010")) {
				try (ResultSet rst = pst.executeQuery()) {
					if (rst.next()) {
						num = rst.getInt(1);
					}
				}
			}
		}
		return num;
	}

}
