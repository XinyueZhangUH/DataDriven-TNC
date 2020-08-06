%%
M_set = [5,8,10,15,20,25,30,40,50];
[X1_FM_noP, X1_FM_noP_err] = loadFinalResult('result/Xian1_FM_noP.mat');
[X1_K_noP, X1_K_noP_err] = loadFinalResult('result/Xian1_K_noP.mat');
[X1_U_noP, X1_U_noP_err] = loadFinalResult('result/Xian1_U_noP.mat');
[X2_FM_noP, X2_FM_noP_err] = loadFinalResult('result/Xian2_FM_noP.mat');
[X2_K_noP, X2_K_noP_err] = loadFinalResult('result/Xian2_K_noP.mat');
[X2_U_noP, X2_U_noP_err] = loadFinalResult('result/Xian2_U_noP.mat');
[X1_FM_ep1, X1_FM_ep1_err] = loadFinalResult('result/Xian1_FM_eps1.mat');
[X1_K_ep1, X1_K_ep1_err] = loadFinalResult('result/Xian1_K_eps1.mat');
[X1_U_ep1, X1_U_ep1_err] = loadFinalResult('result/Xian1_U_eps1.mat');
[X2_FM_ep1, X2_FM_ep1_err] = loadFinalResult('result/Xian2_FM_eps1.mat');
[X2_K_ep1, X2_K_ep1_err] = loadFinalResult('result/Xian2_K_eps1.mat');
[X2_U_ep1, X2_U_ep1_err] = loadFinalResult('result/Xian2_U_eps1.mat');
[X1_FM_ep15, X1_FM_ep15_err] = loadFinalResult('result/Xian1_FM_eps15.mat');
[X1_K_ep15, X1_K_ep15_err] = loadFinalResult('result/Xian1_K_eps15.mat');
[X1_U_ep15, X1_U_ep15_err] = loadFinalResult('result/Xian1_U_eps15.mat');
[X2_FM_ep15, X2_FM_ep15_err] = loadFinalResult('result/Xian2_FM_eps15.mat');
[X2_K_ep15, X2_K_ep15_err] = loadFinalResult('result/Xian2_K_eps15.mat');
[X2_U_ep15, X2_U_ep15_err] = loadFinalResult('result/Xian2_U_eps15.mat');

X_FM_noP = X1_FM_noP + X2_FM_noP;
X_K_noP = X1_K_noP + X2_K_noP;
X_U_noP = X1_U_noP + X2_U_noP;
X_FM_ep1 = X1_FM_ep1 + X2_FM_ep1;
X_K_ep1 = X1_K_ep1 + X2_K_ep1;
X_U_ep1 = X1_U_ep1 + X2_U_ep1;
X_FM_ep15 = X1_FM_ep15 + X2_FM_ep15;
X_K_ep15 = X1_K_ep15 + X2_K_ep15;
X_U_ep15 = X1_U_ep15 + X2_U_ep15;

X_FM_noP_err = (X1_FM_noP_err + X2_FM_noP_err) / 2;
X_K_noP_err = (X1_K_noP_err + X2_K_noP_err) / 2;
X_U_noP_err = (X1_U_noP_err + X2_U_noP_err) / 2;
X_FM_ep1_err = (X1_FM_ep1_err + X2_FM_ep1_err) / 2;
X_K_ep1_err = (X1_K_ep1_err + X2_K_ep1_err) / 2;
X_U_ep1_err = (X1_U_ep1_err + X2_U_ep1_err) / 2;
X_FM_ep15_err = (X1_FM_ep15_err + X2_FM_ep15_err) / 2;
X_K_ep15_err = (X1_K_ep15_err + X2_K_ep15_err) / 2;
X_U_ep15_err = (X1_U_ep15_err + X2_U_ep15_err) / 2;

X_optimal = 613.33 * ones(1, length(M_set));
r_base = 368.47 * ones(1, length(M_set));
r_base_err = 54.87 * ones(1, length(M_set));

