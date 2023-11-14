clear all

tabs_s = [295 300 305];
colorset = [0.267004 0.004874 0.329415; 0.127568 0.566949 0.550556; 0.993248 0.906157 0.143936];
deltaSST = {'0p625' '1p25' '2p5'};
% deltaSST = {'0p625' '0p75' '1' '1p25' '1p5' '2' '2p5' '3' '5'};
% deltaSST = {'0p625' '0p75' '1'};
% deltaSST = {'1p25' '1p5' '2'};
% deltaSST = {'2p5' '3' '5'};
% deltaSST= {'0p75' '1p5' '3'};
% deltaSST= {'1' '2' '3'};
linesty = {':' '--' '-'};
% linesty = {'-' '-' '-'};
% linesty = {'-' '-' '-' '-' '-' '-' '-' '-' '-'};
% lw = [0.5 1 1.5 2];
lw = [2 2 2];
% lw = [0.5 1 1.5 2 2.5 3 3.5 4 4.5];

%% Read in data
count = 1;
for it = 1:length(tabs_s)
    for id = 1:length(deltaSST)
        runid = ['MW_' num2str(tabs_s(it)) 'dT' deltaSST{id}];
        dname = ['MW\_' num2str(tabs_s(it)) 'dT' deltaSST{id}];
        % runid = ['MW_' num2str(tabs_s(it)) 'dT' deltaSST{id} 'wide'];
        % dname = ['MW\_' num2str(tabs_s(it)) 'dT' deltaSST{id} 'wide'];
        % runid = ['MW_' num2str(tabs_s(it)) 'dT' deltaSST{id} 'long'];
        % dname = ['MW\_' num2str(tabs_s(it)) 'dT' deltaSST{id} 'long'];
        % runid = ['MW_' num2str(tabs_s(it)) 'dT' deltaSST{id} 'longwide'];
        % dname = ['MW\_' num2str(tabs_s(it)) 'dT' deltaSST{id} 'longwide'];
        dnames(count) = {dname};
        colorset1(count,:) = colorset(it,:);
        linesty1{count} = linesty{id};
        lw1(count) = lw(id);
        % 	filepath = ['/huracan/tank4/cornell/mockwalker/' runid '/NC_files/OUT_STAT/'];
        filepath = ['./data/lambda6144/'];
        
        ncid = netcdf.open([filepath 'mockwalker_2048x128x74_3km_12s_' num2str(tabs_s(it)) 'K_' deltaSST{id} 'K.nc']);
        % ncid = netcdf.open([filepath 'mockwalker_2048x256x74_3km_12s_' num2str(tabs_s(it)) 'K_' deltaSST{id} 'K.nc']);
        % ncid = netcdf.open([filepath 'mockwalker_4096x128x74_3km_12s_' num2str(tabs_s(it)) 'K_' deltaSST{id} 'K.nc']);
        % ncid = netcdf.open([filepath 'mockwalker_4096x256x74_3km_12s_' num2str(tabs_s(it)) 'K_' deltaSST{id} 'K.nc']);
        time = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'time'));
        OLR(count,:) = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'LWNT'));
        PW(count,:) = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'PW'));
        SWNT(count,:) = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'SWNT'));
        pr(count,:) = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'PREC'));
        
        count = count + 1;
    end
end

%% Plot time series of baseline hourly average data
sz = size(OLR);
figure('Position',[100 100 1000 1000]);
for i = sz(1):-1:1
    
    subplot(2,2,1)
    hold on
    plot(time,OLR(i,:),'Color',colorset1(i,:),'LineStyle',linesty1{i},'LineWidth',lw1(i),'DisplayName',dnames{i})
    
    subplot(2,2,2)
    hold on
    plot(time,SWNT(i,:),'Color',colorset1(i,:),'LineStyle',linesty1{i},'LineWidth',lw1(i),'DisplayName',dnames{i})
    
    subplot(2,2,3)
    hold on
    plot(time,PW(i,:),'Color',colorset1(i,:),'LineStyle',linesty1{i},'LineWidth',lw1(i),'DisplayName',dnames{i})
    
    subplot(2,2,4)
    hold on
    plot(time,pr(i,:),'Color',colorset1(i,:),'LineStyle',linesty1{i},'LineWidth',lw1(i),'DisplayName',dnames{i})
end

subplot(2,2,1)
set(gca,'FontSize',16)
xlabel('Time (days)')
ylabel('W m^{-2}')
title('(a) OLR')
% legend('location','southeast')

subplot(2,2,2)
set(gca,'FontSize',16)
xlabel('Time (days)')
ylabel('W m^{-2}')
title('(b) Net SW at TOA')
% legend('location','northeast')

subplot(2,2,3)
set(gca,'FontSize',16)
xlabel('Time (days)')
ylabel('mm')
title('(c) Precipitable Water')
% legend('location','northeast')

