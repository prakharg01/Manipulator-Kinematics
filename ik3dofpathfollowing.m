clear all
clc

syms  X x y t1 t2 t3 l1 l2 l3 gamma f1 f2 f3 f jacobian;
% x=-1.2578;
% y=0;
% gamma=pi;
x=1.2578*cos(-pi/4);
y=1.2578*sin(-pi/4);
gamma=-pi/4;
l1=0.4;
l2=0.4;
l3=0.4578;
f1=subs(x-(l1*cos(t1)+l2*cos(t1+t2)+l3*cos(t1+t2+t3)));
f2=subs(y-(l1*sin(t1)+l2*sin(t1+t2)+l3*sin(t1+t2+t3)));
f3=subs(gamma-(t1+t2+t3));
f=([f1;f2;f3]);
jacobian=(subs([diff(f1,t1),diff(f1,t2),diff(f1,t3);diff(f2,t1),diff(f2,t2),diff(f2,t3);diff(f3,t1),diff(f3,t2),diff(f3,t3)]));
maxiter=30;

t1=-0.5;
t2=-0.5;
t3=-0.5;
X=[t1;t2;t3];
X0=[-0.5;-0.5;-0.5];
X=X0;
error=zeros(30);
data=zeros(30,3);
path=zeros(30,3);

for i=1:maxiter
    X=X-double(subs((inv(jacobian))))*double(subs((f)));
    t1=X(1);
    t2=X(2);
    t3=X(3);
    data(i,1)=atan2(sin(t1),cos(t1));
    data(i,2)=atan2(sin(t2),cos(t2));
    data(i,3)=atan2(sin(t3),cos(t3));
    writematrix(data);
    path(i,1)=-0.2001;
    path(i,2)=l1*cos(t1)+l2*cos(t1+t2)+l3*cos(t1+t2+t3);
    path(i,3)=1.5750+l1*sin(t1)+l2*sin(t1+t2)+l3*sin(t1+t2+t3);
    writematrix(path);
    error(i)=double(subs(f2));
    %if((double(subs(f1)<1.0e-10))&&(double(subs(f2)<1.0e-10))&&(double(subs(f3)<1.0e-10)))
    %    fprintf("im in bitch");
    %   break;
        
    %end
    
    
end
theta11=rad2deg(atan2(sin(t1),cos(t1)))
theta22=rad2deg(atan2(sin(t2),cos(t2)))
theta33=rad2deg(atan2(sin(t3),cos(t3)))
a1 = l1; alpha1 = 0; d1=0; theta1 = t1;
A01 = DH(a1,alpha1,d1,theta1); 
a2 = l2; alpha2 = 0; d2=0; theta2 = t2;
A12 = DH(a2,alpha2,d2,theta2); 
a3 = l3; alpha3 = 0; d3=0; theta3 = t3;
gamma=t1+t2+t3;
A23 = DH(a3,alpha3,d3,theta3);  
endOfBASE = [0;0;0];
%Location of joint 1
endOfLink1 = A01(1:3,4);
%Location of joint 2
A02 = A01*A12;
endOfLink2 = A02(1:3,4);
%Location of joint 3
A03 = A01*A12*A23;
endOfLink3 = A03(1:3,4);

%end-effector position and orientation.
position_of_end_effector = A03(1:3,4)
orientation_of_end_effector = A03(1:3,1:3)
param=0:pi/100:2*pi;
r1=l1+l2+l3;
x1=r1*cos(param);
x2=r1*sin(param);

%Plot the point where we want the end-effector
plot(x1,x2);
hold on;
  plot3(position_of_end_effector(1,1),position_of_end_effector(2,1),position_of_end_effector(3,1),'o','MarkerSize',10,'MarkerFaceColor','black');
  hold on; %Ensures that dot on screen does not dissappear

%%% Draw lines from one joint to another 
%Draw line from BASE to end of link 1
line([endOfBASE(1) endOfLink1(1)],[endOfBASE(2) endOfLink1(2)],[endOfBASE(3) endOfLink1(3)],....
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
xlim([-6 6]); 
ylim([-6 6]);
zlim([-6 6]);

view(3);
view(-37.5,30);