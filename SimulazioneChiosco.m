classdef SimulazioneChiosco < handle      % classe che gestisce la simulazione del chiosco dei panini
    properties  
        clock = 0
        numeroMassimoPaniniBuffer = 6
        paniniNelBuffer = 3
        bufferPieno = false
        domandaMassima = 3
        tempoTotaleAttesa = 0
        numeroClientiServiti = 0
        numeroClientiDaServire = 1000
        coda
        eventoArrivo
        eventoPreparazione
        prossimoID = 1
    end

    methods
        function obj = SimulazioneChiosco(lunghezzaMassimaCoda, tempoInterArrivo, tempoPrepMin, tempoPrepMax)
            obj.coda = Coda(lunghezzaMassimaCoda);
            obj.eventoArrivo = GenerazioneEvento(tempoInterArrivo, @exprnd);
            obj.eventoPreparazione = GenerazioneEvento([tempoPrepMin, tempoPrepMax], @unifrnd);
        end

        function simula(obj)
            while obj.numeroClientiServiti < obj.numeroClientiDaServire
                if obj.eventoPreparazione.prossimoEvento <= obj.eventoArrivo.prossimoEvento   % il primo evento che si verifica è il completamento del panino
                    evento = EventoCompletamentoPreparazionePanini(obj.eventoPreparazione.prossimoEvento);
                else    % il primo evento che si verifica è l'arrivo di un cliente
                    evento = EventoArrivoClienteChiosco(obj.eventoArrivo.prossimoEvento);
                end
                obj = evento.gestioneEvento(obj);
            end

            tempoMedioAttesa = obj.tempoTotaleAttesa / obj.numeroClientiServiti;
            fprintf("Clienti serviti: %d\n", obj.numeroClientiServiti);
            fprintf("Tempo medio d'attesa: %.2f minuti\n", tempoMedioAttesa);
        end
    end
end