figure(1)
plot(M_set,X_optimal,'k-', 'markersize', 8,'linewidth',2)
hold on
plot(M_set,X_FM_noP,'rd-', 'markersize', 8,'linewidth',2)
plot(M_set,X_FM_ep1,'rd--', 'markersize', 8,'linewidth',2)
plot(M_set,X_K_noP,'ms-', 'markersize', 8,'linewidth',2)
plot(M_set,X_K_ep1,'ms--', 'markersize', 8,'linewidth',2)
plot(M_set,X_U_noP,'b^-', 'markersize', 8,'linewidth',2)
plot(M_set,X_U_ep1,'b^--', 'markersize', 8,'linewidth',2)
plot(M_set,r_base,'ko-.', 'markersize', 8,'linewidth',2)
axis([5 50 0 650])

h_legend=legend('Optimal value','FM metric','FM metric with \epsilon = 1km^{-1}',...
    'K metric','K metric with \epsilon = 1km^{-1}',...
    'U metric','U metric with \epsilon = 1km^{-1}','Random baseline','Location','southeast')
set(h_legend,'FontSize',15,'FontWeight','bold');
set(gca,'FontSize',15,'FontWeight','bold')
xlhand = get(gca,'xlabel')
set(xlhand,'string','Size of Historical Data','fontsize',15,'FontWeight','bold')
ylhand = get(gca,'ylabel')
set(ylhand,'string','Total Revenue of TNC','fontsize',15,'FontWeight','bold')
hold off

%% FM_errorbar
figure(2)
plot(M_set,X_optimal,'k-', 'markersize', 8,'linewidth',2)
hold on
errorbar(M_set,X_FM_noP,X_FM_noP_err,'rd-', 'markersize', 8,'linewidth',2)
errorbar(M_set,X_FM_ep1,X_FM_ep1_err,'ms-', 'markersize', 8,'linewidth',2)
errorbar(M_set,X_FM_ep15,X_FM_ep15_err,'b^-', 'markersize', 8,'linewidth',2)
errorbar(M_set,r_base,r_base_err,'ko-.', 'markersize', 8,'linewidth',2)
axis([5 50 0 650])
h_legend=legend('Optimal value','FM metric','FM metric with \epsilon = 1km^{-1}',...
    'FM metric with \epsilon = 1.5km^{-1}','Random baseline','Location','southeast');
set(h_legend,'FontSize',20,'FontWeight','bold');
set(gca,'FontSize',20,'FontWeight','bold')
xlhand = get(gca,'xlabel');
set(xlhand,'string','Size of Historical Data','fontsize',20,'FontWeight','bold')
ylhand = get(gca,'ylabel');
set(ylhand,'string','Total Revenue of TNC','fontsize',20,'FontWeight','bold')
hold off

%% K_errorbar
figure(3)
plot(M_set,X_optimal,'k-', 'markersize', 8,'linewidth',2)
hold on
errorbar(M_set,X_K_noP,X_K_noP_err,'rd-', 'markersize', 8,'linewidth',2)
errorbar(M_set,X_K_ep1,X_K_ep1_err,'ms-', 'markersize', 8,'linewidth',2)
errorbar(M_set,X_K_ep15,X_K_ep15_err,'b^-', 'markersize', 8,'linewidth',2)
errorbar(M_set,r_base,r_base_err,'ko-.', 'markersize', 8,'linewidth',2)
axis([5 50 0 650])
h_legend=legend('Optimal value','K metric','K metric with \epsilon = 1km^{-1}',...
    'K metric with \epsilon = 1.5km^{-1}','Random baseline','Location','southeast');
set(h_legend,'FontSize',20,'FontWeight','bold');
set(gca,'FontSize',20,'FontWeight','bold')
xlhand = get(gca,'xlabel');
set(xlhand,'string','Size of Historical Data','fontsize',20,'FontWeight','bold')
ylhand = get(gca,'ylabel');
set(ylhand,'string','Total Revenue of TNC','fontsize',20,'FontWeight','bold')
hold off

