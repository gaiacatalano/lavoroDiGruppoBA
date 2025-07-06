classdef GestoreIngressi < handle

    methods(Static)
       

        function assegnato = gestisciIngressiDaCoda(simulazione, autista)

            

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
                    autista.assegnaPompa(simulazione.pompe(prima));
                    simulazione.listaEventi.aggiungi(EventoRifornimento(tempoFineRifornimento, autista));
                else %altrimenti mi posiziono nella seconda
                    simulazione.pompe(seconda).assegnaCliente(autista,tempoFineRifornimento);
                    autista.assegnaPompa(simulazione.pompe(seconda));
                    simulazione.listaEventi.aggiungi(EventoRifornimento(tempoFineRifornimento, autista));
                end
            else
                assegnato = false;
            end
            %fprintf("Stato pompe: prima=%d libera=%d seconda=%d libera=%d\n", ...
        %prima, simulazione.pompe(prima).pompaLibera(), ...
        %seconda, simulazione.pompe(seconda).pompaLibera());
        end
        

    end
end
 