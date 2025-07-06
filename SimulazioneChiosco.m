classdef SimulazioneChiosco < handle      % classe che gestisce la simulazione del chiosco dei panini
    properties  
        clock
        numeroMassimoPaniniBuffer
        paniniNelBuffer
        bufferPieno
        domandaMassima 
        tempoTotaleAttesa 
        numeroClientiServiti 
        numeroClientiDaServire 
        numeroClientiPersi
        coda
        eventoArrivo
        eventoPreparazione
        prossimoID
    end

    methods
        function obj = SimulazioneChiosco(lunghezzaMassimaCoda, numeroMaxClientiChiosco, tempoInterArrivo, tempoPrepMin, tempoPrepMax)
            obj.coda = Coda(lunghezzaMassimaCoda);
            obj.eventoArrivo = GenerazioneEvento(tempoInterArrivo, @exprnd);
            obj.eventoPreparazione = GenerazioneEvento([tempoPrepMin, tempoPrepMax], @unifrnd);
            obj.clock = 0;
            obj.numeroMassimoPaniniBuffer = 6;
            obj.paniniNelBuffer = 3;
            obj.bufferPieno = false;
            obj.domandaMassima = 3;
            obj.tempoTotaleAttesa = 0;
            obj.numeroClientiServiti = 0;
            obj.numeroClientiDaServire = numeroMaxClientiChiosco;
            obj.numeroClientiPersi = 0;
            obj.prossimoID = 1;
        end

        function simula(obj)
            fprintf("Chiosco \n");
            while obj.numeroClientiServiti < obj.numeroClientiDaServire
                if obj.eventoPreparazione.prossimoEvento <= obj.eventoArrivo.prossimoEvento   % il primo evento che si verifica è il completamento del panino
                    evento = EventoCompletamentoPreparazionePanini(obj.eventoPreparazione.prossimoEvento);
                else    % il primo evento che si verifica è l'arrivo di un cliente
                    evento = EventoArrivoClienteChiosco(obj.eventoArrivo.prossimoEvento);
                end
                obj = evento.gestioneEvento(obj);
            end
            obj.numeroClientiPersi = obj.coda.numeroClientiPersi;
            tempoMedioAttesa = obj.tempoTotaleAttesa / obj.numeroClientiServiti;
            fprintf("Clienti serviti: %d\n", obj.numeroClientiServiti);
            fprintf("Clienti persi: %d\n", obj.numeroClientiPersi);
            fprintf("Tempo medio d'attesa: %.2f minuti\n", tempoMedioAttesa);
        end

        function aggiornaClientiServiti(obj)
            obj.numeroClientiServiti = obj.numeroClientiServiti + 1;
            %fprintf("Clienti serviti: %d\n", obj.numeroClientiServiti);
        end
        
    end
end