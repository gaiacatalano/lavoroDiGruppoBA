% testSimulazione.m
clear
close all
clc

% chiosco
lunghezzaMassimaCodaChiosco = 100;
tempoInterArrivo = 4; 
tempoPrepMin = 1.5;     
tempoPrepMax = 2;    

% benzinaio
lunghezzaMassimaCodaBenzinaio = 10;
tempoRifMin = 5;
tempoRifMax = 7;
tempoPagMin = 1;
tempoPagMax = 2;

% simulazioneChiosco = SimulazioneChiosco(lunghezzaMassimaCodaChiosco, tempoInterArrivo, tempoPrepMin, tempoPrepMax);
% 
% simulazioneChiosco.simula()

simulazioneBenzinaio = SimulazioneBenzinaio(lunghezzaMassimaCodaBenzinaio, tempoInterArrivo, tempoRifMin, tempoRifMax, tempoPagMin, tempoPagMax);

simulazioneBenzinaio.simula()