%% Plot structure of Mock Walker simulations
%Figure 2: Fig_MW_300dT1p25_day150mean.pdf
clear all

tabs_s = '300';
deltaSST = '1p25';
nproc = '128';
nx = '2048';
ny = '128';
runid = ['MW_' tabs_s 'dT' deltaSST];
filepath = ['/huracan/tank4/cornell/mockwalker/SAM6.11.2/' runid '/NC_files/OUT_2D/'];

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

pr(pr==0) = NaN;

%% Plot daily average at day 150
itime = find(time==150);
itime1 = itime - 12; %12 hours before
itime2 = itime + 12; %12 hours after
figure('Position',[100 100 1000 600])

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
h3=imagesc(x/1000,y/1000,nanmean(pr(:,:,itime1:itime2),3)');
set(h3,'AlphaData',~isnan(pr(:,:,itime)'))
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

 
