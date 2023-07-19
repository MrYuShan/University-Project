%========================================
% Main Program
% Programmed By
% TP061278 Thean Yee Sin
% TP059897 Ee Jiunn Haw
% TP059577 Yong Zu Yi
%========================================

clc;
clear;
close all;

%=====Main Figure UI=====
mainFigure = uifigure("Name","Glove Defect Detection");
mainFigure.Position = [100 100 800 560];
handles.chosenOperation = 1;

%=====Axes For Input Image===== 
handles.axes1 = uiaxes(mainFigure);
title(handles.axes1, "Input Image");
handles.axes1.Position = [11 88 377 248];
handles.axes1.Visible = false;
guidata(handles.axes1,handles);

%=====Axes For Output Image===== 
handles.axes2 = uiaxes(mainFigure);
title(handles.axes2, "Output Image");
handles.axes2.Position = [410 88 377 248];
handles.axes2.Visible = false;
guidata(handles.axes2,handles);

%=====Button To Train The System=====
handles.button1 = uibutton(mainFigure,"push");
handles.button1.Text = "Train Image";
handles.button1.Position = [49 451 136 44];
handles.button1.ButtonPushedFcn = @(button,event) train_image(button,handles);
guidata(handles.button1,handles);

%=====Button To Detect Defect=====
handles.button2 = uibutton(mainFigure,"push");
handles.button2.Text = "Detect Defect";
handles.button2.Position = [225 451 136 44];
handles.button2.ButtonPushedFcn = @(button,event) detect_defect(button,handles);
guidata(handles.button2,handles);

%=====Button Group For Different Algorithms=====
handles.buttonGroup = uibuttongroup(mainFigure);
handles.buttonGroup.Title="Segmentation Algorithm";
handles.buttonGroup.Position = [559 424 204 106];
handles.buttonGroup.SelectionChangedFcn = @(buttonGroup,event) choose_operation(buttonGroup,handles);
guidata(handles.buttonGroup,handles);

%=====Radio Button For 1st Algorithm (developed by TP061278 Thean Yee Sin)=====
handles.radioButton1 = uiradiobutton(handles.buttonGroup);
handles.radioButton1.Text = "Thean Yee Sin";
handles.radioButton1.Position = [12 58 100 22];
handles.radioButton1.Value = true;
guidata(handles.radioButton1,handles);

%=====Radio Button For 2nd Algorithm (developed by TP059897 Ee Jiunn Haw)=====
handles.radioButton2 = uiradiobutton(handles.buttonGroup);
handles.radioButton2.Text = "Ee Jiunn Haw";
handles.radioButton2.Position = [12 37 100 22];
guidata(handles.radioButton2,handles);

%=====Radio Button For 3rd Algorithm (developed by TP059577 Yong Zu Yi)=====
handles.radioButton3 = uiradiobutton(handles.buttonGroup);
handles.radioButton3.Text = "Yong Zu Yi";
handles.radioButton3.Position = [12 16 100 22];
guidata(handles.radioButton3,handles);


