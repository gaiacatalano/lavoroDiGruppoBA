classdef Coda < handle
    properties
        lunghezzaCoda
        lunghezzaMassimaCoda
        numClientiPersi
        numClientiServiti
        clientiCoda 
        codaPiena 
    end

    methods
        function obj = Coda(lunghezzaMassimaCoda)
            obj.lunghezzaMassimaCoda = lunghezzaMassimaCoda;
            obj.lunghezzaCoda = 0;
            obj.numClientiServiti = 0;
            obj.numClientiPersi = 0;
            obj.clientiCoda = Cliente.empty;
            obj.codaPiena = false;
        end

        function AggiungoInCoda(obj, cliente)
            if obj.lunghezzaCoda < obj.lunghezzaMassimaCoda
                obj.clientiCoda(end + 1) = cliente;
                obj.lunghezzaCoda = obj.lunghezzaCoda + 1;
            else
                obj.codaPiena = true;
                obj.numClientiPersi = obj.numClientiPersi + 1;
            end
        end

        function cliente = RimuovoDallaCoda(obj)
            if obj.lunghezzaCoda > 0
                cliente = obj.clientiCoda(1);
                obj.clientiCoda(1) = []; % Remove the first customer
                obj.lunghezzaCoda = obj.lunghezzaCoda - 1;
                obj.numClientiServiti = obj.numClientiServiti + 1;
            else
                cliente = Cliente.empty;
            end
        end

        function cliente = InfoPrimoCoda(obj)
            if obj.lunghezzaCoda > 0
                cliente = obj.clientiCoda(1);
            else
                cliente = Cliente.empty;
            end
        end
    end
end