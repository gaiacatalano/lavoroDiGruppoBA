classdef statoSistema < handle

    properties
        clock
        prossimoArrivo
        %prossimoCompletamentoServizio
        interArrivalTime
        tempoArrivoCoda
        tempoTotaleAttesa
        maxClientiDaServire
        numClientiServiti
    end

    methods

        % costuttore che inizializza la classe
        function stato = statoSistema()
            stato.clock = 0;
            stato.interArrivalTime = 4;
            stato.prossimoArrivo = exprnd(stato.interArrivalTime);
            %stato.prossimoCompletamentoServizio = inf; % il primo evento deve per forza essere l'arrivo del cliente
            stato.maxClientiDaServire = 1000;
            stato.numClientiServiti = 0;
        end

        % aggiorno i valori
        function stato = aggiornoProssimoArrivo(obj, stato)
            stato.prossimoArrivo = stato.clock + exprnd(stato.interArrivalTime);
        end

    end

    methods (Abstract)
        % funzione controlla se ho ancora clienti da servire e mi dice qual
        % è il primo evento che si verifica (tra completamento servizio e
        % arrivo)
        stato = prossimoEventoDaGestire(obj, stato)

    end
end
