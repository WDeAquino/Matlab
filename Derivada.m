%%Autor: Willinton De Aquino Perez

%% Creamos la función derivar para cual necesitamos una una funcion y el punto donde se deriva como argumento

function FPrima = derivar(f,a)
h= 1e-10
FPrima = (f(a+h)-f(a))/(2*h)
end
