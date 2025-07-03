classdef EventoArrivoClienteStazioneRifornimento < Evento
    
    methods

        function simulazione = gestioneEvento(obj, simulazione)
            simulazione.clock = obj.tempo;
            simulazione.eventoArrivo.generaProssimoEvento(simulazione.clock);
            tempoProssimoArrivo = simulazione.eventoArrivo.prossimoEvento;
            simulazione.listaEventi.aggiungi(EventoArrivoClienteStazioneRifornimento(tempoProssimoArrivo))

            bocchettaDestra = rand() < 0.5; % true con prob 1/2, false con prob 1/2
            autista = Autista(simulazione.prossimoID, simulazione.clock, bocchettaDestra);
            simulazione.prossimoID = simulazione.prossimoID + 1;

             if ~isempty(simulazione.codaRifornimento.clienti)    % se la coda non è vuota
                simulazione.codaRifornimento.aggiungi(autista);  % cliente arriva e si mette in coda
             else % se la coda è vuota controllo se c'è un posto libero compatibile

                % if autista.bocchettaDestra %assegno gli id delle due pompe
                %     prima = 1;
                %     seconda = 2;
                % else
                %    prima = 3;
                %    seconda = 4;
                % end
                % 
                % if  simulazione.pompe(seconda).pompaLibera() %se la seconda pompa è libera posso fare rifornimento
                %     autista.tempoInizioRifornimento = simulazione.clock;
                %     simulazione.eventoRifornimento.generaProssimoEvento(simulazione.clock);
                %     tempoFineRifornimento = simulazione.eventoRifornimento.prossimoEvento;
                %     if simulazione.pompe(prima).pompaLibera() %se anche la prima è libera mi posiziono nella prima
                %         simulazione.pompe(prima).assegnaCliente(autista,tempoFineRifornimento);
                %         simulazione.listaEventi.aggiungi(EventoRifornimento(tempoFineRifornimento,prima, autista));
                %     else%altrimenti mi posiziono nella seconda
                %         simulazione.pompe(seconda).assegnaCliente(autista,tempoFineRifornimento);
                %         simulazione.listaEventi.aggiungi(EventoRifornimento(tempoFineRifornimento,seconda, autista));
                %     end
                    assegnato = gestoreIngressi.gestisciIngressiDaCoda(simulazione, autista);
               
                    
                if ~assegnato %se non ci sono pompe compatibili disponibili mi metto in coda
                    simulazione.codaRifornimento.aggiungi(autista);
            
                end
             end


        end
    end
end