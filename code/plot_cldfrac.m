clear all

tabs_s = [295 300 305];
colorset = [0.267004 0.004874 0.329415; 0.127568 0.566949 0.550556; 0.993248 0.906157 0.143936];
deltaSST = {'0p625' '1p25' '2p5'};
% deltaSST = {'0p625' '0p75' '1' '1p25' '1p5' '2' '2p5' '3' '5'};
% deltaSST = {'0p625' '0p75' '1' '1p25' '2p5' '5'};
dSST = [0.625 1.25 2.5];
% dSST = [0.625 0.75 1 1.25 1.5 2 2.5 3 5];
% dSST = [0.625 0.75 1 1.25 2.5 5];
linesty = {':' '--' '-'};
% linesty = {'-' '-' '-' '-' '-' '-' '-' '-' '-'};
lw = [1 1.5 2];
% lw = [0.5 1 1.5 2 2.5 3 3.5 4 4.5];

%% Read in SAM Mock Walker data
for it = 1:length(tabs_s)
    for id = 1:length(deltaSST)
        
        runid = ['MW_' num2str(tabs_s(it)) 'dT' deltaSST{id}];
        dname = ['MW\_' num2str(tabs_s(it)) 'dT' deltaSST{id}];
        dnames(it,id) = {dname};
        colorset1(it,id,:) = colorset(it,:);
        linesty1{it,id} = linesty{id};
        lw1(it,id) = lw(id);
        
%         filepath = ['/huracan/tank4/cornell/mockwalker/' runid '/NC_files/OUT_STAT/'];        
%         ncid = netcdf.open([filepath 'mockwalker_2048x128x74_3km_12s_' num2str(tabs_s(it)) 'K_' deltaSST{id} 'K.nc']);        
%         cldfrac(it,id,:,:) = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'CLD'));
        ncid = netcdf.open(['/Users/awing/Dropbox/mockwalker/data/lambda6144/SAM_CRM_' runid '_1D_cldfrac_avg.nc']);
        cldfrac(it,id,:,:) = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'cldfrac_avg'));
        time = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'time'));
        z = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'z'));
        p = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'p'));
        
    end
end

% Take average excluding first 100 days
itime = find(abs(time-100)==min(abs(time-100)));
cldfrac_avg = nanmean(cldfrac(:,:,:,itime:end),4);

clear cldfrac

%% Read in CAM6 Mock Walker data
cldfrac_avgCAM = nan(length(tabs_s),length(deltaSST),32);
timeCAM = nan(length(tabs_s),length(deltaSST),4400);
itimeCAM = nan(length(tabs_s),length(deltaSST));
for it = 1:length(tabs_s)
    for id = 1:length(deltaSST)
        file = ['./CAM/CAM6_MockW_' deltaSST{id} 'K_cos_' num2str(tabs_s(it)) '_3yr_HCF_1D_cldfrac_avg.nc'];
        if isfile(file)
            ncid = netcdf.open(file);
            timeC = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'time'));
            cf = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'cldfrac_avg'));
            pCAM(it,id,:) = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'lev'));
            
            %Take average excluding first 100 days
            itimeC = find(abs(timeC-100)==min(abs(timeC-100)));
            cldfrac_avgCAM(it,id,:) = nanmean(cf(:,itimeC:end),2);
        end
        
        
    end
end

clear cf


%% Read in SAM RCE data
%295
ncid = netcdf.open('/Users/awing/Dropbox/RCEMIP_local/var_files/large_v4/SAM-CRM_RCE_large295_cfv1-cfv2-profiles.nc');
p295 = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'pa_avg'));
cld295 = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'cfv2_avg'));

%300
ncid = netcdf.open('/Users/awing/Dropbox/RCEMIP_local/var_files/large_v4/SAM-CRM_RCE_large300_cfv1-cfv2-profiles.nc');
p300 = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'pa_avg'));
cld300 = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'cfv2_avg'));

%305
ncid = netcdf.open('/Users/awing/Dropbox/RCEMIP_local/var_files/large_v4/SAM-CRM_RCE_large305_cfv1-cfv2-profiles.nc');
p305 = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'pa_avg'));
cld305 = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'cfv2_avg'));

