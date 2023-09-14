%  Copyright (c) 2023 Dashan Dong
%  
%  Permission is hereby granted, free of charge, to any person obtaining a copy
%  of this software and associated documentation files (the "Software"), to deal
%  in the Software without restriction, including without limitation the rights
%  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
%  copies of the Software, and to permit persons to whom the Software is
%  furnished to do so, subject to the following conditions:
%  
%  The above copyright notice and this permission notice shall be included in all
%  copies or substantial portions of the Software.
%  
%  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
%  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
%  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
%  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
%  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
%  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
%  SOFTWARE.


% Main entrance of this program

%% Initialize Environment
close all;
clear;
clc;

%% Basic Parameters
% refractive index of immersed environment:
para_n_m = 1.333;
% wavelength (microns):
para_lambda = 0.415;
% pixel size of camera (microns):
para_PixelSize = 6.500;
% magnification of imaging system:
para_mag = 100 * (200/180) * (250/180);
% numerical aperture:
para_NA = 1.45;
% Conjugate term flag (Normal:1 Conjugate:-1)
para_ConjFlag = 1;
% VISA iterator time
para_VISATimes = 5;

%% Size Parameters
size_Raw = [1024, 1024];
size_Crop = [1024, 1024];
size_Spec = [512, 512];
size_Joint = [768, 768, 256];
size_CropJointZ = 128;

%% Configure Working Path
% read location of this program to 'path_program'
path_program = fileparts(mfilename('fullpath'));
% change current working directionary to 'path_program'
cd(path_program);
% adding subfolder 'subFunctions' and its subfolders to the MATLAB function searching list
% this change will discard in the reboot of MATLAB
addpath(genpath('./subFunctions/'))

%% Read Raw Data
disp('Reading Raw Data...');
[raw_Samp, raw_Back, size_Raw, para_NStack, path_Raw] = func_ReadRaw(size_Raw, pwd);

%% Pre-Process of raw data (Crop)
% crop raw images using function 'func_CropRaw'
if any(size_Crop > size_Raw)
    error('One or both crop size is too large');
elseif any(size_Crop < size_Raw)
    disp('Crop Input data...');
    [raw_Samp, raw_Back] = func_CropRaw(raw_Samp, raw_Back, size_Raw, size_Crop);
end

%% Calculation Parameters
para_SizeSpec2D = 2 * pi ./ size_Crop ./ para_PixelSize .* para_mag;
para_SizeSpec3D = [para_SizeSpec2D, min(para_SizeSpec2D)];
para_kBoundPixel = ceil((para_NA * 2 * pi / para_lambda) ./ para_SizeSpec2D);
para_kmBoundPixel = ceil((para_n_m * 2 * pi / para_lambda) ./ para_SizeSpec2D);
para_km = para_n_m * 2 * pi / para_lambda;

%% Holographic Processing
disp('Holographic Processing...');
[u_Samp_amp, u_Samp_phs, u_Back_amp, u_Back_phs, k_ScanSamp, k_ScanBack] = func_HoloProcess(raw_Samp, raw_Back, size_Spec, para_NStack, para_kBoundPixel, para_ConjFlag, para_VISATimes);
clearvars raw_Samp raw_Back;

%% Approximation
disp('Generate Field Stack...');
u_Rytov = log(u_Samp_amp ./ u_Back_amp) + 1i * (u_Samp_phs - u_Back_phs);
clearvars u_Samp_amp u_Samp_phs u_Back_amp u_Back_phs;

%% Rytov Reconstruction
disp('Rytov Reconstruction...');
% scattering potential f
f = func_RytovRec(u_Rytov, k_ScanSamp, size_Joint, para_NStack, para_kBoundPixel, para_kmBoundPixel, para_km, para_SizeSpec3D);

if size_CropJointZ < size_Joint(3)
    f = func_CropResult(f, size_CropJointZ);
end

%% convert to refractive index
deltaRI = real(para_n_m * sqrt(1 + (4 * pi) * f .* (para_lambda / (para_n_m * 2 * pi))^2)) - para_n_m;
func_SaveResult(deltaRI, 'Rytov.tif', 2 * pi ./ para_SizeSpec3D ./ size_Joint);
