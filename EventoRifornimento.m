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
            % pompa, deve prima pagare

            % se la coda in cassa non è vuota
            if ~isempty(simulazione.codaCassa.clienti)   
                simulazione.codaCassa.aggiungi(obj.autista);  % si mette in coda
            else % se la coda è vuota, gestisco l'ingresso in cassa
                GestoreStazione.gestisciIngressiCasse(simulazione, obj.autista);
            end
        end
    end
end