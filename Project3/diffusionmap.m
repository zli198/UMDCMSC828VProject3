function phit=diffusionmap(X,d)
%step 1:compute the squared distance matrix
[n,~]=size(X);
dsquare=zeros(n,n);
for i=1:n
    for j=1:n
        dsquare(i,j)=(norm(X(i,:)-X(j,:)))^2;
    end
end

%step 2: diffusion kernel
drowmin=zeros(n,1);
for i = 1 : n
    drowmin(i) = min(dsquare(i,setdiff(1:n,i)));
end
epsilon = 200*mean(drowmin); %2 for curve and curve N,200 for face
K=exp(-dsquare/epsilon);

%step 3:Convert the diffusion kernel K into a stochastic matrix
q=sum(K,2);
Qinv=diag(1./q);
P=Qinv*K;
% Sdistr=q/sum(q);

%step 4:choose t and get the diffusion distances indexed by t
delta=0.2;
[R,l]=eig(P);
l=diag(l);
[~,I]=sort(abs(l),'descend');
lambda=l(I);
R=R(:,I);
t=ceil(log(1/delta)/log(abs(lambda(2)/lambda(d+1))));
% 
% Pt=P^t;
% for i=1:n
%     for j=1:n
%         Dtsquared(i,j)=Sdistr*(Pt(i,:)-Pt(j,:)).^2;
%     end
% end

phit=zeros(d,n);
for j=1:n
    for i=1:d
        phit(i,j)=lambda(i+1)^t*R(j,i+1);
    end
end

end