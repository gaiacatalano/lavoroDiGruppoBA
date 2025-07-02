classdef EventoRifornimento < Evento

    properties
        idPompa
    end

    methods
        function obj= EventoRifornimento(tempoFineRifornimento, idPompa)
            obj@Evento(tempoFineRifornimento);
            obj.idPompa = idPompa;
        end

        function  simulazione = gestioneEvento(obj, simulazione)
            simulazione.clock = obj.tempo;
            autista = simulazione.pompe(obj.idPompa).cliente;
            autista.tempoFineRifornimento = simulazione.clock;
            % il cliente finisce il rifornimento, ma non libera ancora la
            % pompa

            %il cliente deve pagare in cassa
            if ~isempty(simulazione.codaCassa.clienti)    % se la coda non è vuota
                simulazione.codaCassa.aggiungi(autista);  % cliente arriva e si mette in coda
            else %se la coda è vuota
                if simulazione.cassa.cassaLibera() %se la cassa è libera pago immediatamente
                    simulazione.Cassa.occupa();
                    autista.tempoInizioPagamento = simulazione.clock;
                    simulazione.eventoPagamento.generaProssimoEvento(simulazione.clock);
                    tempoFinePagamento = simulazione.eventoPagamento.prossimoEvento;
                    simulazione.listaEventi.aggiungi(EventoPagamento(tempoFinePagamento));
                else
                    simulazione.codaCassa.aggiungi(autista); 
                end

            end

        end
    end
end