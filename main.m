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
tempoInterArrivoBenzina = 4; 
tempoRifMin = 2;
tempoRifMax = 3;
tempoPagMin = 1;
tempoPagMax = 2;

% simulazioneChiosco = SimulazioneChiosco(lunghezzaMassimaCodaChiosco, tempoInterArrivo, tempoPrepMin, tempoPrepMax);
% simulazioneChiosco.simula()

simulazioneBenzinaio = SimulazioneBenzinaio(lunghezzaMassimaCodaBenzinaio, tempoInterArrivoBenzina, tempoRifMin, tempoRifMax, tempoPagMin, tempoPagMax);
simulazioneBenzinaio.simula()