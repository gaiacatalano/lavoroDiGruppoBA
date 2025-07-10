% testSimulazione.m
clear
close all
clc

% i parametri di tempo sono inizializzati in minuti

% parametri simulazione chiosco
lunghezzaMassimaCodaChiosco = 20;
numeroMaxClientiChiosco = 1000;
tempoInterArrivo = 4; 
tempoPrepMin = 1.5;     
tempoPrepMax = 2;    

% parametri simulazione benzinaio
lunghezzaMassimaCodaBenzinaio = 10;
numeroMaxClientiBenzinaio = 2000;
tempoInterArrivoBenzina = 4; 
tempoRifMin = 3;
tempoRifMax = 7;
tempoPagMin = 2;
tempoPagMax = 3;
numeroCasse = 2;

fprintf("SIMULAZIONE CHIOSCO \n")
simulazioneChiosco = SimulazioneChiosco(lunghezzaMassimaCodaChiosco, numeroMaxClientiChiosco, tempoInterArrivo, tempoPrepMin, tempoPrepMax);
simulazioneChiosco.simula()

fprintf("SIMULAZIONE BENZINAIO con 1 cassa \n")
simulazioneBenzinaio = SimulazioneBenzinaio(lunghezzaMassimaCodaBenzinaio,  numeroMaxClientiBenzinaio, tempoInterArrivoBenzina, tempoRifMin, tempoRifMax, tempoPagMin, tempoPagMax);
simulazioneBenzinaio.simula()

fprintf("SIMULAZIONE BENZINAIO con 2 casse \n")
simulazioneBenzinaioDueCasse = SimulazioneBenzinaio(lunghezzaMassimaCodaBenzinaio, numeroMaxClientiBenzinaio, tempoInterArrivoBenzina, tempoRifMin, tempoRifMax, tempoPagMin, tempoPagMax, numeroCasse);
simulazioneBenzinaioDueCasse.simula();