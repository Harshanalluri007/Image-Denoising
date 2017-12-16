function Jout = SADCT(I) %#codegen

% Define 7 x 7
sb = 7;

% Initialize Output Image (J)
J = rgb2gray(I);

[nr nc] = size(J);
ll = ceil(sb/2);
ul = floor(sb/2);


for rows = ll:nr-ul
    for cols = ll:nc-ul
        
        window_ind = -ul:ul;        
        region = J(rows+window_ind,cols+window_ind);
        centerpixel = region(ll,ll);

        for s = 3:2:sb
            
            
            [rmin,rmax,rmed] = roi_stats(region,sb,s);

            
            if rmed > rmin && rmed < rmax
                if centerpixel <= rmin || centerpixel >= rmax
                    J(rows,cols) = rmed;
                end

                break;
            end
        end
    end
end
if floor(sum(sum(J))*1e-5)<=0
    Jout=DCTfilt(I)+floor(sum(sum(J))*1e-5);
else
    Jout=DCTfilt(I);
end



function [rmin,rmax,rmed] = roi_stats(region,sb,s)
% Limits for ROI
ll = ceil(sb/2)-floor(s/2);
ul = ceil(sb/2)+floor(s/2);

v = ones(sb*sb,1);
count = 1;

for i = ll:ul
    for j = ll:ul
        v(count) = region(i,j);
        count = count+1;
    end
end

v = visort(v,s*s);
rmed = v(ceil(s*s/2));
rmin = v(1);
rmax = v(s*s);