%% Read in CAM6 RCE data with HCF
%295
% ncid = netcdf.open('/Users/awing/Dropbox/RCEMIP_local/var_files/large_v4/CAM6-GCM_RCE_large295_cfv0-profiles.nc');
ncid = netcdf.open('/Users/awing/Dropbox/mockwalker/CAM/CAM6_RCEMIP_295_3yr_HCF_1D_cldfrac_avg.nc');
p295CAM = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'lev'));
cld295CAM = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'cldfrac_avg'));
% Take average excluding first 100 days
timeCrce = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'time'));
itimeCrce = find(abs(timeCrce-100)==min(abs(timeCrce-100)));
cld295CAM = nanmean(cld295CAM(:,itimeCrce:end),2);

%300
% ncid = netcdf.open('/Users/awing/Dropbox/RCEMIP_local/var_files/large_v4/CAM6-GCM_RCE_large300_cfv0-profiles.nc');
ncid = netcdf.open('/Users/awing/Dropbox/mockwalker/CAM/CAM6_RCEMIP_300_3yr_HCF_1D_cldfrac_avg.nc');
p300CAM = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'lev'));
cld300CAM = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'cldfrac_avg'));
% Take average excluding first 100 days
timeCrce = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'time'));
itimeCrce = find(abs(timeCrce-100)==min(abs(timeCrce-100)));
cld300CAM = nanmean(cld300CAM(:,itimeCrce:end),2);

%305
% ncid = netcdf.open('/Users/awing/Dropbox/RCEMIP_local/var_files/large_v4/CAM6-GCM_RCE_large305_cfv0-profiles.nc');
ncid = netcdf.open('/Users/awing/Dropbox/mockwalker/CAM/CAM6_RCEMIP_305_3yr_HCF_1D_cldfrac_avg.nc');
p305CAM = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'lev'));
cld305CAM = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'cldfrac_avg'));
% Take average excluding first 100 days
timeCrce = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'time'));
itimeCrce = find(abs(timeCrce-100)==min(abs(timeCrce-100)));
cld305CAM = nanmean(cld305CAM(:,itimeCrce:end),2);

%% Plot for each SST for a given dSST in each panel

% figure('Position',[100 100 1200 400]);
figure('Position',[100 100 1200 800]);
% SAM
ax1 = subplot(2,length(deltaSST)+1,1);
plot(cld295,p295,'Color',colorset1(1,1,:),'LineWidth',2,'DisplayName','295 K')
hold on
plot(cld300,p300,'Color',colorset1(2,1,:),'LineWidth',2,'DisplayName','300 K')
plot(cld305,p305,'Color',colorset1(3,1,:),'LineWidth',2,'DisplayName','305 K')
set(ax1,'FontSize',16)
set(ax1,'Ydir','reverse')
ylim(ax1,[0 1015])
xlim(ax1,[0 0.35])
title(ax1,['SAM; \DeltaSST = 0 K'])
xlabel('Cloud Fraction')
ylabel('Pressure (hPa)')
legend('location','southeast')

for id = 1:length(deltaSST)
    ax1 = subplot(2,length(deltaSST)+1,id+1);
    for it = 1:length(tabs_s)
        hold on
        plot(squeeze(cldfrac_avg(it,id,:)),p,'Color',colorset1(it,id,:),'LineWidth',2,'DisplayName',[num2str(tabs_s(it)) ' K'])
    end
    set(ax1,'FontSize',16)
    set(ax1,'Ydir','reverse')
    ylim(ax1,[0 1015])
    xlim(ax1,[0 0.35])
    title(ax1,['\DeltaSST = ' num2str(dSST(id)) ' K'])
    xlabel('Cloud Fraction')
%     ylabel('Pressure (hPa)')
%     legend('location','southeast')
    
end

% CAM
ax1 = subplot(2,length(deltaSST)+1,length(deltaSST)+2);
plot(cld295CAM,p295CAM,'Color',colorset1(1,1,:),'LineWidth',2,'DisplayName','295 K')
hold on
plot(cld300CAM,p300CAM,'Color',colorset1(2,1,:),'LineWidth',2,'DisplayName','300 K')
plot(cld305CAM,p305CAM,'Color',colorset1(3,1,:),'LineWidth',2,'DisplayName','305 K')
set(ax1,'FontSize',16)
set(ax1,'Ydir','reverse')
ylim(ax1,[0 1015])
xlim(ax1,[0 1])
title(ax1,['CAM6; \DeltaSST = 0 K'])
xlabel('Cloud Fraction')
ylabel('Pressure (hPa)')
legend('location','southeast')

