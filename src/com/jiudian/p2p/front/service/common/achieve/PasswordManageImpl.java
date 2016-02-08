package com.jiudian.p2p.front.service.common.achieve;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.codec.digest.UnixCrypt;

import com.jiudian.framework.service.ServiceFactory;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.framework.service.exception.ParameterException;
import com.jiudian.p2p.front.config.FrontConst;
import com.jiudian.p2p.front.service.common.PasswordManage;
import com.jiudian.util.StringHelper;

public class PasswordManageImpl extends AbstractCommonService implements
		PasswordManage {

	public PasswordManageImpl(ServiceResource serviceResource) {
		super(serviceResource);
	}

	@Override
	public int emailExist(String email) throws Throwable {
		if (StringHelper.isEmpty(email)) {
			return 0;
		}
		try (Connection connection = getConnection(FrontConst.DB_USER)) {
			try (PreparedStatement ps = connection
					.prepareStatement("SELECT F01 FROM T6010 WHERE F05=? LIMIT 1")) {
				ps.setString(1, email);
				try (ResultSet resultSet = ps.executeQuery()) {
					if (resultSet.next()) {
						return resultSet.getInt(1);
					}
				}
			}
		}
		return 0;
	}

	@Override
	public int phoneExist(String phone) throws Throwable {
		if (StringHelper.isEmpty(phone)) {
			return 0;
		}
		try (Connection connection = getConnection(FrontConst.DB_USER)) {
			try (PreparedStatement ps = connection
					.prepareStatement("SELECT F01 FROM T6010 WHERE F04=? LIMIT 1")) {
				ps.setString(1, phone);
				try (ResultSet resultSet = ps.executeQuery()) {
					if (resultSet.next()) {
						return resultSet.getInt(1);
					}
				}
			}
		}
		return 0;
	}

	@Override
	public void updatePassword(String password, int userId) throws Throwable {
		if (StringHelper.isEmpty(password)) {
			throw new ParameterException("密码为空");
		} else if (userId <= 0) {
			throw new ParameterException("用户id不小于等于0");
		}
		try (Connection connection = getConnection(FrontConst.DB_USER)) {
			try (PreparedStatement ps = connection
					.prepareStatement("UPDATE T6010 SET F03=? WHERE F01=?")) {
				ps.setString(1, UnixCrypt.crypt(password,
						DigestUtils.sha256Hex(password)));
				ps.setInt(2, userId);
				ps.executeUpdate();
			}
		}
	}

	public static class PasswordManageFactory implements
			ServiceFactory<PasswordManage> {

		@Override
		public PasswordManage newInstance(ServiceResource serviceResource) {
			return new PasswordManageImpl(serviceResource);
		}

	}
}
