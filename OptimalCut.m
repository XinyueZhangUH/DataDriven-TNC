function [lam, Mu, P_t, bound] = OptimalCut(M,eta,Y_value,cost_2,revenue,P_ref,Demand,metric_flag)
%variable
[m,k] = size(P_ref);
scenirio = m * k;
P_tr = sdpvar(m,k);
lamda = sdpvar(m,k);
mu = sdpvar(k,m); 

%subproblem
Objective = sum(lamda) * Y_value + Demand * mu;

%%constraints
Constraints = [lamda >= 0, mu >= 0, lamda + mu' >= revenue*P_tr, lamda <= cost_2*P_tr, sum(P_tr) == 1];

%confidence set constraints 
if metric_flag(1) == 1
    [new_constraint1, new_constraint2, u] = FM_metric(P_ref,P_tr,scenirio,M,eta,Demand);
    new_constraint = [new_constraint1, new_constraint2];
end

if metric_flag(2) == 1
    [new_constraint1, new_constraint2, u] = K_metric(P_ref,P_tr,scenirio,M,eta,Demand);
    new_constraint = [new_constraint1, new_constraint2];
end

if metric_flag(3) == 1
    new_constraint = U_metric(P_ref,P_tr,scenirio,M,eta);
end

Constraints = Constraints + new_constraint;

%solve
options = sdpsettings('solver','gurobi');
sol_master = optimize(Constraints,Objective,options);
lam = value(lamda);
Mu = value(mu);
P_t = value(P_tr);
bound = value(Objective);
end
