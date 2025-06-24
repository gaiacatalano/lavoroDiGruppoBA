 classdef evento < handle

    % Classe astratta per gestire gli eventi

    methods (Abstract)
        stato = gestioneEvento(obj, stato)
        %gestioneArrivo = gestioneArrivo(stato)
    end

    
end