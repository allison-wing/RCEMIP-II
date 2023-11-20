function [sstx,sstphi] = sst_pattern(x,lambdax,phi,tabs_s,delta_sst,lambdaphi,option)
% [sstx,sstphi] = sst_pattern(x,lx,phi,tabs_s,delta_sst,philim)
%
% Inputs
% x = array of x values (from 0+dx to Lx)
% lambdax = desired wavelength in x (same units as x)
% phi = array of latitudes (in degrees)
% tabs_s = desired mean SST
% delta_sst = desired SST range (SSTmax-SSTmin)
% lambdaphi = desired wavelength (in degrees, positive)
% option = which equation to use for CRM [protocol is option 3]
%
% Outputs
% sstx = SST as function of x
% sstphi = SST as function of latitude

%% Compute SST as function of x
Lx = x(end); %length
% sstx = tabs_s-delta_sst/2*cos(2*pi*x/lx);
if option == 1
    sstx = tabs_s+(delta_sst/2)*cos((2*pi/lambdax)*(x + lambdax - (Lx/2))); %force to center at L/2 ORIGINAL EQUATION
elseif option == 2
    sstx = tabs_s+(delta_sst/2)*cos((2*pi/lambdax)*(x + (lambdax/2))); %NEW EQUATION, lambdax must equal Lx
elseif option == 3
    sstx = tabs_s+(delta_sst/2)*cos((2*pi/Lx)*(x + (Lx/2))); %NEW EQUATION, sets wavelength to Lx=x(end), regardless of lambdax input
elseif option == 4
    sstx = tabs_s-(delta_sst/2)*cos((2*pi/Lx)*x); %EQUATION REQUIRED FOR RCEMIP-II, sets wavelength to Lx=x(end), regardless of lambdax input
end

%% Compute SST as function of latitude

sstphi = tabs_s+delta_sst/2*cosd(360*phi/lambdaphi);

