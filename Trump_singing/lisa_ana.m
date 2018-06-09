% clear;clc;
%load align wave
[x_pit fs] = audioread('Lisa_s.wav');
[x_lyc fs] = audioread('Lisa_same_s.wav');

% clip
len = min(length(x_pit),length(x_lyc));
x_pit = x_pit(1:len);
x_lyc = x_lyc(1:len);

param.hop = 1;
param.sr = fs;
% [feat,t] = yin_f0(x_pit,param);  %get freq_tbl
% f0 = feat.f0;
% best = feat.best ;
% best_idx = find(best == 0);
% idx_exclude = 1:length(f0);
% idx_exclude(ismember(idx_exclude,best_idx))=[];
[f0,t] = yin_f0(x_pit,param);  %get freq_tbl


% f0(idx_exclude) = nan;
f0(find(f0>600)) = nan;
f0_pit = fix_f0(f0);
% plot(feat.f0);
figure
plot(f0_pit);

%%

[f0,t] = yin_f0(x_lyc,param);  %get freq_tbl


% idx_exclude = 1:length(f0);
% idx_exclude(ismember(idx_exclude,best_idx))=[];
f0(idx_exclude) = nan;
f0(find(f0>600)) = nan;
f0_lyc = fix_f0(f0,200,0.4);
