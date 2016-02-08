package com.jiudian.p2p.front.service.information;

import com.jiudian.framework.service.Service;
import com.jiudian.framework.service.query.Paging;
import com.jiudian.framework.service.query.PagingResult;
import com.jiudian.p2p.common.enums.ArticlePublishStatus;
import com.jiudian.p2p.common.enums.ArticleType;
import com.jiudian.p2p.front.service.information.entity.Article;
import com.jiudian.p2p.front.service.information.entity.TitleWz;
import com.jiudian.p2p.front.service.information.entity.TjzxVo;

/**
 * 文章管理
 * 
 */
public abstract interface ArticleManage extends Service {

	/**
	 * <dt>
	 * <dl>
	 * 描述：按文章类型分页查询文章列表.
	 * </dl>
	 * 
	 * <dl>
	 * 数据校验：
	 * <ol>
	 * <li>如果 {@code articleType == null} 则直接返回空{@link PagingResult}</li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 逻辑校验：
	 * <ol>
	 * <li>无</li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 业务处理：
	 * <ol>
	 * <li>分页查询{@link T5011}表</li>
	 * <li>查询条件: {@link T5011#F05} {@code =} {@link ArticlePublishStatus#YFB}
	 * {@code AND} {@link T5011#F02} {@code = articleType}</li>
	 * <li>按照{@link T5011#F04}字段降序排序</li>
	 * <li>
	 * 查询字段列表
	 * <ol>
	 * <li>{@link T5011#F01}</li>
	 * <li>{@link T5011#F03}</li>
	 * <li>{@link T5011#F06}</li>
	 * <li>{@link T5011#F07}</li>
	 * <li>{@link T5011#F08}</li>
	 * <li>{@link T5011#F09}</li>
	 * <li>{@link T5011#F11}</li>
	 * <li>{@link T5011#F12}</li>
	 * </ol>
	 * </li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 返回结果说明：
	 * <ol>
	 * <li>{@link Article#id}对应{@link T5011#F01}</li>
	 * <li>{@link Article#viewTimes}对应{@link T5011#F03}</li>
	 * <li>{@link Article#title}对应{@link T5011#F06}</li>
	 * <li>{@link Article#source}对应{@link T5011#F07}</li>
	 * <li>{@link Article#summary}对应{@link T5011#F08}</li>
	 * <li>{@link Article#imageCode}对应{@link T5011#F09}</li>
	 * <li>{@link Article#createtime}对应{@link T5011#F11}</li>
	 * <li>{@link Article#publishTime}对应{@link T5011#F12}</li>
	 * </ol>
	 * </dl>
	 * </dt>
	 * 
	 * @param articleType
	 *            文章类型
	 * @param paging
	 *            分页查询参数
	 * @return {@link PagingResult}{@code <}{@link Article}{@code >} 分页查询结果
	 * @throws Throwable
	 */
	public abstract PagingResult<Article> search(ArticleType articleType,
			Paging paging) throws Throwable;
	
	
	public abstract PagingResult<Article> search(int bqid,Paging paging) throws Throwable;

	/**
	 * <dt>
	 * <dl>
	 * 描述：根据文章ID查询已发布文章信息.
	 * </dl>
	 * 
	 * <dl>
	 * 数据校验：
	 * <ol>
	 * <li>无</li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 逻辑校验：
	 * <ol>
	 * <li>如果 {@code id <= 0} 则直接返回 {@code null}</li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 业务处理：
	 * <ol>
	 * <li>查询{@link T5011}表</li>
	 * <li>查询条件: {@link T5011.F05} {@code =} {@link ArticlePublishStatus#YFB}
	 * {@code AND} {@link T5011.F01} {@code  = id}</li>
	 * <li>
	 * 查询字段列表
	 * <ol>
	 * <li>{@link T5011#F01}</li>
	 * <li>{@link T5011#F03}</li>
	 * <li>{@link T5011#F06}</li>
	 * <li>{@link T5011#F07}</li>
	 * <li>{@link T5011#F08}</li>
	 * <li>{@link T5011#F09}</li>
	 * <li>{@link T5011#F11}</li>
	 * <li>{@link T5011#F12}</li>
	 * </ol>
	 * </li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 返回结果说明：
	 * <ol>
	 * <li>{@link Article#id}对应{@link T5011#F01}</li>
	 * <li>{@link Article#viewTimes}对应{@link T5011#F03}</li>
	 * <li>{@link Article#title}对应{@link T5011#F06}</li>
	 * <li>{@link Article#source}对应{@link T5011#F07}</li>
	 * <li>{@link Article#summary}对应{@link T5011#F08}</li>
	 * <li>{@link Article#imageCode}对应{@link T5011#F09}</li>
	 * <li>{@link Article#createtime}对应{@link T5011#F11}</li>
	 * <li>{@link Article#publishTime}对应{@link T5011#F12}</li>
	 * </ol>
	 * </dl>
	 * </dt>
	 * 
	 * @param id
	 *            文章ID
	 * @return {@link Article} 文章信息,如果不存在则返回{@code null}
	 * @throws Throwable
	 */
	public abstract Article get(int id) throws Throwable;

