package com.jiudian.p2p.front.config.data.prd;

import com.jiudian.framework.data.sql.mysql.AbstractPooledConnectionProvider;
import com.jiudian.framework.log.Logger;
import com.jiudian.framework.resource.InitParameterProvider;
import com.jiudian.framework.resource.ResourceAnnotation;
import com.jiudian.framework.resource.ResourceRetention;
import com.jiudian.p2p.variables.P2PConst;

@ResourceAnnotation({ ResourceRetention.PRE_PRODUCTION,
		ResourceRetention.PRODUCTION })
public class Master extends AbstractPooledConnectionProvider {

	public Master(InitParameterProvider parameterProvider, Logger logger) {
		super(parameterProvider, logger);
	}

	@Override
	public String getName() {
		return P2PConst.DB_MASTER_PROVIDER;
	}

}
