clear all

tabs_s = [295 300 305];
colorset = [0.267004 0.004874 0.329415; 0.127568 0.566949 0.550556; 0.993248 0.906157 0.143936];
deltaSST = {'0p625' '1p25' '2p5'};
% deltaSST = {'0p625' '0p75' '1' '1p25' '1p5' '2' '2p5' '3' '5'};
% deltaSST = {'0p625' '0p75' '1'};
% deltaSST = {'1p25' '1p5' '2'};
% deltaSST = {'2p5' '3' '5'};
linesty = {':' '--' '-'};
% linesty = {'-' '-' '-'};
lw = [2 2 2];
% lw = [1 2 3];


%% Read in data
count = 0;
for it = 1:length(tabs_s)
    for id = 1:length(deltaSST)
        count = count + 1;
        runid = ['CAM6_MockW_' deltaSST{id} 'K_cos_' num2str(tabs_s(it)) '_3yr_HCF_0D'];
        dname = ['MW\_' num2str(tabs_s(it)) 'dT' deltaSST{id}];
        dnames(count) = {dname};
        colorset1(count,:) = colorset(it,:);
        linesty1{count} = linesty{id};
        lw1(count) = lw(id);
        
        %         ncid = netcdf.open(['./CAM/' runid '_prw_avg.nc']);
        %         time = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'time'));
        %         prw(:,count) = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'prw_avg'));
        
        ncid = netcdf.open(['./CAM/' runid '_rlut_avg.nc']);
        time1 = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'time'));
        OLR1 = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'rlut_avg'));
        
        ncid = netcdf.open(['./CAM/' runid '_rsut_avg.nc']);
        rsut = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'rsut_avg'));
        ncid = netcdf.open(['./CAM/' runid '_rsdt_avg.nc']);
        rsdt = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'rsdt_avg'));
        SWNT1 = rsdt - rsut;
        
        %% Restrict to 200 days
        itime1 = 1;
        itime2 = find(time1==time1(itime1)+200);
        time(:,count) = time1(itime1:itime2);
        OLR(:,count) = OLR1(itime1:itime2,:);
        SWNT(:,count) = SWNT1(itime1:itime2,:);
        
    end
end


%% Plot time series of data
figure('Position',[100 100 1000 1000]);
for i = 1:count
    
    %% Take 5-day running mean
    OLRsmooth = smooth(OLR(:,i),24*5);
    SWNTsmooth = smooth(SWNT(:,i),24*5);
    timey = time(:,i);
    %     prwsmooth = smooth(prw(:,i),24*5);
    
    subplot(2,2,1)
    hold on
    plot(timey(24*5:end-24*5),OLRsmooth(24*5:end-24*5),'Color',colorset1(i,:),'LineStyle',linesty1{i},'LineWidth',lw1(i),'DisplayName',dnames{i})
    
    subplot(2,2,2)
    hold on
    plot(timey(24*5:end-24*5),SWNTsmooth(24*5:end-24*5),'Color',colorset1(i,:),'LineStyle',linesty1{i},'LineWidth',lw1(i),'DisplayName',dnames{i})
    
    %         subplot(2,2,3)
    %         hold on
    %         plot(time(24*5:end-24*5),prwsmooth(24*5:end-24*5),'Color',colorset1(i,:),'LineStyle',linesty1{i},'LineWidth',lw1(i),'DisplayName',dnames{i})
    
    %     subplot(2,2,4)
    %     hold on
    %     plot(time,pr(i,:),'Color',colorset1(i,:),'LineStyle',linesty1{i},'LineWidth',lw1(i),'DisplayName',dnames{i})
end

subplot(2,2,1)
set(gca,'FontSize',16)
xlabel('Time (days)')
ylabel('W m^{-2}')
title('(d) CAM: OLR')
ylim([230 310]) 
% ylim([245 310])
xlim([0 200])
% legend('location','southeast')

subplot(2,2,2)
set(gca,'FontSize',16)
xlabel('Time (days)')
ylabel('W m^{-2}')
title('(e) CAM: Net SW at TOA')
ylim([315 345])
% ylim([290 350])
xlim([0 200])
legend('location','northeast')

% subplot(2,2,3)
% set(gca,'FontSize',16)
% xlabel('Time (days)')
% ylabel('mm')
% title('(f) Precipitable Water')
% xlim([0 200])
% legend('location','northeast')

% subplot(2,2,4)
% set(gca,'FontSize',16)
% xlabel('Time (days)')
% ylabel('mm d^{-1}')
% title('(d) Precipitation Rate')
% xlim([0 200])
% legend('location','northeast')

%     gcfsavepdf('Fig_MW_statevol_5day_CAM.pdf')
% gcfsavepdf('Fig_MW_statevol_5day_CAM_300.pdf')



