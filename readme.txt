一、代码运行环境：
MATLAB2019 / MATLAB2018 / MATLAB2017

二、文件说明
1. SARMA_Forecast.m
知乎专栏（https://zhuanlan.zhihu.com/p/117595003）中的多步预测代码。为脚本文件，可以直接运行。其中调用了SARMA_Order_Select和creatSARIMA
2. Demo_SARIMA.m
调用Fun_SARIMA_Forecast 进行多步预测的demo。m文件，可以直接运行
3. SARMA_Order_Select.p
通过AIC，BIC等准则暴力选定阶数。P文件，可以调用。
4. Fun_SARIMA_Forecast.p
封装好的预测程序，可以通过输入原始数据、预测步数等直接获得预测结果。使用SARIMA进行预测的函数，可以直接调用，非季节差分阶数自动确定。p，q，P，Q自动确定。P文件，可以调用。
5. creatSARIMA.p
根据输入条件创建SARIMA模型的函数，p文件，可以调用
三、获取源码
如果需要封装好的预测函数（Fun_SARIMA_Forecast.m）、定阶函数（SARMA_Order_Select.m）和模型创建函数（creatSARIMA.m）的源码，可在下述连接获取。

编程不易，感谢支持~

紧巴巴的学生党可以联系店主，店主会给优惠~

https://item.taobao.com/item.htm?spm=a2126o.11854294.0.0.709e4831JOp1nS&id=614056536116

