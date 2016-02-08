 window.onload=function(){
	    fntab('question');
	    fntab('question2');
	    fntab('question3');
	   function fntab(id){
			var oQes=document.getElementById(id);
			var aH3=oQes.getElementsByTagName('h3');
			var aSpan=oQes.getElementsByTagName('span');
			for(var i=0;i<aH3.length;i++){
				aH3[i].index=i;
				aH3[i].onclick=function(){

					for(var i=0;i<aH3.length;i++){
						aH3	[i].className='';
						aSpan[i].style.display='none';
					}
					aSpan[this.index].style.display='block';
					this.className='active';
			}	
		}
	}

}

