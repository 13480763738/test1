package com.jiudian.p2p.front.service.information.achieve;

import java.sql.Connection;
import java.sql.SQLException;

import com.jiudian.framework.data.sql.SQLConnectionProvider;
import com.jiudian.framework.resource.ResourceNotFoundException;
import com.jiudian.framework.service.AbstractService;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.p2p.front.config.FrontConst;

public abstract class AbstractInformationService extends AbstractService {

	public AbstractInformationService(ServiceResource serviceResource) {
		super(serviceResource);
	}

	protected Connection getConnection() throws ResourceNotFoundException,
			SQLException {
		return serviceResource.getDataConnectionProvider(
				SQLConnectionProvider.class, FrontConst.DB_MASTER_PROVIDER)
				.getConnection(FrontConst.DB_INFORMATION);
	}

	protected Connection getConnection(String db)
			throws ResourceNotFoundException, SQLException {
		return serviceResource.getDataConnectionProvider(
				SQLConnectionProvider.class, FrontConst.DB_MASTER_PROVIDER)
				.getConnection(db);
	}
}
