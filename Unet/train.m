clear all; close all;
%The width and height of the image must be a multiple of 2^EncoderDepth.
imageSize = [224 224 3];
numClasses = 2;
encoderDepth = 5;
lgraph = unetLayers(imageSize,numClasses,'EncoderDepth',encoderDepth)
%plot(lgraph)

dataSetDir = fullfile('dataset');
imageDir = fullfile(dataSetDir,'images');
labelDir = fullfile(dataSetDir,'labels');
imds = imageDatastore(imageDir);
classNames = ["tumor","background"];
labelIDs   = [1 0];
pxds = pixelLabelDatastore(labelDir,classNames,labelIDs);
ds = combine(imds,pxds);
options = trainingOptions('adam', ...
    'MiniBatchSize',7,...
    'InitialLearnRate',1e-3, ...
    'MaxEpochs',10,...
    'Plots','training-progress',...
    'ExecutionEnvironment','cpu');

net = trainNetwork(ds,lgraph,options)

%imageDS.ReadFcn = @customReadDatastoreImage;

I = imread("dataset\images\benign (1).png");
C = semanticseg(I,net);
B = labeloverlay(I,C);
figure

imshow(B)

