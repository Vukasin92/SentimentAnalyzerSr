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

function [C, sigma] = tuneParams(X, y, C0, C1)

C = 1;
sigma = 0.3;

[Ctemp, SigmaTemp] = meshgrid(-1:1:3, -7:1:-4);
folds = 4;
cv_acc = zeros(numel(Ctemp),1); 
for i=1:numel(Ctemp)
        fprintf('Selecting params, iteration %d\n', i);
        cv_acc(i) = svmtrain(y, X, sprintf('-t 2 -c %f -g %f -v %d -w-1 %f -w1 %f -h 0 -q', 2^Ctemp(i), 2^SigmaTemp(i), folds, C0, C1));
end
[~,idx] = max(cv_acc);
%# contour plot of paramter selection 
contour(Ctemp, SigmaTemp, reshape(cv_acc,size(Ctemp))), colorbar
hold on;
text(Ctemp(idx), SigmaTemp(idx), sprintf('Acc = %.2f %%',cv_acc(idx)), ...  
    'HorizontalAlign','left', 'VerticalAlign','top') 
hold off 
xlabel('log_2(C)'), ylabel('log_2(\gamma)'), title('Cross-Validation Accuracy') 
%# now you can train you model using best C and best sigma

C = 2^Ctemp(idx);
sigma = 2^SigmaTemp(idx);
save params.mat cv_acc



% =========================================================================

end