	/**
	 * <dt>
	 * <dl>
	 * 描述：根据文章ID和类型查询已发布文章信息.
	 * </dl>
	 * 
	 * <dl>
	 * 数据校验：
	 * <ol>
	 * <li>无</li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 逻辑校验：
	 * <ol>
	 * <li>如果 {@code id <= 0} 则直接返回 {@code null}</li>
	 * <li>如果 {@code articleType == null} 则直接返回 {@code null}</li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 业务处理：
	 * <ol>
	 * <li>查询{@link T5011}表</li>
	 * <li>查询条件: {@link T5011.F05} {@code =} {@link ArticlePublishStatus#YFB}
	 * {@code AND} {@link T5011.F01} {@code = id} {@code AND} {@link T5011.F02}
	 * {@code = articleType}</li>
	 * <li>
	 * 查询字段列表
	 * <ol>
	 * <li>{@link T5011#F01}</li>
	 * <li>{@link T5011#F03}</li>
	 * <li>{@link T5011#F06}</li>
	 * <li>{@link T5011#F07}</li>
	 * <li>{@link T5011#F08}</li>
	 * <li>{@link T5011#F09}</li>
	 * <li>{@link T5011#F11}</li>
	 * <li>{@link T5011#F12}</li>
	 * </ol>
	 * </li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 返回结果说明：
	 * <ol>
	 * <li>{@link Article#id}对应{@link T5011#F01}</li>
	 * <li>{@link Article#viewTimes}对应{@link T5011#F03}</li>
	 * <li>{@link Article#title}对应{@link T5011#F06}</li>
	 * <li>{@link Article#source}对应{@link T5011#F07}</li>
	 * <li>{@link Article#summary}对应{@link T5011#F08}</li>
	 * <li>{@link Article#imageCode}对应{@link T5011#F09}</li>
	 * <li>{@link Article#createtime}对应{@link T5011#F11}</li>
	 * <li>{@link Article#publishTime}对应{@link T5011#F12}</li>
	 * </ol>
	 * </dl>
	 * </dt>
	 * 
	 * @param id
	 *            文章ID
	 * @param articleType
	 *            文章类型
	 * @return {@link Article} 文章信息,如果不存在则返回{@code null}
	 * @throws Throwable
	 */
	public abstract Article get(int id, ArticleType articleType)
			throws Throwable;
	
	public abstract Article gets(int id) throws Throwable;

	/**
	 * <dt>
	 * <dl>
	 * 描述：根据文章类型查询已发布的该类型第一篇文章信息.
	 * </dl>
	 * 
	 * <dl>
	 * 数据校验：
	 * <ol>
	 * <li>无</li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 逻辑校验：
	 * <ol>
	 * <li>如果 {@code articleType == null} 则直接返回 {@code null} </li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 业务处理：
	 * <ol>
	 * <li>查询{@code T5011}表,查询条件:{@code T5011.F05 = }
	 * {@link ArticlePublishStatus#YFB} {@code AND T5011.F02 = articleType}</li>
	 * <li>按照{@code T5011.F04}字段降序排序,取第一条记录</li>
	 * <li>
	 * 查询字段列表
	 * <ol>
	 * <li>{@code T5011.F01}</li>
	 * <li>{@code T5011.F03}</li>
	 * <li>{@code T5011.F06}</li>
	 * <li>{@code T5011.F07}</li>
	 * <li>{@code T5011.F08}</li>
	 * <li>{@code T5011.F09}</li>
	 * <li>{@code T5011.F11}</li>
	 * <li>{@code T5011.F12}</li>
	 * </ol>
	 * </li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 返回结果说明：
	 * <ol>
	 * <li>{@link Article#id}对应{@code T5011.F01}</li>
	 * <li>{@link Article#viewTimes}对应{@code T5011.F03}</li>
	 * <li>{@link Article#title}对应{@code T5011.F06}</li>
	 * <li>{@link Article#source}对应{@code T5011.F07}</li>
	 * <li>{@link Article#summary}对应{@code T5011.F08}</li>
	 * <li>{@link Article#imageCode}对应{@code T5011.F09}</li>
	 * <li>{@link Article#createtime}对应{@code T5011.F11}</li>
	 * <li>{@link Article#publishTime}对应{@code T5011.F12}</li>
	 * </ol>
	 * </dl>
	 * </dt>
	 * 
	 * @param articleType
	 *            文章类型
	 * @return {@link Article} 文章信息,如果不存在则返回{@code null}
	 * @throws Throwable
	 */
	public abstract Article get(ArticleType articleType) throws Throwable;

