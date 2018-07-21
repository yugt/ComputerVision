function I = mydemosaic(I_gray)

% function demosaic recovers the original color image (M*N*3)
% from Bayer encoded image I_gray (M*N).
%
% EECS442, Fall 2017

%%% Implement the function here.
[M, N]=size(I_gray);

red=zeros(M,N);
green=zeros(M,N);
blue=zeros(M,N);

for i=1:M
    for j=1:N
         if mod(i,2)==0 && mod(j,2)==1
             red(i,j)=I_gray(i,j);
         elseif mod(i,2)==1 && mod(j,2)==0
             blue(i,j)=I_gray(i,j);
         else
             green(i,j)=I_gray(i,j);
         end
    end
end

for i=2:M-1
    for j=2:N-1
        if (mod(i,2)==0 && mod(j,2)==1) || (mod(i,2)==1 && mod(j,2)==0)
            green(i,j)=(green(i-1,j)+green(i+1,j)+green(i,j-1)+green(i,j+1))/4;
        end
    end
end

for j=2:N-1
    if mod(j,2)==0
        green(1,j)=(green(1,j-1)+green(1,j+1)+green(2,j))/3;
    end
end
if mod(N,2)==0
    green(1,N)=(green(1,N-1)+green(2,N))/2;
end
for i=2:M-1
    if mod(i,2)==0
        green(i,1)=(green(i-1,1)+green(i+1,1)+green(i,2))/3;
    end
end
if mod(M,2)==0
    green(M,1)=(green(M-1,1)+green(M,2))/2;
end

if mod(M+N,2)==1
    green(M,N)=(green(M-1,N)+green(M,N-1))/2;
end

for i=2:M-1
    if mod(i,2)==1
        green(i,N)=(green(i-1,N)+green(i+1,N)+green(i,N-1))/3;
    end
end
for j=2:N-1
    if mod(j,2)==0
        green(M,j)=(green(M,j-1)+green(M,j+1)+green(M-1,j))/3;
    end
end


	function x=nest(x)
	[M, N]=size(x);
	
	for i=2:M-1
		for j=2:N-1
			if mod(i,2)==0 && mod(j,2)==0
				x(i,j)=(x(i,j-1)+x(i,j+1))/2;
			elseif mod(i,2)==1 && mod(j,2)==1
				x(i,j)=(x(i-1,j)+x(i+1,j))/2;
			elseif mod(i,2)==1 && mod(j,2)==0
				x(i,j)=(x(i-1,j-1)+x(i-1,j+1)+x(i+1,j-1)+x(i+1,j+1))/4;
			end
		end
	end
	for j=1:N
		x(1,j)=x(2,j);
	end
	if mod(N,2)==0  % column N all zero
		x(1,N)=x(2,N-1);
		for i=2:M-mod(M,2)
			x(i,N)=x(i,N-1);
			if mod(i,2)==1
				x(i,1)=(x(i-1,1)+x(i+1,1))/2;
			end
		end
		if mod(M,2)==1  % row M all zero
			for j=1:N
				x(M,j)=x(M-1,j);
			end
		else  % row M half zero
			x(M,N)=x(M,N-1);
			for j=1:N-1
				if mod(j,2)==0
					x(M,j)=(x(M,j-1)+x(M,j+1))/2;
				end
			end
		end
	else  % column N half zero
		for i=2:M-mod(M,2)
			if mod(i,2)==1
				x(i,1)=(x(i-1,1)+x(i+1,1))/2;
				x(i,N)=(x(i-1,N)+x(i+1,N))/2;
			end
		end
		if mod(M,2)==1 % row M all zero
			for j=1:N
				x(M,j)=x(M-1,j);
			end
		else % row M half zero
			for j=1:N-1
				if mod(j,2)==0
					x(M,j)=(x(M,j-1)+x(M,j+1))/2;
				end
			end
		end
	end
	end

red=nest(red);
blue=nest(blue');
blue=blue';

I(:,:,1)=red/255;
I(:,:,2)=green/255;
I(:,:,3)=blue/255;

end
%%%