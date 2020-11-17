load traindata.mat;
traindata=Instance';
mlplabel=Label';
a=find(mlplabel==-1);
mlplabel=cat(1,mlplabel,zeros(1,length(mlplabel)));
mlplabel(2,a)=1;  %down is non-shadow label
mlplabel(1,a)=0;  %up is shadow label
x=traindata;
t = mlplabel; 
%% Construct Neural Nerwork
% Choose a Training Function
% For a list of all training functions type: help nntrain
% Backpropagation training functions that use Jacobian derivatives
% 'trainlm' is usually fastest.
% 'trainbr' takes longer but may be better for challenging problems.

% Backpropagation training functions that use gradient derivatives
% These algorithms may not be as fast as Jacobian backpropagation.
% They are supported on GPU hardware with the Parallel Computing Toolbox.
% 'trainscg' uses less memory. Suitable in low memory situations.
trainFcn = 'trainscg';  % Scaled conjugate gradient backpropagation.
hiddenLayerSize = 10;

%default arguments are 'trainscg','crossentropy'.
%trainbr   - Bayesian Regulation backpropagation.
%trainlm   - Levenberg-Marquardt backpropagation.
mlp10sat = patternnet(hiddenLayerSize);
mlp10sat.layers{1}.transferFcn='satlin'; %set activation function of first layer
% Setup Division of Data for Training, Validation, Testing
mlp10sat.divideParam.trainRatio = 70/100;
mlp10sat.divideParam.valRatio = 15/100;
mlp10sat.divideParam.testRatio = 15/100;

% Train the Network
[mlp10sat,tr] = train(mlp10sat,x,t);
% View the Network
%view(mlp1net)

%% Test the network
y=mlp10sat(x);
e=gsubtract(t,y);
performance=perform(mlp10sat,t,y);
tind=vec2ind(t);
yind=vec2ind(y);
percentErrors=sum(tind~=yind)/numel(tind);
%% Plots
% Uncomment these lines to enable various plots.
% figure, plotperform(tr)
% figure, plottrainstate(tr)
% figure, ploterrhist(e)
% figure, plotconfusion(t,y)
% figure, plotroc(t,y)

%"help nntrain" to see more details
save mlp10satmodel.mat mlp10sat