function [ digit ] = recognize( window, pred )

if nargin==1
    pred=-1;
else
    digit=pred;
end



window=imresize(window,[32 32]);
vec=reshape(window,[1024 1]);
imshow(window);
imagesc(window);

% u=unique(window','rows');
% if size(u,1)<0.5*size(u,2)
%     digit=1;
% end

d0=0;d1=0;d2=0;d3=0;d4=0;
d5=0;d6=0;d7=0;d8=0;d9=0;
if pred>=0 && pred<=9
    base=[];
    switch digit
        case 0
            load('./handwritten/d0.mat','-mat','d0');
            base=d0;
        case 1
            load('./handwritten/d1.mat','-mat','d1');
            base=d1;
        case 2
            load('./handwritten/d2.mat','-mat','d2');
            base=d2;
        case 3
            load('./handwritten/d3.mat','-mat','d3');
            base=d3;
        case 4
            load('./handwritten/d4.mat','-mat','d4');
            base=d4;
        case 5
            load('./handwritten/d5.mat','-mat','d5');
            base=d5;
        case 6
            load('./handwritten/d6.mat','-mat','d6');
            base=d6;
        case 7
            load('./handwritten/d7.mat','-mat','d7');
            base=d7;
        case 8
            load('./handwritten/d8.mat','-mat','d8');
            base=d8;
        case 9
            load('./handwritten/d9.mat','-mat','d9');
            base=d9;
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

