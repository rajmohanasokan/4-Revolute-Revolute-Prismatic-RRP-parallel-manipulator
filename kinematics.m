function varargout = kinematics(varargin)
% KINEMATICS M-file for kinematics.fig
%      KINEMATICS, by itself, creates a new KINEMATICS or raises the existing
%      singleton*.
%
%      H = KINEMATICS returns the handle to a new KINEMATICS or the handle to
%      the existing singleton*.
%
%      KINEMATICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KINEMATICS.M with the given input arguments.
%
%      KINEMATICS('Property','Value',...) creates a new KINEMATICS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ex1_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to kinematics_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help kinematics

% Last Modified by GUIDE v2.5 12-Feb-2014 11:42:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @kinematics_OpeningFcn, ...
                   'gui_OutputFcn',  @kinematics_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% --- Executes just before kinematics is made visible.
function kinematics_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to kinematics (see VARARGIN)

% Choose default command line output for kinematics
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% --- Outputs from this function are returned to the command line.
function varargout = kinematics_OutputFcn(hObject, eventdata, handles) 
% Get default command line output from handles structure
varargout{1} = handles.output;
% --- Executes on button press in push_button__reset.
function push_button__reset_Callback(hObject, eventdata, handles)
% initial configuration
global d1 d2 d3 d4 r a
global th1 th2 th3 th4 aa1 aa2 aa3 aa4 xe ye phi 
global xJ yJ xK yK xM yM xN yN
%
D=15; % half width of square)
r= 9; % radius of rotating link
a= 3;% diagonal od square)
xe=0; ye=0; phi=0;
xJ=D; yJ=-D; xK=D; yK=D; xM=-D; yM=D; xN=-D; yN=-D;
aa1=315; aa2=45; aa3=135; aa4=225;
%
[xx,yy]=initial_config();
%
alpha1=aa1-180; alpha2=aa2+180; alpha3=aa3+180; alpha4=aa4-180;
set(handles.status_text,'string','Initial configuration')
set(handles.theta1_slider,'Value',alpha1);
set(handles.theta2_slider,'Value',alpha2);
set(handles.theta3_slider,'Value',alpha3);
set(handles.xe_slider,'Value',xe); 
set(handles.ye_slider,'Value',ye); 
set(handles.phi_slider,'Value',phi); 
set(handles.theta1_disp, 'String',num2str(alpha1,'%0.2f'));
set(handles.theta2_disp, 'String',num2str(alpha2,'%0.2f'));
set(handles.theta3_disp, 'String',num2str(alpha3,'%0.2f'));
%
set(handles.xe_disp, 'String',num2str(xe,'%0.2f'));
set(handles.ye_disp, 'String',num2str(ye,'%0.2f'));
set(handles.phi_disp, 'String',num2str(phi,'%0.2f'));
%
set(handles.d1_value, 'String',num2str(d1,'%0.2f'));
set(handles.d2_value, 'String',num2str(d2,'%0.2f'));
set(handles.d3_value, 'String',num2str(d3,'%0.2f'));
set(handles.d4_value, 'String',num2str(d4,'%0.2f'));
set(handles.theta4_value, 'String',num2str(alpha4,'%0.2f'));
%
function [xx,yy]= initial_config()
global aa1 aa2 aa3 aa4 d1 d2 d3 d4 a r 
global xJ yJ xK yK xM yM xN yN xe ye phi
%
alpha1=aa1-180; alpha2=aa2+180; alpha3= aa3+180; alpha4=aa4-180;
%
xE=xJ+r*cosd(alpha1); yE=yJ+r*sind(alpha1);
xF=xK+r*cosd(alpha2); yF=yK+r*sind(alpha2);
xG=xM+r*cosd(alpha3); yG=yM+r*sind(alpha3);
xH=xN+r*cosd(alpha4); yH=yN+r*sind(alpha4);
%
xA=a*cosd(aa1); yA=a*sind(aa1);
xB=a*cosd(aa2); yB=a*sind(aa2);
xC=a*cosd(aa3); yC=a*sind(aa3);
xD=a*cosd(aa4); yD=a*sind(aa4);
%
d1=sqrt((xA-xE)^2+(yA-yE)^2);
d2=sqrt((xB-xF)^2+(yB-yF)^2);
d3=sqrt((xC-xG)^2+(yC-yG)^2);
d4=sqrt((xD-xH)^2+(yD-yH)^2);
%
xx(1)=xA; yy(1)=yA;xx(2)=xB;  yy(2)=yB;xx(3)=xC; yy(3)=  yC; xx(4)= xD;  yy(4)=yD;
xx(5)=xE; yy(5)=yE; xx(6)=xF;  yy(6)=yF; xx(7)=xG; yy(7)= yG; xx(8)= xH; yy(8)= yH;
%
cla
config_plot(xx,yy,xe,ye,phi);
%
function grid_box_Callback(hObject, eventdata, handles)
% 
xxx= get(hObject,'value');
if xxx==1
    grid on
