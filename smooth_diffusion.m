function It=smooth_diffusion(I,niter,K,dt)
% edgestop function and method type %
% edgestop: g=1/(1+(x/K)^2)
% method: ut=div(g(|Du|)*Du)

% I:input image
% niter:number of iterations
% K:edge threshold param
% dt:time increment

%Defaul Image
im3 = imread('Super_Heros.jpg');
im3 = rgb2gray(im3);

%Default values if called with no parameters
if ~exist('I') I=im3; end  %Default is greyscale 'Super_Heros.jpg'
if ~exist('niter') niter=50; end
if ~exist('K') K=15; end
if ~exist('dt') dt=.01; end

[row,col]=size(I);


%Compute the coefficient (k,a) of normalization g()
    k=K; %gradient threshold normalization
    a=1; %amplitude normalization

for i=1:niter
    
    %
    %Compute the value of gradient in (N,S,E,W)
    %    N
    % W  O  E 
    %    S
     Gn=[I(1,:,:);I(1:row-1,:,:)]-I;  %N-O
     Gs=[I(2:row,:,:);I(row,:,:)]-I;  %S-O
     Ge=[I(:,2:col,:) I(:,col,:)]-I;  %E-O
     Gw=[I(:,1,:) I(:,1:col-1,:)]-I;  %W-O

  % Compute the diffusion coefficient
     Cn=1./(1+(Gn/k).^2).*a;
     Cs=1./(1+(Gs/k).^2).*a;
     Ce=1./(1+(Ge/k).^2).*a;
     Cw=1./(1+(Gw/k).^2).*a;

  %  
    %Solve PDE diffusion using gradient descent
        I=I+dt*(Cn.*Gn+Cs.*Gs+Ce.*Ge+Cw.*Gw);

end
It=I;
%imshow(It);
end