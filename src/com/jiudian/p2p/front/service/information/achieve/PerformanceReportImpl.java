package com.jiudian.p2p.front.service.information.achieve;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.jiudian.framework.service.ServiceFactory;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.framework.service.query.ArrayParser;
import com.jiudian.framework.service.query.ItemParser;
import com.jiudian.framework.service.query.Paging;
import com.jiudian.framework.service.query.PagingResult;
import com.jiudian.p2p.common.enums.PerformanceReportPublishStatus;
import com.jiudian.p2p.front.service.information.PerformanceReportManage;
import com.jiudian.p2p.front.service.information.entity.PerformanceReport;

public class PerformanceReportImpl extends AbstractInformationService implements
		PerformanceReportManage {

	public static class PerformanceReportMangeFactory implements
			ServiceFactory<PerformanceReportManage> {
		@Override
		public PerformanceReportManage newInstance(
				ServiceResource serviceResource) {
			return new PerformanceReportImpl(serviceResource);
		}
	}

	public PerformanceReportImpl(ServiceResource serviceResource) {
		super(serviceResource);
	}

	@Override
	public PagingResult<PerformanceReport> search(Paging paging)
			throws Throwable {
		return selectPaging(
				getConnection(),
				new ArrayParser<PerformanceReport>() {
					@Override
					public PerformanceReport[] parse(ResultSet resultSet)
							throws SQLException {
						ArrayList<PerformanceReport> list = null;
						while (resultSet.next()) {
							PerformanceReport report = new PerformanceReport();
							report.id = resultSet.getInt(1);
							report.title = resultSet.getString(2);
							report.attachmentCode = resultSet.getString(3);
							report.updateTime = resultSet.getTimestamp(4);
							if (list == null) {
								list = new ArrayList<>();
							}
							list.add(report);
						}
						return list == null || list.size() == 0 ? null : list
								.toArray(new PerformanceReport[list.size()]);
					}
				},
				paging,
				"SELECT F01,F05,F06,F09 FROM T5018 WHERE F03 = ? ORDER BY F09 DESC",
				PerformanceReportPublishStatus.YFB);

	}

	@Override
	public PerformanceReport get(int id) throws Throwable {
		return select(getConnection(), new ItemParser<PerformanceReport>() {
			@Override
			public PerformanceReport parse(ResultSet resultSet)
					throws SQLException {
				PerformanceReport report = null;
				if (resultSet.next()) {
					report = new PerformanceReport();
					report.id = resultSet.getInt(1);
					report.title = resultSet.getString(2);
					report.attachmentCode = resultSet.getString(3);
					report.updateTime = resultSet.getTimestamp(4);

				}
				return report;
			}
		}, "SELECT F01,F05,F06,F09 FROM T5018 WHERE F01 = ? AND F03 = ? ", id,
				PerformanceReportPublishStatus.YFB);

	}

	@Override
	public void view(int id) throws Throwable {
		if (id <= 0) {
			return;
		}
		execute(getConnection(),
				"UPDATE T5018 SET F04 = F04 + 1 WHERE F01 = ? AND F03 = ?", id,
				PerformanceReportPublishStatus.YFB);

	}

}
