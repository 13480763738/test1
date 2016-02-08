package com.jiudian.p2p.front.service;

import java.sql.Connection;
import java.sql.SQLException;

import com.jiudian.framework.data.sql.SQLConnectionProvider;
import com.jiudian.framework.resource.ResourceNotFoundException;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.p2p.front.config.FrontConst;
import com.jiudian.p2p.service.AbstractP2PService;

public abstract class AbstractFrontService extends AbstractP2PService {

	public AbstractFrontService(ServiceResource serviceResource) {
		super(serviceResource);
	}

	protected SQLConnectionProvider getConnectionProvider()
			throws ResourceNotFoundException {
		return serviceResource.getDataConnectionProvider(
				SQLConnectionProvider.class, FrontConst.DB_MASTER_PROVIDER);
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
