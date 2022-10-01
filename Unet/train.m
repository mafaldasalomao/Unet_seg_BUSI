imageSize = [224 224 3];
numClasses = 2;
encoderDepth = 4;
lgraph = unetLayers(imageSize,numClasses,'EncoderDepth',encoderDepth)
%plot(lgraph)

imds   = imageDatastore('dataset\'...
                        ,'IncludeSubfolders',true, 'LabelSource','foldernames');

dataSetDir = fullfile('dataset');
imageDir = fullfile(dataSetDir,'images');
labelDir = fullfile(dataSetDir,'labels');
imds = imageDatastore(imageDir);
classNames = ["tumor","background"];
labelIDs   = [1 0];
pxds = pixelLabelDatastore(labelDir,classNames,labelIDs);
ds = combine(imds,pxds);
options = trainingOptions('sgdm', ...
    'MiniBatchSize',10,...
    'InitialLearnRate',1e-3, ...
    'MaxEpochs',5, ...
    'VerboseFrequency',10);

net = trainNetwork(ds,lgraph,options)

%imageDS.ReadFcn = @customReadDatastoreImage;


