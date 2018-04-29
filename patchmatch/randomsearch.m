%randomsearch
function output=randomsearch(NNF,x,y,dim,it)
[m,n,~]=size(NNF);
coor=[inf inf];
if dim*0.5^it>=1
    if x-dim>=1 && x+dim<=m && y-dim>=1 && y+dim<=n
        coor=[x y]+floor(dim*(0.5^it)*[unifrnd(-1,1) unifrnd(-1,1)]);
    elseif x-dim<1 && x+dim<=m && y-dim>=1 && y+dim<=n
        coor=[x y]+floor(dim*(0.5^it)*[unifrnd(0,1) unifrnd(-1,1)]);
    elseif x-dim<1 && x+dim<=m && y-dim<1 && y+dim<=n
        coor=[x y]+floor(dim*(0.5^it)*[unifrnd(0,1) unifrnd(0,1)]);
    elseif x-dim>=1 && x+dim<=m && y-dim<1 && y+dim<=n
        coor=[x y]+floor(dim*(0.5^it)*[unifrnd(-1,1) unifrnd(0,1)]);
    elseif x-dim>=1 && x+dim>m && y-dim>=1 && y+dim<=n
        coor=[x y]+floor(dim*(0.5^it)*[unifrnd(-1,0) unifrnd(-1,1)]);
    elseif x-dim>=1 && x+dim>m && y-dim>=1 && y+dim>n
        coor=[x y]+floor(dim*(0.5^it)*[unifrnd(-1,0) unifrnd(-1,0)]); 
    elseif x-dim>=1 && x+dim<=m && y-dim>=1 && y+dim>n
        coor=[x y]+floor(dim*(0.5^it)*[unifrnd(-1,1) unifrnd(-1,0)]);
    end
end

if norm(coor-[x y])<norm([NNF(x,y,1) NNF(x,y,2)]-[x y])
    output=coor;
else
    output=[NNF(x,y,1) NNF(x,y,2)];
end