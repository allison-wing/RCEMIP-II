%% Compare CRH hovmuller of Mock Walker simulations, domain size test
% read in data, calculate y-averaged CRH, write y-averaged CRH out to file
%change tabs_s to do different SST
clear all

figure('Position',[100 100 1200 800])

%% SIMULATION 1
tabs_s = '300';
deltaSST = '1p25';
nproc = '128';
nx = '2048';
ny = '128';
runid = ['MW_' tabs_s 'dT' deltaSST];
dname = ['MW\_' tabs_s 'dT' deltaSST];
filepath = ['/huracan/tank4/cornell/mockwalker/' runid '/NC_files/OUT_2D/'];

%read from standalone CRH version
ncid = netcdf.open([filepath 'SAM_CRM_' runid '_2D_CRH.nc']);
x = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'x'));
time = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'time'));
CRH = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'crh'));
netcdf.close(ncid)

crh_avg = squeeze(mean(CRH,2));

% save
save(['crh_avg_' tabs_s 'K_' deltaSST 'K.mat'],'crh_avg','x','time')

ax1 = subplot(1,4,1);
imagesc(x/1000+(2048*3)/2,time,crh_avg')
colormap(ax1,flipud(parula))
caxis([0.05 1.0])
colorbar
set(ax1,'Ydir','normal')
set(ax1,'FontSize',16)
xlabel('X (km)')
ylabel('Time (days)')
ylim([0 200])
xlim([0 12300])
title(['(a)' dname])

%% SIMULATION 2
tabs_s = '300';
deltaSST = '1p25';
nproc = '256';
nx = '2048';
ny = '256';
runtype = 'wide';
runid = ['MW_' tabs_s 'dT' deltaSST runtype];
dname = ['MW\_' tabs_s 'dT' deltaSST runtype];
filepath = ['/huracan/tank4/cornell/mockwalker/' runid '/NC_files/OUT_2D/'];

clear x time CRH
%read from standalone CRH version
ncid = netcdf.open([filepath 'SAM_CRM_' runid '_2D_CRH.nc']);
x = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'x'));
time = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'time'));
CRH = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'crh'));
netcdf.close(ncid)

crh_avg = squeeze(mean(CRH,2));

% save
save(['crh_avg_' tabs_s 'K_' deltaSST 'K' runtype '.mat'],'crh_avg','x','time')

ax2 = subplot(1,4,2);
imagesc(x/1000+(2048*3)/2,time,crh_avg')
colormap(ax2,flipud(parula))
caxis([0.05 1.0])
colorbar
set(ax2,'Ydir','normal')
set(ax2,'FontSize',16)
xlabel('X (km)')
ylabel('Time (days)')
ylim([0 200])
xlim([0 12300])
title(['(b)' dname])


%% SIMULATION 3
tabs_s = '300';
deltaSST = '1p25';
nproc = '128';
nx = '4096';
ny = '128';
runtype = 'long';
runid = ['MW_' tabs_s 'dT' deltaSST runtype];
dname = ['MW\_' tabs_s 'dT' deltaSST runtype];
filepath = ['/huracan/tank4/cornell/mockwalker/' runid '/NC_files/OUT_2D/'];

clear x time CRH
%read from 3D-based version
ncid = netcdf.open([filepath 'SAM_CRM_' runid '_2D_CRH.nc']);
x = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'x'));
time = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'time'));
CRH = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'crh'));
netcdf.close(ncid)

crh_avg = squeeze(mean(CRH,2));

% save
save(['crh_avg_' tabs_s 'K_' deltaSST 'K' runtype '.mat'],'crh_avg','x','time')

ax3 = subplot(1,4,3);
imagesc(x/1000,time,crh_avg')
colormap(ax3,flipud(parula))
caxis([0.05 1.0])
colorbar
set(ax3,'Ydir','normal')
set(ax3,'FontSize',16)
xlabel('X (km)')
ylabel('Time (days)')
ylim([0 200])
xlim([0 12300])
title(['(c)' dname])


%% SIMULATION 4
tabs_s = '300';
deltaSST = '1p25';
nproc = '256';
nx = '4096';
ny = '256';
runtype = 'longwide';
runid = ['MW_' tabs_s 'dT' deltaSST runtype];
dname = ['MW\_' tabs_s 'dT' deltaSST runtype];
filepath = ['/huracan/tank4/cornell/mockwalker/' runid '/NC_files/OUT_2D/'];

clear x time CRH
%read from 3D-based version
ncid = netcdf.open([filepath 'SAM_CRM_' runid '_2D_CRH.nc']);
x = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'x'));
time = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'time'));
CRH = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'crh'));
netcdf.close(ncid)

crh_avg = squeeze(mean(CRH,2));

% save
save(['crh_avg_' tabs_s 'K_' deltaSST 'K' runtype '.mat'],'crh_avg','x','time')

ax4 = subplot(1,4,4);
imagesc(x/1000,time,crh_avg')
colormap(ax4,flipud(parula))
caxis([0.05 1.0])
colorbar
set(ax4,'Ydir','normal')
set(ax4,'FontSize',16)
xlabel('X (km)')
ylabel('Time (days)')
ylim([0 200])
xlim([0 12300])
title(['(d)' dname])

%% Save figure
gcfsavepdf(['Fig_CRHhov_' tabs_s '_' deltaSST '_domainsize.pdf'])


