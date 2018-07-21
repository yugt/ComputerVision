pic=rgb2gray(imread('Lenna.png'));
T=[sqrt(3)/3 -1/3 30;1/3 sqrt(3)/3 40;0 0 1];
[x,y]=size(pic);
range=T*[1 1 1;x 1 1; 1 y 1; x y 1]';
x=int16(floor(min(range(1,:))):ceil(max(range(1,:))));
y=int16(floor(min(range(2,:))):ceil(max(range(2,:))));
im=uint8(zeros(size(x',1),size(y',1)));
for i=1:size(x',1)
    for j=1:size(y',1)
        z=T\double([x(i);y(size(y,2)-j+1);1]);
        if z(1)>1 && z(1)<size(pic,1) && z(2)>1 && z(2)<size(pic,2)
            A=double([pic(floor(z(1)),size(pic,2)-floor(z(2))+1)...
                pic(ceil(z(1)),size(pic,2)-floor(z(2))+1);
                pic(floor(z(1)),size(pic,2)-ceil(z(2))+1)...
                pic(ceil(z(1)),size(pic,2)-ceil(z(2))+1)]);
            A(1,1)=A(1,1)*(z(1)-floor(z(1))+z(2)-floor(z(2)));
            A(1,2)=A(1,2)*(ceil(z(1))-z(1)+z(2)-floor(z(2)));
            A(2,1)=A(2,1)*(z(1)-floor(z(1))+ceil(z(2))-z(2));
            A(2,2)=A(2,2)*(ceil(z(1))-z(1)+ceil(z(2))-z(2));
            % im(i,j)=pic(round(z(1)),round(size(pic,2)-z(2))+1);
            im(i,j)=uint8(round(sum(sum(A))/4));
        end
    end
end
imwrite(im,'lenal.png');