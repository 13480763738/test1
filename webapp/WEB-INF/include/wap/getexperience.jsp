
<form class="tyjform" method="post" action="">
<div class="tc_box hq input_tc" style="display:none;" id="get_experience">
	<div class="hqtyj">
    	<h2>获取体验金</h2>
        <div class="txt_box">
            <div class="input_border"><input type="text" id="tyjnum" placeholder="请输入体验金券号" class="input max-length-8"></div>
            <p tip=""></p>
			<p errortip=""></p>
        </div>
        <div class="btn_box">
        	<input type="button" value="取消" onclick="clear_dialog('get_experience',0,0);" class="qx_btn">
            <input type="button" value="确认" class="qr_btn tjhqtyj">
        </div>
    </div>
</div>
</form>

<div class="tc_box gxn" style="display:none;" id="success_experiences">
	<div class="hqtyj">
    	<h3>恭喜你<br/>获得<span id="tyjje" >0</span>元体验金！</h3>
        <div class="btn_box qr_btns" style="text-align:center;">
            <input type="button" onclick="_success_get_experiences()" value="确认" class="qr_btn">
        </div>
    </div>
</div>