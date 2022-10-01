clear all;



dataset_base = "D:\temp\labels";
imds = imageDatastore(dataset_base);
%%
for i =1:length(imds.Files)
    img = readimage(imds,i);
    img = imresize(img, [224 224]);
    [~, ~, c] = size(img);
    imwrite(img, imds.Files{i});
end