%% U_errorbar
figure(4)
plot(M_set,X_optimal,'k-', 'markersize', 8,'linewidth',2)
hold on
errorbar(M_set,X_U_noP,X_U_noP_err,'rd-', 'markersize', 8,'linewidth',2)
errorbar(M_set,X_U_ep1,X_U_ep1_err,'ms-', 'markersize', 8,'linewidth',2)
errorbar(M_set,X_U_ep15,X_U_ep15_err,'b^-', 'markersize', 8,'linewidth',2)
errorbar(M_set,r_base,r_base_err,'ko-.', 'markersize', 8,'linewidth',2)
axis([5 50 0 650])
h_legend=legend('Optimal value','U metric','U metric with \epsilon = 1km^{-1}',...
    'U metric with \epsilon = 1.5km^{-1}','Random baseline','Location','southeast');
set(h_legend,'FontSize',20,'FontWeight','bold');
set(gca,'FontSize',20,'FontWeight','bold')
xlhand = get(gca,'xlabel');
set(xlhand,'string','Size of Historical Data','fontsize',20,'FontWeight','bold')
ylhand = get(gca,'ylabel');
set(ylhand,'string','Total Revenue of TNC','fontsize',20,'FontWeight','bold')
hold off


%%
M_set = [5,8,10,15,20,25,30,40,50];
[C1_FM_noP, C1_FM_noP_err] = loadFinalResult('result/Chengdu1_FM_noP.mat');
[C1_K_noP, C1_K_noP_err] = loadFinalResult('result/Chengdu1_K_noP.mat');
[C1_U_noP, C1_U_noP_err] = loadFinalResult('result/Chengdu1_U_noP.mat');
[C2_FM_noP, C2_FM_noP_err] = loadFinalResult('result/Chengdu2_FM_noP.mat');
[C2_K_noP, C2_K_noP_err] = loadFinalResult('result/Chengdu2_K_noP.mat');
[C2_U_noP, C2_U_noP_err] = loadFinalResult('result/Chengdu2_U_noP.mat');
[C1_FM_ep1, C1_FM_ep1_err] = loadFinalResult('result/Chengdu1_FM_eps1.mat');
[C1_K_ep1, C1_K_ep1_err] = loadFinalResult('result/Chengdu1_K_eps1.mat');
[C1_U_ep1, C1_U_ep1_err] = loadFinalResult('result/Chengdu1_U_eps1.mat');
[C2_FM_ep1, C2_FM_ep1_err] = loadFinalResult('result/Chengdu2_FM_eps1.mat');
[C2_K_ep1, C2_K_ep1_err] = loadFinalResult('result/Chengdu2_K_eps1.mat');
[C2_U_ep1, C2_U_ep1_err] = loadFinalResult('result/Chengdu2_U_eps1.mat');
[C1_FM_ep05, C1_FM_ep05_err] = loadFinalResult('result/Chengdu1_FM_eps05.mat');
[C1_K_ep05, C1_K_ep05_err] = loadFinalResult('result/Chengdu1_K_eps05.mat');
[C1_U_ep05, C1_U_ep05_err] = loadFinalResult('result/Chengdu1_U_eps05.mat');
[C2_FM_ep05, C2_FM_ep05_err] = loadFinalResult('result/Chengdu2_FM_eps05.mat');
[C2_K_ep05, C2_K_ep05_err] = loadFinalResult('result/Chengdu2_K_eps05.mat');
[C2_U_ep05, C2_U_ep05_err] = loadFinalResult('result/Chengdu2_U_eps05.mat');
[C1_FM_ep15, C1_FM_ep15_err] = loadFinalResult('result/Chengdu1_FM_eps15.mat');
[C1_K_ep15, C1_K_ep15_err] = loadFinalResult('result/Chengdu1_K_eps15.mat');
[C1_U_ep15, C1_U_ep15_err] = loadFinalResult('result/Chengdu1_U_eps15.mat');
[C2_FM_ep15, C2_FM_ep15_err] = loadFinalResult('result/Chengdu2_FM_eps15.mat');
[C2_K_ep15, C2_K_ep15_err] = loadFinalResult('result/Chengdu2_K_eps15.mat');
[C2_U_ep15, C2_U_ep15_err] = loadFinalResult('result/Chengdu2_U_eps15.mat');

