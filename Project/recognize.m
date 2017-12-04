function [ digit ] = recognize( window, pred )

if nargin==1
    pred=-1;
else
    digit=pred;
end

imshow(window);

window=imresize(window,[32 32]);
vec=reshape(window,[1024 1]);


% u=unique(window','rows');
% if size(u,1)<0.5*size(u,2)
%     digit=1;
% end


if pred>=0 && pred<=9
    base=[];
    switch digit
        case 0
            load('./handwritten/d0.mat','-mat','base');
        case 1
            load('./handwritten/d1.mat','-mat','base');
        case 2
            load('./handwritten/d2.mat','-mat','base');
        case 3
            load('./handwritten/d3.mat','-mat','base');
        case 4
            load('./handwritten/d4.mat','-mat','base');
        case 5
            load('./handwritten/d5.mat','-mat','base');
        case 6
            load('./handwritten/d6.mat','-mat','base');
        case 7
            load('./handwritten/d7.mat','-mat','base');
        case 8
            load('./handwritten/d8.mat','-mat','base');
        case 9
            load('./handwritten/d9.mat','-mat','base');
    end

    base=[base vec];
    base=unique(base','rows','stable')'>0;

    switch digit
        case 0
            d0=base;
            save('./handwritten/d0.mat','d0','-mat');
        case 1
            d1=base;
            save('./handwritten/d1.mat','d1','-mat');
        case 2
            d2=base;
            save('./handwritten/d2.mat','d2','-mat');
        case 3
            d3=base;
            save('./handwritten/d3.mat','d3','-mat');
        case 4
            d4=base;
            save('./handwritten/d4.mat','d4','-mat');
        case 5
            d5=base;
            save('./handwritten/d5.mat','d5','-mat');
        case 6
            d6=base;
            save('./handwritten/d6.mat','d6','-mat');
        case 7
            d7=base;
            save('./handwritten/d7.mat','d7','-mat');
        case 8
            d8=base;
            save('./handwritten/d8.mat','d8','-mat');
        case 9
            d9=base;
            save('./handwritten/d9.mat','d9','-mat');
    end
end



end

