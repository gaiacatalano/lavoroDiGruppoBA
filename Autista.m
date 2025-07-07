classdef Autista < Cliente

    properties
        tempoInizioRifornimento
        tempoFineRifornimento
        tempoInizioPagamento 
        tempoFinePagamento
        tempoUscita % tempo uscita totale dalla stazione di servizio
        bocchettaDestra % bool = 1 se lato bocchetta è destro
        aspettaUscita % bool = 1 se cliente ha pagato e aspetta di poter uscire
        idPompaAssegnata
        idCassaAssegnata
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
            obj.idCassaAssegnata = NaN;
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
            obj.aspettaUscita = true;
        end

        function obj = assegnaPompa(obj, pompa)
            obj.idPompaAssegnata = pompa.id;
        end

        function obj = assegnaCassa(obj, cassa)
            obj.idCassaAssegnata = cassa.id;
        end

    end


end
