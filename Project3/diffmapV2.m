function[output] = diffmap(data, dim)
    X=data;
    n = size(data,1);
    %% Compute pairwise distances
    d = zeros(n);
    e = ones(n,1);
    for i = 1 : n
        d(i,:) = sum((X - e*X(i,:)).^2,2);
    end

    %% Define the diffusion kernel
    drowmin = zeros(n,1);
    for i = 1 : n
        drowmin(i) = min(d(i,setdiff(1:n,i)));
    end
    epsilon = 2*mean(drowmin);
    K=exp(-d/epsilon);

    %% Convert the diffusion kernel into a stochastic matrix
    rowsum = sum(K,2);
    Q = diag(rowsum);
    P = Q\K;

    %% determine the power t for embedding
    delta=0.2;
    [R,lambdas]=eig(P);
    L=diag(lambdas);
    [~,I]=sort(abs(L),'descend');
    lambda=lambdas(I);
    R=R(:,I);
    t=ceil(log(1/delta)/log(abs(lambda(2)/lambda(d+1))));


    output=zeros(n,d);
    for i=1:d
        for j=1:n
            output(i,j)=lambda(i+1)^t*R(j,i+1);
        end
    end
end