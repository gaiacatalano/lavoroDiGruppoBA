classdef EventoPagamento < Evento

    properties
        autista
    end

    methods

        function obj= EventoPagamento(tempoFinePagamento, autista)
                obj@Evento(tempoFinePagamento);
                obj.autista = autista;
        end

        function  simulazione = gestioneEvento(obj, simulazione)
            simulazione.clock = obj.tempo;

            % recupero dall'autista le informazioni sulla pompa che ha
            % usato e sulla cassa in cui deve pagare
            pompa = simulazione.pompe(obj.autista.idPompaAssegnata);
            cassa = simulazione.casse{obj.autista.idCassaAssegnata};

            obj.autista.tempoFinePagamento = simulazione.clock;

            % aggiorno codaCassa
            cassa.libera();
            simulazione.aggiornaClientiServitiCassa();

           % se ci sono clienti in coda per pagare, creo eventi di tipo
           % EventoPagamento
           if ~isempty(simulazione.codaCassa.clienti) 
               prossimoCliente = simulazione.codaCassa.rimuovi();
               simulazione.storicoCodaCassa(end+1, :) = [simulazione.clock, simulazione.codaCassa.lunghezza];
               GestoreStazione.gestisciIngressiCasse(simulazione, prossimoCliente);
           end

           % devo controllare il lato della pompa in cui ha fatto
           % rifornimeno il cliente che ha pagato

           if obj.autista.bocchettaDestra 
                prima = 1;
                seconda = 2;
           else
               prima = 3;
               seconda = 4;
            end

            % se il cliente che ha pagato era nella prima pompa se ne puo' andare
            if pompa.id == prima
                obj.autista.tempoUscita = simulazione.clock;
                simulazione.aggiornaTotaleSistema(obj.autista.TempoAttesa());
                pompa.aggiornaTempoTotaleInattivita(obj.autista);
                pompa.libera();  
                simulazione.aggiornaClientiUsciti();

                % controllo se c'è un cliente nella pompa dietro che aspetta
                % e eventualmente lo faccio uscire dalla stazione       
                if ~isempty(simulazione.pompe(seconda).cliente) && simulazione.pompe(seconda).cliente.aspettaUscita
                    simulazione.pompe(seconda).cliente.tempoUscita = simulazione.clock();
                    simulazione.aggiornaTotaleSistema(simulazione.pompe(seconda).cliente.TempoAttesa());
                    simulazione.pompe(seconda).aggiornaTempoTotaleInattivita(simulazione.pompe(seconda).cliente);
                    simulazione.pompe(seconda).libera();
                    simulazione.aggiornaClientiUsciti();
                end       

            % se il cliente che ha pagato è nella pompa dietro
            else 
                % se la pompa davanti è libera, se ne va
                if simulazione.pompe(prima).pompaLibera()
                    obj.autista.tempoUscita = simulazione.clock;
                    simulazione.aggiornaTotaleSistema(obj.autista.TempoAttesa());
                    pompa.aggiornaTempoTotaleInattivita(obj.autista);
                    pompa.libera(); 
                    simulazione.aggiornaClientiUsciti();
                else % deve aspettare che liberi la pompa quello davanti
                    obj.autista.inAttesa();
                end
            end
            
            % gestisco i nuovi rifornimenti, ammettendo le persone
            % eventualmente in coda
            assegnato = true;
            while assegnato && ~isempty(simulazione.codaRifornimento.clienti)
                prossimoAutista = simulazione.codaRifornimento.clienti{1};
                assegnato = GestoreStazione.gestisciIngressiRifornimento(simulazione, prossimoAutista);
                if assegnato
                    simulazione.codaRifornimento.rimuovi();
                    simulazione.storicoCodaRifornimento(end+1, :) = [simulazione.clock, simulazione.codaRifornimento.lunghezza];
                end
            end          
        end

         

    
    end

end