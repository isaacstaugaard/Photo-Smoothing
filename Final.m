function Final()

%Original=imread('landscape.jpg');     % Load the image file and store it as the variable I.
Original=imread('Super_Heros.jpg');    % Load the image file and store it as the variable I.
%figure;
%imshow(I);                      % Display the original image
title('Normal Image');                
I=rgb2gray(Original);                  % Convert to gray scale
I=im2double(I);                 % Convert the variable into double. 
%figure,imshow(I);               % Display the greyscale image
%title('Greyscale Image');       
m=size(I,1);                    % Height of the photo
n=size(I,2);                    % Width of the photo
I_noisy = zeros(m,n);

% Add some noise to the image
for i=1:m
    for j=1:n
        I_noisy(i,j)=I(i,j)+((rand(1))-.5)/5;
    end
end
%figure,imshow(I_noisy);         % Display the noisy image
%title('Noisy Image');

% Process the noisy image ...
g = smooth_diffusion(I,50,15,.01);
figure,imshow(g);               % Display the smoothed image
title('Smoothed Image');

% Show all images in one figure
imgs = cell(4,1);
imgs{1} = Original;
imgs{2} = I;
imgs{3} = I_noisy;
imgs{4} = g;
%figure(1)
%for i=1:4
%    subplot(2,2,i);
%    h = imshow(imgs{i}, 'InitialMag',100, 'Border','tight');
%    title(num2str(i))
%end
    
end