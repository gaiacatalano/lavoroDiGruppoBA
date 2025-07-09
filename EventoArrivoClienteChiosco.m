classdef EventoArrivoClienteChiosco < Evento

    methods

        function simulazione = gestioneEvento(obj, simulazione)

            simulazione.clock = obj.tempo;
            simulazione.eventoArrivo.generaProssimoEvento(simulazione.clock);

            % genero casualmente la domanda del cliente in modo che sia
            % intera e uniformemente distribuita entro il limite massimo di
            % domanda
            domanda = unidrnd(simulazione.domandaMassima);
            cliente = ClienteChiosco(simulazione.prossimoID, simulazione.clock, domanda);
            simulazione.prossimoID = simulazione.prossimoID + 1;

            % se la coda non è vuota, cliente arriva e si mette in coda
            if ~isempty(simulazione.coda.clienti)    
                simulazione.coda.aggiungi(cliente);  
            else    % se la coda è vuota, appena arriva un cliente lo servo
                if simulazione.paniniNelBuffer >= cliente.domanda    % se riesco a soddisfare subito la domanda
                    simulazione.paniniNelBuffer = simulazione.paniniNelBuffer - cliente.domanda;
                    cliente.tempoFineServizio = simulazione.clock;
                    simulazione.aggiornaClientiServiti();
                    simulazione.tempoTotaleAttesa = simulazione.tempoTotaleAttesa + cliente.TempoAttesa();
                else   % se non ci sono abbastanza panini pronti
                    cliente.domanda = cliente.domanda - simulazione.paniniNelBuffer;
                    simulazione.paniniNelBuffer = 0;
                    simulazione.coda.aggiungi(cliente);
                end

                % se il buffer era pieno, adesso non lo sarà più perché ho
                % servito un cliente
                if simulazione.bufferPieno
                    simulazione.bufferPieno = false;   
                    simulazione.eventoPreparazione.generaProssimoEvento(simulazione.clock); 
                end
            end
            simulazione.storicoCoda(end+1, :) = [simulazione.clock, simulazione.coda.lunghezza];
        end

    end

end