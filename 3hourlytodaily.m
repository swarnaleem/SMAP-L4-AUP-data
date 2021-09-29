p = dir('SMAP_L4_SM_aup_20150431*.h5');
    for i = 1:numel(p)
            filename = p(i).name;
            h5disp(p(i).name);
            file_id = H5F.open (filename, 'H5F_ACC_RDONLY', 'H5P_DEFAULT');
            smroot = 'Analysis_Data/sm_rootzone_analysis';
            sm_root = H5D.open (file_id, smroot);
            % Read the dataset.
            data=H5D.read (sm_root,'H5T_NATIVE_DOUBLE', 'H5S_ALL', 'H5S_ALL', 'H5P_DEFAULT');
            % Read the fill value.
            ATTRIBUTE = '_FillValue';
            attr_id = H5A.open_name (sm_root, ATTRIBUTE);
            fillvalue=H5A.read (attr_id, 'H5T_NATIVE_DOUBLE');
            % Read the valid_max.
            ATTRIBUTE = 'valid_max';
            attr_id = H5A.open_name (sm_root, ATTRIBUTE);
            valid_max = H5A.read(attr_id, 'H5ML_DEFAULT');
            % Read the valid_min.
            ATTRIBUTE = 'valid_min';
            attr_id = H5A.open_name (sm_root, ATTRIBUTE);
            valid_min = H5A.read(attr_id, 'H5ML_DEFAULT');
            % Replace the fill value with NaN.
            data(data==fillvalue) = NaN;
            % Replace the invalid range values with NaN.
            data(data < double(valid_min)) = NaN;
            data(data > double(valid_max)) = NaN;
            A = data(:,:);
            for j=i
                save(['rzsm_' num2str(j) '.mat'],'data')
            end
    end

    path = '/Volumes/SANDISK 128/SMAP/2015/2015-04';
    S = dir(fullfile(path,'rzsm*.mat')); % path - where the .mat files are saved
    N = numel(S);
    C = cell(1,N); % preallocate cell array
    for k = 1:N
        T = load(fullfile(path,S(k).name));
        C(k) = struct2cell(T);
    end
    mjoin = cat(3,C{:}); % join all of the original matrices into a 376x428x8 array
    daily_mean_150331 = mean(mjoin,3);
    save daily_mean_150431.mat
