function vocabList = getVocabList()
%GETVOCABLIST reads the fixed vocabulary list in vocab.txt and returns a
%cell array of the words
%   vocabList = GETVOCABLIST() reads the fixed vocabulary list in vocab.txt 
%   and returns a cell array of the words in vocabList.


%% Read the fixed vocabulary list
fid = fopen('vocab.txt', 'rb');

%%
%# Get file size.
fseek(fid, 0, 'eof');
fileSize = ftell(fid);
frewind(fid);
%# Read the whole file.
data = fread(fid, fileSize, 'uint8');
%# Count number of line-feeds and increase by one.
numLines = sum(data == 10) + 1;
frewind(fid);
%%
% Store all dictionary words in cell array vocab{}
n = numLines;  % Total number of words in the dictionary

% For ease of implementation, we use a struct to map the strings => integers
% In practice, you'll want to use some form of hashmap
vocabList = cell(n, 1);
for i = 1:n
    % Word Index (can ignore since it will be = i)
    fscanf(fid, '%d', 1);
    % Actual Word
    vocabList{i} = fscanf(fid, '%s', 1);
    fscanf(fid, '%d', 1);
end
fclose(fid);

end
