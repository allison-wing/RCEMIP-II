%% Compare CRH structure of Mock Walker simulations
clear all

tabs_s = [295 300 305];
colorset = [0.267004 0.004874 0.329415; 0.127568 0.566949 0.550556; 0.993248 0.906157 0.143936];
deltaSST = {'0p625' '0p75' '1' '1p25' '1p5' '2' '2p5' '3' '5'};
dSST = [0.625 0.75 1 1.25 1.5 2 2.5 3 5];

figure('Position',[100 100 2000 600])

%% Read in data
for it = 2 %1:length(tabs_s)
    for id = 1:length(deltaSST)

        %% Read in 2D data
        runid = ['MW_' num2str(tabs_s(it)) 'dT' deltaSST{id}];
        dname = ['MW\_' num2str(tabs_s(it)) 'dT' deltaSST{id}];
%         fname = ['./CAM/MockWalk_humidity_' deltaSST{id} '_' num2str(tabs_s(it)) '_4longs.nc']
        fname = ['./CAM/MockWalk54_humidity_HCF_' deltaSST{id} '_' num2str(tabs_s(it)) '.nc']
        
        ncid = netcdf.open(fname);
        time = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'time'));
        lat = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'lat'));
        prw = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'prw'));
        sprw = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'sprw'));  
       
    
    %% calculate zonal-average CRH
    crh_avg = prw./sprw;
    
    %% Plot zonal-averaged hovmuller
    
    %restrict to first 200 days
    itime = find(time==200);
    
    %restrict to +/- 27
    ilat1 = find(abs(lat--27)==min(abs(lat--27)));
    ilat2 = find(abs(lat-27)==min(abs(lat-27)));
    
    ax1 = subplot(1,length(deltaSST),id);
    imagesc(lat(ilat1:ilat2),time(1:itime),crh_avg(ilat1:ilat2,1:itime)')
    colormap(ax1,flipud(parula))
    caxis([0.05 1.0])
    colorbar
    set(ax1,'Ydir','normal')
    set(ax1,'FontSize',16)
    xlabel('Latitude (degrees)')
    ylabel('Time (days)')
    title(['\DeltaSST = ' num2str(dSST(id)) ' K'])
    
    end
end

gcfsavepdf(['Fig_CRHhov' num2str(tabs_s(it)) '_CAMd200.pdf'])
