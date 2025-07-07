classdef Cassa < handle
    properties
        occupata   % bool = 1 se la cassa è occupata
        id
    end
    
    methods
        function obj = Cassa(id)
            obj.occupata = false;
            obj.id = id;
        end
        
        % funzione che controlla se la cassa è libera
        function libera = cassaLibera(obj)
            libera = ~obj.occupata;
        end
        
        % funzione che imposta la cassa a occupata
        function occupa(obj)
            obj.occupata = true;
        end
        
        % funzione che imposta la cassa a libera
        function libera(obj)
            obj.occupata = false;
        end

        
    end
end