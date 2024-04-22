%% Plot structure of Mock Walker simulations
clear all

tabs_s = '300';
deltaSST = '1p25';
nproc = '128';
nx = '2048';
ny = '128';
runid = ['MW_' tabs_s 'dT' deltaSST];
dname = ['MW\_' tabs_s 'dT' deltaSST];
% runid = ['MW_' tabs_s 'dT' deltaSST 'long'];
% dname = ['MW\_' tabs_s 'dT' deltaSST 'long'];
% runid = ['MW_' tabs_s 'dT' deltaSST 'wide'];
% dname = ['MW\_' tabs_s 'dT' deltaSST 'wide'];
filepath = ['/huracan/tank4/cornell/mockwalker/SAM6.11.2-lambda6144/' runid '/NC_files/OUT_2D/'];

%% Read in 2D data

%file 1
ncid = netcdf.open([filepath 'mockwalker_' nx 'x' ny 'x74_3km_12s_' tabs_s 'K_' deltaSST 'K_' nproc '.2Dcom_1.nc']);
x = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'x'));
y = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'y'));
time = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'time'));
sst = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'SST'));
pr = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'Prec'));
w = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'W500'));
olr = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'LWNT'));

%file 2
ncid = netcdf.open([filepath 'mockwalker_' nx 'x' ny 'x74_3km_12s_' tabs_s 'K_' deltaSST 'K_' nproc '.2Dcom_2.nc']);
time = cat(1,time,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'time')));
sst = cat(3,sst,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'SST')));
pr = cat(3,pr,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'Prec')));
w = cat(3,w,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'W500')));
olr = cat(3,olr,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'LWNT')));

%file 3
ncid = netcdf.open([filepath 'mockwalker_' nx 'x' ny 'x74_3km_12s_' tabs_s 'K_' deltaSST 'K_' nproc '.2Dcom_3.nc']);
time = cat(1,time,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'time')));
sst = cat(3,sst,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'SST')));
pr = cat(3,pr,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'Prec')));
w = cat(3,w,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'W500')));
olr = cat(3,olr,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'LWNT')));

%file 4
ncid = netcdf.open([filepath 'mockwalker_' nx 'x' ny 'x74_3km_12s_' tabs_s 'K_' deltaSST 'K_' nproc '.2Dcom_4.nc']);
time = cat(1,time,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'time')));
sst = cat(3,sst,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'SST')));
pr = cat(3,pr,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'Prec')));
w = cat(3,w,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'W500')));
olr = cat(3,olr,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'LWNT')));

%file 5
ncid = netcdf.open([filepath 'mockwalker_' nx 'x' ny 'x74_3km_12s_' tabs_s 'K_' deltaSST 'K_' nproc '.2Dcom_5.nc']);
time = cat(1,time,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'time')));
sst = cat(3,sst,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'SST')));
pr = cat(3,pr,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'Prec')));
w = cat(3,w,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'W500')));
olr = cat(3,olr,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'LWNT')));

file = [filepath 'mockwalker_' nx 'x' ny 'x74_3km_12s_' tabs_s 'K_' deltaSST 'K_' nproc '.2Dcom_6.nc'];
if isfile(file)
    %file 6
    ncid = netcdf.open(file);
    time = cat(1,time,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'time')));
    sst = cat(3,sst,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'SST')));
    pr = cat(3,pr,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'Prec')));
    w = cat(3,w,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'W500')));
    olr = cat(3,olr,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'LWNT')));
end

%% Plot daily average at day 150
itime = find(time==150);
itime1 = itime - 12; %12 hours before
itime2 = itime + 12; %12 hours after
figure('Position',[100 100 1000 600])

%daily average precip
prdaily = nanmean(pr(:,:,itime1:itime2),3)
prdaily(prdaily==0)=NaN; %set zero to NaN

