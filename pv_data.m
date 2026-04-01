%% =====================================================
% LECTURE DE DEUX PROFILS PV (CLEAR / CLOUDY) – EXCEL
% Sortie compatible From Workspace (Simulink)
%% =====================================================

clear; clc;

fichier = 'pv_donnee.xlsx';

%% --------- Lecture Excel ---------
Tpv_clear  = readtable(fichier,'Sheet','PV_clear');
Tpv_cloudy = readtable(fichier,'Sheet','PV_cloudy');

% Vecteurs horaires
time_h = Tpv_clear.Heure(:);          % 0..23
Ppv_clear_kW  = Tpv_clear.P_PV_kW(:);
Ppv_cloudy_kW = Tpv_cloudy.P_PV_kW(:);

%% --------- Vérification sécurité ---------
assert(length(Ppv_clear_kW)==length(Ppv_cloudy_kW), ...
    'Les deux profils PV doivent avoir la même longueur');

%% --------- Conversion pour Simulink ---------
% Temps en secondes
time_s = time_h * 3600;

% Profil clair
clearPpv.time = time_s;
clearPpv.signals.values = Ppv_clear_kW * 1000;   % kW → W
clearPpv.signals.dimensions = 1;

% Profil nuageux
cloudyPpv.time = time_s;
cloudyPpv.signals.values = Ppv_cloudy_kW * 1000; % kW → W
cloudyPpv.signals.dimensions = 1;

%% --------- Message OK ---------
disp('✔ Profils PV clear & cloudy chargés avec succès');
