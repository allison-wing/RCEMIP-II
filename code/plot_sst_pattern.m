%% Plot SST pattern for required RCEMIP-II simulations

tabs_s = [295 300 305];
colorset = [0.267004 0.004874 0.329415; 0.127568 0.566949 0.550556; 0.8784 0.7137 0.1686];
deltaSST = [0.625 1.25 2.5];
linesty = {':' '--' '-'};

%% Plot all experiments for a given domain [option 4]
x = 3:3:6000;
lambdax = 6000;
phi = -90:1:90;
lambdaphi = 54;
figure('Position',[100 100 1000 500]);
for i = 1:length(tabs_s)
    if tabs_s(i) == 300
        for j = 1:length(deltaSST)
            [sstx,sstphi] = sst_pattern(x,lambdax,phi,tabs_s(i),deltaSST(j),lambdaphi,4);
            subplot(1,2,1); hold on
            plot(x,sstx,'LineWidth',2,'LineStyle',linesty{j},'Color',colorset(i,:),'DisplayName',['<SST> = ' num2str(tabs_s(i)) '; \DeltaSST = ' num2str(deltaSST(j))])
            subplot(1,2,2); hold on
            plot(phi,sstphi,'LineWidth',2,'LineStyle',linesty{j},'Color',colorset(i,:),'DisplayName',['<SST> = ' num2str(tabs_s(i)) '; \DeltaSST = ' num2str(deltaSST(j))])
        end
    else
        j = 2;
        [sstx,sstphi] = sst_pattern(x,lambdax,phi,tabs_s(i),deltaSST(j),lambdaphi,4);
        subplot(1,2,1); hold on
        plot(x,sstx,'LineWidth',2,'LineStyle',linesty{j},'Color',colorset(i,:),'DisplayName',['<SST> = ' num2str(tabs_s(i)) '; \DeltaSST = ' num2str(deltaSST(j))])
        subplot(1,2,2); hold on
        plot(phi,sstphi,'LineWidth',2,'LineStyle',linesty{j},'Color',colorset(i,:),'DisplayName',['<SST> = ' num2str(tabs_s(i)) '; \DeltaSST = ' num2str(deltaSST(j))])
    end
end


subplot(1,2,1);
xlabel('X (km)')
ylabel('SST (K)')
legend('Location','SouthOutside')
title('(a) CRMs')
set(gca,'FontSize',16)

subplot(1,2,2);
xlabel('Latitude')
ylabel('SST (K)')
legend('Location','SouthOutside')
title('(b) GCMs')
set(gca,'FontSize',16)

sgtitle('RCEMIP-II Experiments','FontSize',16)

gcfsavepdf('Fig_MW_sst_pattern.pdf')

%% Check dSST/dx different for all domain lenghts for control experiment (300, 1.25K) [option 4]
lambdax = 6000;
phi = -90:1:90;
lambdaphi = 54;

x0 = 3:3:5832;
x1 = 3:3:5952;
x2 = 3:3:6000;
x3 = 3:3:6048;
x4 = 3:3:6144;
x5 = 3:3:6480;

[sstx5,sstphi] = sst_pattern(x5,lambdax,phi,tabs_s(2),deltaSST(2),lambdaphi,4);
[sstx4,sstphi] = sst_pattern(x4,lambdax,phi,tabs_s(2),deltaSST(2),lambdaphi,4);
[sstx3,sstphi] = sst_pattern(x3,lambdax,phi,tabs_s(2),deltaSST(2),lambdaphi,4);
[sstx2,sstphi] = sst_pattern(x2,lambdax,phi,tabs_s(2),deltaSST(2),lambdaphi,4);
[sstx1,sstphi] = sst_pattern(x1,lambdax,phi,tabs_s(2),deltaSST(2),lambdaphi,4);
[sstx0,sstphi] = sst_pattern(x0,lambdax,phi,tabs_s(2),deltaSST(2),lambdaphi,4);

dsstx5dx = (max(sstx5) - min(sstx5))/(0.5*x5(end));
dsstx4dx = (max(sstx4) - min(sstx4))/(0.5*x4(end));
dsstx3dx = (max(sstx3) - min(sstx3))/(0.5*x3(end));
dsstx2dx = (max(sstx2) - min(sstx2))/(0.5*x2(end));
dsstx1dx = (max(sstx1) - min(sstx1))/(0.5*x1(end));
dsstx0dx = (max(sstx0) - min(sstx0))/(0.5*x0(end));

[x0(end) dsstx0dx; x1(end) dsstx1dx; x2(end) dsstx2dx; x3(end) dsstx3dx; x4(end) dsstx4dx; x5(end) dsstx5dx]

%% Plot control experiment (300, 1.25K) for all domain lengths [option 1, old equation]
lambdax = 6000;
phi = -90:1:90;
lambdaphi = 54;

x0 = 0:3:5832-3;
x1 = 0:3:5952-3;
x2 = 0:3:6000-3;
x3 = 0:3:6048-3;
x4 = 0:3:6144-3;
x5 = 0:3:6480-3;

