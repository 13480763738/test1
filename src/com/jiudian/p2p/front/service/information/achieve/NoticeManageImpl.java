package com.jiudian.p2p.front.service.information.achieve;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.jiudian.framework.service.ServiceFactory;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.framework.service.query.ArrayParser;
import com.jiudian.framework.service.query.ItemParser;
import com.jiudian.framework.service.query.Paging;
import com.jiudian.framework.service.query.PagingResult;
import com.jiudian.p2p.common.enums.ArticlePublishStatus;
import com.jiudian.p2p.common.enums.NoticePublishStatus;
import com.jiudian.p2p.common.enums.NoticeType;
import com.jiudian.p2p.front.service.information.NoticeManage;
import com.jiudian.p2p.front.service.information.entity.Notice;

public class NoticeManageImpl extends AbstractInformationService implements
		NoticeManage {

	public static class NoticeManageFactory implements
			ServiceFactory<NoticeManage> {
		@Override
		public NoticeManage newInstance(ServiceResource serviceResource) {
			return new NoticeManageImpl(serviceResource);
		}
	}

	public NoticeManageImpl(ServiceResource serviceResource) {
		super(serviceResource);
	}

	@Override
	public PagingResult<Notice> search(Paging paging) throws Throwable {
		return selectPaging(
				getConnection(),
				new ArrayParser<Notice>() {
					@Override
					public Notice[] parse(ResultSet resultSet)
							throws SQLException {
						List<Notice> list = null;
						while (resultSet.next()) {
							Notice notice = new Notice();
							notice.id = resultSet.getInt(1);
							notice.type = NoticeType.valueOf(resultSet
									.getString(2));
							notice.title = resultSet.getString(3);
							notice.content = resultSet.getString(4);
							notice.createtime = resultSet.getTimestamp(5);
							notice.lastTime = resultSet.getTimestamp(6);
							if (list == null) {
								list = new ArrayList<Notice>();
							}
							list.add(notice);
						}
						return list == null || list.size() == 0 ? null : list
								.toArray(new Notice[list.size()]);
					}
				},
				paging,
				"SELECT F01,F02,F05,F06,F08,F09 FROM T5015 WHERE F04=? ORDER BY F08 DESC ",
				NoticePublishStatus.YFB);
	}

	@Override
	public Notice get(final int id) throws Throwable {
		if (id <= 0) {
			return null;
		}
		return select(getConnection(), new ItemParser<Notice>() {
			@Override
			public Notice parse(ResultSet resultSet) throws SQLException {
				Notice notice = null;
				if (resultSet.next()) {
					notice = new Notice();
					notice.id = id;
					notice.type = NoticeType.valueOf(resultSet.getString(1));
					notice.title = resultSet.getString(2);
					notice.content = resultSet.getString(3);
					notice.createtime = resultSet.getTimestamp(4);
					notice.lastTime = resultSet.getTimestamp(5);
				}
				return notice;
			}
		}, "SELECT F02,F05,F06,F08,F09 FROM T5015 WHERE F01 = ? ",
				id);

	}

	@Override
	public void view(int id) throws Throwable {
		if (id <= 0) {
			return;
		}
		execute(getConnection(),
				"UPDATE T5015 SET F03 = F03 + 1 WHERE F01 = ? AND F04 = ?", id,
				NoticePublishStatus.YFB);

	}

	@Override
	public Notice getUp(int id) throws Throwable {
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT F01,F05 FROM( SELECT F01,F05 ,@rownum := @rownum +1 AS rownum FROM T5015,(SELECT @rownum:=0) t WHERE F04=? ");
		sb.append(" ORDER BY F09 DESC)tt  WHERE rownum = ( SELECT rownum FROM( SELECT F01 ,@rownum := @rownum +1 AS rownum ");
		sb.append(" FROM T5015,(SELECT @rownum:=0) t WHERE F04=? ORDER BY F09 DESC ");
		sb.append(" )tab WHERE  F01 = ? )-1 ");
		return select(getConnection(), new ItemParser<Notice>() {
			@Override
			public Notice parse(ResultSet rs) throws SQLException {
				Notice news = new Notice();
				if (rs.next()) {
					news.id = rs.getInt(1);
					news.title = rs.getString(2);
				}
				return news;
			}
		}, sb.toString(), ArticlePublishStatus.YFB,ArticlePublishStatus.YFB,id );
	}

	@Override
	public Notice getDown(int id) throws Throwable {
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT F01,F05 FROM( SELECT F01,F05 ,@rownum := @rownum +1 AS rownum FROM T5015,(SELECT @rownum:=0) t WHERE F04=? ");
		sb.append(" ORDER BY F09 DESC )tt  WHERE rownum = ( SELECT rownum FROM( SELECT F01 ,@rownum := @rownum +1 AS rownum ");
		sb.append(" FROM T5015,(SELECT @rownum:=0) t WHERE F04=? ORDER BY F09 DESC ");
		sb.append(" )tab WHERE  F01 = ? )+1 ");
		return select(getConnection(), new ItemParser<Notice>() {
			@Override
			public Notice parse(ResultSet rs) throws SQLException {
				Notice news = new Notice();
				if (rs.next()) {
					news.id = rs.getInt(1);
					news.title = rs.getString(2);
				}
				return news;
			}
		}, sb.toString(), ArticlePublishStatus.YFB,ArticlePublishStatus.YFB,id );
	}

}
