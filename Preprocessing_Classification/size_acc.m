function size_acc(y, x)

rand('seed', 0);

num_data = size(y,1);
init_size = 1000;
if num_data <= init_size
    disp('Data too small');
    exit;
end

if sum(y ~= floor(y)) > 0
    disp('Not a classification problem');
    exit;
end

if max(max(abs(x))) > 1
    disp('Warning: |x|_1 > 1; you may scale data for faster training');
end

perm_ind = randperm(num_data)';

xt_perm = x';
xt_perm = xt_perm(:,perm_ind);
y_perm = y(perm_ind);

% draw a new figure
figure; hold on; 
xlabel('Size of training subsets');
ylabel('Cross validation accuracy');
set(gca(), 'xminortick', 'on')

subset_size = init_size;
sizes = []; cv_accs = [];
XposSize = sum(y==1);
XnegSize = sum(y==-1);
C0 = (XnegSize+XposSize) / XnegSize;
C1 = (XnegSize+XposSize) / XposSize;
[Ctemp, SigmaTemp] = meshgrid(-1:1:5, -9:1:0);
cv_acc = zeros(numel(Ctemp),1); 
folds = 4;
while 1,
    subset_size
    x_subset = xt_perm(:, 1:subset_size)';
    y_subset = y_perm(1:subset_size);
    for i=1:numel(Ctemp)
        cv_acc(i) = svmtrain(y_subset, x_subset, sprintf('-q -t 2 -c %f -g %f -v %d -w-1 %f -w1 %f -h 0', 2^Ctemp(i), 2^SigmaTemp(i), folds, C0, C1));
    end
    [~,idx] = max(cv_acc);
    cv_accs = [cv_accs; svmtrain(y_subset, x_subset, sprintf('-q -t 2 -c %f -g %f -v %d -w-1 %f -w1 %f -h 0', 2^Ctemp(idx), 2^SigmaTemp(idx), folds, C0, C1))];
    sizes = [sizes; subset_size];
    semilogx(sizes, cv_accs, '*-');
    
    % set y-axis (accuracy) range at the first iteration
    if subset_size == init_size
        set(gca, 'ylim', [min(cv_accs(1)-5,90), 100]);
    end

    if subset_size >= num_data
        break;
    else
        subset_size = min(floor(1.1*subset_size), num_data);
    end
    drawnow;
end

hold off
