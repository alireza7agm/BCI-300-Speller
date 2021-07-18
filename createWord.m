function outputWord = createWord(inputLabel,Stimulus,Method)
    Word = Stimulus(find(strcmp(inputLabel,'target')));
    if(strcmp(Method,'SC'))
        [~,Word] = threshold(Word,Method);
        codedWord(find(Word == 1)) = 'A';
        codedWord(find(Word == 2)) = 'B';
        codedWord(find(Word == 3)) = 'C';
        codedWord(find(Word == 4)) = 'D';
        codedWord(find(Word == 5)) = 'E';
        codedWord(find(Word == 6)) = 'F';
        codedWord(find(Word == 7)) = 'G';
        codedWord(find(Word == 8)) = 'H';
        codedWord(find(Word == 9)) = 'I';
        codedWord(find(Word == 10)) = 'J';
        codedWord(find(Word == 11)) = 'K';
        codedWord(find(Word == 12)) = 'L';
        codedWord(find(Word == 13)) = 'M';
        codedWord(find(Word == 14)) = 'N';
        codedWord(find(Word == 15)) = 'O';
        codedWord(find(Word == 16)) = 'P';
        codedWord(find(Word == 17)) = 'Q';
        codedWord(find(Word == 18)) = 'R';
        codedWord(find(Word == 19)) = 'S';
        codedWord(find(Word == 20)) = 'T';
        codedWord(find(Word == 21)) = 'U';
        codedWord(find(Word == 22)) = 'V';
        codedWord(find(Word == 23)) = 'W';
        codedWord(find(Word == 24)) = 'X';
        codedWord(find(Word == 25)) = 'Y';
        codedWord(find(Word == 26)) = 'Z';
        codedWord(find(Word == 27)) = '0';
        codedWord(find(Word == 28)) = '1';
        codedWord(find(Word == 29)) = '2';
        codedWord(find(Word == 30)) = '3';
        codedWord(find(Word == 31)) = '4';
        codedWord(find(Word == 32)) = '5';
        codedWord(find(Word == 33)) = '6';
        codedWord(find(Word == 34)) = '7';
        codedWord(find(Word == 35)) = '8';
        codedWord(find(Word == 36)) = '9';
        outputWord = char(codedWord);
    else
        outputWord = '';
        [Word2,~] = threshold(Word,'RC');
        for i=1:2:min(length(Word2))
            if(Word2(i) == 1)
                if(Word2(i+1) == 7)
                    outputWord = [outputWord 'A'];
                elseif(Word2(i+1) == 8)
                    outputWord = [outputWord 'G'];
                elseif(Word2(i+1) == 9)
                    outputWord = [outputWord 'M'];
                elseif(Word2(i+1) == 10)
                    outputWord = [outputWord 'S'];
                elseif(Word2(i+1) == 11)
                    outputWord = [outputWord 'Y'];
                elseif(Word2(i+1) == 12)
                    outputWord = [outputWord '4'];
                end
            elseif(Word2(i) == 2)
                if(Word2(i+1) == 7)
                    outputWord = [outputWord 'B'];
                elseif(Word2(i+1) == 8)
                    outputWord = [outputWord 'H'];
                elseif(Word2(i+1) == 9)
                    outputWord = [outputWord 'N'];
                elseif(Word2(i+1) == 10)
                    outputWord = [outputWord 'T'];
                elseif(Word2(i+1) == 11)
                    outputWord = [outputWord 'Z'];
                elseif(Word2(i+1) == 12)
                    outputWord = [outputWord '5'];
                end
            elseif(Word2(i) == 3)
               if(Word2(i+1) == 7)
                    outputWord = [outputWord 'C'];
                elseif(Word2(i+1) == 8)
                    outputWord = [outputWord 'I'];
                elseif(Word2(i+1) == 9)
                    outputWord = [outputWord 'O'];
                elseif(Word2(i+1) == 10)
                    outputWord = [outputWord 'U'];
                elseif(Word2(i+1) == 11)
                    outputWord = [outputWord '0'];
                elseif(Word2(i+1) == 12)
                    outputWord = [outputWord '6'];
                end
            elseif(Word2(i) == 4)
              if(Word2(i+1) == 7)
                    outputWord = [outputWord 'D'];
                elseif(Word2(i+1) == 8)
                    outputWord = [outputWord 'J'];
                elseif(Word2(i+1) == 9)
                    outputWord = [outputWord 'P'];
                elseif(Word2(i+1) == 10)
                    outputWord = [outputWord 'V'];
                elseif(Word2(i+1) == 11)
                    outputWord = [outputWord '1'];
                elseif(Word2(i+1) == 12)
                    outputWord = [outputWord '7'];
                end
            elseif(Word2(i) == 5)
                if(Word2(i+1) == 7)
                    outputWord = [outputWord 'E'];
                elseif(Word2(i+1) == 8)
                    outputWord = [outputWord 'K'];
                elseif(Word2(i+1) == 9)
                    outputWord = [outputWord 'Q'];
                elseif(Word2(i+1) == 10)
                    outputWord = [outputWord 'W'];
                elseif(Word2(i+1) == 11)
                    outputWord = [outputWord '2'];
                elseif(Word2(i+1) == 12)
                    outputWord = [outputWord '8'];
                end
            elseif(Word2(i) == 6)
                if(Word2(i+1) == 7)
                    outputWord = [outputWord 'F'];
                elseif(Word2(i+1) == 8)
                    outputWord = [outputWord 'L'];
                elseif(Word2(i+1) == 9)
                    outputWord = [outputWord 'R'];
                elseif(Word2(i+1) == 10)
                    outputWord = [outputWord 'X'];
                elseif(Word2(i+1) == 11)
                    outputWord = [outputWord '3'];
                elseif(Word2(i+1) == 12)
                    outputWord = [outputWord '9'];
                end
            end
        end
    end
    outputWord = outputWord(1:5);
end


function [output2 output] = threshold(inputWord,Method)
    output = [];
    output2 = [];
    if(strcmp(Method,'SC'))
        shift = 15;
    else
        shift = 30;
    end
    for i=1:floor(length(inputWord)/shift)
            [n,bin] = hist((inputWord((i-1)*shift+1:(i-1)*shift+shift)),unique(inputWord((i-1)*shift+1:(i-1)*shift+shift)));
            [~,idx] = sort(-n);
            X = bin(idx);
            if(length(X) == 1 && strcmp(Method,'SC'))
                X = [X 0];
            end
            if(strcmp(Method,'RC') == 1)
                tmp = X(1);
                X(1) = min(X(1),X(2));
                X(2) = max(tmp,X(2));
            end
            output = [output  X(1)];
            output2 = [[output2 X(1)] X(2)];
        if i == floor(length(inputWord)/shift)
            [n,bin] = hist((inputWord((i-1)*shift+shift:end)),unique(inputWord((i-1)*shift+shift:end)));
            [~,idx] = sort(-n);
            X = bin(idx);
            output = [output  X(1)];
            output2 = [[output2 X(1)] X(2)];
        end
    end
end