	/**
	 * <dt>
	 * <dl>
	 * 描述：根据ID,获取已发布文章的内容.
	 * </dl>
	 * 
	 * <dl>
	 * 数据校验：
	 * <ol>
	 * <li>无</li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 逻辑校验：
	 * <ol>
	 * <li>如果{@code id<=0}则直接返回{@code null}</li>
	 * <li>查询 {@code T5011}, 如果{@code T5011.F01 = id AND T5011.F05 = }
	 * {@link ArticlePublishStatus#YFB}不存在记录,则返回{@code null}</li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 业务处理：
	 * <ol>
	 * <li>查询{@code T5011_1.F02},查询条件:{@code T5011_1.F01 = id}</li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 返回结果说明：
	 * <ol>
	 * <li>无</li>
	 * </ol>
	 * </dl>
	 * </dt>
	 * 
	 * @param id
	 *            文章ID
	 * @return {@link String} 文章内容,如果不存在记录则返回{@code null}
	 * @throws Throwable
	 */
	public abstract String getContent(int id) throws Throwable;

	/**
	 * <dt>
	 * <dl>
	 * 描述：根据文章类型,获取已发布第一篇文章的内容.
	 * </dl>
	 * 
	 * <dl>
	 * 数据校验：
	 * <ol>
	 * <li>无</li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 逻辑校验：
	 * <ol>
	 * <li>如果{@code articleType==null}则直接返回{@code null}</li>
	 * <li>查询 {@code T5011}, 如果{@code T5011.F02 = articleType AND T5011.F05 = }
	 * {@link ArticlePublishStatus#YFB}不存在记录,则返回{@code null}</li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 业务处理：
	 * <ol>
	 * <li>查询{@code T5011_1.F02},查询条件:{@code T5011_1.F01 = id}</li>
	 * <li>按照{@code T5011.F04}字段降序排序,取第一条记录</li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 返回结果说明：
	 * <ol>
	 * <li>无</li>
	 * </ol>
	 * </dl>
	 * </dt>
	 * 
	 * @param articleType
	 *            文章类型
	 * @return {@link String} 文章内容,如果不存在则返回{@code null}
	 * @throws Throwable
	 */
	public abstract String getContent(ArticleType articleType) throws Throwable;

	/**
	 * <dt>
	 * <dl>
	 * 描述：累加已发布文章点击次数.
	 * </dl>
	 * 
	 * <dl>
	 * 数据校验：
	 * <ol>
	 * <li>无</li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 逻辑校验：
	 * <ol>
	 * <li>如果{@code id<=0}则直接返回</li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 业务处理：
	 * <ol>
	 * <li>修改{@code T5011.F03=F03+1},修改条件:{@code T5011.F01 = id AND T5011.F05 = }
	 * {@link ArticlePublishStatus#YFB}</li>
	 * </ol>
	 * </dl>
	 * 
	 * <dl>
	 * 返回结果说明：
	 * <ol>
	 * <li>无</li>
	 * </ol>
	 * </dl>
	 * </dt>
	 * 
	 * @param id
	 *            文章ID
	 * @throws Throwable
	 */
	public abstract void view(int id) throws Throwable;
	
	
	
	public abstract Article getUp(int id,ArticleType type) throws Throwable;
	
	public abstract Article getDown(int id,ArticleType type) throws Throwable;
	
	/***
	 * 获取当前的标签
	 * @return
	 * @throws Throwable
	 */
	public abstract TitleWz[] getTitle() throws Throwable;
	
	/***
	 * 获取标签名称
	 * @return
	 * @throws Throwable
	 */
	public abstract String getTitlename(int id) throws Throwable;
	
	/**
	 * 获取当前文章的标签
	 * @param type
	 * @return
	 * @throws Throwable
	 */
	public abstract TitleWz[] getTitle(int id) throws Throwable;
	
	/**
	 * 获取推荐文章
	 * @return
	 * @throws Throwable
	 */
	public abstract TjzxVo[] getTj() throws Throwable;
	
	/**
	 * 获取最新文章
	 * @return
	 * @throws Throwable
	 */
	public abstract TjzxVo[] getXz() throws Throwable;
	
	/**
	 * 查询论坛最新帖子
	 * @return
	 * @throws Throwable
	 */
	public abstract TjzxVo[] getLt() throws Throwable;
	
}
