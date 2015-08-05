%Author: Alex Dytso
%email: odytso2@uic.edu
%Discription: This code is a simulation of 3 user Distributed Power Control
%algorithm used in CDMA networks for interference coordination. 

%Variables:   SIR-Signal to Interference+Noise Ratio
%             H-channel gain matrix; Gamm- Gamm-Required SIR at each receiver
%             P-power available at each transmitter, N-noise at each
%             receiver
%             Err-error.Difference between required SIR and actual SIR. Measure
%             of convergence of algorithm


%Algorithm:   p(t+1,i)=Gamm(i)/SIR(t,i)*p(t,i) where t-is time index and
%i-user index.
%We perfom this algorithm until we conver to required SIR levels


clc, clear all, clf

K=3;%number of user(transmitter-receiver pairs)


%Next we randomly generate channel matrix H.
%H=rand(K,K); %H contains channel all channel gains. Channels gains are assumed to be less then 1
H= [1.0 0.2 0.2; 0.2 0.9 0.3; 0.2 0.2 1.0]

% Next we specify required SIR levels at each receiver
Gamm=[0.1, 0.2, 0.3]; %target SIR at each receiver


P=[0.5 0.5 0.5]; % power available at each transmitter i.e Transmit Power

N=[0.01, 0.01, 0.01]; % Noise power at each receiver 

SIR=[H(1)*P(1)/(H(3)*P(3)+H(2)*P(2)+N(1)),H(2)*P(2)/(H(3)*P(3)+H(1)*P(1)+N(2)),H(3)*P(3)/(H(2)*P(2)+H(1)*P(1)+N(3))];% initial SIR at each reciever




%algorithm starts here
iterations=1;
Err=1; %some initial error value  
while max(Err)>0.000001  % I choose maximum erro to be a divergence criteria
     
    P=(Gamm./SIR(iterations,:)).*P; % New power used by transmitters
    iterations=iterations+1;
    SIR(iterations,:)=[H(1)*P(1)/(H(3)*P(3)+H(2)*P(2)+N(1)),H(2)*P(2)/(H(3)*P(3)+H(1)*P(1)+N(2)),H(3)*P(3)/(H(2)*P(2)+H(1)*P(1)+N(3))]% new SIR
    
    Err=abs(Gamm- SIR(iterations,:)); %error
   
    
    
end
    
%ploting 
 plot(linspace(0,iterations,100),Gamm(1)*ones(1,100),'b')
hold on 
plot(linspace(0,iterations,100),Gamm(2)*ones(1,100),'g')
plot(linspace(0,iterations,100),Gamm(3)*ones(1,100),'r')

plot(1:iterations,SIR(:,1),'-.')
 plot(1:iterations,SIR(:,2),'-.g')
 plot(1:iterations,SIR(:,3),'-.r')
 xlabel('Iterations')
 ylabel('SIR')
 title('SIR vs number of Iterations')
     legend(' SIR of user 1',' SIR of user 2',' SIR of user 3')


