% Lire la feuille 2 (ou la feuille nommée "load")
P = readmatrix("profil_puissance_24h_1440min.xlsx","Sheet",2);

% Garder la première colonne
P = P(:,1);

% Supprimer NaN (cellules vides / texte)
P = P(~isnan(P));

% Afficher infos
disp(["N=", num2str(length(P)), " min=", num2str(min(P)), " max=", num2str(max(P))])

% Tracer
figure;
plot(P)
xlabel("Temps (minutes)")
ylabel("Puissance (kW)")
grid on

% Sauvegarder en .mat (propre)
save("profil_puissance_24h_1440min_clean.mat","P","-v7.3");
Ts = 60;                 % pas de temps = 60 s
fc = 1/3600;             % fréquence de coupure (1h)
[b,a] = butter(2, fc*2*Ts);
P_smooth = filtfilt(b,a,P);

figure;
plot(P,'b')
hold on
plot(P_smooth,'g','LineWidth',2)
grid on
legend("Profil escalier","Signal lissé (filtre)")
xlabel("Temps (minutes)")
ylabel("Puissance (kW)")
alpha = 0.02;              % facteur de lissage (0.01 à 0.05 recommandé)
P_exp = zeros(size(P));
P_exp(1) = P(1);

for k = 2:length(P)
    P_exp(k) = alpha*P(k) + (1-alpha)*P_exp(k-1);
end

figure;
plot(P,'b','LineWidth',1)
hold on
plot(P_exp,'r','LineWidth',2)
grid on
xlabel("Temps (minutes)")
ylabel("Puissance (kW)")
legend("Profil escalier","Lissage exponentiel","Location","best")