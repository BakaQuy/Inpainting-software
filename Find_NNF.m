function NNF = find_NNF(image,iteration,dim,mask)
[m,n,p]=size(image);
output=zeros(m,n,p);
norm_matrix=inf*ones(m,n);
NNF=inf*ones(m,n,2);
x_basis=zeros(n,m);
y_basis=zeros(m,n);
dim_wind = dim;
for i=1:m
    for j=1:n
        if mask(i,j)~=0
            y_basis(i,j)=j;
            x_basis(j,i)=i;
        end
    end
end

                 
for it=0:iteration
    for i=1:m
        for j=1:n
            fst=x_basis(j,:);
            scd=y_basis(i,:);
            fst=fst(fst~=0);
            scd=scd(scd~=0);
            if length(fst)~=0 && length(scd)~=0
                min_x=min(fst)-ceil(dim_wind/2);
                max_x=max(fst)+ceil(dim_wind/2);
                min_y=min(scd)-ceil(dim_wind/2);
                max_y=max(scd)+ceil(dim_wind/2);
                a_next=[1:min_x,max_x:m];
                b_next=[1:min_y,max_y:n];
                x=randsample(a_next, 1);
                y=randsample(b_next, 1);
    %             x=randi([1,m],1);
    %             y=randi([1,n],1);
                temp1=norm([x y]-[i j]);
                if temp1<=norm([NNF(i,j,1) NNF(i,j,2)]-[i j]) 
                    NNF(i,j,1)=x; 
                    NNF(i,j,2)=y;
                    norm_matrix(i,j)=norm([NNF(i,j,1) NNF(i,j,1)]-[i j]);
                end
            elseif length(fst)~=0
                min_x=min(fst)-ceil(dim_wind/2);
                max_x=max(fst)+ceil(dim_wind/2);
                a_next=[1:min_x,max_x:m];
                x=randsample(a_next, 1);
                y=randi([1,n],1);
                temp1=norm([x y]-[i j]);
                if temp1<=norm([NNF(i,j,1) NNF(i,j,2)]-[i j]) 
                    NNF(i,j,1)=x; 
                    NNF(i,j,2)=y;
                    norm_matrix(i,j)=norm([NNF(i,j,1) NNF(i,j,1)]-[i j]);
                end
            elseif length(scd)~=0
                min_y=min(scd)-ceil(dim_wind/2);
                max_y=max(scd)+ceil(dim_wind/2);
                b_next=[1:min_y,max_y:m];
                y=randsample(b_next, 1);
                x=randi([1,m],1);
                temp1=norm([x y]-[i j]);
                if temp1<=norm([NNF(i,j,1) NNF(i,j,2)]-[i j]) 
                    NNF(i,j,1)=x; 
                    NNF(i,j,2)=y;
                    norm_matrix(i,j)=norm([NNF(i,j,1) NNF(i,j,1)]-[i j]);
                end     
            else
                x=randi([1,m],1);
                y=randi([1,n],1);
                temp1=norm([x y]-[i j]);
                if temp1<=norm([NNF(i,j,1) NNF(i,j,2)]-[i j]) 
                    NNF(i,j,1)=x; 
                    NNF(i,j,2)=y;
                    norm_matrix(i,j)=norm([NNF(i,j,1) NNF(i,j,1)]-[i j]);
                end
            end
        end
    end
    NNF=propagation(norm_matrix,NNF,it,dim); 
end