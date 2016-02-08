package com.jiudian.p2p.front.service.financing.achieve;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.jiudian.framework.data.sql.SQLConnectionProvider;
import com.jiudian.framework.resource.ResourceNotFoundException;
import com.jiudian.framework.service.AbstractService;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.framework.service.query.ItemParser;
import com.jiudian.p2p.front.config.FrontConst;

public abstract class AbstractFinancingManage extends AbstractService {

    public AbstractFinancingManage(final ServiceResource serviceResource) {
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
    
    protected SQLConnectionProvider getSQLConnectionProvider()
			throws ResourceNotFoundException, SQLException {
		return serviceResource.getDataConnectionProvider(
				SQLConnectionProvider.class, FrontConst.DB_USER);
	}
    
    protected BigDecimal selectBigDecimal(String db, String sql,
			Object... paramters) throws SQLException {
		final BigDecimal decimal = new BigDecimal(0);
		return select(getConnection(db), new ItemParser<BigDecimal>() {
			@Override
			public BigDecimal parse(ResultSet resultSet) throws SQLException {
				if (resultSet.next()) {
					return resultSet.getBigDecimal(1);
				}
				return decimal;
			}
		}, sql, paramters);
	}
	
	protected int selectInt(String db, String sql,
			Object... paramters) throws SQLException {
		final Integer decimal = new Integer(0);
		return select(getConnection(db), new ItemParser<Integer>() {
			@Override
			public Integer parse(ResultSet resultSet) throws SQLException {
				if (resultSet.next()) {
					return resultSet.getInt(1);
				}
				return decimal;
			}
		}, sql, paramters);
	}
	
	protected String selectString(String db, String sql,
			Object... paramters) throws SQLException {
		final String decimal = null ;
		return select(getConnection(db), new ItemParser<String>() {
			@Override
			public String parse(ResultSet resultSet) throws SQLException {
				if (resultSet.next()) {
					return resultSet.getString(1);
				}
				return decimal;
			}
		}, sql, paramters);
	}

    
}
