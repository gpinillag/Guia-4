clc
 % Cargar los datos CSV en una variable 
  heart_data = readtable('heart_data.csv');

   % Guardar los datos en un archivo .mat
   save('heart_data.mat', 'heart_data');
load("heart_data.mat");
%a)DIAS POR AÑOS
heart_data.age=(heart_data.age)/365;
Edad=heart_data.age; 

% B)Cambia las variables que se encuentran en código binario.

%FUMADOR
N=size(heart_data, 1);
smokeLe = strings(N,1);
for f=1:N
    if heart_data.smoke(f) == 1
        smokeLe(f) = "Fumador";
    elseif heart_data.smoke(f) ~=1
        smokeLe(f) = "No fumador";
    end
end
heart_data.fumador = smokeLe;

%% 
%ALCOHOLICO
N=size(heart_data, 1);
alcoLe = strings(N,1);
for f=1:N
    if heart_data.alco(f) == 1
        alcoLe(f) = "Toma alcohol";
    elseif heart_data.alco(f) ~=1
        alcoLe(f) = "No toma alcohol";
    end
end
heart_data.alcoholico = alcoLe;


%ACTIVIDAD FISICA
N=size(heart_data, 1);
activLe = strings(N,1);
for f=1:N
   if heart_data.active(f) == 1
        activLe(f) = "Hace actividad fisica";
    elseif heart_data.active(f) ~=1
        activLe(f) = "No hace actividad fisica";
    end
end
heart_data.actividad = activLe;

%% 
%CARDIO
N=size(heart_data, 1);
cardioLe = strings(N,1);
for f=1:N
   if heart_data.cardio(f) == 1
        cardioLe(f) = "Tiene una condicion cardiaca";
    elseif heart_data.cardio(f) ~=1
        cardioLe(f) = "No tiene una condicion cardiaca";
    end
end
heart_data.cardio = cardioLe;

%%
% cambiar cm a m
Altura =heart_data.height;
heart_data.height=(heart_data.height)/100;
Altura=heart_data.height;

%%
% C)Calcula el índice de masa corporal para cada individuo

N = size (heart_data,1);
IMC= zeros (N,1);

ClasificacionIMC=strings (N,1); %vector  vacio 
for i=1:N
    IMC(i)= (heart_data.weight(i))/((heart_data.height(i))^2);
    
    if (IMC(i)<18.5)
        ClasificacionIMC(i)="Peso bajo";

    elseif (18.5<=IMC(i) && 24.9>=IMC(i))
        ClasificacionIMC(i)="Peso normal";

    elseif (25<=IMC(i) && 30>=IMC(i))
        ClasificacionIMC(i)="Sobre peso";

    else 
        ClasificacionIMC(i)="Obeso";
    end
end
heart_data.IMC=IMC;
heart_data.ClasificacionIMC=ClasificacionIMC;

%%
% D)Calcula la presión arterial media 

N = size (heart_data,1);
PresionMedia= zeros (N,1);

for j=1:N
    PresionMedia(j) =(((heart_data.ap_hi(j))+((heart_data.ap_lo(j))*2))/3);
end

heart_data.PresionMedia=PresionMedia;
 
%%
%Punto 4: grafica de barras
function interfazGrafica()
    % Crear la interfaz gráfica
    app = uifigure('Name', 'Graficas', 'Position', [100 100 600 400]);
    
    % Crear lista desplegable
    dropdown = uidropdown(app, 'Items', {'Gráfica de Barras', 'Gráfica de Dispersión 1', 'Gráfica de Dispersión 2','Media y desviacion'}, 'Position', [50 300 200 22]);
    
    % Botón Graficar
    botonGraficar = uibutton(app, 'Text', 'Graficar', 'Position', [300 300 100 22], 'ButtonPushedFcn', @(btnGraficar,event) graficarCallback(dropdown.Value));
end

