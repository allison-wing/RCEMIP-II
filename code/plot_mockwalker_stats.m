%% Plot time evolution of domain-average statistics for SAM simulations
% Figure 6: Fig_MW_statevol_5day_300_groups.pdf
% Figure 7: Fig_MW_statevol_5day_SAMCAM.pdf
% Figure 11: Fig_MW_statevol_5day_domainsize.pdf
% parts of figures are combined/edited in Illustrator

clear all

% Set Figure Option
%1,2,3: run options 1, 2, and 3 to generate each SAM part of Fig_MW_statevol_5day_300_groups.pdf
%4: run option 4 to generate SAM part of Fig_MW_statevol_5day_SAMCAM.pdf
%5,6: run options 5 and 6 to generate Fig_MW_statevol_5day_domainsize.pdf
dofigoption = 4;

if dofigoption==1
    deltaSST = {'0p625' '0p75' '1'};
    linesty = {'-' '-' '-'};
    lw = [1 2 3];
    tabs_s = [300];
    colorset = [0.127568 0.566949 0.550556];
elseif dofigoption==2
    deltaSST = {'1p25' '1p5' '2'};
    linesty = {'-' '-' '-'};
    lw = [1 2 3];
    tabs_s = [300];
    colorset = [0.127568 0.566949 0.550556];
elseif dofigoption==3
    deltaSST = {'2p5' '3' '5'};
    linesty = {'-' '-' '-'};
    lw = [1 2 3];
    tabs_s = [300];
    colorset = [0.127568 0.566949 0.550556];
elseif dofigoption==4
    deltaSST = {'0p625' '1p25' '2p5'};
    linesty = {':' '--' '-'};
    lw = [2 2 2];
    tabs_s = [295 300 305];
    colorset = [0.267004 0.004874 0.329415; 0.127568 0.566949 0.550556; 0.8784 0.7137 0.1686];
elseif dofigoption==5
    deltaSST = {'1p25' '1p25' '1p25' '1p25'};
    linesty = {'-' '-' '-' '--'};
    lw = [1 2 3 3];
    tabs_s = [300];
    colorset = [133/255 145/255 140/255; 33/255 79/255 140/255; 136/255 96/255 140/255 231/255 79/255 140/255];
elseif dofigoption==6
    deltaSST = {'2p5' '2p5' '2p5'};
    linesty = {'-' '-' '-'};
    lw = [1 2 3];
    tabs_s = [300];
    colorset = [133/255 145/255 140/255; 33/255 79/255 140/255; 136/255 96/255 140/255 231/255];
end


