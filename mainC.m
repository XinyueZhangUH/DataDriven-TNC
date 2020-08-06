clc
clear all
selected_file1 = 'Chengdu1';
privacy = 'noP';
filename1_noP = ['data/', selected_file1, '.mat'];
[FM_C1,K_C1,U_C1] = solveTNC(filename1_noP, selected_file1, privacy);

privacy = 'eps1';
filename1_eps1 = ['data/', selected_file1, '_', privacy '.mat'];
[FM_C1_ep1,K_C1_ep1,U_C1_ep1] = solveTNC(filename1_eps1, selected_file1, privacy);

privacy = 'eps15';
filename1_eps15 = ['data/', selected_file1, '_', privacy '.mat'];
[FM_C1_ep15,K_C1_ep15,U_C1_ep15] = solveTNC(filename1_eps15, selected_file1, privacy);

selected_file2 = 'Chengdu2';
privacy = 'noP';
filename2_noP = ['data/', selected_file2, '.mat'];
[FM_C2,K_C2,U_C2] = solveTNC(filename2_noP, selected_file2, privacy);

privacy = 'eps1';
filename2_eps1 = ['data/', selected_file2, '_', privacy '.mat'];
[FM_C2_ep1,K_C2_ep1,U_C2_ep1] = solveTNC(filename2_eps1, selected_file2, privacy);

privacy = 'eps15';
filename2_eps15 = ['data/', selected_file2, '_', privacy '.mat'];
[FM_C2_ep15,K_C2_ep15,U_C2_ep15] = solveTNC(filename2_eps15, selected_file2, privacy);

C_optimal = cal_opt(filename1_noP, filename2_noP);
[r, r_err] = rBase(filename1_noP, filename2_noP);

C_FM_noP = FM_C1(1,:) + FM_C2(1,:);
C_K_noP = K_C1(1,:) + K_C2(1,:);
C_U_noP = U_C1(1,:) + U_C2(1,:);

C_FM_ep1 = FM_C1_ep1(1,:) + FM_C2_ep1(1,:);
C_K_ep1 = K_C1_ep1(1,:) + K_C2_ep1(1,:);
C_U_ep1 = U_C1_ep1(1,:) + U_C2_ep1(1,:);

C_FM_ep15 = FM_C1_ep15(1,:) + FM_C2_ep15(1,:);
C_K_ep15 = K_C1_ep15(1,:) + K_C2_ep15(1,:);
C_U_ep15 = U_C1_ep15(1,:) + U_C2_ep15(1,:);

%% Plot figure
M_set = [5,8,10,15,20,25,30,40,50];
r_base = r * ones(1, length(M_set));
C_opt = C_optimal * ones(1, length(M_set));
figure(1)
plot(M_set,C_opt,'k-', 'markersize', 8,'linewidth',2)
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
