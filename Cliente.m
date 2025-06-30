classdef Cliente < handle
    properties
        id
        tempoArrivo
        domanda
        tempoInizioServizio
    end

    methods
        function obj = Cliente(id, tempoArrivo, domanda)
            obj.id = id;
            obj.tempoArrivo = tempoArrivo;
            obj.domanda = domanda;
            obj.tempoInizioServizio = NaN;
        end

        function attesa = TempoAttesa(obj)
            if isnan(obj.tempoInizioServizio)
                attesa = NaN;
            else
                attesa = obj.tempoInizioServizio - obj.tempoArrivo;
            end
        end
    end
end