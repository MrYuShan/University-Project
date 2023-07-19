%========================================
% Browse An Image Using File Directory
%========================================
function outputImage = browse_image()
    %=====Get The File Path=====
    [fileName, pathName]=uigetfile({'*';'*.jpg';'*.png';'*.bmp';'*.tif'},"Browse Image");

    %=====Concatenate The File Path=====
    fullName=strcat(pathName, fileName);

    %=====Output The Image=====
    img=imread(fullName);
    outputImage=img;
end