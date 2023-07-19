%================================================================================
% Segmenting Images With Different Types/Lighting/Background
%================================================================================


function outputImage = segment_image(inputImage,handles)
    %=====Segmentation by TP061278 Thean Yee Sin=====
    if handles.chosenOperation == 1
        %=====Sharpen Image=====
        unsharpMask=fspecial('unsharp');
        sharpenImg=imfilter(inputImage,unsharpMask,'conv');

        %=====Turn Image To Gray Sale Image=====
        grayImg = rgb2gray(sharpenImg(:,:,1:3));

        %=====Adjust Contrast Of The Gray Image=====
        grayImg = imadjust(grayImg);

        %=====Manual Threshold=====
        binarizeImg = grayImg > 170;

        %=====Morphological Operation - Close=====
        se = strel('rectangle', [10 3]);
        binarizeImg = imclose(binarizeImg, se);
        binarizeImg = imerode(binarizeImg, se);
        binarizeImg = bwareaopen(binarizeImg,50);

    %=====Segmentation by TP059897 Ee Jiunn Haw=====
    elseif handles.chosenOperation == 2
        %=====Turn Image To Gray Sale Image=====
        grayImg = rgb2gray(inputImage(:,:,1:3));
       
        %=====Image data adjustment for data range=====
        grayImg = imadjust(grayImg);
        
        %=====Graph cut the glove color as foreground, 
        %the background color as background to diffirentiate=====
        foregroundInd = 1602353 ;
        backgroundInd = 2291651 ;
        L = superpixels(grayImg,12051);

        %=====Lazysnapping the color and data=====
        binarizeImg = lazysnapping(grayImg,L,foregroundInd,backgroundInd);

        

    %=====Segmentation by TP059577 Yong Zu Yi=====   
    elseif handles.chosenOperation == 3
        %=====Turn Image To Gray Sale Image=====
        grayImg = rgb2gray(inputImage);

        %=====Adjust Contrast And Brightness Of The Gray Image
        grayImg = imadjust(grayImg,[0.4 0.7],[],0.5);

        %=====Adaptive Threshold=====
        binarizeImg=imbinarize(grayImg,'adaptive', 'Sensitivity', 0.700000, 'ForegroundPolarity', 'bright');

        %=====Morphological Operation - Dilate=====
        radius = 3;
        decomposition = 0;
        se = strel('disk', radius, decomposition);
        binarizeImg = imdilate(binarizeImg, se);
    end
    outputImage=binarizeImg;
end