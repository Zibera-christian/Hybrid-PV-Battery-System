%% ===== Lire profil charge 24x2 depuis Excel =====
clear; clc;

fichier = 'profil_charge_24x2.xlsx';     % <-- nom du fichier généré
feuille = 'Charge_24h_24x2';

T = readtable(fichier,'Sheet',feuille);

% Matrice 24x2 : [temps(s)  puissance(W)]
P_load_mat = [T.time_s, T.P_load_W];

% Mettre dans le base workspace (pour Simulink)
assignin('base','P_load_mat',P_load_mat/1000);

disp("✔ P_load_mat créé (24x2) et envoyé au base workspace.");