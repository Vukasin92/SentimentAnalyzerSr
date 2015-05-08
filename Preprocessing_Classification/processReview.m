function word_indices = processReview(reviewBody)
%PROCESSEMAIL preprocesses a the body of an email and
%returns a list of word_indices 
%   word_indices = PROCESSEMAIL(email_contents) preprocesses 
%   the body of an email and returns a list of indices of the 
%   words contained in the email. 
%

% Load Vocabulary
vocabList = getVocabList();

% Init return value
word_indices = [];

while ~isempty(reviewBody)

       % Tokenize and also get rid of any punctuation
        [str, reviewBody] = ...
           strtok(reviewBody, ...
                  [' @$/#.-:&*+=[]?!(){},''"><;%' char(10) char(13)]);
              
            % Remove any non alphanumeric characters
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