for id = 1:length(deltaSST)
    ax1 = subplot(2,length(deltaSST)+1,length(deltaSST)+2+id);
    for it = 1:length(tabs_s)
        hold on
        plot(squeeze(cldfrac_avgCAM(it,id,:)),squeeze(pCAM(it,id,:)),'Color',colorset1(it,id,:),'LineWidth',2,'DisplayName',[num2str(tabs_s(it)) ' K'])
    end
    set(ax1,'FontSize',16)
    set(ax1,'Ydir','reverse')
    ylim(ax1,[0 1015])
    xlim(ax1,[0 1])
    title(ax1,['\DeltaSST = ' num2str(dSST(id)) ' K'])
    xlabel('Cloud Fraction')
%     ylabel('Pressure (hPa)')
%     legend('location','southeast')
    
end


gcfsavepdf('Fig_cldfrac_SST.pdf')

%% Plot for each dSST for a given SST in each panel
figure('Position',[100 100 1200 800]);

%SAM
ax1 = subplot(2,length(tabs_s),1);
plot(cld295,p295,'k-','LineWidth',1,'DisplayName','\DeltaSST = 0 K')
ax1 = subplot(2,length(tabs_s),2);
plot(cld300,p300,'k-','LineWidth',1,'DisplayName','\DeltaSST = 0 K')
ax1 = subplot(2,length(tabs_s),3);
plot(cld305,p305,'k-','LineWidth',1,'DisplayName','\DeltaSST = 0 K')

for it = 1:length(tabs_s)
    ax1 = subplot(2,length(tabs_s),it);
    for id = 1:length(deltaSST)
        hold on
        plot(squeeze(cldfrac_avg(it,id,:)),p,'Color',colorset1(it,id,:),'LineWidth',2,'LineStyle',linesty{id},'DisplayName',['\DeltaSST = ' num2str(dSST(id)) ' K'])
    end
    set(ax1,'FontSize',16)
    set(ax1,'Ydir','reverse')
    ylim(ax1,[0 1015])
    xlim(ax1,[0 0.4])
    title(ax1,['SAM; <SST> = ' num2str(tabs_s(it)) ' K'])
    xlabel('Cloud Fraction')
    ylabel('Pressure (hPa)')
    legend('location','northeast')
end

%CAM
ax1 = subplot(2,length(tabs_s),length(tabs_s)+1);
plot(cld295CAM,p295CAM,'k-','LineWidth',1,'DisplayName','\DeltaSST = 0 K')
ax1 = subplot(2,length(tabs_s),length(tabs_s)+2);
plot(cld300CAM,p300CAM,'k-','LineWidth',1,'DisplayName','\DeltaSST = 0 K')
ax1 = subplot(2,length(tabs_s),length(tabs_s)+3);
plot(cld305CAM,p305CAM,'k-','LineWidth',1,'DisplayName','\DeltaSST = 0 K')

for it = 1:length(tabs_s)
    ax1 = subplot(2,length(tabs_s),length(tabs_s)+it);
    for id = 1:length(deltaSST)
        hold on
        plot(squeeze(cldfrac_avgCAM(it,id,:)),squeeze(pCAM(it,id,:)),'Color',colorset1(it,id,:),'LineWidth',2,'LineStyle',linesty{id},'DisplayName',['\DeltaSST = ' num2str(dSST(id)) ' K'])
    end
    set(ax1,'FontSize',16)
    set(ax1,'Ydir','reverse')
    ylim(ax1,[0 1015])
    xlim(ax1,[0 0.4])
    title(ax1,['CAM; <SST> = ' num2str(tabs_s(it)) ' K'])
    xlabel('Cloud Fraction')
    ylabel('Pressure (hPa)')
    legend('location','southeast')
end

% gcfsavepdf('Fig_cldfrac_dSST.pdf')








