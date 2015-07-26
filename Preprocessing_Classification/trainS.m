%Author: Vukasin Stefanovic, vukasin.stefanovic92@gmail.com
% This work is done as part of bachelor thesis of Vukasin Stefanovic on University
% of Belgrade, School of Electrical Engineering
%This program is free software: you can redistribute it and/or modify it under
%the terms of the GNU General Public License as published by the Free Software
%Foundation, either version 3 of the License, or (at your option) any later
%version.
%This program is distributed in the hope that it will be useful, but WITHOUT
%ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
% FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
%details.
%You should have received a copy of the GNU General Public License along with
%this program. If not, see http://www.gnu.org/licenses/.

%% Initialization
clear ; close all;
%% =========== Part 3: Train RBF SVM for Sentiment Analysis ========

% Load the Sentiment Analysis dataset
[ytrain, Xtrain] = libsvmread('dataTrain.txt');
[ytest, Xtest] = libsvmread('dataTest.txt');

fprintf('\nTraining RBF SVM (Sentiment Analysis)\n')

XposSize = sum(ytrain==1) + sum(ytest==1);
XnegSize = sum(ytrain==-1) + sum(ytest==-1);
C0 = (XnegSize+XposSize) / XnegSize;
C1 = (XnegSize+XposSize) / XposSize;
[C, sigma] = tuneParams(Xtrain, ytrain, C0, C1);
model = svmtrain(ytrain, Xtrain, sprintf('-t 2 -c %f -g %f -w-1 %f -w1 %f', C, sigma, C0, C1));
save sentimentsModel.mat model