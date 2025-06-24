% testSimulazione.m

% Inizializza lo stato
stato = statoSistemaChiosco();

% Stampa stato iniziale
disp("STATO INIZIALE");
disp(stato);

% Simula un arrivo
evento1 = eventoArrivoClienteChiosco();
stato = evento1.gestioneEvento(stato);

% Stampa stato finale
disp("STATO INTERMEDIO");
disp(stato);

% Simula un completamento preparazione panino
evento2 = eventoCompletamentoPreparazionePanini();
stato = evento2.gestioneEvento(stato);

% Stampa stato finale
disp("STATO FINALE");
disp(stato);
