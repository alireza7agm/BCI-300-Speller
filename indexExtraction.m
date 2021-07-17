function  updatedSubject = indexExtraction(subject)
    % add time field to the structs for each train and test data
    % sub1
    subject.subject1.timeTest = find(subject.subject1.test(10,:) ~= 0);
    subject.subject1.timeTrain = find(subject.subject1.train(10,:) ~= 0);
    % sub2
    subject.subject2.timeTest = find(subject.subject2.test(10,:) ~= 0);
    subject.subject2.timeTrain = find(subject.subject2.train(10,:) ~= 0);
    % sub3
    subject.subject3.timeTest = find(subject.subject3.test(10,:) ~= 0);
    subject.subject3.timeTrain = find(subject.subject3.train(10,:) ~= 0);
    % sub5
    subject.subject5.timeTest = find(subject.subject5.test(10,:) ~= 0);
    subject.subject5.timeTrain = find(subject.subject5.train(10,:) ~= 0);
    % sub6
    subject.subject6.timeTest = find(subject.subject6.test(10,:) ~= 0);
    subject.subject6.timeTrain = find(subject.subject6.train(10,:) ~= 0);
    % sub7
    subject.subject7.timeTest = find(subject.subject7.test(10,:) ~= 0);
    subject.subject7.timeTrain = find(subject.subject7.train(10,:) ~= 0);
    % sub8
    subject.subject8.timeTest = find(subject.subject8.test(10,:) ~= 0);
    subject.subject8.timeTrain = find(subject.subject8.train(10,:) ~= 0);
    % sub9
    subject.subject9.timeTest = find(subject.subject9.test(10,:) ~= 0);
    subject.subject9.timeTrain = find(subject.subject9.train(10,:) ~= 0);
    
    % add target status to the structs for train data
    % target = 1; nontarget = -1
    % sub1
    subject.subject1.targetStatus = -1*ones(1,length(subject.subject1.timeTrain));
    targets = (find(subject.subject1.train(11,:) == 1));
    subject.subject1.targetStatus((find(ismember(subject.subject1.timeTrain(:),targets(:)) == 1))) = 1;
    % sub2
    subject.subject2.targetStatus = -1*ones(1,length(subject.subject2.timeTrain));
    targets = (find(subject.subject2.train(11,:) == 1));
    subject.subject2.targetStatus((find(ismember(subject.subject2.timeTrain(:),targets(:)) == 1))) = 1;
    % sub3
    subject.subject3.targetStatus = -1*ones(1,length(subject.subject3.timeTrain));
    targets = (find(subject.subject3.train(11,:) == 1));
    subject.subject3.targetStatus((find(ismember(subject.subject3.timeTrain(:),targets(:)) == 1))) = 1;
    % sub5
    subject.subject5.targetStatus = -1*ones(1,length(subject.subject5.timeTrain));
    targets = (find(subject.subject5.train(11,:) == 1));
    subject.subject5.targetStatus((find(ismember(subject.subject5.timeTrain(:),targets(:)) == 1))) = 1;
    % sub6
    subject.subject6.targetStatus = -1*ones(1,length(subject.subject6.timeTrain));
    targets = (find(subject.subject6.train(11,:) == 1));
    subject.subject6.targetStatus((find(ismember(subject.subject6.timeTrain(:),targets(:)) == 1))) = 1;
    % sub7
    subject.subject7.targetStatus = -1*ones(1,length(subject.subject7.timeTrain));
    targets = (find(subject.subject7.train(11,:) == 1));
    subject.subject7.targetStatus((find(ismember(subject.subject7.timeTrain(:),targets(:)) == 1))) = 1;
    % sub8
    subject.subject8.targetStatus = -1*ones(1,length(subject.subject8.timeTrain));
    targets = (find(subject.subject8.train(11,:) == 1));
    subject.subject8.targetStatus((find(ismember(subject.subject8.timeTrain(:),targets(:)) == 1))) = 1;
    % sub9
    subject.subject9.targetStatus = -1*ones(1,length(subject.subject9.timeTrain));
    targets = (find(subject.subject9.train(11,:) == 1));
    subject.subject9.targetStatus((find(ismember(subject.subject9.timeTrain(:),targets(:)) == 1))) = 1;
    
    updatedSubject = subject;
end