function graficarCallback(selectedOption)
    edadeshombre = zeros(1,6);
    edadesmujer = zeros(1,6);
    load("heart_data.mat");
    heart_data.age = heart_data.age/365;

    for i = 1:length(heart_data.age)
        if strcmp(heart_data.cardio(i), 'Tiene una condicion cardiaca')
            if heart_data.age(i) <= 20
                if heart_data.gender(i) == 1
                    edadeshombre(1) = edadeshombre(1) + 1;
                elseif heart_data.gender(i) == 2
                    edadesmujer(1) = edadesmujer(1) + 1;
                end
            elseif (20<=heart_data.age(i))&&(heart_data.age(i)<=40)
                if heart_data.gender(i) == 1
                    edadeshombre(2) = edadeshombre(2) + 1;
                elseif heart_data.gender(i) == 2
                    edadesmujer(2) = edadesmujer(2) + 1;
                end
             elseif (40<=heart_data.age(i))&&(heart_data.age(i)<=60)
                if heart_data.gender(i) == 1
                    edadeshombre(3) = edadeshombre(3) + 1;
                elseif heart_data.gender(i) == 2
                    edadesmujer(3) = edadesmujer(3) + 1;
                end
             elseif (60<=heart_data.age(i))&&(heart_data.age(i)<=80)
                if heart_data.gender(i) == 1
                    edadeshombre(4) = edadeshombre(4) + 1;
                elseif heart_data.gender(i) == 2
                    edadesmujer(4) = edadesmujer(4) + 1;
                end
             elseif (80<=heart_data.age(i))&&(heart_data.age(i)<=100)
                if heart_data.gender(i) == 1
                    edadeshombre(5) = edadeshombre(5) + 1;
                elseif heart_data.gender(i) == 2
                    edadesmujer(5) = edadesmujer(5) + 1;
                end
             elseif heart_data.age(i) >= 100
                if heart_data.gender(i) == 1
                    edadeshombre(6) = edadeshombre(6) + 1;
                elseif heart_data.gender(i) == 2
                    edadesmujer(6) = edadesmujer(6) + 1;
                end
            end
        end
    end

    figure;
    bar([edadeshombre; edadesmujer]')
    ylabel('Cantidad de personas');
    xlabel('Edad de las personas');
    title('Enfermedad cardiovascular');
    legend('Hombres','Mujeres');
    etiquetas={'0-20','20-40','40-60','60-80','80-100','100-...'};
    xticklabels(etiquetas);

    if strcmp(selectedOption, 'Gráfica de Dispersión 1')
        
        concardioIMC = zeros(1, length(heart_data.age));
        sincardioIMC = zeros(1, length(heart_data.age));
        concardioCol = zeros(1, length(heart_data.age));
        sincardioCol = zeros(1, length(heart_data.age));
        
        for i = 1:length(heart_data.age)
            IMC2(i)= (heart_data.weight(i))/((heart_data.height(i))^2);

            if heart_data.cardio(i)==1
                concardioIMC(i)=concardioIMC(i)+IMC2(i);
                concardioCol(i)=concardioCol(i)+heart_data.cholesterol(i);
            elseif heart_data.cardio(i)==0
                sincardioIMC(i)=sincardioIMC(i)+IMC2(i);
                sincardioCol(i)=sincardioCol(i)+heart_data.cholesterol(i);
            end
        end
        
        figure;
        scatter(concardioIMC, concardioCol, 'filled', 'MarkerFaceColor', 'b');
        hold on;
        scatter(sincardioIMC, sincardioCol, 'filled', 'MarkerFaceColor', 'r');
        xlabel('IMC');
        ylabel('Colesterol');
        title('Gráfico de dispersión de IMC vs. Colesterol agrupado por condición cardíaca');
        legend('Con enfermedad cardíaca', 'Sin enfermedad cardíaca');
        grid on;
    end
if strcmp(selectedOption, 'Gráfica de Dispersión 2')
        
        concardioGlu = zeros(1, length(heart_data.age));
        sincardioGlu = zeros(1, length(heart_data.age));
        concardioPres = zeros(1, length(heart_data.age));
        sincardioPres = zeros(1, length(heart_data.age));
        
        for i = 1:length(heart_data.age)
            PresionMedia(i) =(((heart_data.ap_hi(i))+((heart_data.ap_lo(i))*2))/3);
            if heart_data.cardio(i)==1
                concardioGlu(i)=concardioGlu(i)+heart_data.gluc(i);
                concardioPres(i)=concardioPres(i)+PresionMedia(i);
            elseif heart_data.cardio(i)==0
                sincardioGlu(i)=sincardioGlu(i)+heart_data.gluc(i);
                sincardioPres(i)=sincardioPres(i)+PresionMedia(i);
            end
        end
        
        figure;
        scatter(concardioGlu, concardioPres, 'filled', 'MarkerFaceColor', 'b');
        hold on;
        scatter(sincardioGlu, sincardioPres, 'filled', 'MarkerFaceColor', 'r');
        xlabel('Glucosa');
        ylabel('Presion arterial media');
        title('Gráfico de dispersión de nivel de glucosa vs. Presion arterial media agrupado por condición cardíaca');
        legend('Con enfermedad cardíaca', 'Sin enfermedad cardíaca');
        grid on;
end
if strcmp(selectedOption, 'Media y desviacion')
    
    for i=1:length(heart_data.age)
        datos=zeros(6,i);
        if strcmp(heart_data.cardio(i), 'Tiene una condicion cardiaca')
            datos(1,i)=datos(1,i)+IMC2(i)
            datos(2,i)=datos(2,i)+PresionMedia(i)
            datos(3,i)=datos(3,i)+heart_data.cholesterol(i)
        elseif strcmp(heart_data.cardio(i), 'No tiene una condicion cardiaca')
            datos(4,i)=datos(4,i)+IMC2(i)
            datos(5,i)=datos(5,i)+PresionMedia(i)
            datos(6,i)=datos(6,i)+heart_data.cholesterol(i)
        end
        media=zeros(3,2)
        media(1,1)=mean(datos(1,:));
        media(2,1)=mean(datos(2,:));
        media(3,1)=mean(datos(3,:));
        media(1,2)=mean(datos(4,:));
        media(2,2)=mean(datos(5,:));
        media(3,2)=mean(datos(6,:));

        desvesta=zeros(3,2)
        devesta(1,1)=std(datos(1,:));
        devesta(2,1)=std(datos(2,:));
        devesta(3,1)=std(datos(3,:));
        devesta(1,2)=std(datos(4,:));
        devesta(2,2)=std(datos(5,:));
        devesta(3,2)=std(datos(6,:));
    end
        
end
end
