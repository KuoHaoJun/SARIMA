load('Data_Airline.mat')
data = Data;
days = 48; %Ԥ��45������
S = 12; %����
max_ar = 3;
max_ma = 3;
max_sar = 3;
max_sma = 3;
figflag = 'on';
[forData,lower,upper] = Fun_SARIMA_Forecast(data,days,max_ar,max_ma,max_sar,max_sma,S,figflag);  %��ȡԴ�뷽ʽ�ο�"����˵��.docx"
% ʹ��SARIMA����Ԥ��ĺ���������ֱ�ӵ��ã��Ǽ��ڲ�ֽ����Զ�ȷ����p��q��P��Q�Զ�ȷ��
% ���룺
% dataΪ��Ԥ�����ݣ�һά���ݣ�ʹ��SARIMAʱ�������ݳ�������Ϊ10+S��SΪ���ڳ��ȣ����Ǵﵽ10+S֮����Ȼ���ܻᱨ�������������ݵĲ�ִ���ʹ��Ŀ�����ݳ��ȱ�̵��µġ�
% stepΪ��Ԥ�ⲽ��
% max_arΪARģ����Ѱ��������   ���鲻����3
% max_maΪMAģ����Ѱ��������   ���鲻����3
% max_sarΪSARģ����Ѱ��������   ���鲻����3
% max_smsΪSMAģ����Ѱ��������   ���鲻����3
% SΪ����������
% figflag Ϊ��ͼ��־λ��'on'Ϊ��ͼ��'off'Ϊ����
% �����
% forDataΪԤ�������䳤�ȵ���step
% lowerΪԤ������95%��������ֵ
% upperΪԤ������95%��������ֵ