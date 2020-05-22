function x = mcperpendicularpoint(d,p,v)
% find the point along line between two markers that is closest to a third
% point. 

if length(p) == 1 %marker number is given for point
    p = d.data(:,p*3-2:p*3);
else %coordinates are given as input
    p = repmat(p,d.nFrames,1);
end

if length(v) == 2 %marker numbers are given for vector
    vp1 = d.data(:,v(1)*3-2:v(1)*3);
    vp2 = d.data(:,v(2)*3-2:v(2)*3);
else %coordinates are given as input
    vp1 = repmat(v(1:3),d.nFrames,1);
    vp2 = repmat(v(4:6),d.nFrames,1);
end

vx = vp1-vp2;
px = p-vp1;

for i = 1:d.nFrames
    x(i,:) = vx(i,:)/norm(vx(i,:))*dot(px(i,:),vx(i,:)/norm(vx(i,:))) + vp1(i,:);
end

% verify that it works:
% d2 = d;
% d2.data(:,end+1:end+3)=x;
% d2.nMarkers = d2.nMarkers+1;
% d2.markerName{end+1} = 'XTRA';
% q=rad2deg(mcangle(d2,v(1),d2.nMarkers,p));
% disp(mean(q))
% disp(std(q))

end
