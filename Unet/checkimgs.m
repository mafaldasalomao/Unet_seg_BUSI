clear all;



dataset_base = "dataset\images";
imds = imageDatastore(dataset_base);
%%
for i =1:length(imds.Files)
    img = readimage(imds,i);
    img = imresize(img, [224 224]);
    [~, ~, c] = size(img);
    img = rescale(img, 0, 1);
    imwrite(img, imds.Files{i});
end