classdef EventoCompletamentoPreparazionePanini < Evento

    methods
        function stato = gestioneEvento(obj, stato)

            if stato.domandaResidua > 0
                stato.domandaResidua(1) = stato.domandaResidua(1) -1;

                if stato.domandaResidua(1) == 0 % servo il cliente e finisco
                    stato.tempoTotaleAttesa = stato.tempoTotaleAttesa + (stato.clock - stato.tempoArrivoCoda(1));
                    stato.numClientiServiti = stato.numClientiServiti + 1;
                    stato.tempoArrivoCoda(1) = [];
                    stato.domandaResidua(1) = [];
                end
            else % non ci sono clienti, metto i panini nel buffer
                stato.paniniNelBuffer = stato.paniniNelBuffer + 1;
            end
            if stato.paniniNelBuffer == stato.numeroMassimoPaniniBuffer
                stato.bufferPieno = true;
                stato.prossimoPanino = inf;
            else
                %stato.prossimoPanino = stato.clock + unifrnd(stato.infTempoPreparazione,stato.infTempoPreparazione);
                stato.prossimoPanino = stato.aggiornoProssimoPanino(obj, stato);
            end

        end
        

    end
end