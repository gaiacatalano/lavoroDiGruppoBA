classdef ListaEventi < handle % gestisce una priority queue di eventi ordinati per tempo
    
    properties
        eventi 
    end
    
    methods

        function obj = ListaEventi()
            obj.eventi = {};
        end
        
        function aggiungi(obj, nuovoEvento)

            if isempty(obj.eventi)
                obj.eventi{1} = nuovoEvento;
            else % inserisce l'evento in ordine crescente di tempo
                tempi = cellfun(@(e) e.tempo, obj.eventi);
                pos = find(tempi >= nuovoEvento.tempo, 1); % primo evento con tempo maggiore
                if isempty(pos)
                    obj.eventi{end+1} = nuovoEvento;
                else
                    obj.eventi = [obj.eventi(1:pos-1), {nuovoEvento}, obj.eventi(pos:end)];
                end
            end
        end

        
        function evento = estrai(obj)
            % estrae e restituisce il primo evento, che è quello con tempo minimo
            if isempty(obj.eventi)
                error('ListaEventi: lista vuota');
            end
            evento = obj.eventi{1};
            obj.eventi(1) = [];  % rimuove dalla lista l'evento
        end
        
        function vuota = listaVuota(obj)
            vuota = isempty(obj.eventi);
        end

    end
end