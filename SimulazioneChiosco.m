classdef SimulazioneChiosco < handle 
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
        prossimoID %  contatore per assegnare un id al cliente
        storicoCoda % matrice che registra ogni variazione [tempo, lunghezza]

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
            obj.storicoCoda = [0, 0]; 
        end

        % funzione che simula il funzionamento del chiosco di panini
        function simula(obj)

            % finché ci sono ancora clienti da servire
            while obj.numeroClientiServiti < obj.numeroClientiDaServire

                % Se si verifica prima il completamento del panino,
                % creo l'evento EventoCompletamentoPreparazionePanini
                if obj.eventoPreparazione.prossimoEvento <= obj.eventoArrivo.prossimoEvento   
                    evento = EventoCompletamentoPreparazionePanini(obj.eventoPreparazione.prossimoEvento);
                else    % altrimenti creo l'evento EventoArrivoClienteChiosco
                    evento = EventoArrivoClienteChiosco(obj.eventoArrivo.prossimoEvento);
                end
                obj = evento.gestioneEvento(obj);
            end
            obj.numeroClientiPersi = obj.coda.numeroClientiPersi;

            Statistiche.stampaStatistiche(obj);
        end

        function aggiornaClientiServiti(obj)
            obj.numeroClientiServiti = obj.numeroClientiServiti + 1;
        end
        
        function aggiornaTotaleAttesa(obj,attesa)
            obj.tempoTotaleAttesa = obj.tempoTotaleAttesa + attesa;
        end
    end
end