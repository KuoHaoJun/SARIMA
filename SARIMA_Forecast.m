close all
clear all
%% 1.��������
load('Data_Airline.mat')
data = Data(:);
S = 12; %���������б仯����
step = 48;
% ͨ��P��Q������3
%% 2.ȷ����������Ǽ����Բ������DȡĬ��ֵ1��d��0��3ѭ����ƽ�Ⱥ�ֹͣ
for d = 0:3
    D1 = LagOp({1 -1},'Lags',[0,d]);     %�Ǽ��ڲ������ͺ�����
    D12 = LagOp({1 -1},'Lags',[0,1*S]);  %���ڲ������ͺ�����
    D = D1*D12;          %���
    dY = filter(D,data); %��ԭ���ݽ��в������
    if(getStatAdfKpss(dY)) %����ƽ��
        disp(['�Ǽ����Բ����Ϊ',num2str(d),'�������Բ����Ϊ1']);
        break;
    end
end
%% 3.ȷ������ARlags,MALags,SARLags,SMALags
max_ar = 3;    %ARlags����
max_ma = 3;    %MALags����
max_sar = 3;   %SARLags����
max_sma = 3;   %SMALags����
try
    [AR_Order,MA_Order,SAR_Order,SMA_Order] = SARMA_Order_Select(dY,max_ar,max_ma,max_sar,max_sma,S,d); %�Զ����� ��ȡԴ�뷽ʽ�ο�"����˵��.docx"
catch ME %��׽������Ϣ
    msgtext = ME.message;
    if (strcmp(ME.identifier,'econ:arima:estimate:InvalidVarianceModel'))
         msgtext = [msgtext,'  ','�޷�����arimaģ�͹��ƣ����������������ѵ�������ݳ��Ƚ�С����Ҫ������ϵĽ����ϸߵ��µģ��볢�Լ�Сmax_ar,max_ma,max_sar,max_sma��ֵ'];
    end
    msgbox(msgtext, '����')
end
disp(['ARlags=',num2str(AR_Order),',MALags=',num2str(MA_Order),',SARLags=',num2str(SAR_Order),',SMALags=',num2str(SMA_Order)]);
%% 4.�в����
Mdl = creatSARIMA(AR_Order,MA_Order,SAR_Order,SMA_Order,S,d);  %����SARIMAģ�� ��ȡԴ�뷽ʽ�ο�"����˵��.docx"
try
    EstMdl = estimate(Mdl,data);
catch ME %��׽������Ϣ
    msgtext = ME.message;
    if (strcmp(ME.identifier,'econ:arima:estimate:InvalidVarianceModel'))
         msgtext = [msgtext,'  ','�޷�����arimaģ�͹��ƣ����������������ѵ�������ݳ��Ƚ�С����Ҫ������ϵĽ����ϸߵ��µģ��볢�Լ�Сmax_ar��max_ma��ֵ']
    end
    msgbox(msgtext, '����')
    return
end
[res,~,logL] = infer(EstMdl,data);   %res���в�

stdr = res/sqrt(EstMdl.Variance);
figure('Name','�в����','Visible','on')
subplot(2,3,1)
plot(stdr)
title('Standardized Residuals')
subplot(2,3,2)
histogram(stdr,10)
title('Standardized Residuals')
subplot(2,3,3)
autocorr(stdr)
subplot(2,3,4)
parcorr(stdr)
subplot(2,3,5)
qqplot(stdr)
% Durbin-Watson ͳ���Ǽ�������ѧ��������õ�����ض���
diffRes0 = diff(res);  
SSE0 = res'*res;
DW0 = (diffRes0'*diffRes0)/SSE0 % Durbin-Watson statistic����ֵ�ӽ�2���������Ϊ���в�����һ������ԡ�
%% 5.Ԥ��
if contains(version,'2018') || contains(version,'2017')
    [forData,YMSE] = forecast(EstMdl,step,'Y0',data);   %matlab2018�����°汾дΪPredict_Y = forecast(EstMdl,step,'Y0',Y);   matlab2019дΪPredict_Y = forecast(EstMdl,step,Y);
elseif contains(version,'2019')
    [forData,YMSE] = forecast(EstMdl,step,data);   %matlab2018�����°汾дΪPredict_Y = forecast(EstMdl,step,'Y0',Y);   matlab2019дΪPredict_Y = forecast(EstMdl,step,Y);
else
    warndlg('��֧��MATLAB2017/2018/2019')
end
lower = forData - 1.96*sqrt(YMSE); %95������������
upper = forData + 1.96*sqrt(YMSE); %95������������

figure('Visible','on')
plot(data,'Color',[.7,.7,.7]);
hold on
h1 = plot(length(data):length(data)+step,[data(end);lower],'r:','LineWidth',2);
plot(length(data):length(data)+step,[data(end);upper],'r:','LineWidth',2)
h2 = plot(length(data):length(data)+step,[data(end);forData],'k','LineWidth',2);
legend([h1 h2],'95% ��������','Ԥ��ֵ',...
	     'Location','NorthWest')
title('Forecast')
hold off

function stat = getStatAdfKpss(data)
try 
    stat = adftest(data) && ~kpsstest(data);
catch ME
    msgtext = ME.message;
    if (strcmp(ME.identifier,'econ:adftest:EffectiveSampleSizeLessThanTabulatedValues'))
         msgtext = [msgtext,'  ','��λ�������޷����У����ݳ��Ȳ���'];
    end
    msgbox(msgtext, '����')
end
end