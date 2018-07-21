function [Is, alpha] = stitchImages(It,varargin)
%
% Syntax:       [Is, alpha] = stitchImages(It);
%               [Is, alpha] = stitchImages(...,'dim',dim,...);
%               [Is, alpha] = stitchImages(...,'b0',b0,...);
%               [Is, alpha] = stitchImages(...,'view',view,...);
%               [Is, alpha] = stitchImages(...,'order',order,...);
%               [Is, alpha] = stitchImages(...,'mode',mode,...);
%               
% Inputs:       It is an n x 1 array of structs, where
%               
%                   It(i).image is an Nyi x Nxi x Nc uint8 image
%                   
%                   It(i).tform is the 3 x 3 transformation matrix that
%                   maps It(i).image into the coordinates specified by the 
%                   mode argument below
%               
%               [OPTIONAL] dim = [h, w] are the desired height and width,
%               respectively, in pixels, of the stitched image. By default
%               dim is set to preserve the input resolutions
%               
%               [OPTIONAL] b0 is a Nc x 1 vector of double values in
%               [0, 255] specifying the background (i.e., missing data)
%               color. The default value is b0 = 255 * ones(Nc,1)
%               
%               [OPTIONAL] view = {'left','center','right','default'}
%               specifies what view to construct the stitched image from.
%               The default is view = 'default' (world coordinates)
%               
%               [OPTIONAL] order = {'natural','reverse'} specifies the
%               order in which to overlay the stitched images. In natural
%               ordering, the closest image is displayed on top. The
%               default is order = 'natural'
%               
%               [OPTIONAL] mode = {'absolute','relative'} specifies the 
%               type of transform used. When mode = 'absolute', It(i).tform
%               should map to "world" coordinates. When mode = 'relative',
%               It(i).tform should map It(i).image into the coordinates of
%               It(i-1).image. Here, It(1).tform can be eye(3) or another
%               transformation that maps to the desired world coordinates.
%               The default value is mode = 'relative'
%               
% Outputs:      Is is a h x w x Nc uint8 matrix containing the stitched
%               image
%               
%               alpha is a h x w uint8 matrix containing the alpha channel
%               (transparency) values for generating a nice transparent png
%               of the stitched image
%               
% Author:       Brian Moore
%               brimoor@umich.edu
%               
% Date:         September 30, 2015
%

    % Parse inputs
    [Ns, Nc, dim, b0, view, order, mode] = parseInputs(It,varargin{:});
    
    % Convert to absolute coordinates, if necessary
    if strcmpi(mode,'relative')
        It = toAbsoluteCoordinates(It);
    end
    
    % Apply view
    It = applyView(It,view);
    
    % Apply order
    It = applyOrder(It,order);
    
    % Compute stitched image limits
    [It, xlim, ylim] = computeStitchedLimits(It);
    
    % Get sample points
    [x, y, w, h] = getSamplePoints(xlim,ylim,dim);
    
    % Stitch images
    Is = nan(h,w,Nc);
    for i = Ns:-1:1
        Is = overlayImage(Is,It(i),x,y);
    end
    
    % Fill background
    [Is, alpha] = fillBackground(Is,b0);
    
    % Convert to unit8
    Is = uint8(Is);

%--------------------------------------------------------------------------
function [Ns, Nc, dim, b0, view, order, mode] = parseInputs(It,varargin)
    % Parse mandatory inputs
    Ns = numel(It);
    Nc = size(It(1).image,3);
    
    % Default values
    dim = [];
    b0 = 255 * ones(Nc,1);
    view = 'default';
    order = 'natural';
    mode = 'relative';
    
    % Parse arguments
    for i = 1:2:numel(varargin)
        switch lower(varargin{i})
            case 'dim'
                dim = varargin{i + 1};
            case 'b0'
                b0 = varargin{i + 1};
            case 'view'
                view = varargin{i + 1};
            case 'order'
                order = varargin{i + 1};
            case 'mode'
                mode = varargin{i + 1};
        end
    end

%--------------------------------------------------------------------------
function It = toAbsoluteCoordinates(It)
    % Map all transforms to coordinates of It(1)
    for i = 2:numel(It)
        It(i).tform = It(i).tform * It(i - 1).tform;
    end

%--------------------------------------------------------------------------
function It = applyView(It,view)
    % Get transformed limits 
    Ns = numel(It);
    xc = zeros(Ns,1);
    for i = 1:Ns
        [xlimi, ~] = getOutputLimits(It(i).image,It(i).tform);
        xc(i) = mean(xlimi);
    end
    
    % Get ordering
    switch lower(view)
        case 'left'
            % Left view
            [~,idx] = sort(xc,'ascend');
        case 'center'
            % Center view
            [~,idx] = sort(abs(xc - mean(xc)));
        case 'right'
            % Right view
            [~,idx] = sort(xc,'descend');
        case 'default'
            % Use input ordering
            idx = 1:Ns;
        otherwise
            % Unsupported view
            error('Unsupported view "%s"',view);
    end
    
    % Apply ordering
    It = It(idx);
    if ~strcmpi(view,'default')
        H1 = It(1).tform;
        for i = 1:Ns
            It(i).tform = It(i).tform / H1;
        end
    end

