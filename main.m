% testSimulazione.m
clear
close all
clc

lunghezzaMassimaCoda = 100;
tempoInterArrivo = 4; 
tempoPrepMin = 1.5;     
tempoPrepMax = 2;    

simulazione = SimulazioneChiosco(lunghezzaMassimaCoda, tempoInterArrivo, tempoPrepMin, tempoPrepMax);

simulazione.simula()