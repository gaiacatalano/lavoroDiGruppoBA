classdef EventoCompletamentoPreparazionePanini < Evento
    methods
        function simulazione = gestioneEvento(obj, simulazione)
            simulazione.clock = obj.tempo;

            if ~isempty(simulazione.coda.clienti)   % se la coda non è vuota
                 simulazione.coda.decrementaDomanda();

                if simulazione.coda.primo().domanda == 0    % se la domanda residua del primo cliente in coda è nulla vuol dire che ho finito di servire il cliente
                    cliente = simulazione.coda.rimuovi();   % il cliente lascia la coda
                    cliente.tempoInizioServizio = simulazione.clock;
                    simulazione.numeroClientiServiti = simulazione.numeroClientiServiti + 1;
                    simulazione.tempoTotaleAttesa = simulazione.tempoTotaleAttesa + cliente.TempoAttesa();
                end
            else  % se non ci sono clienti in coda metto il panino pronto nel buffer
                simulazione.paniniNelBuffer = simulazione.paniniNelBuffer + 1;
            end

            if simulazione.paniniNelBuffer == simulazione.numeroMassimoPaniniBuffer   % è stata raggiunta la capacità massima del buffer
                simulazione.bufferPieno = true;
                simulazione.eventoPreparazione.prossimoEvento = Inf;  % non si può produrre un nuovo panino se prima non viene prima servito un cliente
            else
                simulazione.eventoPreparazione.generaProssimoEvento(simulazione.clock);
            end
        end
    end
end