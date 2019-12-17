function vinkel = mcangle(a,m1,m2,m3)
%
% 
%joint angle in m2. Between markers m1,m2,m3 along the plane spanned by 
%the three markers
%by Kristian Nymoen 2019

        
    if ischar(m1)
        m1 = find(strcmpi(a.markerName,m1));
    end

    if ischar(m2)
        m2 = find(strcmpi(a.markerName,m2));
    end
    
    if ischar(m3)
        m3 = find(strcmpi(a.markerName,m3));
    end
    
    a = mcconcatenate(a,[m1,m2,m3]);

    for k = 1:a.nFrames
    %joint angles:
        p1 = a.data(k,1:3)';
        p2 = a.data(k,4:6)';
        p3 = a.data(k,7:9)';

    vinkel(k) = atan2(norm(cross(p1-p2,p3-p2)),dot(p1-p2,p3-p2));

    end
       


end