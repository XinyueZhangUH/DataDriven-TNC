function [p_ref, demand] = sampleData(data, M)
max_data = max(data);
no_bins = ceil(max_data/10);
demand = 5:10:no_bins*10-5;
p_ref = zeros(1, no_bins);
% N = length(data);
% for i = 1:no_bins
%     count = sum(data <= i*10 & data > (i-1)*10);
%     p_ref(i) = count / N;
% end
selected = datasample(data,M,'Replace',false);
for i = 1:no_bins
    count = sum(selected <= i*10 & selected > (i-1)*10);
    p_ref(i) = count / M;
end
end