ax1 = subplot(4,1,1);
imagesc(x/1000,y/1000,nanmean(sst(:,:,itime1:itime2),3)')
colormap(ax1,parula)
colorbar
set(ax1,'Ydir','normal')
set(ax1,'FontSize',16)
xlabel('X (km)')
ylabel('Y (km)')
title('SST (K)')

ax2 = subplot(4,1,2);
h3=imagesc(x/1000,y/1000,prdaily');
set(h3,'AlphaData',~isnan(prdaily')) %set NaN to white
colormap(ax2,parula)
colorbar
caxis(ax2,[0 200])
set(ax2,'Ydir','normal')
set(ax2,'FontSize',16)
xlabel('X (km)')
ylabel('Y (km)')
title('Precipitation (mm/day)')

ax3 = subplot(4,1,3);
imagesc(x/1000,y/1000,nanmean(w(:,:,itime1:itime2),3)')
colormap(ax3,darkb2r(-1,1))
colorbar
set(ax3,'Ydir','normal')
set(ax3,'FontSize',16)
xlabel('X (km)')
ylabel('Y (km)')
title('w at 500 hPa (m/s)')

ax4 = subplot(4,1,4);
imagesc(x/1000,y/1000,nanmean(olr(:,:,itime1:itime2),3)')
colormap(ax4,flipud(gray))
colorbar
caxis(ax4,[160 320])
set(ax4,'Ydir','normal')
set(ax4,'FontSize',16)
xlabel('X (km)')
ylabel('Y (km)')
title('OLR (W/m^2)')

gcfsavepdf(['Fig_' runid '_day150mean.pdf'])

% %% Plot at day 50
% itime = find(time==50);
% figure('Position',[100 100 1000 600])
% 
% ax1 = subplot(4,1,1);
% imagesc(x/1000,y/1000,sst(:,:,itime)')
% colormap(ax1,parula)
% colorbar
% set(ax1,'Ydir','normal')
% set(ax1,'FontSize',16)
% xlabel('X (km)')
% ylabel('Y (km)')
% title('SST (K)')
% 
% ax2 = subplot(4,1,2);
% h3=imagesc(x/1000,y/1000,pr(:,:,itime)');
% set(h3,'AlphaData',~isnan(pr(:,:,itime)'))
% colormap(ax2,parula)
% colorbar
% set(ax2,'Ydir','normal')
% set(ax2,'FontSize',16)
% xlabel('X (km)')
% ylabel('Y (km)')
% title('Precipitation (mm/day)')
% 
% ax3 = subplot(4,1,3);
% imagesc(x/1000,y/1000,w(:,:,itime)')
% colormap(ax3,darkb2r(-2,5))
% colorbar
% set(ax3,'Ydir','normal')
% set(ax3,'FontSize',16)
% xlabel('X (km)')
% ylabel('Y (km)')
% title('w at 500 hPa (m/s)')
% 
% ax4 = subplot(4,1,4);
% imagesc(x/1000,y/1000,olr(:,:,itime)')
% colormap(ax4,flipud(gray))
% colorbar
% set(ax4,'Ydir','normal')
% set(ax4,'FontSize',16)
% xlabel('X (km)')
% ylabel('Y (km)')
% title('OLR (W/m^2)')
% 
% gcfsavepdf(['Fig_' runid '_day50.pdf'])
% 
% %% Plot at day 100
% itime = find(time==100);
% figure('Position',[100 100 1000 500])
% 
% ax1 = subplot(4,1,1);
% imagesc(x/1000,y/1000,sst(:,:,itime)')
% colormap(ax1,parula)
% colorbar
% set(ax1,'Ydir','normal')
% set(ax1,'FontSize',16)
% xlabel('X (km)')
% ylabel('Y (km)')
% title('SST (K)')
% 
% ax2 = subplot(4,1,2);
% h3=imagesc(x/1000,y/1000,pr(:,:,itime)');
% set(h3,'AlphaData',~isnan(pr(:,:,itime)'))
% colormap(ax2,parula)
% colorbar
% set(ax2,'Ydir','normal')
% set(ax2,'FontSize',16)
% xlabel('X (km)')
% ylabel('Y (km)')
% title('Precipitation (mm/day)')
% 
% ax3 = subplot(4,1,3);
% imagesc(x/1000,y/1000,w(:,:,itime)')
% colormap(ax3,darkb2r(-2,5))
% colorbar
% set(ax3,'Ydir','normal')
% set(ax3,'FontSize',16)
% xlabel('X (km)')
% ylabel('Y (km)')
% title('w at 500 hPa (m/s)')
% 
% ax4 = subplot(4,1,4);
% imagesc(x/1000,y/1000,olr(:,:,itime)')
% colormap(ax4,flipud(gray))
% colorbar
% set(ax4,'Ydir','normal')
% set(ax4,'FontSize',16)
% xlabel('X (km)')
% ylabel('Y (km)')
% title('OLR (W/m^2)')
% 
% gcfsavepdf(['Fig_' runid '_day100.pdf'])
% 
% %% Plot at day 200
% itime = find(time==200);
% figure('Position',[100 100 1000 500])
% 
% ax1 = subplot(4,1,1);
% imagesc(x/1000,y/1000,sst(:,:,itime)')
% colormap(ax1,parula)
% colorbar
% set(ax1,'Ydir','normal')
% set(ax1,'FontSize',16)
% xlabel('X (km)')
% ylabel('Y (km)')
% title('SST (K)')
% 
% ax2 = subplot(4,1,2);
% h2=imagesc(x/1000,y/1000,pr(:,:,itime)');
% set(h2,'AlphaData',~isnan(pr(:,:,itime)'))
% colormap(ax2,parula)
% colorbar
% set(ax2,'Ydir','normal')
% set(ax2,'FontSize',16)
% xlabel('X (km)')
% ylabel('Y (km)')
% title('Precipitation (mm/day)')
% 
% ax3 = subplot(4,1,3);
% imagesc(x/1000,y/1000,w(:,:,itime)')
% colormap(ax3,darkb2r(-2,5))
% colorbar
% set(ax3,'Ydir','normal')
% set(ax3,'FontSize',16)
% xlabel('X (km)')
% ylabel('Y (km)')
% title('w at 500 hPa (m/s)')
% 
% ax4 = subplot(4,1,4);
% imagesc(x/1000,y/1000,olr(:,:,itime)')
% colormap(ax4,flipud(gray))
% colorbar
% set(ax4,'Ydir','normal')
% set(ax4,'FontSize',16)
% xlabel('X (km)')
% ylabel('Y (km)')
% title('OLR (W/m^2)')
% 
% gcfsavepdf(['Fig_' runid '_day200.pdf'])
% 
% %% Plot y-averaged hovmuller
% 
% sst_avg = squeeze(mean(sst,2));
% pr_avg = squeeze(nanmean(pr,2));
% w_avg = squeeze(nanmean(w,2));
% olr_avg = squeeze(nanmean(olr,2));
% 
% figure('Position',[100 100 1000 500])
% 
% ax1 = subplot(1,4,1);
% imagesc(x/1000,time,sst_avg')
% colormap(ax1,parula)
% colorbar
% set(ax1,'Ydir','normal')
% set(ax1,'FontSize',16)
% xlabel('X (km)')
% ylabel('Time (days)')
% title('SST (K)')
% 
% ax2 = subplot(1,4,2);
% h2 = imagesc(x/1000,time,pr_avg');
% set(h2,'AlphaData',~isnan(pr_avg'))
% colormap(ax2,parula)
% colorbar
% set(ax2,'Ydir','normal')
% set(ax2,'FontSize',16)
% xlabel('X (km)')
% ylabel('Time (days)')
% title('Precipitation (mm/day)')
% 
% ax3 = subplot(1,4,3);
% imagesc(x/1000,time,w_avg')
% colormap(ax3,darkb2r(-1,1))
% colorbar
% set(ax3,'Ydir','normal')
% set(ax3,'FontSize',16)
% xlabel('X (km)')
% ylabel('Time (days)')
% title('w at 500 hPa (m/s)')
% 
% ax4 = subplot(1,4,4);
% imagesc(x/1000,time,olr_avg')
% colormap(ax4,flipud(gray))
% colorbar
% set(ax4,'Ydir','normal')
% set(ax4,'FontSize',16)
% xlabel('X (km)')
% ylabel('Time (days)')
% title('OLR (W/m^2)')
% 
% gcfsavepdf(['Fig_' runid '_hov.pdf'])
% 
% 
% 
% 