%    grid minor
else
    grid off
end
% --- Executes on slider movement.
function theta1_slider_Callback(hObject, eventdata, handles)
global th1 th2 th3 th4 xe ye phi d1 d2 d3 d4 x0 xx0
th1=get(handles.theta1_slider,'Value'); 
set(handles.theta1_disp, 'String',num2str(th1,'%0.2f'));
th2=get(handles.theta2_slider,'Value'); 
th3=get(handles.theta3_slider,'Value'); 
%
x0=[0 0 0 9 9 9];
[PP,ppp]=fwd_kinematics(th1,th2,th3);
%
if (isempty(PP))
set(handles.status_text,'string','Configurationnot possible')
else
set(handles.status_text,'string','fwd_kin_configuration displayed')
xe=PP(1); ye=PP(2); phi=PP(3); d1=PP(4); d2=PP(5); d3=PP(6); th4=ppp(1); d4=ppp(2);
%
set(handles.xe_disp, 'String',num2str(xe,'%0.2f'));
set(handles.ye_disp, 'String',num2str(ye,'%0.2f'));
set(handles.phi_disp, 'String',num2str(phi,'%0.2f'));
set(handles.theta4_value, 'String',num2str(th4,'%0.2f'));
%
set(handles.d1_value, 'String',num2str(d1,'%0.2f'));
set(handles.d2_value, 'String',num2str(d2,'%0.2f'));
set(handles.d3_value, 'String',num2str(d3,'%0.2f'));
set(handles.d4_value, 'String',num2str(d4,'%0.2f'));
end
% --- Executes on slider movement.
function theta2_slider_Callback(hObject, eventdata, handles)
global th1 th2 th3 th4 xe ye phi d1 d2 d3 d4 x0 xx0
th2=get(handles.theta2_slider,'Value'); 
set(handles.theta2_disp, 'String',num2str(th2,'%0.2f'));
th1=get(handles.theta1_slider,'Value'); 
th3=get(handles.theta3_slider,'Value'); 
%
x0=[0 0 0 9 9 9];xx0=[-5 -5];
[PP,ppp]=fwd_kinematics(th1,th2,th3);
%
if (isempty(PP))
set(handles.status_text,'string','configuration not possible')
else
set(handles.status_text,'string','fwd_kin_configuration displayed')
%
xe=PP(1); ye=PP(2); phi=PP(3); d1=PP(4); d2=PP(5); d3=PP(6);th4=ppp(1); d4=ppp(2);  
% 
set(handles.xe_disp, 'String',num2str(xe,'%0.2f'));
set(handles.ye_disp, 'String',num2str(ye,'%0.2f'));
set(handles.phi_disp, 'String',num2str(phi,'%0.2f'));
set(handles.theta4_value, 'String',num2str(th4,'%0.2f'));
%
set(handles.d1_value, 'String',num2str(d1,'%0.2f'));
set(handles.d2_value, 'String',num2str(d2,'%0.2f'));
set(handles.d3_value, 'String',num2str(d3,'%0.2f'));
set(handles.d4_value, 'String',num2str(d4,'%0.2f'));
end
% --- Executes on slider movement.
function theta3_slider_Callback(hObject, eventdata, handles)
global th1 th2 th3 th4 xe ye phi d1 d2 d3 d4 x0 xx0
th3=get(handles.theta3_slider,'Value'); 
set(handles.theta3_disp, 'String',num2str(th3,'%0.2f'));
th1=get(handles.theta1_slider,'Value'); 
th2=get(handles.theta2_slider,'Value');
%
x0=[0 0 0 9 9 9];
[PP,ppp]=fwd_kinematics(th1,th2,th3);
%
if (isempty(PP))
set(handles.status_text,'string','configuration not possible')
else
set(handles.status_text,'string','fwd_kin_configuration displayed')
%
xe=PP(1); ye=PP(2); phi=PP(3); d1=PP(4); d2=PP(5); d3=PP(6);
 d4=ppp(2); th4=ppp(1); 
 %
