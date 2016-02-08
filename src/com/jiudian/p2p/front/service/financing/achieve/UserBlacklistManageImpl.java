package com.jiudian.p2p.front.service.financing.achieve;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.jiudian.framework.service.ServiceFactory;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.framework.service.query.ArrayParser;
import com.jiudian.framework.service.query.Paging;
import com.jiudian.framework.service.query.PagingResult;
import com.jiudian.p2p.common.enums.UserStatus;
import com.jiudian.p2p.front.config.FrontConst;
import com.jiudian.p2p.front.service.financing.UserBlacklistManage;
import com.jiudian.p2p.front.service.financing.entity.UserBlack;

public class UserBlacklistManageImpl extends AbstractFinancingManage implements UserBlacklistManage {

	public UserBlacklistManageImpl(ServiceResource serviceResource) {
		super(serviceResource);
	}
	
	public static class UserBlacklistManageFactory implements
	ServiceFactory<UserBlacklistManage> {
		@Override
		public UserBlacklistManage newInstance(ServiceResource serviceResource) {
			return new UserBlacklistManageImpl(serviceResource);
		}
		
	}

	@Override
	public PagingResult<UserBlack> search(Paging paging) throws Throwable {
		ArrayList<Object> parameters = new ArrayList<Object>();
		String sql="SELECT T6011.F29 img, T6011.F06 userName, T6011.F07 card, T6011.F24 address, T6011.F02 tel, T6011.F04 email, T6045.F02 yqCount, T6045.F03 yzyq, T6045.F04 zcyq, T6045.F05 dhje, T6010.F02 loginName,T6010.F01 userID FROM T6011, T6045, T6010 WHERE T6011.F01 = T6045.F01 AND T6011.F01 = T6010.F01 AND T6011.F28 = ?";
		parameters.add(UserStatus.S);
		return selectPaging(getConnection(FrontConst.DB_USER),
				new ArrayParser<UserBlack>() {
			@Override
			public UserBlack[] parse(ResultSet resultSet)
					throws SQLException {
				ArrayList<UserBlack> list = null;
				while (resultSet.next()) {
					UserBlack ub = new UserBlack();
					ub.imgPath = resultSet.getString(1);
					ub.realName = resultSet.getString(2);
					ub.card = resultSet.getString(3);
					ub.city = resultSet.getString(4);
					ub.telphone = resultSet.getString(5);
					ub.email = resultSet.getString(6);
					ub.yqCount = resultSet.getInt(7);
					ub.yzyqCount = resultSet.getInt(8);
					ub.zcyzyqDay = resultSet.getInt(9);
					ub.dhMoney = resultSet.getBigDecimal(10);
					ub.loginName = resultSet.getString(11);
					ub.userID = resultSet.getInt(12);
					if (list == null) {
						list = new ArrayList<>();
					}
					list.add(ub);
				}
				return list == null ? null : list
						.toArray(new UserBlack[list.size()]);
			}
		}, paging, sql,parameters);
	}

}
