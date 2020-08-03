function [Constraint_1, Constraint_2,u]=FM_metric(P_ref,P_real,scenario,sample_size,eta,Data)

%FM-metric
%P_real is a vector variable
%output: Constraint_1 & Constraint_2, which are so-called "confidence set constraints" and will be included in the sub-pro


%FM-metric parameters

phi=scenario; % diameter of realization space \Omega.
Q=sample_size;
p_m=2;
Lambda=max([1 phi^(p_m-1)]);
theta=phi*Lambda*sqrt(2*log(1/(1-eta))/Q);

% construct matric A (size: file/scenario number* L=C_F^2)
index_f=1:scenario;
index_A=nchoosek(index_f,2);
L=2*size(index_A,1);
A1=zeros(L/2,scenario);
for ii=1:L/2
    A1(ii,index_A(ii,1))=1;
    A1(ii,index_A(ii,2))=-1;
end
A=[A1; -A1];

% construct vector B (size: L=C_F^2  * 1)
B=zeros(L/2,1); a=10;
for ii=1:L/2
    rou= abs(Data(index_A(ii,1))-Data(index_A(ii,2)));
    mmax=max(1,max(abs(Data(index_A(ii,1))-a),abs(Data(index_A(ii,2))-a))^(p_m-1));
    B(ii)=rou*mmax;
end
B=[B; B];

u=sdpvar(L,1,'full');

Constraint_1=[u>=0,B'*u <= theta];

dif_P=P_ref-P_real;
Constraint_2=[A'*u>=dif_P']; 

end