set(handles.xe_disp, 'String',num2str(xe,'%0.2f'));
set(handles.ye_disp, 'String',num2str(ye,'%0.2f'));
set(handles.phi_disp, 'String',num2str(phi,'%0.2f'));
set(handles.theta4_value, 'String',num2str(th4,'%0.2f'));
%
set(handles.d1_value, 'String',num2str(d1,'%0.2f'));
set(handles.d2_value, 'String',num2str(d2,'%0.2f'));
set(handles.d3_value, 'String',num2str(d3,'%0.2f'));
set(handles.d4_value, 'String',num2str(d4,'%0.2f'));
end
%
function xe_slider_Callback(hObject, eventdata, handles)
global th1 th2 th3 th4 xe ye phi d1 d2 d3 d4    
%
xe=get(handles.xe_slider,'Value'); 
set(handles.xe_disp, 'String',num2str(xe,'%0.2f'));
ye=get(handles.ye_slider,'Value'); 
phi=get(handles.phi_slider,'Value'); 
%
[DD,TH]=inv_kinematics(xe,ye,phi);
if (isempty(DD))
set(handles.status_text,'string','configuration not possible')
else
set(handles.status_text,'string','inv_kin_configuration displayed')
th1=TH(1); th2=TH(2); th3=TH(3); th4=TH(4);
d1=DD(1); d2=DD(2); d3=DD(3); d4=DD(4);
%
set(handles.theta1_disp, 'String',num2str(th1,'%0.2f'));
set(handles.theta2_disp, 'String',num2str(th2,'%0.2f'));
set(handles.theta3_disp, 'String',num2str(th3,'%0.2f'));
set(handles.theta4_value, 'String',num2str(th4,'%0.2f'));
%
set(handles.d1_value, 'String',num2str(d1,'%0.2f'));
set(handles.d2_value, 'String',num2str(d2,'%0.2f'));
set(handles.d3_value, 'String',num2str(d3,'%0.2f'));
set(handles.d4_value, 'String',num2str(d4,'%0.2f'));
%
set(handles.theta1_slider,'Value',th1);
set(handles.theta2_slider,'Value',th2);
set(handles.theta3_slider,'Value',th3);
%
end
%
function ye_slider_Callback(hObject, eventdata, handles)
global th1 th2 th3 th4 xe ye phi d1 d2 d3 d4    
%
ye=get(hObject,'Value');
set(handles.ye_disp, 'String',num2str(ye,'%0.2f'));
xe=get(handles.xe_slider,'Value'); 
phi=get(handles.phi_slider,'Value'); 
%
[DD,TH]=inv_kinematics(xe,ye,phi);
if (isempty(DD))
set(handles.status_text,'string','configuration not possible')
else
set(handles.status_text,'string','inv_kin_configuration displayed')
th1=TH(1); th2=TH(2); th3=TH(3); th4=TH(4);
d1=DD(1); d2=DD(2); d3=DD(3); d4=DD(4);
%
set(handles.theta1_disp, 'String',num2str(th1,'%0.2f'));
set(handles.theta2_disp, 'String',num2str(th2,'%0.2f'));
set(handles.theta3_disp, 'String',num2str(th3,'%0.2f'));
set(handles.theta4_value, 'String',num2str(th4,'%0.2f'));
%
set(handles.d1_value, 'String',num2str(d1,'%0.2f'));
set(handles.d2_value, 'String',num2str(d2,'%0.2f'));
set(handles.d3_value, 'String',num2str(d3,'%0.2f'));
set(handles.d4_value, 'String',num2str(d4,'%0.2f'));
%
set(handles.theta1_slider,'Value',th1);
set(handles.theta2_slider,'Value',th2);
set(handles.theta3_slider,'Value',th3);
%
end
% --- Executes on slider movement.
function phi_slider_Callback(hObject, eventdata, handles)
global th1 th2 th3 th4 xe ye phi d1 d2 d3 d4    
%
xe=get(handles.xe_slider,'Value'); 
ye=get(handles.ye_slider,'Value');
phi=get(hObject,'Value'); 
set(handles.phi_disp, 'String',num2str(phi,'%0.2f'));
%
[DD,TH]=inv_kinematics(xe,ye,phi);
if (isempty(DD))
set(handles.status_text,'string','configuration not possible')
else
set(handles.status_text,'string','inv_kin_configuration displayed')
th1=TH(1); th2=TH(2); th3=TH(3); th4=TH(4);
d1=DD(1); d2=DD(2); d3=DD(3); d4=DD(4);
%
set(handles.theta1_disp, 'String',num2str(th1,'%0.2f'));
set(handles.theta2_disp, 'String',num2str(th2,'%0.2f'));
set(handles.theta3_disp, 'String',num2str(th3,'%0.2f'));
set(handles.theta4_value, 'String',num2str(th4,'%0.2f'));
%
set(handles.d1_value, 'String',num2str(d1,'%0.2f'));
set(handles.d2_value, 'String',num2str(d2,'%0.2f'));
set(handles.d3_value, 'String',num2str(d3,'%0.2f'));
set(handles.d4_value, 'String',num2str(d4,'%0.2f'));
%
set(handles.theta1_slider,'Value',th1);
set(handles.theta2_slider,'Value',th2);
set(handles.theta3_slider,'Value',th3);
%
end
% --- Executes on button press in grid_box.
%
function [PP,ppa]=fwd_kinematics (th1,th2,th3)
%
global r a  x0 xx0 d1 d2 d3 d4
global th4 aa1 aa2 aa3 aa4
global xJ yJ xK yK xM yM xN yN
x0=[0 0 0 9 9 9];
%
drawnow
   xE=xJ+r*cosd(th1);         yE=yJ+r*sind(th1);
    xF=xK+r*cosd(th2);         yF=yK+r*sind(th2);
     xG=xM+r*cosd(th3);         yG=yM+r*sind(th3);
