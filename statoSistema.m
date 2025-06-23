classdef statoSistema < handle

    properties
        clock
        prossimoArrivo
        interArrivalTime
        tempoArrivoCoda
        tempoTotaleAttesa
        maxClientiDaServire
        numClientiServiti
    end

    methods

        % costuttore che inizializza la classe
        function obj = statoSistema()
            obj.clock = 0;
            obj.interArrivalTime = 4;
            obj.prossimoArrivo = exprnd(obj.interArrivalTime);
            obj.tempoArrivoCoda = [];
            obj.tempoTotaleAttesa = 0;
            obj.maxClientiDaServire = 1000;
            obj.numClientiServiti = 0;
        end

        % aggiorno i valori
        function obj = aggiornoProssimoArrivo(obj)
            obj.prossimoArrivo = obj.clock + exprnd(obj.interArrivalTime);
        end

    end
end
