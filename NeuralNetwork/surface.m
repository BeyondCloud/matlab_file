[X,Y] = meshgrid(-5:0.5:5,-5:0.5:5);
Z = (X+Y).^2 ;
surf(X,Y,Z)