一、代码运行环境：
MATLAB2019 / MATLAB2018 / MATLAB2017

二、文件说明
1.文件夹funs
funs文件夹中为ARMA相关的函数文件，该文件夹中的文件无法直接运行，需要在其他文件或命令行窗口中对入口参数赋值并调用。
1.1. SARMA_Order_Select.m
通过AIC，BIC等准则暴力选定阶数。
1.2. Fun_SARIMA_Forecast.m
封装好的预测程序，可以通过输入原始数据、预测步数等直接获得预测结果。使用SARIMA进行预测的函数，可以直接调用，非季节差分阶数自动确定。p，q，P，Q自动确定。
2.文件夹demos
2.1. Demo_SARIMA.m
调用Fun_SARIMA_Forecast 进行多步预测的demo。
3.文件夹scripts
demo中为一些demo文件，用于测试funs中的函数。
3.1. SARMA_Forecast.m
知乎专栏（https://zhuanlan.zhihu.com/p/69630638）中的多步预测代码。为脚本文件，可以直接运行。其中调用了Fun_SARIMA_Forecast.。

三、使用说明
1. 请像安装一个普通的工具箱一样安装它
使用该工具箱时，需要将文件夹放入到MATLAB安装路径的toolbox文件夹内。
并在MATLAB中选择：主页-设置路径-添加并包含子文件夹-选择toolbox中的SARIMA-保存-关闭
也可以参考这个：https://jingyan.baidu.com/article/c85b7a649e3b64003bac959c.html


四、常见问题：
暂无
