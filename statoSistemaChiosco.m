classdef statoSistemaChiosco < statoSistema

    properties
        infTempoPreparazione
        supTempoPreparazione
        paniniNelBuffer
        numeroMassimoPaniniBuffer
        bufferPieno
        domanda
        domandaResidua
        domandaMassima
        prossimoPanino % next roll, completamento panino
    end

    methods

        function stato = statoSistemaChiosco()
            stato.infTempoPreparazione = 1.5;
            stato.supTempoPreparazione = 2;
            stato.numeroMassimoPaniniBuffer = 6;
            stato.paniniNelBuffer = 3;
            stato.bufferPieno = false;
            stato.domandaMassima = 3;
            stato.prossimoPanino = unifrnd(stato.infTempoPreparazione,stato.supTempoPreparazione); 
        end

        % aggiorno i valori
        function stato = aggiornoProssimoPanino(obj, stato)
            stato.prossimoPanino = stato.prossimoPanino(obj, stato);
        end

        % gestisco il primo evento distinguendo tra arrivo del cliente e
        % preparazione del panino
        function stato = prossimoEventoDaGestire(obj, stato)
            while stato.numClientiServiti <= stato.maxClientiDaServire

                % primo evento che si verifica: panino pronto
                if stato.prossimoPanino <= stato.prossimoArrivo
                    stato.clock = stato.prossimoPanino;
                    evento = eventoCompletamentoPreparazionePanini();
                    evento.gestioneEvento(stato);                    
              
                % primo evento che si verifica: arrivo cliente
                else
                    stato.clock = stato.prossimoArrivo;
                    evento = arrivoClienteChiosco();
                    evento.gestioneEvento(stato);
                end

            end
        end



    end


end