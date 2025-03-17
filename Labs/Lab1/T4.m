clear all;
clc;

A = [1, 2, 3;
    4, 5, 6;]
 
B = [7, 8;
     9, 10;
     11, 12;]
 
 C = A * B
 
 A_t = transpose(A)
 
 S = A_t + B