package com.jiudian.p2p.front.service.credit.achieve;

import java.math.BigDecimal;
import java.sql.Connection;

import com.jiudian.framework.service.ServiceFactory;
import com.jiudian.framework.service.ServiceResource;
import com.jiudian.framework.service.exception.ParameterException;
import com.jiudian.p2p.common.enums.LoanIntentionState;
import com.jiudian.p2p.front.service.credit.IntentionManage;
import com.jiudian.p2p.front.service.credit.entity.GrjkQuery;
import com.jiudian.p2p.front.service.credit.entity.IntentionQuery;
import com.jiudian.p2p.front.service.credit.entity.QyjkQuery;
import com.jiudian.util.StringHelper;

public class IntentionManageImpl extends AbstractAccountService implements
		IntentionManage {

	public static class IntentionManageFactory implements
			ServiceFactory<IntentionManage> {
		@Override
		public IntentionManage newInstance(ServiceResource serviceResource) {
			return new IntentionManageImpl(serviceResource);
		}
	}

	public IntentionManageImpl(ServiceResource serviceResource) {
		super(serviceResource);
	}

	@Override
	public void addIntention(IntentionQuery query) throws Throwable {
		serviceResource.openTransactions();
		String name = "";
		String phonenumber = "";
		String describe = "";
		BigDecimal money = new BigDecimal(0);
		{
			name = query.getName();
			if (StringHelper.isEmpty(name) || name.length() > 32) {
				throw new ParameterException("联系人不能超过32个字");
			}

			phonenumber = query.getPhonenumber();
			if (StringHelper.isEmpty(phonenumber) || phonenumber.length() > 20) {
				throw new ParameterException("手机号错误！");
			}

			describe = query.getDescribe();
			if (StringHelper.isEmpty(describe) || describe.length() < 20) {
				throw new ParameterException("借款描述应限制在20-500字之间");
			}

			money = query.getMoney();
			if (money == null || money.intValue() <= 0) {
				throw new ParameterException("请输入借款金额");
			}

		}

		try (Connection connection = getConnection()) {
			insert(connection,
					"INSERT INTO T6050 SET F02=?,F03=?,F04=?,F05=?,F06=?,F07=?,F08=?,F09='WCL',F12=CURRENT_TIMESTAMP()",
					name, phonenumber, money, query.getIntentionType().name(),
					query.getCity(), query.getTime(), describe);
		}

	}

	@Override
	public void addGrjk(GrjkQuery query) throws Throwable {
		serviceResource.openTransactions();
		if(query == null){
			throw new ParameterException("添加数据为空");
		}
		if(StringHelper.isEmpty(query.getName()) || query.getName().length() > 50){
			throw new ParameterException("借款人姓名大于50");
		}
		if(StringHelper.isEmpty(query.getSfzh())){
			throw new ParameterException("身份证号为空");
		}
		if(StringHelper.isEmpty(query.getJtzz()) || query.getJtzz().length() > 100){
			throw new ParameterException("借款人家庭住址长度大于100");
		}
		if(StringHelper.isEmpty(query.getLxfs()) || query.getLxfs().length() > 20){
			throw new ParameterException("联系方式大于20");
		}
		if(StringHelper.isEmpty(query.getZy()) || query.getZy().length() > 50){
			throw new ParameterException("借款人职业大于50");
		}
		if(query.getHyzk() == null){
			throw new ParameterException("借款人婚姻状况为空");
		}
		if(query.getJkje() == null){
			throw new ParameterException("借款金额未输入");
		}
		if(StringHelper.isEmpty(query.getQx())){
			throw new ParameterException("借款期限未选择");
		}
		if(query.getJkll() == null){
			throw new ParameterException("借款利率未输入");
		}
		if(StringHelper.isEmpty(query.getJkyt())){
			throw new ParameterException("借款用途为空");
		}
		if(query.getHkfs() == null){
			throw new ParameterException("还款方式未选择");
		}
		if(StringHelper.isEmpty(query.getHkly())){
			throw new ParameterException("借款来源为空");
		}
		int userid = serviceResource.getSession().getAccountId();
		try (Connection connection = getConnection()) {
			insert(connection,"INSERT INTO T6050_1 SET F02=?,F03=?,F04=?,F05=?,F06=?,F07=?,F08=?,F09=?,F10=?,F11=?,F12=?,F13=?,F14=?,F15=?,F16=?,F17=?,F20=CURRENT_TIMESTAMP()",
					userid,query.getName(),query.getSfzh(),query.getJtzz(),query.getLxfs(),query.getZy(),query.getHyzk().name(),
					query.getPoxm(),query.getPosfzh(),query.getJkje(),query.getQx(),query.getJkll(),query.getJkyt(),
					query.getHkfs().name(),query.getHkly(),LoanIntentionState.WCL.name());
		}

		
	}

	@Override
	public void addQyjk(QyjkQuery query) throws Throwable {
		serviceResource.openTransactions();
		if(query == null){
			throw new ParameterException("添加数据为空");
		}
		if(StringHelper.isEmpty(query.getQymc()) || query.getQymc().length() > 50){
			throw new ParameterException("企业名称大于50");
		}
		if(StringHelper.isEmpty(query.getQydz()) || query.getQydz().length() > 100){
			throw new ParameterException("企业地址大于100");
		}
		if(StringHelper.isEmpty(query.getQyxfs()) || query.getQyxfs().length() > 20){
			throw new ParameterException("企业联系方式大于20");
		}
		if(query.getZczb() == null){
			throw new ParameterException("注册资本为空");
		}
		if(query.getSszb() == null){
			throw new ParameterException("实收资本为空");
		}
		if(StringHelper.isEmpty(query.getZyyw()) || query.getZyyw().length() > 255){
			throw new ParameterException("主营业务大于255");
		}
		if(StringHelper.isEmpty(query.getYyzz()) || query.getYyzz().length() > 50){
			throw new ParameterException("营业执照注册号大于50");
		}
		if(StringHelper.isEmpty(query.getJgdm()) || query.getJgdm().length() > 50){
			throw new ParameterException("机构代码证登记号大于50");
		}
		if(StringHelper.isEmpty(query.getSwdj()) || query.getSwdj().length() > 50){
			throw new ParameterException("税务登记证编号大于50");
		}
		if(StringHelper.isEmpty(query.getFrdb()) || query.getFrdb().length() > 50){
			throw new ParameterException("法人代表大于50");
		}
		if(StringHelper.isEmpty(query.getFrlxfs()) || query.getFrlxfs().length() > 20){
			throw new ParameterException("法人联系方式大于50");
		}
		if(StringHelper.isEmpty(query.getFrdb())){
			throw new ParameterException("法人身份证号码为空");
		}
		if(StringHelper.isEmpty(query.getJtzz()) || query.getJtzz().length() > 100){
			throw new ParameterException("家庭住址大于100");
		}
		if(query.getHyzk() == null){
			throw new ParameterException("借款人婚姻状况为空");
		}
		if(query.getJkje() == null){
			throw new ParameterException("借款金额未输入");
		}
		if(StringHelper.isEmpty(query.getQx())){
			throw new ParameterException("借款期限未选择");
		}
		if(query.getJkll() == null){
			throw new ParameterException("借款利率未输入");
		}
		if(StringHelper.isEmpty(query.getJkyt())){
			throw new ParameterException("借款用途为空");
		}
		if(query.getHkfs() == null){
			throw new ParameterException("还款方式未选择");
		}
		if(StringHelper.isEmpty(query.getHkly())){
			throw new ParameterException("借款来源为空");
		}
		int userid = serviceResource.getSession().getAccountId();
		try(Connection conn = getConnection()){
			insert(getConnection(), "INSERT INTO T6050_2 SET F02=?,F03=?,F04=?,F05=?,F06=?,F07=?,F08=?,F09=?,F10=?,F11=?,"
					+ "F12=?,F13=?,F14=?,F15=?,F16=?,F17=?,F18=?,F19=?,F20=?,F21=?,F22=?,F23=?,F26=CURRENT_TIMESTAMP()",
					userid,query.getQymc(),query.getQydz(),query.getQyxfs(),query.getZczb(),query.getSszb(),query.getZyyw(),query.getYyzz(),query.getJgdm(),
					query.getSwdj(),query.getFrdb(),query.getFrlxfs(),query.getSfzhm(),query.getJtzz(),query.getHyzk().name(),query.getJkje(),
					query.getQx(),query.getJkll(),query.getJkyt(),query.getHkfs().name(),query.getHkly(),LoanIntentionState.WCL.name());
		}
	}

}
