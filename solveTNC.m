function [] = solveTNC(filenames, selected_file, privacy)

%initialize
load(filenames)
historical_data = [5,8,10,15,20,25,30,40,50]; % number of historical data
Results = zeros(size(historical_data));
err_bar = zeros(size(historical_data));
iterations = 50;

for flag = 1:3
    % Choose metric
    metric_flag = zeros(1,3);
    metric_flag(flag) = 1;
    if sum(metric_flag) > 1
        fprintf('CHOOSE ONLY ONE METRIC!!!!!!!')
        return
    end

    for i = 1:length(historical_data)

        dummy_result = zeros(iterations,1);
        for j = 1:iterations % run 50 iterations
            M = historical_data(i);
            [P_ref, Demand] = sampleData(demand,M);
            eta = 0.9; %confident level
            N_Senario = size(P_ref);
            cost_1 = 10;
            cost_2 = cost_1 * 1.8;
            revenue = 20;

            % variable
            Y = intvar(1);
            alpha = sdpvar(1); % second stage

            %master problem
            Objective = - cost_1*Y + alpha;
            Constraints = [1e5>=alpha>=0, Y>=0];
            options = sdpsettings('solver','gurobi');
            sol_master = optimize(Constraints,-Objective,options);
            op_cut = 0;

            n=0;
            while 1
                Y_value = value(Y);
                alpha_value = value(alpha);
                [lam, Mu, P_t, bound] = OptimalCut(M,eta,Y_value,cost_2,revenue,P_ref,Demand,metric_flag);

                if bound - alpha_value < 0 %solution not optimal
                    %add optimal cut
                    Constraints = Constraints + [sum(lam) * Y + Demand * Mu - alpha >= 0];
                    op_cut = op_cut +1;
                    n = n + 1;
                    if n == 50
                        break
                    end
                else 
                    break
                end

            %check 
            Objective = - cost_1 * Y + alpha; 
            options = sdpsettings('solver','gurobi');
            sol_master = optimize(Constraints,-Objective,options);
            end
            Result = value(Objective);
            dummy_result(j) = Result;
        end
        Results(i) = mean(dummy_result);
        err_bar(i) = std(dummy_result);
        Final_results = [Results;err_bar];

    end
    if flag == 1
        out_file = ['result/', selected_file, '_FM_', privacy, '.mat'];
        save(out_file, 'Final_results')
    end
    if flag == 2
        out_file = ['result/', selected_file, '_K_', privacy, '.mat'];
        save(out_file, 'Final_results')
    end
    if flag == 3
        out_file = ['result/', selected_file, '_U_', privacy, '.mat'];
        save(out_file, 'Final_results')
    end
end
end