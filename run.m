clear all
clc

%load datas
[ori_tr,labelo_tr]=loaddata('./original/train',4); %load training set in original
[ori_te,labelo_te]=loaddata('./original/test',4);  %load test in original
[sca_tr,labels_tr]=loaddata2('./scaled/train',4);   %load training set in scaled
[sca_te,labels_te]=loaddata2('./scaled/test',4);    %load test set in scaled
[d_tr,labeld_tr]=loaddata('train0.10',10);          %load training set in data0.10
[d_te,labeld_te]=loaddata('test0.10',10);           %load test set in data0.10

%sat bias for loaddata
ori_tr(:,1)=1;
ori_te(:,1)=1;


%using -1 istead of 0
labelo_tr=labelo_tr-(labelo_tr==0);
labelo_te=labelo_te-(labelo_te==0);
labels_tr=labels_tr-(labels_tr==0);
labels_te=labels_te-(labels_te==0);



%run svm

T=30;
pho=0.01;

% on original
c=0.1;
wo=svm(ori_tr,labelo_tr,pho,c,T);
acco=intest(ori_te,labelo_te,wo)

% on scaled
c=10;
ws=svm(sca_tr,labels_tr,pho,c,T);
accs=intest(sca_te,labels_te,ws)

%on data0
c=50;
wd=svm(d_tr,labeld_tr,pho,c,T);
accd=intest(d_te,labeld_te,wd)



%transform data
t_ori_tr=transform(ori_tr);
t_ori_te=transform(ori_te);
t_sca_tr=transform(sca_tr);
t_sca_te=transform(sca_te);

%find farthest data
do=farthest(ori_tr);
dote=farthest(ori_te);
ds=farthest(sca_tr);
dste=farthest(sca_te);

do_tr=farthest(t_ori_tr);
dote_tr=farthest(t_ori_te);
ds_tr=farthest(t_sca_tr);
dste_tr=farthest(t_sca_te);



%cross validation
%pho0=[0.001;0.01;0.1;1];
%c0=[0.001;0.01;0.1;1;10];

%case original
pho0=[0.001;0.01;0.1;1];
c0=[0.001;0.01;0.1;0.5;0.8;1;10];
resulto=crosval(ori_tr,labelo_tr,pho0,c0)
[ac_o,mrgin_o]=predict(resulto,ori_tr,labelo_tr,ori_te,labelo_te)

%case original_transformation
pho0=[0.001;0.01;0.1;1];
c0=[0.001;0.01;0.1;1;10];
resulto_tr=crosval(t_ori_tr,labelo_tr,pho0,c0)
[ac_o_tr,margin_o_tr]=predict(resulto_tr,t_ori_tr,labelo_tr,t_ori_te,labelo_te)

%case scala
pho0=[0.001;0.01;0.1;1];
c0=[0.001;0.01;0.1;1;10;12;15];
results=crosval(sca_tr,labels_tr,pho0,c0)
[ac_s, margin_s]=predict(results,sca_tr,labels_tr,sca_te,labels_te)

%case scala_transformation
pho0=[0.001;0.01;0.1;1];
c0=[0.001;0.01;0.1;1;10;70;100];
results_tr=crosval(t_sca_tr,labels_tr,pho0,c0)
[ac_s_tr, margin_s_tr]=predict(results_tr,t_sca_tr,labels_tr,t_sca_te,labels_te)

%case data0
pho0=[0.001;0.01;0.1;1];
c0=[0.001;0.01;0.1;1;10;20;50;100];
result_d=crosval(d_tr,labeld_tr,pho0,c0)
[ac_d, margin_d]=predict(result_d,d_tr,labeld_tr,d_te,labeld_te)




