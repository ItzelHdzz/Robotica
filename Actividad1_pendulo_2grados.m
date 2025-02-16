%   Cálculo de la cinemática directa y diferencial de un robot planar 2GDL
%
%   Autor: Ana Itzel Hernández García
%   Fecha: 15/02/2025
%   Descripción:
%       Este script calcula la cinemática directa y diferencial de un robot
%       planar de dos grados de libertad (GDL) usando variables simbólicas.
%       Se determinan las coordenadas del efector final y la matriz Jacobiana,
%       que permite analizar la relación entre las velocidades articulares
%       y la velocidad del efector final.
%   Salida:
%       - Matriz de transformación homogénea total
%       - Posición del efector final (x, y, z)
%       - Matriz Jacobiana

%Limpieza de pantalla/ entorno
clear all
close all
clc


%Declaración de variables
%th -> ángulos de la articulación
%l -> Longitud del eslabón
syms th1(t) l1
syms th2(t) l2

%Configuración del robot, 0 para junta rotacional, 1 para junta prismatica
RP=[0 0];

%Creamos el vector de coordenadas generalizadas
Q = [th1 th2];
disp('Coordenadas generalizadas');
pretty(Q);

%Creamos el vector de velocidades generalizadas
Qp = diff(Q, t);
disp('Velocidades generalizadas');
pretty(Qp);

%Número de grado de libertad del robot
GDL = size(RP,2); %Número de articulaciones
GDL_str = num2str(GDL); %Se convierte en string

%Junta 1
%Posición de la justa 1 respecto a la base 
P(:,:,1) = [l1*cos(th1);
            l1*sin(th1);
            0];

%Matriz de rotación de la junta 1 respecto a 0
R(:,:,1) = [cos(th1) -sin(th1) 0;
            sin(th1)  cos(th1) 0;
               0         0     1];

%Junta 2
%Posición de la junta 2 con respecto a la junta 1
P(:,:,2) = [l2*cos(th2);
            l2*sin(th2);
            0];

%Matriz de rotación de la junta 2 respecto a 0
R(:,:,2) = [cos(th2) -sin(th2) 0;
            sin(th2)   cos(th2) 0;
               0         0     1];

%Matriz de transformación homogénea total
c = [0;0;0];

%Vector auxiliar para completar la matriz de transformación
H1 = [R(:,:,1) P(:,:,1); c' 1]; % Matriz de transformaciónde la base a la primera junta
H2 = [R(:,:,2) P(:,:,2); c' 1]; % Matriz de transformaciónde la primera a la segunda junta
MG = H1 * H2; % Matriz de transformación homogénea total

%Coordenadas Finales
x = MG(1,4);
y = MG(2,4);
z = MG(3,4);

%Derivadas parciales de x respecto a th1
Jv11 = functionalDerivative(x,th1);

%Derivadas parciales de y respecto a th1
Jv21 = functionalDerivative(y,th1);

%Derivadas parciales de z respecto a th1
Jv31 = functionalDerivative(z,th1);

%Derivadas parciales de x respecto a th2
Jv12 = functionalDerivative(x,th2);

%Derivadas parciales de y respecto a th1
Jv22 = functionalDerivative(y,th2);

%Derivadas parciales de z respecto a th1
Jv32 = functionalDerivative(z,th2);

disp('Cinemática diferencial de la posición del péndulo');

%Obtenemos la cinématica diferencial del péndulo a partir de la cinématica directa
jv_d = simplify([Jv11 Jv21; 
                Jv21 Jv22; 
                Jv31 Jv32]);
pretty(jv_d)
%jv_d
