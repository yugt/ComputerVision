function [ digit ] = recognize( window )

imshow(window);

window=imresize(window,[32 32]);
vec=reshape(window,[1024 1]);

digit=0;

u=unique(window','rows');
if size(u,1)<0.5*size(u,2)
    digit=1;
end

base=[];
switch digit
    case 0
        load('./PrintedDigitCases/d0.mat','-mat','base');
    case 1
        load('./PrintedDigitCases/d1.mat','-mat','base');
    case 2
        load('./PrintedDigitCases/d2.mat','-mat','base');
    case 3
        load('./PrintedDigitCases/d3.mat','-mat','base');
    case 4
        load('./PrintedDigitCases/d4.mat','-mat','base');
    case 5
        load('./PrintedDigitCases/d5.mat','-mat','base');
    case 6
        load('./PrintedDigitCases/d6.mat','-mat','base');
    case 7
        load('./PrintedDigitCases/d7.mat','-mat','base');
    case 8
        load('./PrintedDigitCases/d8.mat','-mat','base');
    case 9
        load('./PrintedDigitCases/d9.mat','-mat','base');
end

base=[base vec];
base=unique(base','rows','stable')'>0;

switch digit
    case 0
        save('./PrintedDigitCases/d0.mat','base','-mat');
    case 1
        save('./PrintedDigitCases/d1.mat','base','-mat');
    case 2
        save('./PrintedDigitCases/d2.mat','base','-mat');
    case 3
        save('./PrintedDigitCases/d3.mat','base','-mat');
    case 4
        save('./PrintedDigitCases/d4.mat','base','-mat');
    case 5
        save('./PrintedDigitCases/d5.mat','base','-mat');
    case 6
        save('./PrintedDigitCases/d6.mat','base','-mat');
    case 7
        save('./PrintedDigitCases/d7.mat','base','-mat');
    case 8
        save('./PrintedDigitCases/d8.mat','base','-mat');
    case 9
        save('./PrintedDigitCases/d9.mat','base','-mat');
end




end

