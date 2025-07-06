% testSimulazione.m
clear
close all
clc

% chiosco
lunghezzaMassimaCodaChiosco = 100;
numeroMaxClientiChiosco = 1000;
tempoInterArrivo = 4; 
tempoPrepMin = 1.5;     
tempoPrepMax = 2;    

% benzinaio
lunghezzaMassimaCodaBenzinaio = 10;
numeroMaxClientiBenzinaio = 2000;
tempoInterArrivoBenzina = 4; 
tempoRifMin = 5;
tempoRifMax = 10;
tempoPagMin = 2;
tempoPagMax = 3;

simulazioneChiosco = SimulazioneChiosco(lunghezzaMassimaCodaChiosco, numeroMaxClientiChiosco, tempoInterArrivo, tempoPrepMin, tempoPrepMax);
simulazioneChiosco.simula()

simulazioneBenzinaio = SimulazioneBenzinaio(lunghezzaMassimaCodaBenzinaio,  numeroMaxClientiBenzinaio, tempoInterArrivoBenzina, tempoRifMin, tempoRifMax, tempoPagMin, tempoPagMax);
simulazioneBenzinaio.simula()