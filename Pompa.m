classdef Pompa < handle
    
    properties
        id
        occupata
        cliente
        lato
        tempoRifornimento
    end

    methods
        function obj = Pompa(id,lato)
            obj.id = id;
            obj.occupata = false;
            obj.lato = lato;
            obj.cliente = [];
            obj.tempoRifornimento = NaN;
        end

        % function compatibile = compatibileCon(obj, latoCliente)
        %     compatibile = strcmp(obj.latoCompatibile, latoCliente);
        % end
        
        function obj = assegnaCliente(obj, cliente,tempoRifornimento)
            obj.occupata = true;
            obj.cliente = cliente;
            obj.tempoRifornimento = tempoRifornimento;
        end
        
        function occ = pompaLibera(obj)
            occ = ~obj.occupata;
        end

        function obj = libera(obj)
            obj.occupata = false;
            obj.cliente = [];
        end

    end
end