%% Read in data
count = 1;
for it = 1:length(tabs_s)
    for id = 1:length(deltaSST)
        if dofigoption==5 %1.25 domain size test
            dnames(count) = {dname};
            colorset1(count,:) = colorset(id,:);
            linesty1{count} = linesty{id};
            lw1(count) = lw(id);
            filepath = ['/Users/awing/Dropbox/mockwalker/data/SAM6.11.2/lambda600/'];
            if id==1
                runid = ['MW_' num2str(tabs_s(it)) 'dT' deltaSST{id}];
                dname = ['MW\_' num2str(tabs_s(it)) 'dT' deltaSST{id}];
                ncid = netcdf.open([filepath 'mockwalker_2048x128x74_3km_12s_' num2str(tabs_s(it)) 'K_' deltaSST{id} 'K.nc']);
            elseif id==2
                runid = ['MW_' num2str(tabs_s(it)) 'dT' deltaSST{id} 'wide'];
                dname = ['MW\_' num2str(tabs_s(it)) 'dT' deltaSST{id} 'wide'];
                ncid = netcdf.open([filepath 'mockwalker_2048x256x74_3km_12s_' num2str(tabs_s(it)) 'K_' deltaSST{id} 'K.nc']);
            elseif id==3
                runid = ['MW_' num2str(tabs_s(it)) 'dT' deltaSST{id} 'long'];
                dname = ['MW\_' num2str(tabs_s(it)) 'dT' deltaSST{id} 'long'];
                ncid = netcdf.open([filepath 'mockwalker_4096x128x74_3km_12s_' num2str(tabs_s(it)) 'K_' deltaSST{id} 'K.nc']);
            elseif id==4
                runid = ['MW_' num2str(tabs_s(it)) 'dT' deltaSST{id} 'longwide'];
                dname = ['MW\_' num2str(tabs_s(it)) 'dT' deltaSST{id} 'longwide'];
                ncid = netcdf.open([filepath 'mockwalker_4096x256x74_3km_12s_' num2str(tabs_s(it)) 'K_' deltaSST{id} 'K.nc']);
            end
        elseif dofigoption==6 %2.5 domain size test
            dnames(count) = {dname};
            colorset1(count,:) = colorset(id,:);
            linesty1{count} = linesty{id};
            lw1(count) = lw(id);
            filepath = ['/Users/awing/Dropbox/mockwalker/data/SAM6.11.2/lambda600/'];
            if id==1
                runid = ['MW_' num2str(tabs_s(it)) 'dT' deltaSST{id}];
                dname = ['MW\_' num2str(tabs_s(it)) 'dT' deltaSST{id}];
                ncid = netcdf.open([filepath 'mockwalker_2048x128x74_3km_12s_' num2str(tabs_s(it)) 'K_' deltaSST{id} 'K.nc']);
            elseif id==2
                runid = ['MW_' num2str(tabs_s(it)) 'dT' deltaSST{id} 'wide'];
                dname = ['MW\_' num2str(tabs_s(it)) 'dT' deltaSST{id} 'wide'];
                ncid = netcdf.open([filepath 'mockwalker_2048x256x74_3km_12s_' num2str(tabs_s(it)) 'K_' deltaSST{id} 'K.nc']);
            elseif id==3
                runid = ['MW_' num2str(tabs_s(it)) 'dT' deltaSST{id} 'long'];
                dname = ['MW\_' num2str(tabs_s(it)) 'dT' deltaSST{id} 'long'];
                ncid = netcdf.open([filepath 'mockwalker_4096x128x74_3km_12s_' num2str(tabs_s(it)) 'K_' deltaSST{id} 'K.nc']);
            end
        elseif dofigoption ==4 %(required sims)
            runid = ['MW_' num2str(tabs_s(it)) 'dT' deltaSST{id}];
            dname = ['MW\_' num2str(tabs_s(it)) 'dT' deltaSST{id}];
            dnames(count) = {dname};
            colorset1(count,:) = colorset(it,:);
            linesty1{count} = linesty{id};
            lw1(count) = lw(id);
            filepath = ['/Users/awing/Dropbox/mockwalker/data/SAM6.11.2/lambda6144/'];
            ncid = netcdf.open([filepath 'mockwalker_2048x128x74_3km_12s_' num2str(tabs_s(it)) 'K_' deltaSST{id} 'K.nc']);
        else %1 2 or 3 (groups - deltaSST test)
            runid = ['MW_' num2str(tabs_s(it)) 'dT' deltaSST{id}];
            dname = ['MW\_' num2str(tabs_s(it)) 'dT' deltaSST{id}];
            dnames(count) = {dname};
            colorset1(count,:) = colorset(it,:);
            linesty1{count} = linesty{id};
            lw1(count) = lw(id);
            filepath = ['/Users/awing/Dropbox/mockwalker/data/SAM6.11.2/lambda600/'];
            ncid = netcdf.open([filepath 'mockwalker_2048x128x74_3km_12s_' num2str(tabs_s(it)) 'K_' deltaSST{id} 'K.nc']);
        end
        
        time = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'time'));
        OLR(count,:) = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'LWNT'));
        PW(count,:) = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'PW'));
        SWNT(count,:) = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'SWNT'));
        pr(count,:) = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'PREC'));
        
        count = count + 1;
    end
end

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
    if dofigoption==5
        title('(a) OLR, dSST = 1.25 K')
        ylim([255 280])
    elseif dofigoption==6
        title('(d) OLR, dSST = 2.5 K')
        ylim([255 280])
    else
        title('(a) SAM: OLR')
        ylim([220 305])
    end
    xlim([0 200])
    % legend('location','southeast')
    
    subplot(2,2,2)
    set(gca,'FontSize',16)
    xlabel('Time (days)')
    ylabel('W m^{-2}')
    xlim([0 200])
    if dofigoption==1
        title('(a) Weak SST Gradients: SAM')
        ylim([290 350])
    elseif dofigoption==2
        title('(b) Moderate SST Gradients: SAM')
        ylim([290 350])
    elseif dofigoption==3
        title('(c) Strong SST Gradients: SAM')
        ylim([290 350])
    elseif dofigoption==4
        title('(b) SAM: Net SW at TOA')
        ylim([320 350])
    elseif dofigoption==5
        title('(b) Net SW at TOA, dSST = 1.25K')
        ylim([325 345])
    elseif dofigoption==6
        title('(e) Net SW at TOA, dSST = 2.5 K')
        ylim([325 345])
    end
    
    % legend('location','northeast')
    
    subplot(2,2,3)
    set(gca,'FontSize',16)
    xlabel('Time (days)')
    ylabel('mm')
    if dofigoption==5
        title('(c) Precipitable Water, dSST = 1.25K')
        ylim([30 38])
    elseif dofigoption==6
        title('(f) Precipitable Water, dSST = 2.5K')
        ylim([30 38])
    else
        title('(c) SAM: Precipitable Water')
    end
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

if dofigoption==1 
    gcfsavepdf('Fig_MW_statevol_5day_SAM_300_g1.pdf')
elseif dofigoption==2 
    gcfsavepdf('Fig_MW_statevol_5day_SAM_300_g2.pdf')
elseif dofigoption==3 
    gcfsavepdf('Fig_MW_statevol_5day_SAM_300_g3.pdf')    
elseif dofigoption==4
    gcfsavepdf('Fig_MW_statevol_5day_SAM.pdf')
elseif dofigoption==5
    gcfsavepdf('Fig_MW_statevol_5day_1p25_domainsize.pdf')
elseif dofigoption==6
    gcfsavepdf('Fig_MW_statevol_5day_2p5_domainsize.pdf')
end

