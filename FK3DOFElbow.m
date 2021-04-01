clc
clear all
close all
l1=2;
l2=2;
l3=2;
a1 = 0; alpha1 = pi/2; d1=l1; theta1 = input("enter first angle");
A01 = DH(a1,alpha1,d1,theta1); %A^0_1
a2 = l2; alpha2 = 0; d2=0; theta2 = input("enter second angle");
A12 = DH(a2,alpha2,d2,theta2); %A^1_2
a3 = l3; alpha3 = 0; d3=0; theta3 = input("enter third angle");
A23 = DH(a3,alpha3,d3,theta3); %A^2_3
%%% Get locations of joints
%Location of joint 1
endOfLink1 = A01(1:3,4);
%Location of joint 2
A02 = A01*A12;
endOfLink2 = A02(1:3,4);
A03=A01*A12*A23;
endOfLink3=A03(1:3,4);

%end-effector position and orientation.
position_of_end_effector = A03(1:3,4)
orientation_of_end_effector = A03(1:3,1:3)

%Plot the point where we want the end-effector
  
  plot3(position_of_end_effector(1,1),position_of_end_effector(2,1),position_of_end_effector(3,1),'o','MarkerSize',10,'MarkerFaceColor','black');
  hold on; %Ensures that dot on screen does not dissappear

%%% Draw lines from one joint to another 
%Draw line from origin to end of link 1
line([0 endOfLink1(1)],[0 endOfLink1(2)],[0 endOfLink1(3)],....
      'LineWidth',5,'Color','red');

%Draw line from end of link 1 to end of link 2
line([endOfLink1(1) endOfLink2(1)],...
     [endOfLink1(2) endOfLink2(2)],...
     [endOfLink1(3) endOfLink2(3)],...
     'LineWidth',5,'Color','blue');
 
%Draw line from end of link 2 to end of link 3
line([endOfLink2(1) endOfLink3(1)],...
     [endOfLink2(2) endOfLink3(2)],...
     [endOfLink2(3) endOfLink3(3)],...
     'LineWidth',5,'Color','black');


xlabel('x');
ylabel('y');
zlabel('z');
grid on; %if you want the grid to show up.
axis('equal'); %make the axis equal, to avoid scaling effect
 
% These set the x and y limits for the axis (will need adjustment)
xlim([-7 7]); 
ylim([-7 7]);
zlim([-7 7]);

view(3);
view(-37.5,30);
[a1,b1,c1]=sphere;
  r1=l1+l2+l3;
h=surfl(a1*r1,b1*r1,c1*r1);
set(h, 'FaceAlpha', 0.5);
shading interp;
  hold on;