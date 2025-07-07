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
        prossimoID % contatore per assegnare un id all'autista
        pompe % array di oggetti di tipo Pompa
        listaEventi % lista contenente gli eventi da gestire
        casse % cell array di oggetti di tipo Cassa
    end

    methods
        
        function obj = SimulazioneBenzinaio(lunghezzaMassimaCoda, numeroMaxClientiBenzinaio, tempoInterArrivo, tempoRifMin, tempoRifMax, tempoPagMin, tempoPagMax, numeroCasse)

            % distinzione tra caso con una sola cassa o con due casse
            if nargin < 8
                numeroCasse = 1; 
            end
            obj.casse = cell(1, numeroCasse);
            for i = 1:numeroCasse
                obj.casse{i} = Cassa(i); 
            end

            obj.clock = 0;
            obj.numeroMassimoPompe = 2; % ci sono 4 pompe, ma 2 per lato
            obj.tempoTotaleAttesaRifornimento = 0;
            obj.tempoTotaleAttesaCassa = 0;
            obj.tempoTotale = 0;
            obj.numeroClientiServiti = 0;
            obj.numeroClientiDaServire = numeroMaxClientiBenzinaio;
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
     
        % funzione che simula il funzionamento del benzinaio
        function simula(obj)

            % genero il primo evento possibile che è un arrivo di un cliente
            primoEvento = EventoArrivoClienteStazioneRifornimento(obj.eventoArrivo.prossimoEvento);
            obj.listaEventi.aggiungi(primoEvento);

            % finché ci sono ancora clienti da servire e ho eventi da gestire
            while obj.numeroClientiServiti < obj.numeroClientiDaServire && ~obj.listaEventi.listaVuota()

                % estraggo il primo evento
                evento = obj.listaEventi.estrai();

                % gestisco l'evento
                obj = evento.gestioneEvento(obj);
            end
            
            obj.numeroClientiPersi = obj.codaRifornimento.numeroClientiPersi;
            fprintf("Clienti serviti: %d\n", obj.numeroClientiServiti);
            fprintf("Clienti persi: %d\n", obj.numeroClientiPersi);
        end

        % funzione che aggiorna il numero di clienti serviti
        function aggiornaClientiServiti(obj)
            obj.numeroClientiServiti = obj.numeroClientiServiti + 1;
        end
    end

end
