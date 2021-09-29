% NASA SMAP Level 4 Analysis update data releases 3 hourly data
% Each day has 8 soil moisture data for every point in earth.
% at 00:00, 03:00, 06:00, 09:00, 12:00, 15:00, 18:00, 21:00 - hrs

% Daily mean
path = '/Users/swarnalee/SMAP/trial1';
S = dir(fullfile(path,'rsm_0203_*.mat')); % path - where the .mat files are saved
N = numel(S);

C = cell(1,N); % preallocate cell array

for k = 1:N
    T = load(fullfile(path,S(k).name));
    C(k) = struct2cell(T);
end

mjoin = cat(3,C{:}); % join all of the original matrices into a 376x428x8 array
daily_mean = mean(mjoin,3);
