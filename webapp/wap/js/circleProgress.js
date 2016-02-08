//x,y ���,radius �뾶,process �ٷֱ�,backColor ������ɫ, proColor �����ɫ, fontColor ����������ɫ
function DrowProcess(id,x,y,radius,process,backColor,proColor,fontColor){
	
		
		var canvas = document.getElementById(id);

	if (canvas.getContext) {
		var cts = canvas.getContext('2d');
	}else{
		return;
	}
	
	cts.beginPath();  
	// ����ƶ���Բ��  
	cts.moveTo(x, y);  
	// ��Բ,Բ����24,24,�뾶24,�ӽǶ�0��ʼ,����2PI����,���һ�������Ƿ���˳ʱ�뻹����ʱ��  
	cts.arc(x, y, radius, 0, Math.PI * 2, false);  
	cts.closePath();  
	// �����ɫ  
	cts.fillStyle = backColor;  
	cts.fill();

	cts.beginPath();  
	// �����ε�ʱ���ⲽ����Ҫ,���ʲ���Բ�Ļ������Ĳ�������  
	cts.moveTo(x, y);  
	// �������ԲΨһ�����������,������Բ,��������  
	cts.arc(x, y, radius, Math.PI * 1.5, Math.PI * 1.5 -  Math.PI * 2 * process / 100, true);  
	cts.closePath();  
	cts.fillStyle = proColor;  
	cts.fill(); 
	
	//��䱳����ɫ
	cts.beginPath();  
	cts.moveTo(x, y); 
	cts.arc(x, y, radius - (radius * 0.2), 0, Math.PI * 2, true);  
	cts.closePath();
	cts.fillStyle = 'rgba(255,255,255,1)';  
	cts.fill(); 

	// ��һ����  
	cts.beginPath();  
	cts.arc(x, y, radius-(radius*0.20), 0, Math.PI * 2, true);  
	cts.closePath();  
	// �뻭ʵ��Բ�����,fill�����,stroke�ǻ���  
	cts.strokeStyle = backColor;  
	cts.stroke();  
	  
	//���м�д�� 
	cts.font = "bold 16pt ΢���ź�";  
	cts.fillStyle = fontColor;  
	cts.textAlign = 'center';  
	cts.textBaseline = 'middle';  
	cts.moveTo(x, y);  
	cts.fillText(process+"%", x, y);  
	
}
