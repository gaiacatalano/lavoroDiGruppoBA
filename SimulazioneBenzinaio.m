classdef SimulazioneBenzinaio < handle

    properties
        clock
        numeroMassimoPompe
        tempoTotaleAttesaRifornimento
        tempoTotaleAttesaCassa
        tempoTotale
        numeroClientiServiti
        numeroClientiDaServire
        numeroClientiPersi
        codaRifornimento
        codaCassa
        eventoArrivo
        eventoRifornimento
        eventoPagamento
        prossimoID
        pompe
        listaEventi
    end

    methods
        
        function obj = SimulazioneBenzinaio(lunghezzaMassimaCoda, tempoInterArrivo, tempoRifMin, tempoRifMax, tempoPagMin, tempoPagMax)
            obj.clock = 0;
            obj.numeroMassimoPompe = 2; % ho 4 pompe, ma 2 per parte
            obj.tempoTotaleAttesaRifornimento = 0;
            obj.tempoTotaleAttesaCassa = 0;
            obj.tempoTotale = 0;
            obj.numeroClientiServiti = 0;
            obj.numeroClientiDaServire = 0;
            obj.numeroClientiPersi = 0;
            obj.codaRifornimento = Coda(lunghezzaMassimaCoda);
            obj.codaCassa = Coda(2*obj.numeroMassimoPompe);
            obj.eventoArrivo = GenerazioneEvento(tempoInterArrivo, @exprnd);
            obj.eventoRifornimento = GenerazioneEvento([tempoRifMin, tempoRifMax], @unifrnd);
            obj.eventoPagamento = GenerazioneEvento([tempoPagMin, tempoPagMax], @unifrnd);
            obj.prossimoID = 1;
            obj.pompe = [Pompa(1,"destra"), Pompa(2,"destra"), Pompa(3,"sinistra"), Pompa(4,"sinistra")];
            obj.listaEventi = ListaEventi();
        end

        function simula(obj)
            while obj.numeroClientiServiti < obj.numeroClientiDaServire
                if obj.eventoArrivo.prossimoEvento < min(obj.eventoRifornimento.prossimoEvento, obj.eventoPagamento.prossimoEvento)
                    evento = EventoArrivoClienteStazioneRifornimento(%%%%%);
                elseif obj.eventoRifornimento.prossimoEvento  < min(obj.eventoArrivo.prossimoEvento, obj.eventoPagamento.prossimoEvento)
                    evento = EventoRifornimento(%%%%%);
                else
                    evento = EventoPagamento(%%%%%);
                end            
            end
        end

    end

        % stampe varie
end