%
L=@(x)[xE+(x(4)+a)*cosd(x(3)+aa1-180)-x(1);
       yE+(x(4)+a)*sind(x(3)+aa1-180)-x(2);
       xF+(x(5)+a)*cosd(x(3)+aa2+180)-x(1);
       yF+(x(5)+a)*sind(x(3)+aa2+180)-x(2);
       xG+(x(6)+a)*cosd(x(3)+aa3+180)-x(1);
       yG+(x(6)+a)*sind(x(3)+aa3+180)-x(2)];
 options=optimset('MaxFunEvals',1000,'Display','On'); % Option to display output
   %[PP, fval, exitflag] = fsolve(L,x0,options);
   PP = fsolve(L,x0,options);
% 
x0=PP;xe=PP(1); ye=PP(2); phi=PP(3);
           d1=PP(4); d2=PP(5); d3=PP(6);
%     
      xA=xe+a*cosd(aa1+phi);yA=ye+a*sind(aa1+phi);
      xB=xe+a*cosd(aa2+phi);yB=ye+a*sind(aa2+phi);
      xC=xe+a*cosd(aa3+phi);yC=ye+a*sind(aa3+phi);
      xD = 2*xe-xB;         yD = 2*ye-yB;
      a4=phi+aa4;
%
ss=[1  -2*((xN-xe)*cosd(a4)+(yN-ye)*sind(a4)) ((xN-xe)^2+(yN-ye)^2-r^2)];
dss=roots(ss);
d4=-a+dss(2);
xH=xe+(d4+a)*cosd(a4);yH=ye+(d4+a)*sind(a4);
mae=(yA-yE)/(xA-xE); mcg=(yC-yG)/(xC-xG);mbf=(yB-yF)/(xB-xF); mdh=(yD-yH)/(xD-xH);
if (isreal(dss)) && d1>0 && d2>0 && d3>0 && d4>0 && d1 < 13 && d2 < 13 && d3 < 13 ...
   && d4 < 13 && abs((mae-mcg))< 1e-3 && abs((mbf-mdh))< 1e-3 
%
th4a=atan2d((yH-yN),(xH-xN));
if th4a < 0
th4=th4a+360;
else
th4=th4a;
end
ppa(1)=th4; ppa(2)=d4;PP(4)=d1; PP(5)=d2; PP(6)=d3;
%
xx(1)=xA; yy(1)=yA; xx(2)=xB;  yy(2)=yB; xx(3)=xC; yy(3)= yC; xx(4)= xD; yy(4)=yD;
xx(5)=xE; yy(5)=yE; xx(6)=xF;  yy(6)=yF; xx(7)=xG; yy(7)= yG; xx(8)= xH; yy(8)= yH;
%
%
%if d1 >0 && d2 >0 && d3 > 0 && d4 > 0 && d1 < 18 && d2 < 18 && d3 < 18 && d4 < 18% 

config_plot(xx,yy,xe,ye,phi);
%    
else
    PP=[];ppa=[];
end
%
function[DD,TH] = inv_kinematics(xe,ye,phi)
global th1 th2 th3 th4 a r aa1 aa2 aa3 aa4
global xJ yJ xK yK xM yM xN yN 
% 
a1=phi+aa1; a2=phi+aa2; a3=phi+aa3; a4=phi+aa4;
%
s=[1  -2*((xJ-xe)*cosd(a1)+(yJ-ye)*sind(a1)) ((xJ-xe)^2+(yJ-ye)^2-r^2)];
ds=roots(s);d1=-a+ds(2);
%%%%%%%% leg 2 %%%%%
t=[1  -2*((xK-xe)*cosd(a2)+(yK-ye)*sind(a2)) ((xK-xe)^2+(yK-ye)^2-r^2)];
dt=roots(t);d2=-a+dt(2);
%%%% leg 3 %%%%%%%%
u=[1  -2*((xM-xe)*cosd(a3)+(yM-ye)*sind(a3)) ((xM-xe)^2+(yM-ye)^2-r^2)];
du=roots(u);d3=-a+du(2);
 % leg 4 
