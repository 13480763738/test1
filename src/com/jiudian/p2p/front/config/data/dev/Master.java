package com.jiudian.p2p.front.config.data.dev;

import java.util.Properties;

import com.jiudian.framework.data.sql.mysql.AbstractDriverConnectionProvider;
import com.jiudian.framework.log.Logger;
import com.jiudian.framework.resource.InitParameterProvider;
import com.jiudian.framework.resource.ResourceAnnotation;
import com.jiudian.framework.resource.ResourceRetention;
import com.jiudian.p2p.variables.P2PConst;

@ResourceAnnotation(ResourceRetention.DEVELOMENT)
public class Master extends AbstractDriverConnectionProvider {

	public Master(InitParameterProvider parameterProvider, Logger logger) {
		super(parameterProvider, logger);
		driver = "com.mysql.jdbc.Driver";
		url = "jdbc:mysql://localhost:3306/S50";
		properties = new Properties();
		properties.setProperty("user", "root");
		properties.setProperty("password", "root");
		properties.setProperty("useUnicode", "true");
		properties.setProperty("characterEncoding", "UTF8");
	}

	@Override
	public String getName() {
		return P2PConst.DB_MASTER_PROVIDER;
	}

}
