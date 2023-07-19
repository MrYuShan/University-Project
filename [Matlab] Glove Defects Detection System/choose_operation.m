%================================================================================
% Function To Check ButtonGroup Value And Change Accordingly
%================================================================================
function choose_operation(hObject,handles)
    handles = guidata(hObject);
    if handles.radioButton1.Value
        handles.chosenOperation = 1;
    elseif handles.radioButton2.Value
        handles.chosenOperation = 2;
    elseif handles.radioButton3.Value
        handles.chosenOperation = 3;
    else
        msgbox("Error, please try again");
    end
    guidata(hObject,handles);
end