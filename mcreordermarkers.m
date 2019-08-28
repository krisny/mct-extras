function dout = mcreordermarkers(d,markerlist)
% Reorders the markers in the mocap struct. If any
% markers are missing, insert empty (NaN) marker 
%
% syntax
% dout = mcReorderMarkers(d,markerlist)
%
% d: mocap struct
% markerlist: path to a text file with marker names (one markername per line)
%             or cell array of markernames (should be column format; markers separated by semicolons)
% 
%
% Developed by Kristian Nymoen, University of Oslo
% 
% Download the MoCap Toolbox from 
% https://www.jyu.fi/hytk/fi/laitokset/mutku/en/research/materials/mocaptoolbox
%

if nargin > 1
    if iscell(markerlist)
        correctmarkers = markerlist;
    else
        try
            correctmarkers = importdata(markerlist);
        catch
            disp('WARNING: marker list not found. Using Full Body Plugin Gait by default.')
            correctmarkers = {'LFHD';'RFHD';'LBHD';'RBHD';'C7';'T10';'CLAV';'STRN';'RBAK';'LSHO';'LUPA';'LELB';'LFRA';'LWRA';'LWRB';'LFIN';'RSHO';'RUPA';'RELB';'RFRA';'RWRA';'RWRB';'RFIN';'LASI';'RASI';'LPSI';'RPSI';'LTHI';'LKNE';'LTIB';'LANK';'LHEE';'LTOE';'RTHI';'RKNE';'RTIB';'RANK';'RHEE';'RTOE'};
        end
    end
else
    disp('WARNING: no marker list specified. Using Full Body Plugin Gait by default.')
    correctmarkers = {'LFHD';'RFHD';'LBHD';'RBHD';'C7';'T10';'CLAV';'STRN';'RBAK';'LSHO';'LUPA';'LELB';'LFRA';'LWRA';'LWRB';'LFIN';'RSHO';'RUPA';'RELB';'RFRA';'RWRA';'RWRB';'RFIN';'LASI';'RASI';'LPSI';'RPSI';'LTHI';'LKNE';'LTIB';'LANK';'LHEE';'LTOE';'RTHI';'RKNE';'RTIB';'RANK';'RHEE';'RTOE'};
end

for i = 1:length(correctmarkers)
    c(i)=max([0,find(strcmpi(correctmarkers(i),d.markerName))]);
end

markerDim = size(d.data,2)/d.nMarkers; % = 1 for norm, and 3 for mocap type

d.data(1:d.nFrames,(end+1):(end+length(correctmarkers(c==0))*markerDim)) = NaN; % extend data array by NAN columns for not present in the mocap struct
d.markerName((d.nMarkers+1):(end+length(correctmarkers(c==0)))) = correctmarkers(c==0); % extend marker name field by marker names not present in the mocap struct
c(c==0) = (d.nMarkers+1):(d.nMarkers+length(correctmarkers(c==0))); % assign the new indecies for markers to the indecies of the newly created NaN-columns
d.nMarkers = size(d.data,2)/markerDim;

dout = mcconcatenate(d,c);

end