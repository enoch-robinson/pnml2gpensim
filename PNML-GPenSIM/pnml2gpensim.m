function [] = pnml2gpensim(PNMLfile, visable)
%function []= pnml2gpensim(PNMLfile)
%
% This function generates GPenSIM files (such as MSF and PDF, 
%  and templates for COMMON_PRE and COMMON_POST)from PNML file.
%  Input:   PNMLfile: name of the PNML file
%
%  Reggie.Davidrajuh@uis.no (c) September 2013

% PARSEXML Convert XML file to a MATLAB structure.
try   tree = xmlread(PNMLfile);
catch err
    error(err.identifier, 'Failed to read XML file %s.', PNMLfile);        
end

% Recurse over child nodes. This could run into problems 
% with very deeply nested trees.
try   PNMLStruct = parsePNMLNodes(tree);
catch err
    error(err.identifier, 'Unable to parse XML file %s.', PNMLfile);
end

childrenOfPNMLStruct = PNMLStruct.Children;
for i = 1:length(childrenOfPNMLStruct)
    if strcmp(childrenOfPNMLStruct(i).Name, 'net')
        netStruct = childrenOfPNMLStruct(i);
        break
    end
end

% extract places, transitions, and arcs from the xDOM structure
[global_places, global_transitions, global_arcs] = ...
            extract_pta_elements(netStruct);
% display extracted info: print places, transitions, and arcs
if visable 
    print_pta(global_places, global_transitions, global_arcs);
end
current_dir = pwd;
cd("converted\");
[~, pn_name, ~ ] = fileparts(PNMLfile);

dir_info = dir(pn_name);
% disp(isempty(dir_info))
if isempty(dir_info)
    mkdir(pn_name);
end
cd(pn_name)

% finally, write the GPenSIM files (msf, pdf, common_pre, common_post)
write_GPenSIM_files(PNMLfile, global_places, ...
                 global_transitions, global_arcs);
cd(current_dir)
             