C_FM_noP = C1_FM_noP + C2_FM_noP;
C_K_noP = C1_K_noP + C2_K_noP;
C_U_noP = C1_U_noP + C2_U_noP;
C_FM_ep1 = C1_FM_ep1 + C2_FM_ep1;
C_K_ep1 = C1_K_ep1 + C2_K_ep1;
C_U_ep1 = C1_U_ep1 + C2_U_ep1;
C_FM_ep05 = C1_FM_ep05 + C2_FM_ep05;
C_K_ep05 = C1_K_ep05 + C2_K_ep05;
C_U_ep05 = C1_U_ep05 + C2_U_ep05;
C_FM_ep15 = C1_FM_ep15 + C2_FM_ep15;
C_K_ep15 = C1_K_ep15 + C2_K_ep15;
C_U_ep15 = C1_U_ep15 + C2_U_ep15;

C_FM_noP_err = (C1_FM_noP_err + C2_FM_noP_err) / 2;
C_K_noP_err = (C1_K_noP_err + C2_K_noP_err) / 2;
C_U_noP_err = (C1_U_noP_err + C2_U_noP_err) / 2;
C_FM_ep1_err = (C1_FM_ep1_err + C2_FM_ep1_err) / 2;
C_K_ep1_err = (C1_K_ep1_err + C2_K_ep1_err) / 2;
C_U_ep1_err = (C1_U_ep1_err + C2_U_ep1_err) / 2;
C_FM_ep15_err = (C1_FM_ep15_err + C2_FM_ep15_err) / 2;
C_K_ep15_err = (C1_K_ep15_err + C2_K_ep15_err) / 2;
C_U_ep15_err = (C1_U_ep15_err + C2_U_ep15_err) / 2;

C_optimal = 1166 * ones(1, length(M_set));
r_base = 633.9 * ones(1, length(M_set));
r_base_err = 66.72 * ones(1, length(M_set));

%%
figure(5)
plot(M_set,C_optimal,'k-', 'markersize', 8,'linewidth',2)
hold on
plot(M_set,C_FM_noP,'rd-', 'markersize', 8,'linewidth',2)
plot(M_set,C_FM_ep1,'rd--', 'markersize', 8,'linewidth',2)
plot(M_set,C_K_noP,'ms-', 'markersize', 8,'linewidth',2)
plot(M_set,C_K_ep1,'ms--', 'markersize', 8,'linewidth',2)
plot(M_set,C_U_noP,'b^-', 'markersize', 8,'linewidth',2)
plot(M_set,C_U_ep1,'b^--', 'markersize', 8,'linewidth',2)
plot(M_set,r_base,'ko-.', 'markersize', 8,'linewidth',2)
axis([5 50 0 1200])

h_legend=legend('Optimal value','FM metric','FM metric with \epsilon = 1km^{-1}',...
    'K metric','K metric with \epsilon = 1km^{-1}',...
    'U metric','U metric with \epsilon = 1km^{-1}','Random baseline','Location','southeast')
set(h_legend,'FontSize',15,'FontWeight','bold');
set(gca,'FontSize',15,'FontWeight','bold')
xlhand = get(gca,'xlabel')
set(xlhand,'string','Size of Historical Data','fontsize',15,'FontWeight','bold')
ylhand = get(gca,'ylabel')
set(ylhand,'string','Total Revenue of TNC','fontsize',15,'FontWeight','bold')
hold off

