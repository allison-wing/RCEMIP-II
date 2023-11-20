%% Compare CRH structure of Mock Walker simulations
%plot from pre-saved y-averaged CRH data
clear all

tabs_s = [295 300 305];
deltaSST = {'0p625' '0p75' '1' '1p25' '1p5' '2' '2p5' '3' '5'};
dSST = [0.625 0.75 1 1.25 1.5 2 2.5 3 5];

figure('Position',[100 100 2000 600])

%% Read in data

for it = 2%1:length(tabs_s)
    for id = 1:length(deltaSST)
        
        runid = ['MW_' num2str(tabs_s(it)) 'dT' deltaSST{id}];
        dname = ['MW\_' num2str(tabs_s(it)) 'dT' deltaSST{id}];
        
        % load data
        clearvars time x crh_avg
        load(['./data/SAM6.11.2/lambda6000/crh_avg_' num2str(tabs_s(it)) 'K_' deltaSST{id} 'K.mat'])
        
        % Plot y-averaged hovmuller
        
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
        title(['\DeltaSST = ' num2str(dSST(id)) ' K'])
        
        maxcrh1 = nanmax(crh_avg,1); 
        mincrh1 = nanmin(crh_avg,1);
        rangecrh1 = maxcrh1 - mincrh1;
        
        meancrh = nanmean(crh_avg,1);
        anomcrh = crh_avg - meancrh;
        varcrh = nanmean(anomcrh.*anomcrh,1);
        
        itime1 = find(time==75);
        maxcrh(id) = nanmean(maxcrh1(itime1:end));
        mincrh(id) = nanmean(mincrh1(itime1:end));
        rangecrh(id) = nanmean(rangecrh1(itime1:end));
        varcrhmean(id) = nanmean(varcrh(itime1:end));
        
    end
end

gcfsavepdf(['Fig_CRHhov' num2str(tabs_s(it)) '_v2.pdf'])

figure;
plot(dSST,varcrhmean,'k*-','LineWidth',2)
set(gca,'FontSize',16)
xlabel('\DeltaSST')
ylabel('CRH Variance')
title('Day 75-200 Mean')
% gcfsavepdf('Fig_varcrh.pdf')
