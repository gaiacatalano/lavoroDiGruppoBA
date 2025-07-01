classdef Autista < Cliente

    properties
        tempoInizioRifornimento
        tempoFineRifornimento
        tempoInizioPagamento 
        tempoUscita 
        bocchettaDestra % bool
    end

    methods
        function obj = Autista(id, tempoArrivo, bocchettaDestra)
            obj@Cliente(id,tempoArrivo)
            obj.bocchettaDestra = bocchettaDestra;
            obj.tempoInizioRifornimento = NaN;
            obj.tempoFineRifornimento = NaN;
            obj.tempoInizioPagamento = NaN; 
            obj.tempoUscita = NaN;
        end

        function attesaRifornimento = TempoAttesaRifornimento(obj)
            if isnan(obj.tempoInizioRifornimento)
                attesaRifornimento = NaN;
            else
                attesaRifornimento = obj.tempoInizioRifornimento - obj.tempoArrivo;
            end

        end

        function attesaCassa = TempoAttesaCassa(obj)
            if isnan(obj.tempoInizioPagamento)
                attesaCassa = NaN;
            else
                attesaCassa = obj.tempoInizioPagamento - obj.tempoFineRifornimento;
            end

        end

        function attesaComplessiva = TempoAttesa(obj)
            if isnan(obj.tempoInizioServizio)
                attesaComplessiva = NaN;
            else
                attesaComplessiva = obj.tempoUscita - obj.tempoArrivo;
            end
        end

    end


end
