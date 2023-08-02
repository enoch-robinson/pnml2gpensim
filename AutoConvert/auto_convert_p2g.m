% Convert PNML file into GPenSIM files 
clear all; clc;

exported_dirname = 'converted';
exported_dir_info = dir(exported_dirname);
if isempty(exported_dir_info)
    mkdir(exported_dirname);
end

woped_model_dir = 'WoPedNets';

woped_pnmls = dir(fullfile(woped_model_dir,'*.pnml'));

disp(['Start convert ', int2str(length(woped_pnmls)), 'pnml model(s) exported from WoPed to "', exported_dirname, '" directory']);
for i = 1:length(woped_pnmls)
    pnml_path = fullfile(woped_model_dir,woped_pnmls(i).name);
    disp([ '    -- convert  ', pnml_path, ' ']);
    pnml2gpensim(pnml_path, false);
end
disp(['Converted ', int2str(length(woped_pnmls)), 'pnml model(s) successfully!']);
