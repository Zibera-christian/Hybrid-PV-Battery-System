clear; clc;

fichier = 'pv_donnee.xlsx';

% Lecture profils
Tpv_clear  = readtable(fichier,'Sheet','PV_clear');
Tpv_cloudy = readtable(fichier,'Sheet','PV_cloudy');

% Variables temps
time_h = Tpv_clear.Heure(:);     % [0..23] heures
time_s = time_h * 3600;          % secondes

% Puissances PV
Ppv_clear_kW  = Tpv_clear.P_PV_kW(:);
Ppv_cloudy_kW = Tpv_cloudy.P_PV_kW(:);

% Sécurité
assert(length(time_h)==length(Ppv_clear_kW));
assert(length(time_h)==length(Ppv_cloudy_kW));

% Structures Simulink
clearPpv.time = time_s;
clearPpv.signals.values = Ppv_clear_kW * 1000; % kW → W
clearPpv.signals.dimensions = 1;

cloudyPpv.time = time_s;
cloudyPpv.signals.values = Ppv_cloudy_kW * 1000;
cloudyPpv.signals.dimensions = 1;

disp('✔ Profils PV prêts pour Simulink');