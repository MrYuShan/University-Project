%================================================================================
% Detect Defect Type Using Statistical Pattern Recognition
%================================================================================
function detect_defect(hObject,handles)
    handles = guidata(hObject);
    %=====Input An Image=====
    img=browse_image();
    imshow(img,"Parent",handles.axes1);

    %=====Segment Image=====
    segmentedImg=segment_image(img,handles);

    %=====Try To Draw Boundaries On The Defect Based On the Segmentated Image=====
    imshow(img,"Parent",handles.axes2);
    
    %=====Gloves Outline=====
    hold(handles.axes2, 'on');
    boundaries = bwboundaries(segmentedImg);
    b = boundaries{1};
    plot(handles.axes2,b(:,2),b(:,1),'g','LineWidth',1);
    
    %=====Segmented Defect Outline (It Will Draw Every Boudaries It Can Find, Segmentation Is The Key)=====
    hold(handles.axes2, 'on');
    for k=2:(size(boundaries,1))
        b = boundaries{k};
        plot(handles.axes2,b(:,2),b(:,1),'r','LineWidth',1);
    end


    %=====Extract Features=====
    stats=extract_feature(segmentedImg);
    
    %=====Compare To Data In Database=====
    try
        %=====Load The Table And Assign Them To 2 Variables
        load defect_type_table.mat
        allStats = str2double(defectData(:,1:9));
        allDefectType = defectData(:,10);
        
        %=====Loop the Table, Steps as below=====
        % 1. Stats On The Table(1 by 1) - Stats Of the Image (if 0 < stats < 1)
        % 2. Stats On The Table(1 by 1) / Stats Of the Image - 1 (if stats > 1)
        % 2. Get The Absolute Value Of The Result
        % 3. Sum Of The Stats
        % 4. Add The Sum To An Array
        % 5. From That Array, Find The Lowest Number (If Lowest Number Is 0, The Picture Is The Exact Match)

        sizeOfDefectTable = size(allStats,1);
        for (i=1:sizeOfDefectTable)
            distance(i,:)= ...
                (abs(allStats(i,1)-stats(:,1)) + ...
                abs(allStats(i,2)-stats(:,2)) + ...
                abs(allStats(i,3)/stats(:,3) - 1) + ...
                abs(allStats(i,4)/stats(:,4) - 1) + ...
                abs(allStats(i,5)/stats(:,5) - 1) + ...
                abs(allStats(i,6)/stats(:,6) - 1) + ...
                abs(allStats(i,7)-stats(:,7)) + ...
                abs(allStats(i,8)-stats(:,8)) + ...
                abs(allStats(i,9)/stats(:,9) - 1));
        end
        theClosestOne=find(distance==min(distance),1);

        %=====Find The Defect Type=====
        detectDefect=allDefectType(theClosestOne);

        %=====Display Defect Type As A Result=====
        msgbox(strcat("Defect Type is ",detectDefect));

    catch
        %=====If Table Does Not Exist=====
        msgbox("ERROR: The Table Does Not Exist!");
    end
end