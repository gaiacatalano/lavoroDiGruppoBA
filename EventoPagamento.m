classdef EventoPagamento < Evento

    properties
        idPompa
        autista
    end

    methods

        function obj= EventoPagamento(tempoFinePagamento, idPompa, autista)
                obj@Evento(tempoFinePagamento);
                obj.idPompa = idPompa;
                obj.autista = autista;
        end
        
        function  simulazione = gestioneEvento(obj, simulazione)
            simulazione.clock = obj.tempo;

            pompa = obj.idPompa;
            obj.autista.tempoFinePagamento = simulazione.clock;

            % aggiorno codaCassa
            simulazione.cassa.libera();

           if ~isempty(simulazione.codaCassa.clienti) 
               prossimoCliente = simulazione.codaCassa.rimuovi();
               simulazione.cassa.occupa();
               prossimoCliente.tempoInizioPagamento = simulazione.clock;
               simulazione.eventoPagamento.generaProssimoEvento(simulazione.clock);
               tempoFinePagamento = simulazione.eventoPagamento.prossimoEvento;
               simulazione.listaEventi.aggiungi(EventoPagamento(tempoFinePagamento, prossimoCliente.idPompa));
           end

           if obj.autista.bocchettaDestra % controllo il lato della bocchetta = lato pompa
                prima = 1;
                seconda = 2;
           else
               prima = 3;
               seconda = 4;
            end

            % se il cliente che ha pagato era nella prima pompa
            % se ne puo' andare
            if obj.idPompa == prima
                obj.autista.tempoUscita = simulazione.clocl;
                pompa.libera();  
                % controllo che non ci sia un cliente nella pompa dietro
                % che aspetta
                if simulazione.pompe(seconda).cliente.aspettaUscita
                    simulazione.pompe(seconda).cliente.tempoUscita = simulazione.clock();
                    simulazione.pompe(seconda).libera();
                end       

            % se il cliente che ha pagato è nella pompa dietro
            else 
                % se la pompa davanti è libera, se ne va
                if simulazione.pompe(prima).pompaLibera()
                    obj.autista.tempoUscita = simulazione.clocl;
                    pompa.libera(); 
                else % sennò deve aspettare che liberi la pompa quello davanti
                    obj.autista.inAttesa();
                end
            end
            
            assegnato = true;
            while assegnato
                prossimoAutista = simulazione.codaRifornimento.clienti(1);
                assegnato = gestoreIngressi.gestisciIngressiDaCoda(simulazione, prossimoAutista);
                if assegnato
                    simulazione.codaRifornimento.rimuovi();
                end
            end          
        end

    
    end

end