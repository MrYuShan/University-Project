%========================================
% Extract Features From An Image 
%========================================
function [F]=extract_feature(inputImage)
    %=====MEAN & STANDARD DEVIATION OF THE IMAGE=====
    inputImage=double(inputImage);

    %=====Mean Of The Image(Twice Because Image Is 2d Array)=====
    mean1=mean(inputImage);
    mean2=mean(mean1);

    %=====Standard Deviation Of The Image(Twice Because Image Is 2d Array)=====
    std1 = std(inputImage);
    std2 = std(std1);
    
    regionProperties = regionprops(inputImage,'All');
    %=====Area Of The Image=====
    area=bwarea(inputImage);
        
    %=====Perimeter Of The Image=====
    peri=max([regionProperties.Perimeter]);

    %=====Minor Axis Length=====
    minor=max([regionProperties.MinorAxisLength]);

    %=====Major Axis Length=====
    major=max([regionProperties.MajorAxisLength]);

    %=====Solidity=====
    solidity=mean([regionProperties.Solidity]);

    %=====Extent=====
    extent=mean([regionProperties.Extent]);

    %=====Convex Area=====
    convArea=sum([regionProperties.ConvexArea]);

    F=[mean2 std2 area peri minor major solidity extent convArea];
end