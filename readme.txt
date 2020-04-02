一、代码运行环境：
MATLAB2019 / MATLAB2018 / MATLAB2017

二、文件说明
1. SARMA_Forecast.m
知乎专栏（https://zhuanlan.zhihu.com/p/117595003）中的多步预测代码。为脚本文件，可以直接运行。其中调用了SARMA_Order_Select和creatSARIMA
2. SARMA_Order_Select.p
通过AIC，BIC等准则暴力选定阶数。P文件，可以调用。
3. creatSARIMA.p
根据输入条件创建SARIMA模型的函数，p文件，可以调用

三、获取源码
如果需要定阶函数（SARMA_Order_Select.m）和模型创建函数（creatSARIMA.m）的源码，可在文末链接获取。

源码中包括了店主最新代码，其中还包括：

1)	最新的定阶函数（SARMA_Order_Select.m）的源码。
2)	封装好的全流程函数（Fun_SARIMA_Forecast.m），可以通过输入原始数据、预测步数等直接获得预测结果。使用SARIMA进行预测的函数，可以直接调用，非季节差分阶数自动确定，p，q，P，Q自动确定。将使用SARIMA进行预测的过程中的大部分工作都固化下来，非常方便使用。
3)	演示函数调用方法的demo，包含使用Fun_SARIMA_Forecast.m进行多步预测的程序典型写法。
4)	更为丰富、详细的注释。

编程不易，感谢支持~

紧巴巴的学生党可以联系店主，店主会给优惠~

https://item.taobao.com/item.htm?spm=a2126o.11854294.0.0.709e4831JOp1nS&id=614056536116

