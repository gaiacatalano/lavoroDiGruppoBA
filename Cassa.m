classdef Cassa < handle
    properties
        occupata   % true se la cassa è occupata
    end
    
    methods
        function obj = Cassa()
            obj.occupata = false;
        end
        
        function occ = cassaLibera(obj)
            occ = ~obj.occupata;
        end
        
        function occupa(obj)
            obj.occupata = true;
        end
        
        function libera(obj)
            obj.occupata = false;
        end

        
    end
end