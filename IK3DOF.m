clear all 
clc
close all
global a1 alpha1 d1 a2 alpha2 d2 a3 alpha3 d3 
                                
global x_des y_des z_des 
%D-H for links. Theta's are not set, because we need to find them.
a1 = 2; alpha1 = 0; d1=0;
a2 = 2; alpha2 = 0; d2=0;
a3 = 2; alpha3 = 0; d3=0;

%Location where we want the end-effector to be

x_des = input("enter valid x cordinate"); y_des =input("enter valid y cordinate"); z_des = 0;
gamma=input("enter valid gamma");
syms t1 t2 t3
an=solve(x_des==a1*cos(t1)+a2*cos(t1+t2)+a3*cos(t1+t2+t3),y_des==a1*sin(t1)+a2*sin(t1+t2)+a3*sin(t1+t2+t3),gamma==t1+t2+t3,t1,t2,t3);
theta1=(double(subs(an.t1)));
theta2=(double(subs(an.t2)));
theta3=(double(subs(an.t3)));
param=0:pi/100:2*pi;
r1=a1+a2+a3;
x1=r1*cos(param);
x2=r1*sin(param);
if (x_des^2+y_des^2>36)
    fprintf("nearest solution exists\n");
    theta11=atan2(y_des,x_des);
    theta22=0;
    theta33=0;
    theta1=theta11;
    theta2=theta22;
    theta3=theta33;
    %error("done");
end

if(~(isreal(theta1))||~(isreal(theta2))||~(isreal(theta3)))
    fprintf("no solution exists\n");
    error("done");
end
if((isempty(theta1)))
    fprintf("no solution exists\n");
    error("sorry");
end
if((isempty(theta2)))
    fprintf("no solution exists\n");
    error("sorry");
end
if((isempty(theta3)))
    fprintf("no solution exists\n");
    error("sorry");
end
    

    
%% Now visualize the results 
close all %close all plots before starting

% Now let us plot the results.
for k=1:numel(theta1)
    A01 = DH(a1,alpha1,d1,theta1(k,1)); %A^0_1
    A12 = DH(a2,alpha2,d2,theta2(k,1)); %A^1_2
    A23 = DH(a3,alpha3,d3,theta3(k,1)); %A^2_3
%Location of base
  endOfBASE = [0;0;0];

%Location of joint 1
  
  endOfLink1 = A01(1:3,4);
 %Location of joint 2
 A02 = A01*A12;
  
  endOfLink2 = A02(1:3,4);
   %Location of joint 3
   A03 = A01*A12*A23;
  endOfLink3 = A03(1:3,4);

%Plot the point where we want the end-effector
plot(x1,x2);
hold on;
  plot3(x_des,y_des,z_des,'o','MarkerSize',10,'MarkerFaceColor','black');
  hold on; %Ensures that dot on screen does not dissappear


%Draw line from base to end of link 1
  line([endOfBASE(1) endOfLink1(1)],[endOfBASE(2) endOfLink1(2)],[endOfBASE(3) endOfLink1(3)],....
      'LineWidth',5,'Color','green');

%Draw line from end of link 1 to end of link 2
  line([endOfLink1(1) endOfLink2(1)],...
     [endOfLink1(2) endOfLink2(2)],...
     [endOfLink1(3) endOfLink2(3)],...
     'LineWidth',5,'Color','magenta');
 %Draw line from end of link 2 to end of link 3
  line([endOfLink2(1) endOfLink3(1)],...
     [endOfLink2(2) endOfLink3(2)],...
     [endOfLink2(3) endOfLink3(3)],...
     'LineWidth',5,'Color','red');
 
  xlabel('x');
  ylabel('y');
  zlabel('z');
  grid on; %if you want the grid to show up.
  axis('equal'); %make the axis equal, to avoid scaling effect

  view([0,90]); %top view (for 2-d plot). Comment out if you want a 3-d plot

%These set the x and y limits for the axis (will need adjustment)
  xlim([-4 4]); 
  ylim([-4 4]);
  zlim([-4 4]);
 
  
end
theta1r=rad2deg(atan2(sin(theta1),cos(theta1)));
theta2r=rad2deg(atan2(sin(theta2),cos(theta2)));
theta3r=rad2deg(atan2(sin(theta3),cos(theta3)));

if(numel(theta1)>1)
    fprintf("there are 2 solutions elbow up and down here is the first one\n");
    fprintf("theta1\n");
    sprintf('%f',  theta1r(1,1))
    fprintf("theta2\n");
    sprintf('%f',  theta2r(1,1))
    fprintf("theta3\n");
    sprintf('%f',  theta3r(1,1))
    fprintf("there are 2 solutions elbow up and down here is the second one\n");
    fprintf("theta1\n");
    sprintf('%f',  theta1r(2,1))
    fprintf("theta2\n");
    sprintf('%f',  theta2r(2,1))
    fprintf("theta3\n");
    sprintf('%f',  theta3r(2,1))
    
else
    fprintf("theta1\n");
    sprintf('%f',  theta1r)
    fprintf("theta2\n");
    sprintf('%f',  theta2r)
    fprintf("theta3\n");
    sprintf('%f',  theta3r)
    
end

    
    


    
