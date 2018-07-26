%% **************************************************
%
% Example 3D-FDTD code to simulate scattering
%
% v1.0 - July 2015
%
% Jonathan Sheaffer, Ben-Gurion University, Israel
% Trevor Cox, University of Salford, UK
%


clear
close
clc

%% ************************************************** 
% DEFINE SIMULATION PARAMETERS
%
roomDims = [0.03,0.03,0.12];        % Room dimensions [Lx, Ly, Lz] in meters
srcPos = [0.015,0.015,0.005];        % Source position [x,y,z] in meters 

fs=1000000;                  % Sample rate (Hz)
Courant=sqrt(1/3);             % Courant number
c=343.5;                   % Speed of sound in air
simLength = 0.05;          % how long you want to simulate(seconds).
ra = 1e-10;                % Admittance of rigid materials
dt=1/(fs);                    % (temporal) sample period

dx=c*dt/Courant;                 % (spatial) sample period

maxc = 0.03;               % caxis limits (for visualisation only)

roomDimsD = round(roomDims/dx)+2;    % Room dimensions [Nx,Ny,Nz] in nodes
srcPosD = round(srcPos/dx);          % Discrete source position

maxN = round(simLength/dt);

%% **************************************************
% DESIGN EXCITATION FUNCTION
%
% We design a simple Gaussian pulse, and pass it through a 
% DC blocking filter (to avoid exciting near zero frequency)
%
fc = 0.075;     % Cutoff frequency (normalised 0.5=nyquist)
n0 = 30;        % Initial delay (samples)
sigma=sqrt(2*log(2))/(2*pi*(fc/dt));
n=0:maxN;
srcFn=exp(-dt^2*(n-n0).^2/(2*sigma^2));
srcFn=filter([1 -1], [1 -0.995], srcFn); % DC Blocker
% srcFn = repmat(srcFn(1:50),1,10);
% srcFn = srcFn(1:500);
[x,fs_G] = audioread('M_GT.wav');
srcFn = resample( x ,fs ,fs_G); 
srcFn = 5*srcFn(1:maxN);
%% **************************************************
% ALLOCATE MATRICES
%
p = zeros([roomDimsD 3]);   % Pressure matrix (Nx x Ny x Nz x 3)
                            % Fourth dimension is discrete time
                            % (:,:,:,1) is (n+1)
                            % (:,:,:,2) is (n)
                            % (:,:,:,3) is (n-1)
                            
K = zeros(roomDimsD);       % Node classification mask
                            % 6 = air, 5 = surface, 4 = edge, 3 = corner
                           
                            
beta = ones(roomDimsD)*ra;  % Boundary admittance mask
                            % default is rigid material ("ra")
                            
% Define shift vectors
ll=2:roomDimsD(1)-1;
mm=2:roomDimsD(2)-1;
ii=2:roomDimsD(3)-1;

%% **************************************************
% DEFINE BOUNDARY CONDITIONS
%
K = getK(roomDimsD);
% Walls - absorptive
K(2,:,:)=0;         beta(2,:,:)=1;      
K(end-1,:,:)=0;     beta(end-1,:,:)=1;
K(:,2,:)=0;         beta(:,2,:)=1;
K(:,end-1,:)=0;     beta(:,end-1,:)=1; 
% floor ceil
K(:,:,2)=0;         beta(:,:,2)=1;
K(:,:,end-1)=0;     beta(:,:,end-1)=1;


% Scatterer - reflective

% K(3:end-2,3:end-2,3:end-2)=6;  % All nodes are air by default
% K =  createWall(K,30,35,2,10);
% K =  createWall(K,37,42,2,6);
% K =  createWall(K,45,50,2,8);
% K =  createWall(K,53,58,2,5);
% K =  createWall2(K,61,66,5,9);

% K =  createWall2(K,90,91,90,91);



%% **************************************************
% PREPARE SIMULATION
%

% Intermediate boundary matrix
BK = (6-K)*Courant.*beta/2;
zero_K=find(K==0);
five_K=find(K==5);

% Visualisation infrastructure
% axis equal;
%% View cross section
View_plane = {':', 25, ':'}; 
xlim([2 roomDimsD(3)-1]);
ylim([2 roomDimsD(1)-1]);

%% View longitudinal section
% View_plane = {':', ':', 25}; 
% xlim([0 roomDimsD(1)])
% ylim([0 roomDimsD(1)])
%%

bv=squeeze(K(View_plane{:})); bv(bv==6)=0;
pl = abs(p(View_plane{:},1));
h1=surface(bv); hold on;
h2=pcolor(squeeze(pl)); colormap(flipud(bone)); 
set(gca,'XAxisLocation','top','YAxisLocation','left','ydir','reverse');
hold off;
colorbar;
caxis([0 maxc]);


record = zeros(maxN,1);


shading interp;

%% **************************************************
% EXECUTE SIMULATION
%
source_range = {(srcPosD(1)-2):(srcPosD(1)+2),(srcPosD(2)-5):(srcPosD(2)+5),srcPosD(3),2};
for nn=2:maxN

    % Update the grid
    % c = dx/dt
    p(ll,mm,ii,1) = ((2-K(ll,mm,ii)*Courant^2).*p(ll,mm,ii,2) + (BK(ll,mm,ii)-1).*p(ll,mm,ii,3) ...
        + (Courant^2) * (p(ll+1,mm,ii,2) + p(ll-1,mm,ii,2) + p(ll,mm+1,ii,2) ...
        + p(ll,mm-1,ii,2) + p(ll,mm,ii+1,2) + p(ll,mm,ii-1,2))) ./ (1+BK(ll,mm,ii));

    % Enforce zero pressure at 'dead spaces' (inside objects)
    p(zero_K)=0;
%     p(five_K)=0;

    % Inject the source (soft source)
    
    p(source_range{:}) = p(source_range{:}) + srcFn(nn);
    
    
    % Shift matrices in time
    p(:,:,:,3) = p(:,:,:,2);
    p(:,:,:,2) = p(:,:,:,1);
    
    record(nn) =  p(25,25,200,2);
    % Visualise in 2D
    % Plane parallel to the floor at the source's height
    % Absolute value of pressure, linear scale
     disp(nn);
    pl = squeeze(abs(p(View_plane{:},1)));

    set(h2,'CData',pl*0.5);
    if nn==150, maxc=maxc/2; caxis([0 maxc]); end
    title(sprintf('Sample number %d out of %d\n Note that for visual clarity, the colorscale changes at nn=150.',nn,maxN));

    xlabel(['cell unit (centimeter):',num2str(100*dx)])
    drawnow;    
end