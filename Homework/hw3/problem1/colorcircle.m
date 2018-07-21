% Color CIRCLE - Draws a circle.
%
% Usage: colorcircle(c, r, s, n)
%
% Arguments:  c -  A 2-vector [x y] specifying the centre.
%             r -  The radius.
%             n -  Optional number of sides in the polygonal approximation.
%                  (defualt is 16 sides)
%             s -  color of the line segments to draw [r g b] in [0 1]

function colorcircle(c, r, s, nsides)

    
    if nargin == 2
	    nsides = 16;
      s = [0 0 1];
    elseif nargin == 3
      nsides = 16;
    end
    
    nsides = round(nsides);  % make sure it is an integer
    
    a = [0:pi/nsides:2*pi];
    h = line(r*cos(a)+c(1), r*sin(a)+c(2));
    set(h,'Color',s);
