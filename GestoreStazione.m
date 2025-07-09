classdef GestoreStazione < handle

    methods(Static)
       
        % funzione che gestisce la coda per il rifornimento e l'evento
        % rifornimento
        function assegnato = gestisciIngressiRifornimento(simulazione, autista)

           if autista.bocchettaDestra
                prima = 1;
                seconda = 2;
            else
                prima = 3;
                seconda = 4;
            end

            % se la seconda pompa è libera, il cliente puo' fare rifornimento
            if simulazione.pompe(seconda).pompaLibera() 

                autista.tempoInizioRifornimento = simulazione.clock;
                simulazione.aggiornaTotaleAttesaRifornimento(autista.TempoAttesaRifornimento());
                assegnato = true;
                simulazione.eventoRifornimento.generaProssimoEvento(simulazione.clock);
                tempoFineRifornimento = simulazione.eventoRifornimento.prossimoEvento;

                % se anche la prima è libera, lo posiziono nella prima
                if simulazione.pompe(prima).pompaLibera() 
                    simulazione.pompe(prima).assegnaCliente(autista,tempoFineRifornimento);
                    autista.assegnaPompa(simulazione.pompe(prima));
                    simulazione.listaEventi.aggiungi(EventoRifornimento(tempoFineRifornimento, autista));
                else % altrimenti nella seconda
                    simulazione.pompe(seconda).assegnaCliente(autista,tempoFineRifornimento);
                    autista.assegnaPompa(simulazione.pompe(seconda));
                    simulazione.listaEventi.aggiungi(EventoRifornimento(tempoFineRifornimento, autista));
                end
            else
                assegnato = false;
            end
        end

        % funzione che gestisce la coda per la cassa e l'evento pagamento
        function gestisciIngressiCasse(simulazione, autista)

            assegnata = false;

            % ciclo finché non si trova una cassa libera
            for i=1:length(simulazione.casse)

                cassa = simulazione.casse{i};

                % se la cassa è libera
                if cassa.cassaLibera()

                    % l'autista puo' occuparla e pagare
                    cassa.occupa();
                    autista.tempoInizioPagamento = simulazione.clock;
                    simulazione.aggiornaTotaleAttesaCassa(autista.TempoAttesaCassa());
                    autista.assegnaCassa(cassa);
                    simulazione.eventoPagamento.generaProssimoEvento(simulazione.clock);
                    tempoFinePagamento = simulazione.eventoPagamento.prossimoEvento;
                    simulazione.listaEventi.aggiungi(EventoPagamento(tempoFinePagamento, autista));
                    assegnata = true;

                    break;
                end
            end

            % se non è stata trovata una cassa libera, aggiungo l'autista
            % in coda
            if ~assegnata
                simulazione.codaCassa.aggiungi(autista);
                simulazione.storicoCodaCassa(end+1, :) = [simulazione.clock, simulazione.codaCassa.lunghezza];
            end

        end

    end
end
 