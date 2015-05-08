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

function makeMat(boundary, data)
    
    len = length(data);
    vocabList = getVocabList();
    X = [];
    y = [];
    for i=1:len
        if mod(i, 100) == 0
           fprintf('%i\n', i) 
        end
       word_indices = [];
       reviewBody = data{i}.reviewBody;
       while ~isempty(reviewBody)

           % Tokenize and also get rid of any punctuation
            [str, reviewBody] = ...
               strtok(reviewBody, ...
                      [' @$/#.-:&*+=[]?!(){},''"><;%' char(10) char(13)]);

                % Remove any non alphanumeric characters
                % '_' is left, because it is used during the stemming to
                % represent some words
                str = regexprep(str, '[^a-zA-Z0-9_]', '');

                % Skip the word if it is too short
                if length(str) < 1
                   continue;
                end

            vocabLen = length(vocabList);
            % find index of word in vocab
            for j = 1:vocabLen
                str2 = vocabList{j};
                if strcmp(str, str2)==1
                    word_indices = [word_indices ; j];
                    break;
                end
            end
       end

       %transform indices into feature vector
       x = reviewFeatures(word_indices);
       X = [X  x];
       if str2num(data{i}.reviewRating) > boundary
          yi = 1;
       else
          yi = 0;
       end
       y = [y  yi];
    end

    X = X';
    y = y';
    rp = randperm(size(X, 1));
    X = X(rp,:);
    y = y(rp,:);
    
    testSize = size(X, 1)/5;
    border = round(size(X, 1)-testSize);
    sz = size(X,1);
    Xtest = X(border : sz, :);
    ytest = y(border : sz, :);

    X = X(1:border-1, :);
    y = y(1:border-1, :);

    Xtrain = X;
    ytrain = y;
    
    features_sparse_train = sparse(Xtrain);
    features_sparse_test = sparse(Xtest);
    libsvmwrite('dataTrain.txt', ytrain, features_sparse_train);
    libsvmwrite('dataTest.txt', ytest, features_sparse_test);
    
    save sentimentsTrain.mat Xtrain ytrain
    save sentimentsTest.mat Xtest ytest
end