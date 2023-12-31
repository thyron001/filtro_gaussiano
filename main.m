clc;
close all;

%=======================================================================
%                   Definición del Kernel Gaussiano
%=======================================================================

%Formación del Kernel
%-----------------------------------------------------------------------

%Desviación estándar
sigma = 1; 

%Dimensión del Filtro Gaussiano
k = 3; 

GaussKernel = zeros(k,k);
center = (k+1)/2;

for i = 1:k
    
    for j = 1:k
    
        CenterDist = (i-center)^2 + (j-center)^2;
        GaussKernel(i,j) = exp( -1*( CenterDist ) / ( 2*(sigma^2) ) );    
    end
end

%Normalizacion
GaussKernel = GaussKernel/(2*pi*(sigma)^2);

%-----------------------------------------------------------------------

%=======================================================================
%***********************************************************************
%=======================================================================


%=======================================================================
%      Lectura de Imagen y obtención de valores de filas y columnas
%=======================================================================

img = imread("ex1.bmp");
%I = img;
I = rgb2gray(img);
%=======================================================================
%***********************************************************************
%=======================================================================



%=======================================================================
%            Aplicación del Flitro Gaussiano al objeto "img"
%=======================================================================

%Asignar un valor de 0 a los valores de los bordes
[M,N] = size(I);
Im = padarray(I,[(k-1)/2 (k-1)/2 ],0);
salida = zeros(M,N);

for i = 1:M
    
    for j = 1:N

        temporal = Im( i:i+k-1, j:j+k-1);
        temporal = double(temporal);
        conv = temporal.*GaussKernel;
        salida(i,j) = sum(conv(:));
    
    end

end


%=======================================================================
%***********************************************************************
%=======================================================================



%=======================================================================
%                       Muestra de resultados
%=======================================================================

figure(1);

set(gcf,'Position',get(0,'ScreenSize'));
subplot(121),imshow(Im),title('Original');
subplot(122),imshow(salida,[0, 255]),title('Salida');


figure(2);

imagesc(GaussKernel);
colormap(gray(256));

figure(3)
surf(GaussKernel)
colormap(gray)        
shading interp    

%======================================================================
%**********************************************************************
%======================================================================


