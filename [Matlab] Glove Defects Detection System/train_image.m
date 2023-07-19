%================================================================================
% Train The System By Adding A Dataset To The Database
%================================================================================
function train_image(hObject,handles)
    handles = guidata(hObject);
    %=====Input An Image=====
    img=browse_image();
    imshow(img,"Parent",handles.axes1);

    %=====Segment Image=====
    segmentedImg=segment_image(img,handles);
    imshow(segmentedImg,[],"Parent",handles.axes2);

    %=====Get An Input From The User=====
    defect=inputdlg('Enter Defect Type: ','Defect Input',[5 40]);
    defect=convertCharsToStrings(defect); %Char does not work with combining array
    defect=upper(defect);

    %=====Extract Features(Statistical Pattern Recognition)=====
    stats=extract_feature(segmentedImg);
    statsAndDefect=[stats, defect];

    try
        %=====Load Table And Save New Data=====
        load defect_type_table.mat;
        defectData=[defectData; statsAndDefect];
        save defect_type_table.mat defectData;
    catch
        %=====If Table Does Not Exist, Create A New One=====
        defectData=statsAndDefect;
        save defect_type_table.mat defectData;
    end
end