%% FM_errorbar
figure(6)
plot(M_set,C_optimal,'k-', 'markersize', 8,'linewidth',2)
hold on
errorbar(M_set,C_FM_noP,C_FM_noP_err,'rd-', 'markersize', 8,'linewidth',2)
errorbar(M_set,C_FM_ep1,C_FM_ep1_err,'ms-', 'markersize', 8,'linewidth',2)
errorbar(M_set,C_FM_ep15,C_FM_ep15_err,'b^-', 'markersize', 8,'linewidth',2)
errorbar(M_set,r_base,r_base_err,'ko-.', 'markersize', 8,'linewidth',2)
axis([5 50 0 1200])
h_legend=legend('Optimal value','FM metric','FM metric with \epsilon = 1km^{-1}',...
    'FM metric with \epsilon = 1.5km^{-1}','Random baseline','Location','southeast');
set(h_legend,'FontSize',20,'FontWeight','bold');
set(gca,'FontSize',20,'FontWeight','bold')
xlhand = get(gca,'xlabel');
set(xlhand,'string','Size of Historical Data','fontsize',20,'FontWeight','bold')
ylhand = get(gca,'ylabel');
set(ylhand,'string','Total Revenue of TNC','fontsize',20,'FontWeight','bold')
hold off

%% K_errorbar
figure(7)
plot(M_set,C_optimal,'k-', 'markersize', 8,'linewidth',2)
hold on
errorbar(M_set,C_K_noP,C_K_noP_err,'rd-', 'markersize', 8,'linewidth',2)
errorbar(M_set,C_K_ep1,C_K_ep1_err,'ms-', 'markersize', 8,'linewidth',2)
errorbar(M_set,C_K_ep15,C_K_ep15_err,'b^-', 'markersize', 8,'linewidth',2)
errorbar(M_set,r_base,r_base_err,'ko-.', 'markersize', 8,'linewidth',2)
axis([5 50 0 1200])
h_legend=legend('Optimal value','K metric','K metric with \epsilon = 1km^{-1}',...
    'K metric with \epsilon = 1.5km^{-1}','Random baseline','Location','southeast');
set(h_legend,'FontSize',20,'FontWeight','bold');
set(gca,'FontSize',20,'FontWeight','bold')
xlhand = get(gca,'xlabel');
set(xlhand,'string','Size of Historical Data','fontsize',20,'FontWeight','bold')
ylhand = get(gca,'ylabel');
set(ylhand,'string','Total Revenue of TNC','fontsize',20,'FontWeight','bold')
hold off

%% U_errorbar
figure(8)
plot(M_set,C_optimal,'k-', 'markersize', 8,'linewidth',2)
hold on
errorbar(M_set,C_U_noP,C_U_noP_err,'rd-', 'markersize', 8,'linewidth',2)
errorbar(M_set,C_U_ep1,C_U_ep1_err,'ms-', 'markersize', 8,'linewidth',2)
errorbar(M_set,C_U_ep15,C_U_ep15_err,'b^-', 'markersize', 8,'linewidth',2)
errorbar(M_set,r_base,r_base_err,'ko-.', 'markersize', 8,'linewidth',2)
axis([5 50 0 1200])
h_legend=legend('Optimal value','U metric','U metric with \epsilon = 1km^{-1}',...
    'U metric with \epsilon = 1.5km^{-1}','Random baseline','Location','southeast');
set(h_legend,'FontSize',20,'FontWeight','bold');
set(gca,'FontSize',20,'FontWeight','bold')
xlhand = get(gca,'xlabel');
set(xlhand,'string','Size of Historical Data','fontsize',20,'FontWeight','bold')
ylhand = get(gca,'ylabel');
set(ylhand,'string','Total Revenue of TNC','fontsize',20,'FontWeight','bold')
hold off