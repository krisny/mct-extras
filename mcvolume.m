function v = mcvolume(d)
% Calculate the framewise minimum volume covered by all markers (convex hull)
%
% syntax
% v = mcvolume(d);
%
% Developed by Kristian Nymoen, University of Oslo
% 
% Download the MoCap Toolbox from 
% https://www.jyu.fi/hytk/fi/laitokset/mutku/en/research/materials/mocaptoolbox



if isfield(d,'type') && strcmp(d.type, 'MoCap data')
    
    for i = 1:d.nFrames


        [~ , v(i)] = boundary(d.data(i,1:3:end)',d.data(i,2:3:end)',d.data(i,3:3:end)',0);
        

    end
    
else
    disp([10, 'The first input argument has to be a variable with MoCap data structure.', 10]);
    sm=[];
    [y,fs] = audioread('mcsound.wav');
    sound(y,fs);
    return
end

