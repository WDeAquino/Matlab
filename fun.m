%%Autor: Willinton De Aquino Perez

%% Definimos nuestro sistema de ecuaciones mediante ladoDerecho(a,b)
function ladoDerecho = fun(t,y)
u=y(1);
v=y(2);
ladoDerecho(1,1) = 1+u^2*v-4*u;
ladoDerecho(2,1) = 3*u-u^2*v;
end
