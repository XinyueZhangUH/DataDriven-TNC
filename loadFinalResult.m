function [revenue, err_r] = loadFinalResult(filename)

load(filename);
revenue = Final_results(1,:);
err_r = Final_results(2,:);
end