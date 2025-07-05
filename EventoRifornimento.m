classdef EventoRifornimento < Evento

    properties
        autista
    end

    methods
        function obj= EventoRifornimento(tempoFineRifornimento, autista)
            obj@Evento(tempoFineRifornimento);
            obj.autista = autista;
        end

        function  simulazione = gestioneEvento(obj, simulazione)
            simulazione.clock = obj.tempo;
            
            obj.autista.tempoFineRifornimento = simulazione.clock;
            % il cliente finisce il rifornimento, ma non libera ancora la
            % pompa

            %il cliente deve pagare in cassa
            if ~isempty(simulazione.codaCassa.clienti)    % se la coda non è vuota
                simulazione.codaCassa.aggiungi(obj.autista);  % cliente arriva e si mette in coda
            else %se la coda è vuota
                if simulazione.cassa.cassaLibera() %se la cassa è libera pago immediatamente
                    simulazione.cassa.occupa();
                    obj.autista.tempoInizioPagamento = simulazione.clock;
                    simulazione.eventoPagamento.generaProssimoEvento(simulazione.clock);
                    tempoFinePagamento = simulazione.eventoPagamento.prossimoEvento;
                    simulazione.listaEventi.aggiungi(EventoPagamento(tempoFinePagamento, obj.autista));
                else
                    simulazione.codaCassa.aggiungi(obj.autista); 
                end

            end

        end
    end
end