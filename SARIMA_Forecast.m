close all
clear all
%% 1.加载数据
load('Data_Airline.mat')
data = Data(:);
S = 12; %季节性序列变化周期
step = 48;
% 通常P和Q不大于3
%% 2.确定季节性与非季节性差分数，D取默认值1，d从0至3循环，平稳后停止
for d = 0:3
    D1 = LagOp({1 -1},'Lags',[0,d]);     %非季节差分项的滞后算子
    D12 = LagOp({1 -1},'Lags',[0,1*S]);  %季节差分项的滞后算子
    D = D1*D12;          %相乘
    dY = filter(D,data); %对原数据进行差分运算
    if(getStatAdfKpss(dY)) %数据平稳
        disp(['非季节性差分数为',num2str(d),'，季节性差分数为1']);
        break;
    end
end
%% 3.确定阶数ARlags,MALags,SARLags,SMALags
max_ar = 3;    %ARlags上限
max_ma = 3;    %MALags上限
max_sar = 3;   %SARLags上限
max_sma = 3;   %SMALags上限
try
    [AR_Order,MA_Order,SAR_Order,SMA_Order] = SARMA_Order_Select(dY,max_ar,max_ma,max_sar,max_sma,S,d); %自动定阶 获取源码方式参看"代码说明.docx"
catch ME %捕捉错误信息
    msgtext = ME.message;
    if (strcmp(ME.identifier,'econ:arima:estimate:InvalidVarianceModel'))
         msgtext = [msgtext,'  ','无法进行arima模型估计，这可能是由于用于训练的数据长度较小，而要进行拟合的阶数较高导致的，请尝试减小max_ar,max_ma,max_sar,max_sma的值'];
    end
    msgbox(msgtext, '错误')
end
disp(['ARlags=',num2str(AR_Order),',MALags=',num2str(MA_Order),',SARLags=',num2str(SAR_Order),',SMALags=',num2str(SMA_Order)]);
%% 4.残差检验
Mdl = creatSARIMA(AR_Order,MA_Order,SAR_Order,SMA_Order,S,d);  %创建SARIMA模型 获取源码方式参看"代码说明.docx"
try
    EstMdl = estimate(Mdl,data);
catch ME %捕捉错误信息
    msgtext = ME.message;
    if (strcmp(ME.identifier,'econ:arima:estimate:InvalidVarianceModel'))
         msgtext = [msgtext,'  ','无法进行arima模型估计，这可能是由于用于训练的数据长度较小，而要进行拟合的阶数较高导致的，请尝试减小max_ar和max_ma的值']
    end
    msgbox(msgtext, '错误')
    return
end
[res,~,logL] = infer(EstMdl,data);   %res即残差

stdr = res/sqrt(EstMdl.Variance);
figure('Name','残差检验','Visible','on')
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
% Durbin-Watson 统计是计量经济学分析中最常用的自相关度量
diffRes0 = diff(res);  
SSE0 = res'*res;
DW0 = (diffRes0'*diffRes0)/SSE0 % Durbin-Watson statistic，该值接近2，则可以认为序列不存在一阶相关性。
%% 5.预测
if contains(version,'2018') || contains(version,'2017')
    [forData,YMSE] = forecast(EstMdl,step,'Y0',data);   %matlab2018及以下版本写为Predict_Y = forecast(EstMdl,step,'Y0',Y);   matlab2019写为Predict_Y = forecast(EstMdl,step,Y);
elseif contains(version,'2019')
    [forData,YMSE] = forecast(EstMdl,step,data);   %matlab2018及以下版本写为Predict_Y = forecast(EstMdl,step,'Y0',Y);   matlab2019写为Predict_Y = forecast(EstMdl,step,Y);
else
    warndlg('仅支持MATLAB2017/2018/2019')
end
lower = forData - 1.96*sqrt(YMSE); %95置信区间下限
upper = forData + 1.96*sqrt(YMSE); %95置信区间上限

figure('Visible','on')
plot(data,'Color',[.7,.7,.7]);
hold on
h1 = plot(length(data):length(data)+step,[data(end);lower],'r:','LineWidth',2);
plot(length(data):length(data)+step,[data(end);upper],'r:','LineWidth',2)
h2 = plot(length(data):length(data)+step,[data(end);forData],'k','LineWidth',2);
legend([h1 h2],'95% 置信区间','预测值',...
	     'Location','NorthWest')
title('Forecast')
hold off

function stat = getStatAdfKpss(data)
try 
    stat = adftest(data) && ~kpsstest(data);
catch ME
    msgtext = ME.message;
    if (strcmp(ME.identifier,'econ:adftest:EffectiveSampleSizeLessThanTabulatedValues'))
         msgtext = [msgtext,'  ','单位根检验无法进行，数据长度不足'];
    end
    msgbox(msgtext, '错误')
end
end