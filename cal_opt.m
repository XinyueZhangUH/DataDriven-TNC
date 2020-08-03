load('data/Xian1.mat')
cost_1 = 10;
cost_2 = cost_1 * 1.8;
revenue = 20;
[P_ref, Demand] = sampleData(demand,60);

Y = intvar(1);
X = intvar(1, length(Demand));

Objective = - cost_1 * Y + P_ref * (revenue * min(X+Y, Demand) - cost_2 * X)';
Constraints = [X>=0, Y>=0];
options = sdpsettings('solver','gurobi');
sol_master1 = optimize(Constraints,-Objective,options);
optimal1 = value(Objective);

load('data/Xian2.mat')
cost_1 = 10;
cost_2 = cost_1 * 1.8;
revenue = 20;
[P_ref, Demand] = sampleData(demand,60);

Y = intvar(1);
X = intvar(1, length(Demand));

Objective = - cost_1 * Y + P_ref * (revenue * min(X+Y, Demand) - cost_2 * X)';
Constraints = [X>=0, Y>=0];
options = sdpsettings('solver','gurobi');
sol_master2 = optimize(Constraints,-Objective,options);
optimal2 = value(Objective);
optimal = optimal1 + optimal2;