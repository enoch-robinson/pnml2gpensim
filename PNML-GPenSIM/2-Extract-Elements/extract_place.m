function [place] = extract_place(placeElement)

place = [];

place.id = placeElement.Attributes.Value;
placeStruct = placeElement.Children; 

lenPlaceStruct = length(placeStruct);
place.m0 = int2str(0);
for j = 1:lenPlaceStruct,
    if strcmp(placeStruct(j).Name, 'name'),
        placeData = placeStruct(j).Children;
        lenPlaceData = length(placeData);
        for k = 1:lenPlaceData,
            if (strcmp(placeData(k).Name, 'value') || strcmp(placeData(k).Name, 'text')),
                place.name = placeData(k).Children.Data;
            end;
        end;                             
    end; % if strcmp(placeStruct(j).Name, 'name')        
    
    if strcmp(placeStruct(j).Name, 'initialMarking'), 
        placeData = placeStruct(j).Children;
        lenPlaceData = length(placeData);
        for k = 1:lenPlaceData,
            if (strcmp(placeData(k).Name, 'value') || strcmp(placeData(k).Name, 'text')),
                place.m0 = placeData(k).Children.Data;
            end;
        end;                             
    end; % if strcmp(placeStruct(j).Name, 'initialMarking') 
end;