figure; hold on
[sstx5,sstphi] = sst_pattern(x5,lambdax,phi,tabs_s(2),deltaSST(2),lambdaphi,1);
plot(x5,sstx5,'LineWidth',2,'LineStyle',linesty{2},'Color',[0.466 0.674 0.188],'DisplayName',['L_x = ' num2str(x5(end)+3) 'km; <SST> = ' num2str(mean(sstx5)) 'K'])
vline(x5(sstx5==max(sstx5)),'g--')

[sstx4,sstphi] = sst_pattern(x4,lambdax,phi,tabs_s(2),deltaSST(2),lambdaphi,1);
plot(x4,sstx4,'LineWidth',2,'LineStyle',linesty{2},'Color',[0.494 0.184 0.556],'DisplayName',['L_x = ' num2str(x4(end)+3) 'km; <SST> = ' num2str(mean(sstx4)) 'K'])
vline(x4(sstx4==max(sstx4)),'m--')

[sstx3,sstphi] = sst_pattern(x3,lambdax,phi,tabs_s(2),deltaSST(2),lambdaphi,1);
plot(x3,sstx3,'LineWidth',2,'LineStyle',linesty{2},'Color',[0.929 0.694 0.125],'DisplayName',['L_x = ' num2str(x3(end)+3) 'km; <SST> = ' num2str(mean(sstx3)) 'K'])
vline(x3(sstx3==max(sstx3)),'y--')

[sstx2,sstphi] = sst_pattern(x2,lambdax,phi,tabs_s(2),deltaSST(2),lambdaphi,1);
plot(x2,sstx2,'LineWidth',2,'LineStyle',linesty{2},'Color',[0 0 0],'DisplayName',['L_x = ' num2str(x2(end)+3) 'km; <SST> = ' num2str(mean(sstx2)) 'K'])
vline(x2(sstx2==max(sstx2)),'k--')

[sstx1,sstphi] = sst_pattern(x1,lambdax,phi,tabs_s(2),deltaSST(2),lambdaphi,1);
plot(x1,sstx1,'LineWidth',2,'LineStyle',linesty{2},'Color',[0.85 0.325 0.098],'DisplayName',['L_x = ' num2str(x1(end)+3) 'km; <SST> = ' num2str(mean(sstx1)) 'K'])
vline(x1(sstx1==max(sstx1)),'r--')

[sstx0,sstphi] = sst_pattern(x0,lambdax,phi,tabs_s(2),deltaSST(2),lambdaphi,1);
plot(x0,sstx0,'LineWidth',2,'LineStyle',linesty{2},'Color',[0 0.4470 0.7410],'DisplayName',['L_x = ' num2str(x0(end)+3) 'km; <SST> = ' num2str(mean(sstx0)) 'K'])
vline(x0(sstx0==max(sstx0)),'b--')

title('$SST(x) = \langle SST\rangle + \frac{\Delta SST}{2}cos\left(\frac{2\pi}{\lambda}\left(x + \lambda-\frac{L_x}{2}\right)\right)$','Interpreter','Latex')
xlabel('X (km)')
ylabel('SST (K)')
legend('Location','Southoutside')
set(gca,'FontSize',16)
gcfsavepdf('Fig_MW_sstx_crms.pdf')


%test cusp issue
figure; hold on
plot([sstx0 sstx0(2:end)],'LineWidth',2,'LineStyle',linesty{3},'Color',[0 0.4470 0.7410],'DisplayName',['L_x = ' num2str(x0(end)+3) 'km'])
plot([sstx1 sstx1(2:end)],'LineWidth',2,'LineStyle',linesty{3},'Color',[0.85 0.325 0.098],'DisplayName',['L_x = ' num2str(x1(end)+3) 'km'])
plot([sstx2 sstx2(2:end)],'LineWidth',2,'LineStyle',linesty{3},'Color',[0 0 0],'DisplayName',['L_x = ' num2str(x2(end)+3) 'km'])
plot([sstx3 sstx3(2:end)],'LineWidth',2,'LineStyle',linesty{3},'Color',[0.929 0.694 0.125],'DisplayName',['L_x = ' num2str(x3(end)+3) 'km; SST'' = ' num2str(sstx3(end) - min(sstx3)) 'K'])
plot([sstx4 sstx4(2:end)],'LineWidth',2,'LineStyle',linesty{1},'Color',[0.494 0.184 0.556],'DisplayName',['L_x = ' num2str(x4(end)+3) 'km; SST'' = ' num2str(sstx4(end) - min(sstx4)) 'K'])
plot([sstx5 sstx5(2:end)],'LineWidth',2,'LineStyle',linesty{3},'Color',[0.466 0.674 0.188],'DisplayName',['L_x = ' num2str(x5(end)+3) 'km; SST'' = ' num2str(sstx5(end) - min(sstx5)) 'K'])
title('$SST(x) = \langle SST\rangle + \frac{\Delta SST}{2}cos\left(\frac{2\pi}{\lambda}\left(x + \lambda-\frac{L_x}{2}\right)\right)$','Interpreter','Latex')
xlabel('Index near lateral boundary of domain')
ylabel('SST (K)')
legend('Location','Eastoutside')
set(gca,'FontSize',16)
xlim([1800 2400])
ylim([299.37 299.395])
gcfsavepdf('Fig_MW_sstx_crms_cusp.pdf')

