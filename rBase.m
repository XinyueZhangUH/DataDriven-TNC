function [total_mean,total_std] = rBase(file1,file2,iterations)
load(file1)
cost_1 = 10;
cost_2 = cost_1 * 1.8;
revenue = 20;
[P_ref, Demand] = sampleData(demand,60);
d = Demand(P_ref>0);
d_max = max(d);
d_min = min(d);
total_revenue = zeros(1,iterations);

for i = 1:iterations
    r = randi(d_max-d_min) + d_min;
    total = - cost_1 * r + P_ref * (revenue * Demand - cost_2 * (Demand - r))';
    total_revenue(i) = total;
end
total_mean1 = mean(total_revenue);
total_std1 = std(total_revenue);

load(file2)
cost_1 = 10;
cost_2 = cost_1 * 1.8;
revenue = 20;
[P_ref, Demand] = sampleData(demand,60);
d = Demand(P_ref>0);
d_max = max(d);
d_min = min(d);
total_revenue = zeros(1,20);

for i = 1:iterations
    r = randi(d_max-d_min) + d_min;
    total = - cost_1 * r + P_ref * (revenue * Demand - cost_2 * (Demand - r))';
    total_revenue(i) = total;
end
total_mean2 = mean(total_revenue);
total_std2 = std(total_revenue);

total_mean = (total_mean1 + total_mean2)/2;
total_std = (total_std1 + total_std2)/2;
end