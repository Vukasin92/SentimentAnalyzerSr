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
clear ;
    load('sentimentsModel.mat');

    [ytrain, Xtrain] = libsvmread('dataTrain.txt');
    [ytest, Xtest] = libsvmread('dataTest.txt');
    
    classes = -1:2:1;

    fprintf('\nEvaluating the trained RBF SVM on a training set ...\n')

    [p1, accuracy1, dec_values1] = svmpredict(ytrain, Xtrain, model);

    [confus1,numcorrect1,precision1,recall1,F1] = getcm(ytrain, p1, classes);

    fprintf('Training confus: %f\n', confus1);
    fprintf('Training number of correct: %f\n', numcorrect1);
    fprintf('Training precision: %f\n', precision1);
    fprintf('Training recall: %f\n', recall1);
    fprintf('Training F-score: %f\n', F1);
    fprintf('Training Accuracy: %f\n', accuracy1);
    FScoreMean1 = harmmean(F1);
    fprintf('Training harmonic mean of F scores: %f\n', FScoreMean1);
    
    %% Predict on test set
    fprintf('\nEvaluating the trained RBF SVM on a test set ...\n')

    [p2, accuracy2, dec_values2] = svmpredict(ytest, Xtest, model);

    [confus2,numcorrect2,precision2,recall2,F2] = getcm(ytest, p2, classes);

    fprintf('Test confus: %f\n', confus2);
    fprintf('Test number of correct: %f\n', numcorrect2);
    fprintf('Test precision: %f\n', precision2);
    fprintf('Test recall: %f\n', recall2);
    fprintf('Test F-score: %f\n', F2);
    fprintf('Test Accuracy: %f\n', accuracy2);
    FScoreMean2 = harmmean(F2);
    fprintf('Test harmonic mean of F scores: %f\n', FScoreMean2);