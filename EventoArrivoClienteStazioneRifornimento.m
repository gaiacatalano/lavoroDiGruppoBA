classdef EventoArrivoClienteStazioneRifornimento < Evento

    methods

        function simulazione = gestioneEvento(obj, simulazione)
            simulazione.clock = obj.tempo;
            simulazione.eventoArrivo.generaProssimoEvento(simulazione.clock);

            bocchettaDestra = rand() < 0.5; % true con prob 1/2, false con prob 1/2
            autista = Autista(simulazione.prossimoID, simulazione.clock, bocchettaDestra);
            simulazione.prossimoID = simulazione.prossimoID + 1;
            
            if ~isempty(simulazione.codaRifornimento.clienti)  % se la coda non è vuota
                simulazione.codaRifornimento.aggiungi(autista) % cliente arriva e si mette in coda
            else % se non c'è nessuno in coda
                % se il lato compatibile è accessibile (vuoto 2 posto)
                if bocchettaDestra == pompa.latoCompatibile && pompa.prima == false && pompa.occupata == false 
                   % se è libero anche il primo posto vado a fare rifornimento nel primo
                   if 

                   else % faccio rifornimento nel secondo

                   end




                else % se non è libero il lato compatibile con il mio o non posso inserirmi
                    % mi metto in coda
                    simulazione.codaRifornimento.aggiungi(autista)
                end

            end

            if % se tutte sono piene

            end

            
        end


    end
end