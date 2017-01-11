function drawResult(plotFn, b, stDim)

L = size(b,2);

itp = round(linspace(1,L,10)); % indexes to plot

x = b(1:stDim,:);

pointsToPlot = [x(1,:) NaN;x(2,:) NaN];

Ne = 50;% number of points in ellipse drawing
% confidence = 0.68; % draw the (1-sigma) confidence ellipse

inc= 2*pi/Ne;
phi= 0:inc:2*pi;

% get covariances
for i = itp
        
    sqrtSigma = zeros(stDim,stDim);
    
    for d = 1:stDim
        sqrtSigma(:,d) = b(d*stDim+1:(d+1)*stDim, i);
    end
    
%     Sigma = sqrtSigma*sqrtSigma;
    
    ptemp = make_ellipse(x(:,i),sqrtSigma,2, phi);%error_ellipse('C',Sigma,'mu',x(:,i),'conf',confidence,'scale',1,'N', Ne);
    pointsToPlot = [pointsToPlot ptemp];
end      
            
plotFn(pointsToPlot);

end

function p= make_ellipse(x,r,s, phi)
% make a single 2-D ellipse of s-sigmas over phi angle intervals
a= s*r*[cos(phi); sin(phi)];
p=[a(1,:)+x(1) NaN;a(2,:)+x(2) NaN];
end
