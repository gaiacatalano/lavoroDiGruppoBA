classdef EventoArrivoClienteChiosco < Evento

    methods

        function stato = gestioneEvento(obj, stato)

            stato.prossimoArrivo = stato.aggiornoProssimoArrivo(stato);
            stato.domanda = unidrnd(stato.domandaMassima);

            if stato.domandaResidua > 0 % cliente arriva e si mette in coda
                stato.domandaResidua(end+1) = stato.domanda;
                stato.tempoArrivoCoda(end+1) = stato.clock;
            else % non c'è nessuno in coda e lo servo
                if stato.paniniNelBuffer >= stato.domanda % panini pronti nel buffer e soddisfo domanda
                    stato.paniniNelBuffer = stato.paniniNelBuffer - stato.domanda;
                    stato.numClientiServiti = stato.numClientiServiti + 1;
                else % non ho abbastanza panini già pronti
                    stato.domanda = stato.domanda - stato.paniniNelBuffer;
                    stato.paniniNelBuffer = 0;
                    stato.domandaResidua(1) = stato.domanda;
                    stato.tempoArrivoCoda(1) = stato.clock;
                end

                if stato.bufferPieno
                    stato.bufferPieno = false;
                    stato.prossimoPanino = stato.aggiornoProssimoPanino(stato);
                end
            end
        end

    end

end