classdef EventoArrivoClienteStazioneRifornimento < Evento
    
    methods

        function simulazione = gestioneEvento(obj, simulazione)

            simulazione.clock = obj.tempo;
            simulazione.eventoArrivo.generaProssimoEvento(simulazione.clock);
            tempoProssimoArrivo = simulazione.eventoArrivo.prossimoEvento;
            simulazione.listaEventi.aggiungi(EventoArrivoClienteStazioneRifornimento(tempoProssimoArrivo))

            % genero casualmente il lato della bocchetta, assegnando ad
            % ogni lato una probabilità pari a 1/2
            bocchettaDestra = rand() < 0.5; 

            autista = Autista(simulazione.prossimoID, simulazione.clock, bocchettaDestra);
            simulazione.prossimoID = simulazione.prossimoID + 1;

             if ~isempty(simulazione.codaRifornimento.clienti)    % se la coda non è vuota
                 simulazione.codaRifornimento.aggiungi(autista);  % cliente arriva e si mette in coda
                 simulazione.storicoCodaRifornimento(end+1, :) = [simulazione.clock, simulazione.codaRifornimento.lunghezza];
             else 
                 assegnato = GestoreStazione.gestisciIngressiRifornimento(simulazione, autista);
                 if ~assegnato % se non ci sono pompe compatibili disponibili, si mette in coda
                    simulazione.codaRifornimento.aggiungi(autista);                
                    simulazione.storicoCodaRifornimento(end+1, :) = [simulazione.clock, simulazione.codaRifornimento.lunghezza];
                end
             end


        end
    end
end