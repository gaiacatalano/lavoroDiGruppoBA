classdef EventoArrivoClienteChiosco < Evento
    methods
        function simulazione = gestioneEvento(obj, simulazione)
            simulazione.clock = obj.tempo;
            simulazione.eventoArrivo.generaProssimoEvento(simulazione.clock);

            domanda = unidrnd(simulazione.domandaMassima);
            cliente = ClienteChiosco(simulazione.prossimoID, simulazione.clock, domanda);
            simulazione.prossimoID = simulazione.prossimoID + 1;

            if ~isempty(simulazione.coda.clienti)    % se la coda non è vuota
                simulazione.coda.aggiungi(cliente);  % cliente arriva e si mette in coda
            else    % se la coda è vuota, appena arriva un cliente lo servo
                if simulazione.paniniNelBuffer >= cliente.domanda    % riesco a soddisfare subito la domanda
                    simulazione.paniniNelBuffer = simulazione.paniniNelBuffer - cliente.domanda;
                    cliente.tempoFineServizio = simulazione.clock;
                    simulazione.numeroClientiServiti = simulazione.numeroClientiServiti + 1;
                    simulazione.tempoTotaleAttesa = simulazione.tempoTotaleAttesa + cliente.TempoAttesa();
                else   % non ci sono abbastanza panini pronti
                    cliente.domanda = cliente.domanda - simulazione.paniniNelBuffer;
                    simulazione.paniniNelBuffer = 0;
                    simulazione.coda.aggiungi(cliente);
                end

                if simulazione.bufferPieno
                    simulazione.bufferPieno = false;   % se il buffer era pieno, dopo aver servito un cliente, si è liberato posto nel buffer
                    simulazione.eventoPreparazione.generaProssimoEvento(simulazione.clock);   % può riprendere la preparazione dei panini
                end
            end
        end
    end
end