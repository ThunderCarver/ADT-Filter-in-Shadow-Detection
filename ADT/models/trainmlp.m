for iter=1:7
    datapath=cd;
    datapath=strcat(fileparts(datapath),'/cross validation/');
    datapath=strcat(datapath,num2str(iter),'/');
    load (strcat(datapath,'Ttraindata.mat'));
    traindata=Ttraindata';
    mlplabel=TtrainLabel';
    a=find(mlplabel==-1);
    mlplabel=cat(1,mlplabel,zeros(1,length(mlplabel)));
    mlplabel(2,a)=1;  %down is non-shadow label
    mlplabel(1,a)=0;  %up is shadow label
    x=traindata;
    t = mlplabel; 
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
    hiddenLayerSize = [20,10];

    %default arguments are 'trainscg','crossentropy'.
    %trainbr   - Bayesian Regulation backpropagation.
    %trainlm   - Levenberg-Marquardt backpropagation.
    mlp2010satCV = patternnet(hiddenLayerSize);
    mlp2010satCV.layers{1}.transferFcn='satlin'; %set activation function of first layer
    mlp2010satCV.layers{2}.transferFcn='satlin';

    % force the network to use XTrain only for train (without spilt it into val and test set - as the previous smilation)
    mlp2010satCV.divideFcn='divideind';
    mlp2010satCV.divideParam.trainInd=1:length(x); % use all the train data.
    mlp2010satCV.trainParam.epochs=1000; % set epochs
    %% Setup Division of Data for Training, Validation, Testing
    % mlp10sat.divideParam.trainRatio = 70/100;
    % mlp10sat.divideParam.valRatio = 15/100;
    % mlp10sat.divideParam.testRatio = 15/100;
    %% Train the Network
    [mlp2010satCV,tr] = train(mlp2010satCV,x,t);
    %% Test the network
    y=mlp2010satCV(x);
    e=gsubtract(t,y);
    % performance=perform(mlp10satCV,t,y);
    % tind=vec2ind(t);
    % yind=vec2ind(y);
    % percentErrors=sum(tind~=yind)/numel(tind);
    %% Plots
    % Uncomment these lines to enable various plots.
    % figure, plotperform(tr)
    % figure, plottrainstate(tr)
    % figure, ploterrhist(e)
    % figure, plotroc(t,y)
    figure, plotconfusion(t,y);
    saveas(gcf,strcat(datapath,'mlp2010satCV-train.png'));
    close(gcf);
    % figure, plotroc(t,y)

    %"help nntrain" to see more details
    save (strcat(datapath,'mlp2010satCV.mat'),'mlp2010satCV');
end
