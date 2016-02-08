package com.jiudian.p2p.front.service.information.achieve;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.jiudian.framework.service.ServiceFactory;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.framework.service.query.ArrayParser;
import com.jiudian.framework.service.query.ItemParser;
import com.jiudian.p2p.common.enums.CustomerServiceType;
import com.jiudian.p2p.front.service.information.CustomerServiceManage;
import com.jiudian.p2p.front.service.information.entity.CustomerService;

public class CustomerServiceManageImpl extends AbstractInformationService
		implements CustomerServiceManage {

	public static class CustomerServiceManageFactory implements
			ServiceFactory<CustomerServiceManage> {

		@Override
		public CustomerServiceManage newInstance(ServiceResource serviceResource) {
			return new CustomerServiceManageImpl(serviceResource);
		}

	}

	protected static final ArrayParser<CustomerService> ARRAY_PARSER = new ArrayParser<CustomerService>() {

		@Override
		public CustomerService[] parse(ResultSet resultSet) throws SQLException {
			ArrayList<CustomerService> list = null;
			while (resultSet.next()) {
				CustomerService customerService = new CustomerService();
				customerService.id = resultSet.getInt(1);
				customerService.viewTimes = resultSet.getInt(2);
				customerService.type = CustomerServiceType.valueOf(resultSet
						.getString(3));
				customerService.name = resultSet.getString(4);
				customerService.number = resultSet.getString(5);
				customerService.imageCode = resultSet.getString(6);
				if (list == null) {
					list = new ArrayList<>();
				}
				list.add(customerService);
			}
			return list == null || list.size() == 0 ? null : list
					.toArray(new CustomerService[list.size()]);
		}
	};

	protected static final ItemParser<CustomerService> ITEM_PARSER = new ItemParser<CustomerService>() {
		public CustomerService parse(ResultSet resultSet) throws SQLException {
			CustomerService customerService = null;
			if (resultSet.next()) {
				customerService = new CustomerService();
				customerService.id = resultSet.getInt(1);
				customerService.viewTimes = resultSet.getInt(2);
				customerService.type = CustomerServiceType.valueOf(resultSet
						.getString(3));
				customerService.name = resultSet.getString(4);
				customerService.number = resultSet.getString(5);
				customerService.imageCode = resultSet.getString(6);
			}
			return customerService;
		};
	};

	public CustomerServiceManageImpl(ServiceResource serviceResource) {
		super(serviceResource);
	}

	@Override
	public CustomerService[] getAll(CustomerServiceType customerServiceType)
			throws Throwable {
		if (customerServiceType == null) {
			return null;
		}
		return selectAll(
				getConnection(),
				ARRAY_PARSER,
				"SELECT F01,F02,F03,F05,F06,F07 FROM T5012 WHERE F03 = ? ORDER BY F04 DESC,F10 DESC",
				customerServiceType);
	}

	@Override
	public CustomerService get(int id) throws Throwable {
		if (id <= 0) {
			return null;
		}
		return select(getConnection(), ITEM_PARSER,
				"SELECT F01,F02,F03,F05,F06,F07 FROM T5012 WHERE F01 = ? ", id);
	}

	@Override
	public void view(int id) throws Throwable {
		if (id <= 0) {
			return;
		}
		execute(getConnection(),
				"UPDATE T5012 SET F02 = F02 + 1 WHERE F01 = ? ", id);

	}

}
