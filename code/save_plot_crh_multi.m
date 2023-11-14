%% Compare CRH structure of Mock Walker simulations
clear all

tabs_s = [295 300 305];
colorset = [0.267004 0.004874 0.329415; 0.127568 0.566949 0.550556; 0.993248 0.906157 0.143936];
% deltaSST = {'0p625' '1p25' '2p5' '5'};
% deltaSST = {'0p625' '0p75' '1' '1p25'};
deltaSST = {'0p625' '0p75' '1' '1p25' '1p5' '2' '2p5' '3' '5'};
nproc = '128';

doplot = 0;

figure('Position',[100 100 1200 800])

%% Read in 2D data

for it = 3%1:length(tabs_s)
    for id = 1%1:length(deltaSST)
        
        runid = ['MW_' num2str(tabs_s(it)) 'dT' deltaSST{id}];
        dname = ['MW\_' num2str(tabs_s(it)) 'dT' deltaSST{id}];
        filepath = ['/huracan/tank4/cornell/mockwalker/' runid '/NC_files/OUT_2D/'];
        
        if strcmp(deltaSST{id},'0p75') || strcmp(deltaSST{id},'1') || strcmp(deltaSST{id},'2p5')
            %read from 3D-based version
            ncid = netcdf.open([filepath 'SAM_CRM_' runid '_2D_prw.nc']);
            x = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'x'));
            time = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'time'));
            pw = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'prw'));
            
            ncid = netcdf.open([filepath 'SAM_CRM_' runid '_2D_sprw.nc']);
            spw = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'sprw'));
            
        else
            
            
            %file 1
            ncid = netcdf.open([filepath 'mockwalker_2048x128x74_3km_12s_' num2str(tabs_s(it)) 'K_' deltaSST{id} 'K_' num2str(nproc) '.2Dcom_1.nc']);
            x = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'x'));
            y = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'y'));
            time = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'time'));
            spw = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'SWVP'));
            pw = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'PW'));
            
            %file 2
            file = [filepath 'mockwalker_2048x128x74_3km_12s_' num2str(tabs_s(it)) 'K_' deltaSST{id} 'K_' num2str(nproc) '.2Dcom_2.nc'];
            if isfile(file)
                ncid = netcdf.open(file);
                time = cat(1,time,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'time')));
                spw = cat(3,spw,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'SWVP')));
                pw = cat(3,pw,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'PW')));
            end
            
            %file 3
            file = [filepath 'mockwalker_2048x128x74_3km_12s_' num2str(tabs_s(it)) 'K_' deltaSST{id} 'K_' num2str(nproc) '.2Dcom_3.nc'];
            if isfile(file)
                ncid = netcdf.open(file);
                time = cat(1,time,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'time')));
                spw = cat(3,spw,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'SWVP')));
                pw = cat(3,pw,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'PW')));
            end
            
            %file 4
            file = [filepath 'mockwalker_2048x128x74_3km_12s_' num2str(tabs_s(it)) 'K_' deltaSST{id} 'K_' num2str(nproc) '.2Dcom_4.nc'];
            if isfile(file)
                ncid = netcdf.open(file);
                time = cat(1,time,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'time')));
                spw = cat(3,spw,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'SWVP')));
                pw = cat(3,pw,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'PW')));
            end
            
            %file 5
            file = [filepath 'mockwalker_2048x128x74_3km_12s_' num2str(tabs_s(it)) 'K_' deltaSST{id} 'K_' num2str(nproc) '.2Dcom_5.nc'];
            if isfile(file)
                ncid = netcdf.open(file);
                time = cat(1,time,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'time')));
                spw = cat(3,spw,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'SWVP')));
                pw = cat(3,pw,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'PW')));
            end
            
            %file 6
            file = [filepath 'mockwalker_2048x128x74_3km_12s_' num2str(tabs_s(it)) 'K_' deltaSST{id} 'K_' num2str(nproc) '.2Dcom_6.nc'];
            if isfile(file)
                ncid = netcdf.open(file);
                time = cat(1,time,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'time')));
                spw = cat(3,spw,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'SWVP')));
                pw = cat(3,pw,netcdf.getVar(ncid,netcdf.inqVarID(ncid,'PW')));
            end
        end
        
        %% calculate y-average CRH
        crh = pw./spw;
        crh_avg = squeeze(mean(crh,2));
        
        %% save
        save(['crh_avg_' num2str(tabs_s(it)) 'K_' deltaSST{id} 'K.mat'],'crh_avg','x','time')
        
        if doplot
            %% Plot y-averaged hovmuller
            
            ax1 = subplot(1,length(deltaSST),id);
            imagesc(x/1000,time,crh_avg')
            colormap(ax1,flipud(parula))
            caxis([0.05 1.0])
            colorbar
            set(ax1,'Ydir','normal')
            set(ax1,'FontSize',16)
            xlabel('X (km)')
            ylabel('Time (days)')
            ylim([0 200])
            title(dname)
        end
        
    end
end

% gcfsavepdf(['Fig_CRHhov' num2str(tabs_s(it)) '_v2.pdf'])
