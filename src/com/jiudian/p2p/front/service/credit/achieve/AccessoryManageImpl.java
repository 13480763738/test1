package com.jiudian.p2p.front.service.credit.achieve;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.jiudian.framework.http.upload.UploadFile;
import com.jiudian.framework.service.ServiceFactory;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.framework.service.exception.ParameterException;
import com.jiudian.framework.service.query.ItemParser;
import com.jiudian.p2p.front.service.credit.AccessoryManage;
import com.jiudian.p2p.front.service.credit.entity.AccessoryQuery;
import com.jiudian.util.StringHelper;

public class AccessoryManageImpl extends AbstractAccountService implements
		AccessoryManage {

	public AccessoryManageImpl(ServiceResource serviceResource) {
		super(serviceResource);
	}

	public static class AccessoryManageFactory implements
			ServiceFactory<AccessoryManage> {
		@Override
		public AccessoryManage newInstance(ServiceResource serviceResource) {
			return new AccessoryManageImpl(serviceResource);
		}
	}

	@Override
	public int getId( String type) throws Throwable {
		int account = serviceResource.getSession().getAccountId();
		if (account == 0 || StringHelper.isEmpty(type)) {
			throw new ParameterException("信息有误");
		}
		final List<Object> parameters = new ArrayList<>();
		final StringBuilder sb = new StringBuilder();
		sb.append("SELECT F01 FROM T6017 WHERE 1=1 ");
		if (account > 0) {
			sb.append(" AND F01=?");
			parameters.add(account);
		}
		if (!StringHelper.isEmpty(type)) {
			sb.append(" AND F02=?");
			parameters.add(type);
		}
		return select(getConnection(), new ItemParser<Integer>() {
			@Override
			public Integer parse(ResultSet rs) throws SQLException {
				int id = 0;
				if (rs.next()) {
					id = rs.getInt(1);
				}
				return id;
			}
		}, sb.toString(), parameters);
	}

	@Override
	public int addAccessory(AccessoryQuery query) throws Throwable {
		if (query == null) {
			throw new ParameterException("没有附件内容");
		}
		serviceResource.openTransactions();
		try (Connection connection = getConnection()) {
			int id = query.getId();
			//认证信息ID
			int xxid = 0;
			if(id>0){
			//附件类别(SFRZ:身份认证;SJSMRZ:手机实名认证;XLRZ:学历认证;JZDZM:居住地证明;JHRZ;结婚认证:GZRZ:工作认证;JSZCRZ:技术职称认证;SRZM:收入证明;XYBG:信用报告;FCRZ:房产认证;GCRZ:购车证明;WBRZ:微博认证;GSRZ:公司认证;)'
				String scount = query.getCount();
				if(StringHelper.isEmpty(scount)){
					scount = "";
				}
				//添加认证信息
				xxid = insert(connection,
						"INSERT INTO T6018 SET F02=?,F03=?,F07=?",
						serviceResource.getSession().getAccountId(), query.getType(), scount);
				//修改账户关联认证信息ID
				execute(connection,"UPDATE  T6017 SET F03=?,F04='DSH' WHERE F02=? AND F01 = ?",xxid,query.getType(), id);
				
			}
			//添加附件
			if(xxid>0){
				List<UploadFile> files = query.getAccessory();
				if (files != null && files.size() > 0) {
					for (UploadFile file : files) {
						insert(connection,
								"INSERT INTO T6019 SET F02=?,F03=?,F04=?,F05 = CURRENT_TIMESTAMP()",
								xxid, file.getInputStream(), file.getSuffix());
					}
				}
			}
			return id;
		}
	}

}