%--------------------------------------------------------------------------
function It = applyOrder(It,order)
    % Apply order
    switch lower(order)
        case 'natural'
            % Natural ordering
            % Empty
        case 'reverse'
            % Reverse ordering
            It = flipud(It(:));
        otherwise
            % Unsupported order
            error('Unsupported order "%s"',order);
    end

%--------------------------------------------------------------------------
function [It, xlim, ylim] = computeStitchedLimits(It)
    % Compute limits
    minx = inf;
    maxx = -inf;
    miny = inf;
    maxy = -inf;
    for i = 1:numel(It)
        [xlimi, ylimi] = getOutputLimits(It(i).image,It(i).tform);
        It(i).xlim = xlimi;
        It(i).ylim = ylimi;
        minx = min(minx,xlimi(1));
        maxx = max(maxx,xlimi(2));
        miny = min(miny,ylimi(1));
        maxy = max(maxy,ylimi(2));
    end
    xlim = [floor(minx), ceil(maxx)];
    ylim = [floor(miny), ceil(maxy)];

%--------------------------------------------------------------------------
function [xlim, ylim] = getOutputLimits(I,H)
    % Compute limits of transformed image
    [Ny, Nx, ~] = size(I);
    X = [1 Nx Nx 1];
    Y = [1 1 Ny Ny];
    [Xt, Yt] = applyTransform(X,Y,H);
    xlim = [min(Xt), max(Xt)];
    ylim = [min(Yt), max(Yt)];

%--------------------------------------------------------------------------
function [Xt, Yt] = applyTransform(X,Y,H)
    % Apply transformation
    sz = size(X);
    n = numel(X);
    tmp = [X(:), Y(:), ones(n,1)] * H;
    Xt = reshape(tmp(:,1) ./ tmp(:,3),sz);
    Yt = reshape(tmp(:,2) ./ tmp(:,3),sz);

%--------------------------------------------------------------------------
function [X, Y] = applyInverseTransform(Xt,Yt,H)
    % Apply inverse transformation
    sz = size(Xt);
    n = numel(Xt);
    tmp = [Xt(:), Yt(:), ones(n,1)] / H;
    X = reshape(tmp(:,1) ./ tmp(:,3),sz);
    Y = reshape(tmp(:,2) ./ tmp(:,3),sz);

%--------------------------------------------------------------------------
function [x, y, w, h] = getSamplePoints(xlim,ylim,dim)
    % Get sample dimensions
    if isempty(dim)
        w = diff(xlim) + 1;
        h = diff(ylim) + 1;
    else
        w = dim(2);
        h = dim(1);
    end
    
    % Limit resolution to a reasonable value, if necessary
    MAX_PIXELS = 2000 * 2000;
    [w, h] = limitRes(w,h,MAX_PIXELS);
    
    % Compute sample points
    x = linspace(xlim(1),xlim(2),w);
    y = linspace(ylim(1),ylim(2),h);

%--------------------------------------------------------------------------
function [w, h] = limitRes(w,h,lim)
    if w * h <= lim
        % No rescaling needed
        return;
    end
    
    % Rescale to meet limit
    kappa = w / h;
    w = round(sqrt(lim * kappa));
    h = round(sqrt(lim / kappa));
    warning('Output resolution too large, rescaling to %i x %i',h,w); %#ok

%--------------------------------------------------------------------------
function Is = overlayImage(Is,It,x,y)
    % Overlay image
    Nc = size(Is,3);
    If = fillImage(It,x,y);
    mask = ~any(isnan(If),3);
    for j = 1:Nc
        Isj = Is(:,:,j);
        Ifj = If(:,:,j);
        Isj(mask) = Ifj(mask);
        Is(:,:,j) = Isj;
    end

%--------------------------------------------------------------------------
function If = fillImage(It,x,y)
    % Parse inputs
    Nc = size(It.image,3);
    w = numel(x);
    h = numel(y);
    
    % Get active coordinates
    [~, xIdx1] = find(x <= It.xlim(1),1,'last');
    [~, xIdx2] = find(x >= It.xlim(2),1,'first');
    [~, yIdx1] = find(y <= It.ylim(1),1,'last');
    [~, yIdx2] = find(y >= It.ylim(2),1,'first');
    wa = xIdx2 + 1 - xIdx1;
    ha = yIdx2 + 1 - yIdx1;
    
    % Compute inverse transformed coordinates
    [Xta, Yta] = meshgrid(x(xIdx1:xIdx2),y(yIdx1:yIdx2));
    [Xa, Ya] = applyInverseTransform(Xta,Yta,It.tform);
    
    % Compute active image
    Ia = zeros(ha,wa,Nc);
    for j = 1:Nc
        Ia(:,:,j) = interp2(double(It.image(:,:,j)),Xa,Ya);
    end
    
    % Embed into full image
    If = nan(h,w,Nc);
    If(yIdx1:yIdx2,xIdx1:xIdx2,:) = Ia;

%--------------------------------------------------------------------------
function [Is, alpha] = fillBackground(Is,b0)
    % Fill background
    Nc = size(Is,3);
    mask = any(isnan(Is),3);
    for j = 1:Nc
        Isj = Is(:,:,j);
        Isj(mask) = b0(j);
        Is(:,:,j) = Isj;
    end
    
    % Return alpha
    alpha = zeros(size(mask),'uint8');
    alpha(~mask) = 255;
