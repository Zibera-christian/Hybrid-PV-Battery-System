%% PROFIL D’IRRADIATION JOURNALIER DE KINSHASA
%% COMPRIMÉ SUR 1 SECONDE DE SIMULATION

% Durée totale de la simulation (en secondes)
Tsim = 1;                      % Stop time = 1 s

% Nombre de points du profil (plus il est grand, plus c'est lisse)
N = 1000;

% Vecteur temps de simulation (0 → 1 s)
t_sim = linspace(0, Tsim, N)';

% Conversion du temps simulé en temps réel (24 h)
% 1 s simulée = 86400 s réelles
t_real = t_sim * 86400;

% Heure du lever du soleil à Kinshasa (06h04)
sunrise = 6*3600 + 4*60;

% Heure du coucher du soleil à Kinshasa (18h20)
sunset = 18*3600 + 20*60;

% Irradiation maximale typique à Kinshasa (journée claire)
Gmax = 950;                    % W/m²

% Initialisation de l’irradiation (nuit)
G = zeros(size(t_real));

% Identification de la période de jour
dayIdx = (t_real >= sunrise) & (t_real <= sunset);

% Normalisation du temps journalier (0 → lever, 1 → coucher)
x = (t_real(dayIdx) - sunrise) / (sunset - sunrise);

% Calcul de l’irradiation solaire (courbe en cloche)
G(dayIdx) = Gmax * sin(pi * x).^1.3;

%% FORMAT POUR SIMULINK (From Workspace)
% Colonne 1 : temps simulé (s)
% Colonne 2 : irradiation solaire (W/m²)
G_profile = [t_sim G];