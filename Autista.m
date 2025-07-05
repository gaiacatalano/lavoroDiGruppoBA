classdef Autista < Cliente

    properties
        tempoInizioRifornimento
        tempoFineRifornimento
        tempoInizioPagamento 
        tempoFinePagamento
        tempoUscita 
        bocchettaDestra % bool
        aspettaUscita % bool che mi dice se il cliente sta aspettando dopo aver pagato
        idPompaAssegnata
    end

    methods
        function obj = Autista(id, tempoArrivo, bocchettaDestra)
            obj@Cliente(id,tempoArrivo)
            obj.bocchettaDestra = bocchettaDestra;
            obj.tempoInizioRifornimento = NaN;
            obj.tempoFineRifornimento = NaN;
            obj.tempoInizioPagamento = NaN; 
            obj.tempoUscita = NaN;
            obj.aspettaUscita = false;
            obj.idPompaAssegnata = NaN;
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

        function inAttesa(obj)
            obj.aspettaUscita = true; % Set the waiting status to true
        end

        function obj = assegnaPompa(obj, pompa)
            obj.idPompaAssegnata = pompa.id;
        end


    end


end
