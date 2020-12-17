clc
clear
close all

piece = importdata('6k_forceCurves.csv');
piece = piece.data;
piece(isnan(piece)) = 0;

timeSeries = 0:.015625:.015625*(length(piece(1,:))-1);

for i = 1:length(piece(:,1))
   
    stroke = piece(i,:);
    peakForce(i) = max(stroke);
    impulse(i) = trapz(timeSeries,stroke);
    
end

for i = 1:length(piece(1,:))
    
     averageStroke(i) = mean(piece(:,i));
     stdevStroke(i) = std(piece(:,i));
    
end

timeSeries = 0:.015625:.015625*(length(stroke)-1);
figure(1)
hold on
title('Average Stroke Curve')
plot(timeSeries,averageStroke,'blue')
plot(timeSeries,averageStroke-stdevStroke,'black--')
plot(timeSeries,averageStroke+stdevStroke,'black--')
xlabel('Time [s]')
ylabel('Force [N]')
hold off

strokeSeries = 1:length(peakForce);

figure(2)
tiledlayout(2,1)
nexttile
hold on
title('Peak Stroke Force over piece')
scatter(strokeSeries,peakForce,'blackx')
plot(smooth(peakForce))
xlabel('Stroke [#]')
ylabel('Peak Force [N]')
hold off
nexttile
hold on
title('Stroke Impulse over Piece')
plot(impulse)
xlabel('Stroke [#]')
ylabel('Stroke Impulse [N*s]')
hold off




