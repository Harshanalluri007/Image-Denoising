function Jout = Proposed(I) 
I1=imresize(rgb2gray(I),[256 256]);
vm = 5;
J = I1;
[rr, cc] = size(I1);
ll = ceil(vm/2);
ul = floor(vm/2);
for rows = ll:rr-ul
    for cols = ll:cc-ul
        
        window_ind = -ul:ul;        
        region = I1(rows+window_ind,cols+window_ind);
        
        centerpixel = region(ll,ll);

        for s = 3:2:vm
            
        
            [rmin,rmax,rmed] = rst(region,vm,s);

             
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
    Jout=scorfilt(I)+floor(sum(sum(J))*1e-5);
else
    Jout=scorfilt(I);
end


function [rmin,rmax,rmed] = rst(region,vm,s)
% Limits for ROI
ll = ceil(vm/2)-floor(s/2);
ul = ceil(vm/2)+floor(s/2);

v = ones(vm*vm,1);
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