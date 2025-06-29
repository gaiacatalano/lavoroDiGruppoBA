 classdef Evento < handle
    
     properties
        parametroEvento
        distribuzione
        prossimoEvento
     end
    
    methods
        function obj = Evento(parametroEvento, distribuzione,prossimoEvento)
            obj.parametroEvento = paramtroEvento;
            obj.distribuzione = distribuzione;
            if length(parametroArrivo) == 2
                obj.prossimoEvento  =  distribuzione(parametroEvento(1),parametroEvento(2));
            else 
                obj.prossimoEvento =  distribuzione(parametroEvento);
            end
        end

        function generaProssimoEvento(obj, clock)
            if length(parametroArrivo) == 2
                obj.prossimoEvento  = clock + obj.distribuzione(obj.parametroEvento(1),obj.parametroEvento(2));
            else 
                obj.prossimoEvento = clock + obj.distribuzione(obj.parametroEvento);
            end
        end
    end 

    % Classe astratta per gestire gli eventi
    methods (Abstract)
        gestioneEvento(obj, stato)
    end
    
    
    
end