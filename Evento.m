classdef Evento < handle
    properties
        tempo % momento in cui l'evento deve essere gestito
    end

    methods
        function obj = Evento(tempo)
            obj.tempo = tempo;
        end
    end

    methods (Abstract)
        simulazione = gestioneEvento(obj, simulazione)
    end
end
