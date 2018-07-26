clc;clear;
%%%%%% PARAMETERS %%%%%%%%%%%%%%

dx=0.01; % grid increment
decay = 1.0;
img= imread('O2.bmp');
img = flipdim(img,1);
Nx=size(img,2); % No of grids in x direction
Ny=size(img,1); % No of grids in y direction
r=img(:,:,1); 
g=img(:,:,2); 
b=img(:,:,3); 

wall = find((b-(r/2)-(g/2))' == 255);
listener =  find((g-(r/2)-(b/2))' == 255);
src =  find((r-(g/2)-(b/2))' == 255);

%%%%%%% SOURCE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (CFL) condition : 1D c*dt/dx < =1  2D c*dt/dx < =1/sqrt(2)
SRCNX = Nx/ 2 ; %source position
SRCNY = Ny/ 2 ; %source position
T = 5000; % total time
f = 4 ; % frequency of source
t0 = 0.15 ; % source term
% srcFn  = ricker( f,(1:T)*.002,t0);
% srcFn = repmat(srcFn(1:250),1,10);
load('gt_pulse.mat');
srcFn = longgn;
% srcFn(33:end) = 0;
%%%%%%%%%% MODEL %%%%%%%%%%%%%%%%%%%%%%%%%%%%
c = 340; % velocity
dt =dx/(c*sqrt(2)); % time increment
r = 1.225; % density
const1 = ( r *( c ^2) /dx ) ; % constant used in time updation
const2 = (1/( dx* r)); % constant used in time updation

%%%%%%%%%%%%% FIELD VARIABLES %%%%%%%%%%%%%%%
px0 = zeros(Nx,Ny) ; px2 = zeros(Nx,Ny) ;
py0 = zeros(Nx,Ny) ; py2 = zeros(Nx,Ny) ; 
p = zeros(Nx,Ny) ;
vx0 = zeros(Nx,Ny) ; vx2 = zeros(Nx,Ny) ; 
vy0 = zeros(Nx,Ny) ; vy2 = zeros(Nx,Ny) ; 

%%%%%%%%%%%%%% PML boundary conditions %%%%%%
d0 =1/(dx*c*dt); % maximum value of damping
% d0 = 15;
nPML = 12 ; % width of PML in terms of nodes

ox = zeros(Nx, 1 ) ; %initialize ar ray for damping
% ox(1 :nPML) = d0 * (((nPML:-1:1) /nPML).^2 ) ; %Assign damping
ox((Nx-(nPML-1) ) :Nx) = d0*(((1:nPML)/nPML)).^2 ; %Assign damping

oy = zeros(1,Ny) ; %initialize array for damping
oy( 1 :nPML) = d0 * (((nPML:-1:1) /nPML) ).^2 ; %Assign damping
oy((Ny-(nPML-1) ) :Ny) = d0 * (((1:nPML)/nPML) ).^2 ;%Assign damping

 %%%%%%%%%%%% TIME UPDATING %%%%%%%%%%%%%%%%%

%prepare plot
bv=p; bv(wall)=5;
h1=surface(bv'); hold on;
h2=pcolor(abs(bv')); colormap(flipud(bone)); hold off;
colorbar;
caxis([0 0.05]);
xlabel(['CellSize(' num2str(dx) 'm)']) ; ylabel(['CellSize(' num2str(dx) 'm)'])
shading interp;


record = zeros(T,1);
 for k = 1:T
     %insert source 
%      px0(SRCNX,SRCNY) = px0(SRCNX,SRCNY) +srcFn(k);
%      py0(SRCNX,SRCNY) = py0(SRCNX,SRCNY) +srcFn(k);
     px0(src) = px0(src) +srcFn(k);
     py0(src) = py0(src) +srcFn(k);
     for i =2:Nx-1
         for j =2:Ny-1
           %const1 = ( r *( c ^2) /dx ) ; 
             px2 (i,j) = dt/(1+ ox(i,1)*dt)*...
                  ((px0 (i,j)*( 1/ (dt)))+(const1*( vx0 (i+1,j)-vx0 (i,j))));
             py2 (i,j) = dt/(1+oy(1,j)*dt)* ((py0 (i,j)...
                *( 1/dt))+(const1*( vy0 (i,j+1)-vy0 (i,j))));
            
            p(i,j) = (px2 (i,j)+py2 (i,j))*0.99 ;
            
            p(wall) = 0;
            % const2 = (1/( dx* r));
             vx2 (i,j) = dt /(1+ox(i,1)*dt)*...
                 ((vx0 (i,j)*( 1/ dt))+(const2 *(p(i,j)-p(i-1, j))))*decay;
             vy2 (i,j) = ( dt  /(1+oy(1,j)*dt))* ...
                 ((vy0(i,j)*( 1/dt))+(const2 *(p(i,j)-p(i,j-1))))*decay;
             vx2(wall)  = 0;
             vy2(wall)  = 0;
             
         end
     end
    record(k) = p(listener);
     px0 = px2 ;
     py0 = py2 ;
     vx0 = vx2 ;
     vy0 = vy2 ;
     %%
    %comment below to hidde plote 
     set(h2,'CData',abs(p')); 
     title(sprintf('Sample number %d / %d',k,T));
     drawnow; 
    disp(k);
 end