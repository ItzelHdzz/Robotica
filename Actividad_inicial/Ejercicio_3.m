%   Cálculo de una expresión
%
%   Autor: Ana Itzel Hernández García
%   Fecha: 16/02/2025
%   Descripción:
%       Este script calcula la matriz Jacobiana, y evalúala en el punto (-5,-4, 1).
%   Salida:
%       - Matriz Jacobiana
%       - Matriz evaluada

% Limpieza de pantalla / entorno
clear all
close all
clc

% Declaración de variables simbólicas
syms x y z

% Definición de funciones
Fx = sin((5 * (x^3 )) + (3*y) - (4 * y * x * (z^2) ));
Fy = - (10 * (x^5)) - (4 * y * x * z) + (15 * x * (z^4));
Fz = cos(-(x * y * (z^5)) - (6 * x *(y^5) * z) - (7 * y * x * (z^2)) );

% Derivadas parciales
Jv11 = diff(Fx, x);
Jv12 = diff(Fx, y);
Jv13 = diff(Fx, z);

Jv21 = diff(Fy, x);
Jv22 = diff(Fy, y);
Jv23 = diff(Fy, z);

Jv31 = diff(Fz, x);
Jv32 = diff(Fz, y);
Jv33 = diff(Fz, z);

% Matriz Jacobiana
jv_d = simplify([Jv11 Jv12 Jv13; 
                Jv21 Jv22 Jv23; 
                Jv31 Jv32 Jv33]);

pretty(jv_d)

% Evaluación de la matriz Jacobiana en x = -5, y = -4, z = 1
evalu = double(subs(jv_d, [x, y, z], [-5, -4, 1]))

