
function mcplotkeyframes(d,keyframes,keymarkers,p,timestretchvector)
% 
% plot selected keyframes from mocap recording
% 
% mcplotkeyframes(d,keyframes,keymarkers,p,timestretchvector)
%
%   d: mocap struct
%   keyframes: Selected frames to plot
%   keymarkers: selected markers to outline timeline for
%   p: animation parameter struct
%   timestretchvector: 3D-vector marking the distance to shift the animation per frame
%
%   Uses mcplot3Dframe. Please include a par3D.field in your animation
%   parameter struct. e.g. mcinitanimpar('3D')
%
%   Example:
%     load mcdemodata
%     mapar.msize = 2;
%     mapar.colors;
%     mapar.scrsize = [1000 300];
%     mapar.colors = 'wkkkk';
%     mapar.cwidth = 0.2;
%     mapar.az = 60;
%     mapar.el = 10;
%     mapar.par3D.cameraposition = [1000 10000 2000];
%     mapar.par3D.lightposition = [1000 10000 3000];
%     mapar.par3D.shadowalpha = 0;
%     mcplotkeyframes(dance2,[1,400,700,950,1100],[19,20,26,28],mapar,[6,0,0])
% 
% By Kristian Nymoen, UiO, 2020
% 

if nargin < 5
    timestretchvector = [10,0,0];
end



b = mctranslate(mctrim(d,keyframes(1),keyframes(1),'frame'),timestretchvector*keyframes(1));
p2 = p;

for i = 2:length(keyframes)
    
    [b,p2] = mcmerge(b,mctranslate(mctrim(d,keyframes(i),keyframes(i),'frame'),timestretchvector*keyframes(i)),p2,p);

end






mcplot3Dframe(b,1,p2);
hold all

for i = 1:length(keymarkers)
    
    tmp = mcgetmarker(d,keymarkers(i));
    for j = 1:keyframes(end)
        tmp.data(j,:) = tmp.data(j,:) + timestretchvector*j;
    end
    
    plot3(tmp.data(keyframes(1):keyframes(end),1),tmp.data(keyframes(1):keyframes(end),2),tmp.data(keyframes(1):keyframes(end),3),'b-')
    
end

hold off


end
