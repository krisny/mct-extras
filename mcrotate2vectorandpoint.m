function d2 = mcrotate2vectorandpoint(d,p,v)
% rotate a mc struct to a plane panned by three points, centered in the
% point x along the vector v that creates a perpendicular vector [x,p] on v
%

dxpoint = mcperpendicularpoint(d,p,v);

d2 = mctranslate(d,-dxpoint);
%now, its translated to point x

e1 = d2.data(:,p*3-2:p*3);
e2 = d2.data(:,v(1)*3-2:v(1)*3);
e3 = cross(e1,e2);

for i = 1:d.nFrames
    
    e1n = e1(i,:)/norm(e1(i,:));
    e2n = e2(i,:)/norm(e2(i,:));
    e3n = e3(i,:)/norm(e3(i,:));
    
    R=[e3n;e1n;e2n];
    
    d2.data(i,:) = reshape(R*reshape(d2.data(i,:),3,d.nMarkers),d.nMarkers*3,1)';
end

if 0
    
n1=[1 0 0];n2=[0 1 0];n3=[0 0 1];e1=[1 3 0];e2=[3 -1 0];e3=[0 0 1];%input data
e1 = e1/norm(e1);e2 = e2/norm(e2);e3 = e3/norm(e3);%e1, e2, e3 must be normalized firstly
R=[e1;e2;e3];  % your general formulas R
old=[2/3;2;0];
new=R*old;

end

end
