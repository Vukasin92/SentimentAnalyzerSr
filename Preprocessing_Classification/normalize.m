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

%% This script balances the dataset so that it contains equal number of positive and negative examples
%% Initialization
clear ; close all; clc

load('sentimentsTrain.mat');
load('sentimentsTest.mat');

lenX = size(X, 1);
lenXtest = size(Xtest, 1);
lenNeg = sum(y==-1) + sum(ytest==-1);
pos = 0;
position = 1;
newX = zeros(2*lenNeg, size(X,2));
newy = zeros(2*lenNeg, size(y,2));
for i=1:lenX
    if y(i, 1) == 1
       if (pos<lenNeg)
           pos = pos + 1;
           newX(position, :) = X(i,:);
           newy(position, :) = y(i,:);
           position = position + 1;
       end
    else
       newX(position, :) = X(i,:);
       newy(position, :) = y(i,:);
       position = position + 1;
    end
end
for i=1:lenXtest
    if y(i, 1) == 1
       if (pos<lenNeg)
           pos = pos + 1;
           newX(position, :) = X(i,:);
           newy(position, :) = y(i,:);
           position = position + 1;
       end
    else
       newX(position, :) = X(i,:);
       newy(position, :) = y(i,:);
       position = position + 1;
    end
end
clear X;
clear y;
X = newX;
y = newy;

Xnorm = newX;
ynorm = newy;

save sentimentsNormalized.mat Xnorm ynorm