v=[1  -2*((xN-xe)*cosd(a4)+(yN-ye)*sind(a4)) ((xN-xe)^2+(yN-ye)^2-r^2)];
dv=roots(v);d4=-a+dv(2);
%
if (isreal(ds) && isreal(dt) && isreal(du) && isreal(dv)) && d1>0 && d2>0 && d3>0 && d4>0 ...
    && d1 < 13 && d2 < 13 && d3 < 13 && d4 < 13
     xE=xe+(d1+a)*cosd(a1);yE=ye+(d1+a)*sind(a1);
     xF=xe+(d2+a)*cosd(a2);yF=ye+(d2+a)*sind(a2);
       xG=xe+(d3+a)*cosd(a3);yG=ye+(d3+a)*sind(a3);
        xH=xe+(d4+a)*cosd(a4);yH=ye+(d4+a)*sind(a4);
     
xA=xe+a*cosd(a1);  yA=ye+a*sind(a1);
 xB=xe+a*cosd(a2);   yB=ye+a*sind(a2);
  xC=xe+a*cosd(a3);  yC=ye+a*sind(a3);
   xD=2*xe-xB; yD=2*ye-yB;
%
th1a=atan2d((yE-yJ),(xE-xJ));
if th1a < 0
    th1=th1a+360;
else
    th1=th1a;
end
th2a=atan2d((yF-yK),(xF-xK));
if th2a < 0
    th2=th2a+360;
else
    th2=th2a;
end
th3a=atan2d((yG-yM),(xG-xM));
if th3a < 0
th3=th3a+360;
else
th3=th3a;
end
th4a=atan2d((yH-yN),(xH-xN));
if th4a < 0
th4=th4a+360;
else
th4=th4a;
end
DD=[d1 d2 d3 d4];TH=[th1 th2 th3 th4];
%
xx(1)=xA; yy(1)=yA; xx(2)=xB;  yy(2)=yB; xx(3)=xC; yy(3)=  yC; xx(4)= xD;  yy(4)=yD;
xx(5)=xE; yy(5)=yE; xx(6)=xF;  yy(6)=yF; xx(7)=xG; yy(7)= yG; xx(8)= xH; yy(8)= yH;
%
config_plot(xx,yy,xe,ye,phi)
%
else
DD=[];TH=[];
end  
%
% --- Executes on button press in maximal_work_space.
function maximal_work_space_Callback(hObject, eventdata, handles)
%
global xlim ylim
xee=-10:1:10;yee=-10:1:10;phi=-40:5:40;
nn=length(xee);
initial_config;
%
set(handles.status_text,'string', '*: computing maximal work space')
for i=1:nn
   for j=1:nn
      for k=1:length(phi)
        S=invtest(xee(i),yee(j),phi(k));
           if (isempty(S))
           %         plot(xee(i),yee(j),'m*'); hold on
%            pause(.01);
 %          break
           else
             plot(xee(i),yee(j),'b*');hold on    
        xlim=[xlim;xee(i)]; ylim=[ylim;yee(j)];
            end
      end
    end
end
%
function [S]=invtest(xee,yee,phi0)
global a r aa1 aa2 aa3 aa4
global xJ yJ xK yK xM yM xN yN
%
a1=phi0+aa1; a2=phi0+aa2; a3=phi0+aa3; a4=phi0+aa4;
s=[1  -2*((xJ-xee)*cosd(a1)+(yJ-yee)*sind(a1)) ((xJ-xee)^2+(yJ-yee)^2-r^2)];
ds=roots(s);d1=-a+ds(2);
%%%%%%%% leg 2 %%%%%
t=[1  -2*((xK-xee)*cosd(a2)+(yK-yee)*sind(a2)) ((xK-xee)^2+(yK-yee)^2-r^2)];
dt=roots(t);d2=-a+dt(2);
%%%% leg 3 %%%%%%%%
u=[1  -2*((xM-xee)*cosd(a3)+(yM-yee)*sind(a3)) ((xM-xee)^2+(yM-yee)^2-r^2)];
du=roots(u);d3=-a+du(2);
 % leg 4 
v=[1  -2*((xN-xee)*cosd(a4)+(yN-yee)*sind(a4)) ((xN-xee)^2+(yN-yee)^2-r^2)];
dv=roots(v);d4=-a+dv(2);
%
upper=13;
if (isreal(ds) && isreal(dt) && isreal(du) && isreal(dv))&& d1>0 && d2>0 && d3>0 && d4>0 ...
    && d1 < upper && d2 <upper && d3 < upper && d4 < upper
