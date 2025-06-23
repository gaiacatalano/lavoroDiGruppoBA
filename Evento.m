 classdef Evento < handle
    % Classe astratta per gestire gli eventi

    methods (Abstract)
        % Metodi astratti che verranno implementati nelle sottoclassi
        prossimoEvento = generatoreEvento(obj, interarrivalTimeMedio)

    end
end