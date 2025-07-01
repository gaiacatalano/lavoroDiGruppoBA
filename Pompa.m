classdef Pompa < handle
    
    properties
        occupata
        cliente
    end

    methods
        function obj = Pompa()
            obj.cliente = [];
            obj.occupata = false;
        end

        function compatibile = compatibileCon(obj, latoCliente)
            compatibile = strcmp(obj.latoCompatibile, latoCliente);
        end
    end
end
