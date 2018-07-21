function labelPoints(xy,str)
%
% Syntax:       labelPoints(xy,str);
%               
% Inputs:       xy is an n x 2 matrix of (x,y) coordinates at which to add
%               labels
%               
%               [OPTIONAL] str is a label to display at each point. The
%               default value is str = '+'
%

% Parse inputs
if ~exist('str','var') || isempty(str)
    % Default label
    str = '+';
end

% Add labels
text(xy(:,1),xy(:,2),str, ...
                    'Color','r', ...
                    'HorizontalAlignment','center', ...
                    'VerticalAlignment','middle');
