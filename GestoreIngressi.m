classdef GestoreIngressi < handle

    methods(Static)
       

        function assegnato = gestisciIngressiDaCoda(simulazione, autista)

            assegnato = false;

           if autista.bocchettaDestra
                prima = 1;
                seconda = 2;
            else
                prima = 3;
                seconda = 4;
            end

            if simulazione.pompe(seconda).pompaLibera() %se la seconda pompa è libera posso fare rifornimento
                autista.tempoInizioRifornimento = simulazione.clock;
                assegnato = true;
                simulazione.eventoRifornimento.generaProssimoEvento(simulazione.clock);
                tempoFineRifornimento = simulazione.eventoRifornimento.prossimoEvento;
                if simulazione.pompe(prima).pompaLibera() %se anche la prima è libera mi posiziono nella prima
                    simulazione.pompe(prima).assegnaCliente(autista,tempoFineRifornimento);
                    simulazione.listaEventi.aggiungi(EventoRifornimento(tempoFineRifornimento,prima, autista));
                else %altrimenti mi posiziono nella seconda
                    simulazione.pompe(seconda).assegnaCliente(autista,tempoFineRifornimento);
                    simulazione.listaEventi.aggiungi(EventoRifornimento(tempoFineRifornimento,seconda, autista));
                end
            end
        end
        

    end
end
 