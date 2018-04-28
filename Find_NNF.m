function NNF = find_NNF(image,iteration,dim)
[m,n]=size(image);
norm_matrix=inf*ones(m,n);
NNF=inf*ones(m,n,2);
for it=0:iteration
    for i=1:m
        for j=1:n
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
    NNF=propagation(norm_matrix,NNF,it,dim);
end