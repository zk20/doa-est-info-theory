% Plots all the plots as presented in the paper
%
% Author: Aatmaram Yadav, Arpit Jangid, Jayesh Kumar Gupta, 2014.
%
% Contact: Jayesh Kumar Gupta http://rejuvyesh.com
%          Indian Institute of Technology, Kanpur, India


% o is order here
T60    = [0.15 0.30 0.50];
fs    = 44100;

% ---------------------------------------------------------------
% plot 1
for i =1:3
    L = ceil(T60(i)*fs*0.5);  
    for o = 2: 10
        [rmse_mi(o-1)] =  run(o,L,T60(i)); 
    end
    % for plotting the first graph (different orders)
    j = 2:10;
    
    color = ['b' 'g' 'r'];
    plot(j,rmse_mi,color(i));
    title ('RMSE versus order N for different values of T60');
    xlabel('Order N');
    ylabel('RMSE');
    legend('blue T60=0.15sec','green T60=0.30sec','red T60=0.50sec');
    hold on ;
end
print -dpng plot1.png
close;

% ---------------------------------------------------------------
% plot 2
clear all; 
T = [0.1:0.1:0.5];
fs = 44100;
for i = 1:5
    L = ceil(T(i)*fs*0.5);
    [rmse_mi(i), rmse_gcc(i)] =  run(10,L,T(i));
end
figure;
plot(T,rmse_mi, '--');
hold on;
plot(T,rmse_gcc./100, '-');
title ('RMSE of MI and GCC-PHAT systems for varying T60');
xlabel('RMSE');
ylabel('T60 (sec)');
legend('MI','GCC-PHAT');
print -dpng plot2.png
close;

% ---------------------------------------------------------------
% plot 3
for i = 2:10
    multiple(i-1) = 0.1*i;
end
for i = 1:2
    for k = 1:9
        L = ceil(T60(i)*fs*multiple(k));
        [rmse_mi(k), rmse_gcc(k)] =  run(10,L,T(i));
    end
    plot(multiple, rmse_mi, '--');
    hold on;
    plot(multiple, rmse_gcc./100, '-');
    title (['RMSE of MI and GCC-PHAT systems for varying L shown for T = 0:15 s ' ...
            'and T = 0:30 s']);
    xlabel('RMSE');
    ylabel('Block size L');
    legend('T60=0.30sec GCC-PHAT','T60=0.15sec info theory',['T60=0.30sec info ' ...
                        'theory'], 'T60=0.15sec GCC-PHAT')
    hold on;
end
print -dpng plot3.png
close;
