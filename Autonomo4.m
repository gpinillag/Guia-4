clc
load census
plot (cdate, pop, 'o')
hold on;

% Ajuste polinomial de grado 1
ajp1 = polyfit(cdate, pop, 1);

% Ajuste polinomial de grado 2
ajp2 = polyfit(cdate, pop, 2);

% Ajuste polinomial de grado 3 aqui hay un problema 
ajp3 = polyfit(cdate, pop, 3);

%evaluacion polinomial

p1 = polyval(ajp1, cdate);
p2 = polyval(ajp2, cdate);
p3 = polyval(ajp3, cdate);

% Graficar el ajuste polinomial para cada grado
plot(cdate, p1, 'r');
plot(cdate, p2, 'g');
plot(cdate, p3, 'm');

legend('Datos de población en funcion del año', 'Ajuste polinomial grado 1', 'Ajuste polinomial grado 2', 'Ajuste polinomial grado 3');
xlabel('Variable cdate (Año censado)');
ylabel('Variable pop  (Poblacion en millones)');
title('Censo EE.UU de 1790 a 1990 (Gráfica de dispersión y ajuste polinomial)');


%error cuadratico medio
ECM1 = mse(pop, p1);
ECM2 = mse(pop, p2);
ECM3 = mse(pop, p3);

disp('Funcion polyfit: Esta función de MATLAB se utiliza para ajustar un polinomio a un conjunto de datos mediante el método de mínimos cuadrados');  
disp('Funcion polyval: Se utiliza para evaluar un polinomio en ciertos puntos dados, esta trabaja de la mano de la funcion polyfit puesto que permite evaluar el polinomio en cierto punto');

disp(['El Error cuadratico medio para un ajuste lineal es: ', num2str(ECM1)]);
disp(['El Error cuadratico medio para un ajuste polinomial grado 2 es: ', num2str(ECM2)]);
disp(['El Error cuadratico medio para un ajuste polinomial grado 3 es: ', num2str(ECM3)]);
disp(['El ajuste polinomial que más se acopla a los datos arrojados es el polinomial de grado 3, con un error cuadratico medio de: ', num2str(ECM3)]);
