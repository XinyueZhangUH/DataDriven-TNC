function [Constraint]=U_metric(P_ref,P_real,scenario,sample_size,eta)

%U-metric
%P_real is a vector variable
%output: Constraint_1 & Constraint_2, which are so-called "confidence set constraints" and will be included in the sub-pro

%U-metric parameters
Q=sample_size;
theta = sqrt(-1/(2*Q)*log((1-eta)/2));


Constraint=[];
for f=1:scenario
    sum_diffP=0;
    for j=1:f
        sum_diffP=sum_diffP + P_ref(j)-P_real(j);
    end
    sum_diffP=abs(sum_diffP);
    Constraint=[Constraint, sum_diffP<=theta];
end

end