subplot(2,2,4)
set(gca,'FontSize',16)
xlabel('Time (days)')
ylabel('mm d^{-1}')
title('(d) Precipitation Rate')
legend('location','northeast')

% gcfsavepdf('Fig_MW_statevol_hrly.pdf')

%% Plot time series of running daily mean data
sz = size(OLR);
figure('Position',[100 100 1000 1000]);
for i = sz(1):-1:1
    
    subplot(2,2,1)
    hold on
    plot(time(24:end-24),smooth(OLR(i,24:end-24),24),'Color',colorset1(i,:),'LineStyle',linesty1{i},'LineWidth',lw1(i),'DisplayName',dnames{i})
    
    subplot(2,2,2)
    hold on
    plot(time(24:end-24),smooth(SWNT(i,24:end-24),24),'Color',colorset1(i,:),'LineStyle',linesty1{i},'LineWidth',lw1(i),'DisplayName',dnames{i})
    
    subplot(2,2,3)
    hold on
    plot(time(24:end-24),smooth(PW(i,24:end-24),24),'Color',colorset1(i,:),'LineStyle',linesty1{i},'LineWidth',lw1(i),'DisplayName',dnames{i})
    
    subplot(2,2,4)
    hold on
    plot(time(24:end-24),smooth(pr(i,24:end-24),24),'Color',colorset1(i,:),'LineStyle',linesty1{i},'LineWidth',lw1(i),'DisplayName',dnames{i})
end

subplot(2,2,1)
set(gca,'FontSize',16)
xlabel('Time (days)')
ylabel('W m^{-2}')
title('(a) OLR')
% legend('location','southeast')

subplot(2,2,2)
set(gca,'FontSize',16)
xlabel('Time (days)')
ylabel('W m^{-2}')
title('(b) Net SW at TOA')
% legend('location','northeast')

subplot(2,2,3)
set(gca,'FontSize',16)
xlabel('Time (days)')
ylabel('mm')
title('(c) Precipitable Water')
% legend('location','northeast')

subplot(2,2,4)
set(gca,'FontSize',16)
xlabel('Time (days)')
ylabel('mm d^{-1}')
title('(d) Precipitation Rate')
legend('location','northeast')

% gcfsavepdf('Fig_MW_statevol_daily.pdf')

%% Plot time series of running 5-day mean data
sz = size(OLR);
figure('Position',[100 100 1000 1000]);
for i = sz(1):-1:1
    
    OLRsmooth = smooth(OLR(i,:),24*5);
    SWNTsmooth = smooth(SWNT(i,:),24*5);
    PWsmooth = smooth(PW(i,:),24*5);
    prsmooth = smooth(pr(i,:),24*5);
    
    subplot(2,2,1)
    hold on
    plot(time(24*5:end-24*5),OLRsmooth(24*5:end-24*5),'Color',colorset1(i,:),'LineStyle',linesty1{i},'LineWidth',lw1(i),'DisplayName',dnames{i})
    
    subplot(2,2,2)
    hold on
    plot(time(24*5:end-24*5),SWNTsmooth(24*5:end-24*5),'Color',colorset1(i,:),'LineStyle',linesty1{i},'LineWidth',lw1(i),'DisplayName',dnames{i})
    
    subplot(2,2,3)
    hold on
    plot(time(24*5:end-24*5),PWsmooth(24*5:end-24*5),'Color',colorset1(i,:),'LineStyle',linesty1{i},'LineWidth',lw1(i),'DisplayName',dnames{i})
    
    subplot(2,2,4)
    hold on
    plot(time(24*5:end-24*5),prsmooth(24*5:end-24*5),'Color',colorset1(i,:),'LineStyle',linesty1{i},'LineWidth',lw1(i),'DisplayName',dnames{i})
    
    subplot(2,2,1)
    set(gca,'FontSize',16)
    xlabel('Time (days)')
    ylabel('W m^{-2}')
    title('(a) SAM: OLR')
    % ylim([245 280])
    ylim([220 305])
    xlim([0 200])
    % legend('location','southeast')
    
    subplot(2,2,2)
    set(gca,'FontSize',16)
    xlabel('Time (days)')
    ylabel('W m^{-2}')
    title('(b) SAM: Net SW at TOA')
    ylim([320 350])
    xlim([0 200])
    % legend('location','northeast')
    
    subplot(2,2,3)
    set(gca,'FontSize',16)
    xlabel('Time (days)')
    ylabel('mm')
    title('(c) SAM: Precipitable Water')
    % ylim([29 38])
    % ylim([20 60])
    xlim([0 200])
    % legend('location','northeast')
    
    subplot(2,2,4)
    set(gca,'FontSize',16)
    xlabel('Time (days)')
    ylabel('mm d^{-1}')
    title('(d) SAM: Precipitation Rate')
    % ylim([2.5 6.5])
    xlim([0 200])
    legend('location','northeast')
    
end

% gcfsavepdf('Fig_MW_statevol_5day_300_SAM.pdf')

