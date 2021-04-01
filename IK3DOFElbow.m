clear all 
clc
close all
global a1 alpha1 d1 a2 alpha2 d2 a3 alpha3 d3
global x_des y_des z_des %where you want the end-effector
l1=2;
l2=2;
l3=2;


%D-H for links. Theta's are not set, because we need to find them.
a1 = 0; alpha1 = pi/2; d1=l1;
a2 = l2; alpha2 = 0; d2=0;
a3 = l3; alpha3 = 0; d3=0;
%Location where we want the end-effector to be
x_des = input("enter valid x cordinate"); y_des = input("enter valid y cordinate"); z_des = input("enter valid z cordinate");
syms t1 t2 t3
an=solve(x_des==cos(t1)*cos(t2+t3)*l3+l2*cos(t2)*cos(t1),y_des==sin(t1)*sin(t2+t3)*l3+l2*sin(t2)*sin(t1),z_des==l1+l2*sin(t2)+l3*sin(t2+t3),t1,t2,t3);
theta1=(double(subs(an.t1)))
theta2=(double(subs(an.t2)))
theta3=(double(subs(an.t3)))
    
%% Now visualize the results 
close all %close all plots before starting

% Now let us plot the results.
for l=1:size(theta1)
    A01 = DH(a1,alpha1,d1,theta1(l,1)); %A^0_1
    A12 = DH(a2,alpha2,d2,theta2(l,1)); %A^1_2
    A23 = DH(a3,alpha3,d3,theta3(l,1)); %A^2_3

%Location of joint 1
  endOfLink1 = A01(1:3,4);

%Location of joint 2
  A02 = A01*A12;
  endOfLink2 = A02(1:3,4);
 %Location of joint 3
  A03 = A01*A12*A23;
  endOfLink3 = A03(1:3,4);

%Plot the point where we want the end-effector
  plot3(x_des,y_des,z_des,'o','MarkerSize',10,'MarkerFaceColor','black');
  hold on; %Ensures that dot on screen does not dissappear


%Draw line from origin to end of link 1
  line([0 endOfLink1(1)],[0 endOfLink1(2)],[0 endOfLink1(3)],....
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

  %view([0,90]); %top view (for 2-d plot). Comment out if you want a 3-d plot

%These set the x and y limits for the axis (will need adjustment)
  xlim([-7 7]); 
  ylim([-7 7]);
  zlim([-7 7]);
end
    
