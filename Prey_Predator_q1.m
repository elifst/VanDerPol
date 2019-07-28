%Homework Question 1 Elif Sargut 

%This solution should orbit about the steady state solution. Because one
%expects there should be some balance between fox and rabbit number. If
%number of rabbits are greater than number of foxes there will be plenty of
%rabbits for the foxes and this will result in increase in the fox
%population. But as fox population increases rabbit population will
%decrease as a result. This means both x prime and y prime should equal to
%zero.(Steady-State Equilibrium Solution)

%dR/dt = AR-BRF;   Change in rabbit population in time
%dF/dt = -DF + CRF;  Change in fox population in time
clear all
clc
% Define constants;

A = 2;  B = 0.02; C = 0.0002; D = 0.8;

% Define function handles
fR = @(t,R,F) A*R-B*R*F;
fF = @(t,R,F) -D*F + C*R*F;

% Define initial conditions
t(1) = 0;
F(1) = 100;
% R(1) = 1000;
R_num = [1000 3000 5000 7000];
lr = length(R_num);
for j = 1:lr;
%Define step size
h = 0.01;
tmax = 5;
N = (tmax-t(1))/h;
R(1) = R_num (j);
for i = 1:N;
    %time update
    t(i+1) = t(i) + h;
    
    % update rabbit and fox numbers using Runge Kutta 4 Method
    % we should define k1,k2,k3,k4 coefficients for each species
    k1R = fR( t(i), R(i), F(i) );
    k1F = fF( t(i), R(i), F(i) );
    k2R = fR( t(i)+h/2, R(i)+(h/2)*k1R, F(i)+(h/2)*k1F );
    k2F = fF( t(i)+h/2, R(i)+(h/2)*k1R, F(i)+(h/2)*k1F );
    k3R = fR( t(i)+h/2, R(i)+(h/2)*k2R, F(i)+(h/2)*k2F );
    k3F = fF( t(i)+h/2, R(i)+(h/2)*k2R, F(i)+(h/2)*k2F );
    k4R = fR( t(i)+h,   R(i)+ h   *k3R,     F(i)+h*k3F );
    k4F = fF( t(i)+h,   R(i)+ h   *k3R,     F(i)+h*k3F );
    R(i+1) = R(i) + (1/6)*(k1R + 2*k2R + 2*k3R + k4R)*h ;
    F(i+1) = F(i) + (1/6)*(k1F + 2*k2F + 2*k3F + k4F)*h ;
    
end
plot(t,R,'b.','markersize',10,'MarkerFaceColor','b')
hold on 
% saveas(a,sprintf('Prey_Pred%d.jpeg'))
a = plot(t,F,'r.','markersize',10,'MarkerFaceColor','b')
xlabel('Run Time')
ylabel('Population')
legend('Rabbits','Foxes')
set(gca,'Fontsize',14)
switch j
    case 1
        title('Rabbit Number = 1000');
        saveas(a,sprintf('Prey_Pred_1%d.jpeg'));
        close all
    case 2
        title('Rabbit Number = 3000');
        saveas(a,sprintf('Prey_Pred_2%d.jpeg'));
        close all
    case 3 
        title('Rabbit Number = 5000');
        saveas(a,sprintf('Prey_Pred_3%d.jpeg'));
        close all
    case 4
        title('Rabbit Number = 7000');
        saveas(a,sprintf('Prey_Pred_4%d.jpeg'));
        close all
       
end
end




