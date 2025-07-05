classdef ClienteChiosco < Cliente

    properties
        domanda
        tempoFineServizio
    end

    methods
        
        function obj = ClienteChiosco(id, tempoArrivo, domanda)
            obj@Cliente(id,tempoArrivo)
            obj.domanda = domanda;
            obj.tempoFineServizio = NaN;
        end

        function attesa = TempoAttesa(obj)
            if isnan(obj.tempoFineServizio)
                attesa = NaN;
            else
                attesa = obj.tempoFineServizio - obj.tempoArrivo;
            end
        end

    end
end