classdef EventoCompletamentoPreparazionePanini < Evento

    methods

        function simulazione = gestioneEvento(obj, simulazione)

            simulazione.clock = obj.tempo;

            if ~isempty(simulazione.coda.clienti)   % se la coda non è vuota
                 simulazione.coda.decrementaDomanda();

                if simulazione.coda.primo().domanda == 0    % se la domanda residua del primo cliente in coda è nulla vuol dire che ho finito di servire il cliente
                    cliente = simulazione.coda.rimuovi();   % il cliente lascia la coda
                    cliente.tempoFineServizio = simulazione.clock;
                    simulazione.aggiornaClientiServiti();
                    simulazione.tempoTotaleAttesa = simulazione.tempoTotaleAttesa + cliente.TempoAttesa();
                end
            else  % se non ci sono clienti in coda, metto il panino nel buffer
                simulazione.paniniNelBuffer = simulazione.paniniNelBuffer + 1;
            end

            % se è stata raggiunta la capacità massima del buffer
            if simulazione.paniniNelBuffer == simulazione.numeroMassimoPaniniBuffer   
                simulazione.bufferPieno = true;
                simulazione.eventoPreparazione.prossimoEvento = Inf;  % non si può produrre un nuovo panino, deve prima arrivare un cliente
            else
                simulazione.eventoPreparazione.generaProssimoEvento(simulazione.clock);
            end
        end

    end
end
