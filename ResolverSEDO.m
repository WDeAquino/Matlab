%%Autor: Willinton De Aquino Perez

f = @(t,y) fun(t,y);
tiempo = [0 10];
y0 = [1.5;3];
[T Y] = ode45(f,tiempo,y0);

u = Y(:,1);
v = Y(:,2);

clf, hold on;
plot(T,u,'b')
plot(T,v,'r')
legend('u(t)','v(t)')