%
S=[a1 a2 a3 a4 d1 d2 d3 d4];
else
S=[];
end  
% --- Executes during object creation, after setting all properties.
function theta1_text_CreateFcn(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function theta2_text_CreateFcn(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function theta3_text_CreateFcn(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function theta1_disp_CreateFcn(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function theta2_disp_CreateFcn(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function theta3_disp_CreateFcn(hObject, eventdata, handles)
%
function theta1_slider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
function theta2_slider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
function theta3_slider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
%
% --- Executes during object creation, after setting all properties.
function phi_slider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
% --- Executes during object creation, after setting all properties.
function xe_slider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
% --- Executes during object creation, after setting all properties.
function ye_slider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
% --- Executes during object creation, after setting all properties.
function grid_box_CreateFcn(hObject, eventdata, handles)
function push_button__reset_ButtonDownFcn(hObject, eventdata, handles)
%
function []=config_plot(xx,yy,xe,ye,phi)
global xJ yJ xK yK xM yM xN yN
%
xA=xx(1); yA=yy(1);xB=xx(2);  yB=yy(2);xC=xx(3);   yC=yy(3);  xD=xx(4);  yD=yy(4);
xE=xx(5); yE=yy(5);xF=xx(6);  yF=yy(6);xG=xx(7);   yG=yy(7);  xH=xx(8);  yH=yy(8);
%
lam1=0.8; lam2=1-lam1;
%
 xA1=(lam1*xA+lam2*xe); yA1=(lam1*yA+lam2*ye);
  xB1=(lam1*xB+lam2*xe); yB1=(lam1*yB+lam2*ye);
   xC1=(lam1*xC+lam2*xe); yC1=(lam1*yC+lam2*ye);
    xD1=(lam1*xD+lam2*xe); yD1=(lam1*yD+lam2*ye);
%
xAE=(xA+xE)/2;yAE=(yA+yE)/2;
xBF=(xB+xF)/2;yBF=(yB+yF)/2;
xCG=(xC+xG)/2;yCG=(yC+yG)/2;
xDH=(xD+xH)/2;yDH=(yD+yH)/2;
%
cla
fill([xA xB xC xD xA],[yA yB yC yD yA],'m');hold on
plot([xA1 xA],[yA1 yA],'m',[xB1 xB],[yB1 yB],'m',[xC1 xC],[yC1 yC],'m',[xD1 xD],[yD1 yD],'m',...
    'linewidth',9)
plot([xA xE],[yA yE],'g',[xB xF],[yB yF],'g',[xC xG],[yC yG],'g',[xD xH],[yD yH],'c',...
    'linewidth',9);
plot([xA xC],[yA yC],'k',[xD xB],[yD yB],'k')
plot([xE xJ],[yE yJ],'-bO',[xF xK],[yF yK],'-bO',...
     [xG xM],[yG yM],'-bO',[xH xN],[yH yN],'-rO','linewidth',3,...
    'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',6);
plot([0 0 20],[20 0 0],'-r','linewidth',2);
text(19.4,.4,'\rangle\bf','color',[1 0 0],'fontsize',18);
text(-0.8,20,'\wedge\bf','color',[1 0 0],'fontsize',18)
text(19,-2,'X');text(-2,19,'Y')
text(xJ,yJ,'   J'); text(xK,yK,'   K');text(xM-2.5,yM,'M'); text(xN-2.5,yN,'N')
text(xJ,yJ-2,' \theta1'); text(xK,yK+2,' \theta2');
text(xM,yM+2,'\theta3'); text(xN,yN-2,'\theta4')
text(xE-2,yE,'E'); text(xF-2,yF,'F');text(xG+1,yG,'G'); text(xH+1,yH,'H')
text(xAE,yAE,' d1'); text(xBF,yBF,' d2');text(xCG,yCG,' d3'); text(xDH,yDH,' d4')
axis('square')
axis('equal')
axis([-20 20 -20 20])

% --- Executes on button press in path_tracing.
function path_tracing_Callback(hObject, eventdata, handles)
global xe ye phi
set(handles.status_text,'string','elliptical path tracing')
tt=0:5:360;phi=0;rea=2;reb=1;
nn=length(tt);
xea=zeros(nn,1); yea=zeros(nn,1);
for ii=1:nn
    xea(ii)=rea*cosd(tt(ii));
    yea(ii)=reb*sind(tt(ii));
end
for ii=1:nn
    xe=xea(ii); ye=yea(ii);
    inv_kinematics(xe,ye,phi);hold on
    plot(xea,yea,'linewidth',3);
    pause(.01)
    hold
end
% --- Executes on button press in joint_space_interp.
function joint_space_interp_Callback(hObject, eventdata, handles)
global xlimd ylimd
plot(xlimd,ylimd,'*')
syms t d0 df t_0 t_f
sd=5;%phii=0;
t_initial=0;t_final=10;
tt=t_initial:1:t_final;nt=length(tt);
xbc=[sd -sd -sd sd sd];ybc=[sd sd -sd -sd sd];
%plot(xbc,ybc,'linewidth',3);
%
[xm,ym]=ginput(2);phi1=5; phi2=5;
AA=[1 t_0; 1 t_f];T=[d0;df];
aa=subs(AA\T,[t_0 t_f],[tt(1) tt(nt)]);
DD=aa(1)+aa(2)*t;
x0=xm(1); xf=xm(2); y0=ym(1); yf=ym(2);
xee=eval(subs(subs(DD,t,tt),[d0 df],[x0 xf]));
yee=eval(subs(subs(DD,t,tt),[d0 df],[y0 yf]));
phii=eval(subs(subs(DD,t,tt),[d0 df],[phi1 phi2]));
%
for ii=1:nt
    xmm=xee(ii); ymm=yee(ii);phm=phii(ii);
    [dx,th]=inv_kinematics(xmm,ymm,phm);hold on
    plot(xee,yee,'linewidth',3)
    ths1=th(1); ths2=th(2); ths3=th(3);
set(handles.theta1_slider,'Value',ths1);
set(handles.theta2_slider,'Value',ths2);
set(handles.theta3_slider,'Value',ths3);
set(handles.xe_slider,'Value',xmm); 
set(handles.ye_slider,'Value',ymm); 
set(handles.phi_slider,'Value',phm); 
set(handles.theta1_disp, 'String',num2str(ths1,'%0.2f'));
set(handles.theta2_disp, 'String',num2str(ths2,'%0.2f'));
set(handles.theta3_disp, 'String',num2str(ths3,'%0.2f'));
%
set(handles.xe_disp, 'String',num2str(xmm,'%0.2f'));
set(handles.ye_disp, 'String',num2str(ymm,'%0.2f'));
set(handles.phi_disp, 'String',num2str(phm,'%0.2f'));
%
set(handles.d1_value, 'String',num2str(dx(1),'%0.2f'));
set(handles.d2_value, 'String',num2str(dx(2),'%0.2f'));
set(handles.d3_value, 'String',num2str(dx(3),'%0.2f'));
set(handles.d4_value, 'String',num2str(dx(4),'%0.2f'));
set(handles.theta4_value, 'String',num2str(th(4),'%0.2f'));
    pause(.01)
    hold
    th1(ii,1:3)=th(1:3);
end
figure(1)
    subplot(331),plot(tt,xee,'r','linewidth',2)
    xlabel('time (sec)'); ylabel('x(end-effector)');
    subplot(332),plot(tt,yee,'r','linewidth',2);
    xlabel('time (sec)'); ylabel('y(end-effector)');
    subplot(333),plot(tt,phii,'r','linewidth',2);
    xlabel('time (sec)'); ylabel('phi(end-effector)');
    subplot(335),plot(xee,yee,'r','linewidth',2)
    xlabel('x(end-effector)'); ylabel('y(end-effector)');
    subplot(337),plot(tt,th1(:,1),'b','linewidth',2)
    xlabel('time (sec)'); ylabel('theta_1(deg)');
    subplot(338),plot(tt,th1(:,2),'b','linewidth',2)
    xlabel('time (sec)'); ylabel('theta_2(deg)');
    subplot(339),plot(tt,th1(:,3),'b','linewidth',2)  
    xlabel('time (sec)'); ylabel('theta_3(deg)');
%
axes(handles.axes1)
th10=th1(1,1); th1f=th1(nt,1);th20=th1(1,2); th2f=th1(nt,2);th30=th1(1,3); th3f=th1(nt,3);
th11=eval(subs(subs(DD,t,tt),[d0 df],[th10 th1f]));
th12=eval(subs(subs(DD,t,tt),[d0 df],[th20 th2f]));
th13=eval(subs(subs(DD,t,tt),[d0 df],[th30 th3f]));
for im=1:nt
    x0=[0 0 0 9 9 9];
thm1=th11(im); thm2=th12(im); thm3=th13(im);
    [PQ,pqa]=fwd_kinematics (thm1, thm2, thm3);
    hold on;
    xea(im)=PQ(1); yea(im)=PQ(2); phii(im)=PQ(3);
    dd4=pqa(1); th14=pqa(2);
    dd1=PQ(4); dd2=PQ(5); dd3=PQ(6);
set(handles.theta1_slider,'Value',thm1);
set(handles.theta2_slider,'Value',thm2);
set(handles.theta3_slider,'Value',thm3);
set(handles.xe_slider,'Value',xea(im)); 
set(handles.ye_slider,'Value',yea(im)); 
set(handles.phi_slider,'Value',phii(im)); 
set(handles.theta1_disp, 'String',num2str(thm1,'%0.2f'));
set(handles.theta2_disp, 'String',num2str(thm2,'%0.2f'));
set(handles.theta3_disp, 'String',num2str(thm3,'%0.2f'));
%
set(handles.xe_disp, 'String',num2str(xea(im),'%0.2f'));
set(handles.ye_disp, 'String',num2str(yea(im),'%0.2f'));
set(handles.phi_disp, 'String',num2str(phii(im),'%0.2f'));
%
set(handles.d1_value, 'String',num2str(dd1,'%0.2f'));
set(handles.d2_value, 'String',num2str(dd2,'%0.2f'));
set(handles.d3_value, 'String',num2str(dd3,'%0.2f'));
set(handles.d4_value, 'String',num2str(dd4,'%0.2f'));
set(handles.theta4_value, 'String',num2str(th14,'%0.2f'));
     plot(xea,yea);pause(.01)
     hold
end
figure(2)
    subplot(331),plot(tt,th11,'r','linewidth',2)
    xlabel('time (sec)'); ylabel('theta_1(deg)');
    subplot(332),plot(tt,th12,'r','linewidth',2)
    xlabel('time (sec)'); ylabel('theta_2(deg)');
    subplot(333),plot(tt,th13,'r','linewidth',2)
    xlabel('time (sec)'); ylabel('theta_3(deg)');
    subplot(335),plot(xea,yea,'b','linewidth',2)
    xlabel('x(end-effector)'); ylabel('y(end-effector)');
    subplot(337),plot(tt,xea,'b','linewidth',2)
    xlabel('time (sec)'); ylabel('x(end-effector)');
    subplot(338),plot(tt,yea,'b','linewidth',2)
    xlabel('time (sec)'); ylabel('y(end-effector)');
    subplot(339),plot(tt,phii,'b','linewidth',2)
    xlabel('time (sec)'); ylabel('phi(end-effector)');
% --- Executes on button press in m_click.
function m_click_Callback(hObject, eventdata, handles)
%
sd=5;
xbc=[-sd sd sd -sd -sd];ybc=[-sd -sd sd sd -sd];
phii=0;
initial_config;
plot(xbc,ybc,'k','linewidth',2);hold on
button=1;
while button~=3
[xhe,yhe,button]=ginput(1);
%
if xhe<-sd || xhe>sd || yhe<-sd || yhe>sd
    set(handles.status_text,'string','coordinates exceed the limit; click inside box')
else
   set(handles.status_text,'string','configuration displayed; click Right MouseBtn to exit')    
[ddd,tth]=inv_kinematics(xhe,yhe,phii);
plot(xbc,ybc,'k','linewidth',2);
%
tthm1=tth(1); tthm2=tth(2); tthm3=tth(3); tthm4=tth(4);
%
set(handles.theta1_slider,'Value',tthm1);
set(handles.theta2_slider,'Value',tthm2);
set(handles.theta3_slider,'Value',tthm3);
set(handles.xe_slider,'Value',xhe); 
set(handles.ye_slider,'Value',yhe); 
set(handles.phi_slider,'Value',phii); 
set(handles.theta1_disp, 'String',num2str(tthm1,'%0.2f'));
set(handles.theta2_disp, 'String',num2str(tthm2,'%0.2f'));
set(handles.theta3_disp, 'String',num2str(tthm3,'%0.2f'));
%
set(handles.xe_disp, 'String',num2str(xhe,'%0.2f'));
set(handles.ye_disp, 'String',num2str(yhe,'%0.2f'));
set(handles.phi_disp, 'String',num2str(phii,'%0.2f'));
%
set(handles.d1_value, 'String',num2str(ddd(1),'%0.2f'));
set(handles.d2_value, 'String',num2str(ddd(2),'%0.2f'));
set(handles.d3_value, 'String',num2str(ddd(3),'%0.2f'));
set(handles.d4_value, 'String',num2str(ddd(4),'%0.2f'));
set(handles.theta4_value, 'String',num2str(tthm4,'%0.2f'));
end
end
% --- Executes on button press in dextrous_pushbutton.
function dextrous_pushbutton_Callback(hObject, eventdata, handles)
global xlimd ylimd
xee=-10:1:10;yee=-10:1:10;phi=-20:1:20;
nn=length(xee);
initial_config;
%
set(handles.status_text,'string', '*: computing dextrous workspace')
for i=1:nn
   for j=1:nn
      for k=1:length(phi)
        S=invtest(xee(i),yee(j),phi(k));
        if (isempty(S))
%         plot(xee(i),yee(j),'m*'); hold on
           pause(.01);
           break
        else
        plot(xee(i),yee(j),'b*');hold on   
        xlimd=[xlimd;xee(i)]; ylimd=[ylimd;yee(j)];
        end
      end
    end
end


% --- Executes on button press in co_wrk_space.
function co_wrk_space_Callback(hObject, eventdata, handles)
global xlimd ylimd
xee=-10:1:10;yee=-10:1:10;phi=5;
nn=length(xee);
initial_config;
%
set(handles.status_text,'string', '*: computing constant orientation workspace')
for i=1:nn
   for j=1:nn
      for k=1:length(phi)
        S=invtest(xee(i),yee(j),phi(k));
        if (isempty(S))
%         plot(xee(i),yee(j),'m*'); hold on
%            pause(.01);
           break
        else
        plot(xee(i),yee(j),'b*');hold on   
        xlimd=[xlimd;xee(i)]; ylimd=[ylimd;yee(j)];
        end
      end
    end
end

