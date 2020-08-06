clc
clear all
iterations = 50;
selected_file1 = 'Xian1';
privacy = 'noP';
filename1_noP = ['data/', selected_file1, '.mat'];
[FM_X1,K_X1,U_X1] = solveTNC(filename1_noP, selected_file1, privacy, iterations);

privacy = 'eps1';
filename1_eps1 = ['data/', selected_file1, '_', privacy '.mat'];
[FM_X1_ep1,K_X1_ep1,U_X1_ep1] = solveTNC(filename1_eps1, selected_file1, privacy, iterations);

privacy = 'eps15';
filename1_eps15 = ['data/', selected_file1, '_', privacy '.mat'];
[FM_X1_ep15,K_X1_ep15,U_X1_ep15] = solveTNC(filename1_eps15, selected_file1, privacy, iterations);

selected_file2 = 'Xian2';
privacy = 'noP';
filename2_noP = ['data/', selected_file2, '.mat'];
[FM_X2,K_X2,U_X2] = solveTNC(filename2_noP, selected_file2, privacy, iterations);

privacy = 'eps1';
filename2_eps1 = ['data/', selected_file2, '_', privacy '.mat'];
[FM_X2_ep1,K_X2_ep1,U_X2_ep1] = solveTNC(filename2_eps1, selected_file2, privacy, iterations);

privacy = 'eps15';
filename2_eps15 = ['data/', selected_file2, '_', privacy '.mat'];
[FM_X2_ep15,K_X2_ep15,U_X2_ep15] = solveTNC(filename2_eps15, selected_file2, privacy, iterations);

X_optimal = cal_opt(filename1_noP, filename2_noP);
[r, r_err] = rBase(filename1_noP, filename2_noP);

%% Set values
X_FM_noP = FM_X1(1,:) + FM_X2(1,:);
X_K_noP = K_X1(1,:) + K_X2(1,:);
X_U_noP = U_X1(1,:) + U_X2(1,:);
X_FM_noP_err = (FM_X1(2,:) + FM_X2(2,:))/2;
X_K_noP_err = (K_X1(2,:) + K_X2(2,:))/2;
X_U_noP_err = (U_X1(2,:) + U_X2(2,:))/2;

X_FM_ep1 = FM_X1_ep1(1,:) + FM_X2_ep1(1,:);
X_K_ep1 = K_X1_ep1(1,:) + K_X2_ep1(1,:);
X_U_ep1 = U_X1_ep1(1,:) + U_X2_ep1(1,:);
X_FM_ep1_err = (FM_X1_ep1(2,:) + FM_X2_ep1(2,:))/2;
X_K_ep1_err = (K_X1_ep1(2,:) + K_X2_ep1(2,:))/2;
X_U_ep1_err = (U_X1_ep1(2,:) + U_X2_ep1(2,:))/2;

X_FM_ep15 = FM_X1_ep15(1,:) + FM_X2_ep15(1,:);
X_K_ep15 = K_X1_ep15(1,:) + K_X2_ep15(1,:);
X_U_ep15 = U_X1_ep15(1,:) + U_X2_ep15(1,:);
X_FM_ep15_err = (FM_X1_ep15(2,:) + FM_X2_ep15(2,:))/2;
X_K_ep15_err = (K_X1_ep15(2,:) + K_X2_ep15(2,:))/2;
X_U_ep15_err = (U_X1_ep15(2,:) + U_X2_ep15(2,:))/2;

%% Plot figure
M_set = [5,8,10,15,20,25,30,40,50];
r_base = r * ones(1, length(M_set));
r_base_err = r_err * ones(1, length(M_set));
X_opt = X_optimal * ones(1, length(M_set));
figure(1)
plot(M_set,X_opt,'k-', 'markersize', 8,'linewidth',2)
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
plot(M_set,X_opt,'k-', 'markersize', 8,'linewidth',2)
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
plot(M_set,X_opt,'k-', 'markersize', 8,'linewidth',2)
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
plot(M_set,X_opt,'k-', 'markersize', 8,'linewidth',2)
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
