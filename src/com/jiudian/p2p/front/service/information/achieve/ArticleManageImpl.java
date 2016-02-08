package com.jiudian.p2p.front.service.information.achieve;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.jiudian.framework.http.upload.FileStore;
import com.jiudian.framework.service.ServiceFactory;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.framework.service.query.ArrayParser;
import com.jiudian.framework.service.query.EmptyPageResult;
import com.jiudian.framework.service.query.ItemParser;
import com.jiudian.framework.service.query.Paging;
import com.jiudian.framework.service.query.PagingResult;
import com.jiudian.p2p.common.enums.ArticlePublishStatus;
import com.jiudian.p2p.common.enums.ArticleType;
import com.jiudian.p2p.common.enums.AutoSetStatus;
import com.jiudian.p2p.front.service.information.ArticleManage;
import com.jiudian.p2p.front.service.information.entity.Article;
import com.jiudian.p2p.front.service.information.entity.TitleWz;
import com.jiudian.p2p.front.service.information.entity.TjzxVo;
import com.jiudian.p2p.variables.P2PConst;
import com.jiudian.util.StringHelper;
import com.jiudian.util.parser.EnumParser;

public class ArticleManageImpl extends AbstractInformationService implements
		ArticleManage {

	public static class ArticleManageFactory implements
			ServiceFactory<ArticleManage> {
		@Override
		public ArticleManage newInstance(ServiceResource serviceResource) {
			return new ArticleManageImpl(serviceResource);
		}
	}

	private String getCreater(int creater) throws Throwable {
		try {
			try (Connection connection = getConnection(P2PConst.DB_CONSOLE);
					PreparedStatement pstmt = connection
							.prepareStatement("SELECT F02 FROM T7011 WHERE F01=?")) {
				pstmt.setInt(1, creater);
				try (ResultSet resultSet = pstmt.executeQuery()) {
					if (resultSet.next()) {
						return resultSet.getString(1);
					}
				}
			}
		} catch (Exception e) {

		}
		return "";
	}
	
	private ArticleType getType(int articleId) throws Throwable {
		try {
			try (Connection connection = getConnection(P2PConst.DB_INFORMATION);
					PreparedStatement pstmt = connection
							.prepareStatement("SELECT F02 FROM T5011 WHERE F01=?")) {
				pstmt.setInt(1, articleId);
				try (ResultSet resultSet = pstmt.executeQuery()) {
					if (resultSet.next()) {
						String s= resultSet.getString(1);
						return EnumParser.parse(ArticleType.class, s);
					}
				}
			}
		} catch (Exception e) {

		}
		return null;
	}

	protected static final ArrayParser<Article> ARRAY_PARSER = new ArrayParser<Article>() {

		@Override
		public Article[] parse(ResultSet rs) throws SQLException {
			ArrayList<Article> list = null;
			while (rs.next()) {
				Article article = new Article();
				article.id = rs.getInt(1);
				article.viewTimes = rs.getInt(2);
				article.title = rs.getString(3);
				article.source = rs.getString(4);
				article.summary = rs.getString(5);
				article.imageCode = rs.getString(6);
				article.createtime = rs.getTimestamp(7);
				article.publishTime = rs.getTimestamp(8);
				article.creater = rs.getString(9);
				if (list == null) {
					list = new ArrayList<>();
				}
				list.add(article);
			}
			return list == null ? null : list.toArray(new Article[list.size()]);
		}
	};
	protected static final ItemParser<Article> ITEM_PARSER = new ItemParser<Article>() {

		@Override
		public Article parse(ResultSet rs) throws SQLException {
			Article news = new Article();
			if (rs.next()) {
				news.id = rs.getInt(1);
				news.viewTimes = rs.getInt(2);
				news.title = rs.getString(3);
				news.source = rs.getString(4);
				news.summary = rs.getString(5);
				news.imageCode = rs.getString(6);
				news.createtime = rs.getTimestamp(7);
				news.publishTime = rs.getTimestamp(8);
				news.creater = rs.getString(9);
			}
			return news;
		}
	};
	protected static final String SELECT_ALL_SQL = "SELECT F01,F03,F06,F07,F08,F09,F11,F12,F10 FROM T5011 ";

	public ArticleManageImpl(ServiceResource serviceResource) {
		super(serviceResource);
	}

	@Override
	public Article get(int id) throws Throwable {
		if (id <= 0) {
			return null;
		}
		StringBuffer sql = new StringBuffer();
		sql.append(SELECT_ALL_SQL);
		sql.append(" WHERE F01  =? AND F05  =?");
		return select(getConnection(), ITEM_PARSER, sql.toString(), id,
				ArticlePublishStatus.YFB.name());
	}

	@Override
	public PagingResult<Article> search(ArticleType articleType, Paging paging)
			throws Throwable {
		if (articleType == null) {
			return new EmptyPageResult<Article>();
		}
		StringBuilder sql = new StringBuilder(SELECT_ALL_SQL);
		sql.append(" WHERE F05 = ?  AND F02 = ? ");
		sql.append("ORDER BY F12 DESC,F04 DESC");
		PagingResult<Article> pr = selectPaging(getConnection(), ARRAY_PARSER,
				paging, sql.toString(), ArticlePublishStatus.YFB.name(),
				articleType);
		if(pr.getItems()!=null){
		for (Article a : pr.getItems()) {
			String c = getCreater(Integer.parseInt(a.creater));
			a.creater = c;
		}
		}
		return pr;
	}

	@Override
	public String getContent(int id) throws Throwable {
		if (id <= 0) {
			return null;
		}
		String content = null;
		try (Connection connection = getConnection();
				PreparedStatement pstmt = connection
						.prepareStatement("SELECT T5011_1.F02 FROM T5011_1 INNER JOIN T5011 ON T5011.F01 = T5011_1.F01 WHERE T5011_1.F01 = ? AND T5011.F05 = ?")) {
			pstmt.setInt(1, id);
			pstmt.setString(2, ArticlePublishStatus.YFB.name());
			try (ResultSet resultSet = pstmt.executeQuery()) {
				if (resultSet.next()) {
					content = resultSet.getString(1);
				}
			}
		}
		content = filterTag(content);
		return content;
	}

	@Override
	public void view(int id) throws Throwable {
		if (id <= 0) {
			return;
		}
		execute(getConnection(),
				"UPDATE T5011 SET F03 = F03 + 1 WHERE F01 = ? AND F05 = ?", id,
				ArticlePublishStatus.YFB.name());
	}

	@Override
	public Article get(ArticleType articleType) throws Throwable {
		if (articleType == null) {
			return null;
		}
		StringBuffer sql = new StringBuffer();
		sql.append(SELECT_ALL_SQL);
		sql.append(" WHERE F02 = ? AND F05  =? ORDER BY F04 DESC LIMIT 1");
		return select(getConnection(), ITEM_PARSER, sql.toString(),
				articleType, ArticlePublishStatus.YFB.name());
	}

	@Override
	public String getContent(ArticleType articleType) throws Throwable {
		if (articleType == null) {
			return null;
		}
		String content = null;
		try (Connection connection = getConnection()) {
			int id;
			try (PreparedStatement pstmt = connection
					.prepareStatement("SELECT F01 FROM T5011 WHERE T5011.F02 = ? AND T5011.F05 = ? ORDER BY F04 DESC LIMIT 1")) {
				pstmt.setString(1, articleType.name());
				pstmt.setString(2, ArticlePublishStatus.YFB.name());
				try (ResultSet resultSet = pstmt.executeQuery()) {
					if (resultSet.next()) {
						id = resultSet.getInt(1);
					} else {
						return null;
					}
				}
			}
			try (PreparedStatement pstmt = connection
					.prepareStatement("SELECT T5011_1.F02 FROM T5011_1 INNER JOIN T5011 ON T5011.F01 = T5011_1.F01 WHERE T5011_1.F01 = ? ")) {
				pstmt.setInt(1, id);
				try (ResultSet resultSet = pstmt.executeQuery()) {
					if (resultSet.next()) {
						content = resultSet.getString(1);
					}
				}
			}
		}
		content = filterTag(content);
		return content;
	}

	/**
	 * 替换关键字
	 * 
	 * @param content
	 * @return
	 * @throws Throwable
	 */
	private static final Pattern[] REPLACE_TAG_PATTERN = {
			Pattern.compile("\\<img.*?\\>", 2),
			Pattern.compile("\\<a(.*)\\>(.*)\\<\\/a\\>", 2) };

	private String filterTag(String content) throws Throwable {
		ArrayList<String> KEYS = new ArrayList<String>();
		ArrayList<String> HREFS = new ArrayList<String>();
		HashMap<Integer, String[]> hm = new HashMap<Integer, String[]>();

		FileStore fileStore = serviceResource.getResource(FileStore.class);
		StringBuffer sb = new StringBuffer();
		StringHelper.format(sb, content, fileStore);
		content = sb.toString();

		for (Pattern p : REPLACE_TAG_PATTERN) {
			Matcher matcher = p.matcher(content);
			while (matcher.find()) {
				String key = matcher.group();
				Integer idx = sort(hm, content, key, 0);
				if (idx != null && idx >= 0) {
					String[] keys = { key, key };
					hm.put(idx, keys);
				}
			}
		}

		try (Connection connection = getConnection(P2PConst.DB_CONSOLE);
				PreparedStatement pstmt = connection
						.prepareStatement("SELECT F02,F03 FROM T7059 WHERE F05 = ? ORDER BY LENGTH(F02) DESC ")) {
			pstmt.setString(1, AutoSetStatus.QY.name());
			try (ResultSet resultSet = pstmt.executeQuery()) {
				while (resultSet.next()) {
					KEYS.add(resultSet.getString(1));
					HREFS.add(resultSet.getString(2));
				}
			}
		}

		int size = 0;
		if (content != null && KEYS.size() > 0) {

			for (int i = 0; i < KEYS.size(); i++) {
				String key = KEYS.get(i);
				Integer idx = sort(hm, content, key, 0);
				if (idx != null) {
					String key2 = "<a href='" + HREFS.get(i)
							+ "' target='_blank' class='blue'>" + key + "</a>";
					String[] values = { key, key2 };
					hm.put(idx, values);
					size++;
					if (size == 5) {
						break;
					}
				}
			}

			List<Map.Entry<Integer, String[]>> infoIds = new ArrayList<Map.Entry<Integer, String[]>>(
					hm.entrySet());
			// 排序
			Collections.sort(infoIds,
					new Comparator<Map.Entry<Integer, String[]>>() {
						public int compare(Map.Entry<Integer, String[]> o1,
								Map.Entry<Integer, String[]> o2) {
							return (o1.getKey() - o2.getKey());
						}
					});

			StringBuffer s = new StringBuffer();
			int index = 0;
			for (int i = 0; i < infoIds.size(); i++) {
				int start = infoIds.get(i).getKey();
				String[] values = infoIds.get(i).getValue();
				s.append(content.substring(index, start));
				s.append(values[1]);
				index = start + values[0].length();
			}
			if (index < content.length()) {
				s.append(content.substring(index));
			}
			content = s.toString();
		}

		return content;
	}

	private Integer sort(HashMap<Integer, String[]> hm, String content,
			String key, int index) {
		if (content.length() <= index) {
			return null;
		}
		int idx = content.indexOf(key, index);
		if (idx < 0) {
			return null;
		}

		List<Map.Entry<Integer, String[]>> infoIds = new ArrayList<Map.Entry<Integer, String[]>>(
				hm.entrySet());
		// 排序
		Collections.sort(infoIds,
				new Comparator<Map.Entry<Integer, String[]>>() {
					public int compare(Map.Entry<Integer, String[]> o1,
							Map.Entry<Integer, String[]> o2) {
						return (o1.getKey() - o2.getKey());
					}
				});

		for (int i = 0; i < infoIds.size(); i++) {
			int start = infoIds.get(i).getKey();
			String[] value = infoIds.get(i).getValue();
			int end = start + value[0].length();

			if ((idx > end || start > (idx + key.length()))) {
			} else {
				if (end < idx + key.length()) {
					end = idx + key.length();
				}
				return sort(hm, content, key, end);
			}
		}
		return new Integer(idx);
	}

	@Override
	public Article get(int id, ArticleType articleType) throws Throwable {
		if (id <= 0 || articleType == null) {
			return null;
		}
		StringBuffer sql = new StringBuffer();
		sql.append(SELECT_ALL_SQL);
		sql.append(" WHERE F01  =? AND F02 = ? AND F05  =?");
		Article a = select(getConnection(), ITEM_PARSER, sql.toString(), id,
				articleType, ArticlePublishStatus.YFB);
		String c = getCreater(Integer.parseInt(a.creater));
		a.creater = c;
		return a;
	}
	
	@Override
	public Article gets(int id) throws Throwable {
		if (id <= 0) {
			return null;
		}
		StringBuffer sql = new StringBuffer();
		sql.append(SELECT_ALL_SQL);
		sql.append(" WHERE F01  =? AND F05  =?");
		Article a = select(getConnection(), ITEM_PARSER, sql.toString(), id, ArticlePublishStatus.YFB);
		String c = getCreater(Integer.parseInt(a.creater));
		a.creater = c;
		return a;
	}

	@Override
	public Article getUp(int id, ArticleType type) throws Throwable {
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT F01,F06,F10 FROM( SELECT F01,F06,F10,@rownum := @rownum +1 AS rownum FROM T5011,(SELECT @rownum:=0) t WHERE F05 = ? AND F02 = ? ");
		sb.append(" ORDER BY F12 DESC,F04 DESC )tt  WHERE rownum = ( SELECT rownum FROM( SELECT F01 ,@rownum := @rownum +1 AS rownum ");
		sb.append(" FROM T5011,(SELECT @rownum:=0) t WHERE F05 = ? AND F02 = ? ORDER BY F12 DESC,F04 DESC ");
		sb.append(" )tab WHERE  F01 = ? )-1 ");
		Article a = select(getConnection(), new ItemParser<Article>() {
			@Override
			public Article parse(ResultSet rs) throws SQLException {
				Article news = new Article();
				if (rs.next()) {
					news.id = rs.getInt(1);
					news.title = rs.getString(2);
					news.creater = rs.getString(3);
				}
				return news;
			}
		}, sb.toString(), ArticlePublishStatus.YFB, type,
				ArticlePublishStatus.YFB, type, id);

		if (a != null&&a.creater!=null) {
			String c = getCreater(Integer.parseInt(a.creater));
			a.creater = c;
		}
		return a;
	}

	@Override
	public Article getDown(int id, ArticleType type) throws Throwable {
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT F01,F06,F10 FROM( SELECT F01,F06,F10,@rownum := @rownum +1 AS rownum FROM T5011,(SELECT @rownum:=0) t WHERE F05 = ? AND F02 = ? ");
		sb.append(" ORDER BY F12 DESC,F04 DESC )tt  WHERE rownum = ( SELECT rownum FROM( SELECT F01 ,@rownum := @rownum +1 AS rownum ");
		sb.append(" FROM T5011,(SELECT @rownum:=0) t WHERE F05 = ? AND F02 = ? ORDER BY F12 DESC,F04 DESC ");
		sb.append(" )tab WHERE  F01 = ? )+1 ");
		Article a = select(getConnection(), new ItemParser<Article>() {
			@Override
			public Article parse(ResultSet rs) throws SQLException {
				Article news = new Article();
				if (rs.next()) {
					news.id = rs.getInt(1);
					news.title = rs.getString(2);
					news.creater = rs.getString(3);
				}
				return news;
			}
		}, sb.toString(), ArticlePublishStatus.YFB, type,
				ArticlePublishStatus.YFB, type, id);
		if (a != null&&a.creater!=null) {
			String c = getCreater(Integer.parseInt(a.creater));
			a.creater = c;
		}
		return a;
	}

	@Override
	public TitleWz[] getTitle() throws Throwable {
		return selectAll(getConnection(P2PConst.DB_INFORMATION), new ArrayParser<TitleWz>() {
			@Override
			public TitleWz[] parse(ResultSet res)
					throws SQLException {
				List<TitleWz> list = new ArrayList<TitleWz>();
				while(res.next()){
					TitleWz t = new TitleWz();
					t.id = res.getInt(1);
					t.name = res.getString(2);
					t.wzs = res.getInt(3);
					list.add(t);
				}
				return list.toArray(new TitleWz[list.size()]);
			}
			
		}, "SELECT t5020.F01,t5020.F02,(SELECT COUNT(*) FROM T5020_1 WHERE T5020_1.F01 = t5020.F01 AND (SELECT F05 FROM T5011 WHERE F01 = T5020_1.F02) = 'YFB' ) AS WZS FROM t5020 WHERE t5020.F03 = 'QY' ORDER BY F04 DESC ");
	}

	@Override
	public TjzxVo[] getTj() throws Throwable {
		return selectAll(getConnection(P2PConst.DB_INFORMATION), new ArrayParser<TjzxVo>() {
			@Override
			public TjzxVo[] parse(ResultSet res) throws SQLException {
				List<TjzxVo> list = new ArrayList<TjzxVo>();
				while(res.next()){
					TjzxVo t = new TjzxVo();
					t.id = res.getInt(1);
					t.type = EnumParser.parse(ArticleType.class, res.getString(2));
					t.name = res.getString(3);
					t.time = res.getTimestamp(4);
					t.author = res.getString(5);
					list.add(t);
				}
				return list.toArray(new TjzxVo[list.size()]);
			}
		}, " SELECT F01,F02,F06,F12,(SELECT F02 FROM s70.t7011 WHERE t5011.F10 = s70.t7011.F01) AS AUTHOR from t5011 WHERE F05='YFB' AND ( F02= 'HLWJRYJ' OR F02 = 'WDHYZX' OR F02 = 'WDZS'  )  ORDER BY F12 DESC LIMIT 10 ");
	}

	@Override
	public TjzxVo[] getXz() throws Throwable {
		return selectAll(getConnection(P2PConst.DB_INFORMATION), new ArrayParser<TjzxVo>() {
			@Override
			public TjzxVo[] parse(ResultSet res) throws SQLException {
				List<TjzxVo> list = new ArrayList<TjzxVo>();
				while(res.next()){
					TjzxVo t = new TjzxVo();
					t.id = res.getInt(1);
					t.type = EnumParser.parse(ArticleType.class, res.getString(2));
					t.name = res.getString(3);
					t.time = res.getTimestamp(4);
					t.author = res.getString(5);
					list.add(t);
				}
				return list.toArray(new TjzxVo[list.size()]);
			}
		}, "SELECT F01,F02,F06,F12,(SELECT F02 FROM s70.t7011 WHERE t5011.F10 = s70.t7011.F01) AS AUTHOR from t5011 WHERE F05='YFB' AND F14='S' AND ( F02= 'HLWJRYJ' OR F02 = 'WDHYZX' OR F02 = 'WDZS'  ) ORDER BY F15 DESC LIMIT 10");
	}

	@Override
	public PagingResult<Article> search(int bqid, Paging paging)
			throws Throwable {
		if (bqid <= 0) {
			return new EmptyPageResult<Article>();
		}
		StringBuilder sql = new StringBuilder("SELECT T5011.F01,T5011.F03,T5011.F06,T5011.F07,T5011.F08,T5011.F09,T5011.F11,T5011.F12,T5011.F10 FROM T5020_1 LEFT JOIN T5011 ON T5020_1.F02 = T5011.F01");
		sql.append(" WHERE t5020_1.F01 = ?  AND T5011.F05 = ? ");
		sql.append(" ORDER BY T5011.F12 DESC,T5011.F04 DESC");
		PagingResult<Article> pr = selectPaging(getConnection(), ARRAY_PARSER,
				paging, sql.toString(),bqid, ArticlePublishStatus.YFB.name());
		if(pr!= null && pr.getItems() !=null&& pr.getItems().length>0)
		for (Article a : pr.getItems()) {
			String c = getCreater(Integer.parseInt(a.creater));
			a.creater = c;
			a.type = getType(a.id);
		}
		return pr;
	}

	@Override
	public TitleWz[] getTitle(int id) throws Throwable {
		return selectAll(getConnection(P2PConst.DB_INFORMATION), new ArrayParser<TitleWz>() {
			@Override
			public TitleWz[] parse(ResultSet res)
					throws SQLException {
				List<TitleWz> list = new ArrayList<TitleWz>();
				while(res.next()){
					TitleWz t = new TitleWz();
					t.id = res.getInt(1);
					t.name = res.getString(2);
					list.add(t);
				}
				return list.toArray(new TitleWz[list.size()]);
			}
			
		}, "SELECT T5020_1.F01,T5020.F02 FROM T5020_1 LEFT JOIN T5011 ON T5011.F01 = T5020_1.F02 LEFT JOIN T5020 ON T5020.F01= T5020_1.F01 WHERE T5011.F01=? ",id);
	}

	@Override
	public String getTitlename(int id) throws Throwable {
			return select(getConnection(P2PConst.DB_INFORMATION), new ItemParser<String>() {
				@Override
				public String parse(ResultSet res)
						throws SQLException {
					String s = "";
					if(res.next()){
						s = res.getString(1);
					}
					return s;
				}
				
			}, "SELECT t5020.F02 FROM T5020 WHERE T5020.F01 = ?",id);
		}

	@Override
	public TjzxVo[] getLt() throws Throwable {
		return selectAll(getConnection("forum"), new ArrayParser<TjzxVo>() {
			@Override
			public TjzxVo[] parse(ResultSet res)
					throws SQLException {
				List<TjzxVo> list = new ArrayList<TjzxVo>();
				while(res.next()){
					TjzxVo t = new TjzxVo();
					t.id = res.getInt(1);
					long timeStamp = res.getLong(2);
					Timestamp scurrtest = new Timestamp(timeStamp*1000);
					t.time = scurrtest;
					list.add(t);
				}
				return list.toArray(new TjzxVo[list.size()]);
			}
			
		}, "SELECT TID,DATELINE FROM PRE_FORUM_THREAD ORDER BY DATELINE DESC LIMIT 10 ");
	}

}
