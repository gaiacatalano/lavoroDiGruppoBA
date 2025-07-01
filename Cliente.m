classdef Cliente < handle
    
    properties
        id
        tempoArrivo 
    end

    methods
        function obj = Cliente(id, tempoArrivo)
            obj.id = id;
            obj.tempoArrivo = tempoArrivo;
        end
    end
end