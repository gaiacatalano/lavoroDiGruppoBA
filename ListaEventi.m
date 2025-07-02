classdef ListaEventi < handle
    % ListaEventi gestisce una priority queue di eventi ordinati per tempo
    
    properties
        eventi  % array di oggetti Evento
    end
    
    methods
        function obj = ListaEventi()
            obj.eventi = Evento.empty;
        end
        
        function aggiungi(obj, nuovoEvento)
            % Inserisce l'evento in ordine crescente di tempo
            if isempty(obj.eventi)
                obj.eventi = nuovoEvento;
            else
                tempi = [obj.eventi.tempo];
                pos = find(tempi > nuovoEvento.tempo, 1); % primo evento con tempo maggiore
                if isempty(pos)
                    obj.eventi(end+1) = nuovoEvento;
                else
                    obj.eventi = [obj.eventi(1:pos-1), nuovoEvento, obj.eventi(pos:end)];
                end
            end
        end
        
        function evento = estrai(obj)
            % Estrae e restituisce il primo evento (tempo minimo)
            if isempty(obj.eventi)
                error('ListaEventi: lista vuota');
            end
            evento = obj.eventi(1);
            obj.eventi(1) = [];  % rimuove dalla lista
        end
        
        function vuota = isVuota(obj)
            vuota = isempty(obj.eventi);
        end
        
        function visualizza(obj)
            % per debug
            fprintf('Lista eventi attuale:\n');
            for k = 1:length(obj.eventi)
                fprintf('Evento tipo %s a tempo %.2f\n', class(obj.eventi(k)), obj.eventi(k).tempo);
            end
        end
    end
end