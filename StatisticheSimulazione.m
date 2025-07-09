classdef Statistiche < handle

    properties
        numeroClientiServiti
        numeroClientiPersi
        tempoMedioAttesaCoda
        tempoMedioAttesaCassa
        tempoMedioSistema
        tempoMedioInattivitaPompa
        lunghezzaMediaCoda
        lunghezzaMediaCodaCassa
    end

    methods
        function obj = Statistiche(simulazione)
            obj.numeroClientiServiti = simulazione.numeroClientiServiti;
            obj.numeroClientiPersi = simulazione.numeroClientiPersi;
            obj.tempoMedioAttesaCoda = obj.calcolaTempoMedioAttesaCoda(simulazione);
            obj.tempoMedioAttesaCassa = obj.calcolaTempoMedioAttesaCodaCassa(simulazione);
            obj.tempoMedioSistema = obj.calcolaTempoMedioSistema(simulazione);
            obj.tempoMedioInattivitaPompa = obj.calcolatempoMedioInattivitaPompa(simulazione);
            obj.lunghezzaMediaCoda = obj.calcolaLunghezzaMedia(simulazione);
            obj.lunghezzaMediaCodaCassa = obj.lunghezzaMediaCodaCassa(simulazione);
        end

  
        function attesaMedia = calcolaTempoMedioAttesaCoda(~, sim)
            attesaMedia = sim.tempoTotaleAttesa / sim.numeroClientiServiti;
        end
    
        function calcolaTempoMedioAttesaCodaCassa(~, sim)

        end

        function calcolaTempoMedioSistema(~, sim)

        end

        function calcolatempoMedioInattivitaPompa(~, sim)

        end


        function lunghezzaMedia = calcolaLunghezzaMedia(~, sim)
            storico = sim.storicoCoda; 
            tempoFinale = sim.clock;
        
            areaTotale = 0;   % area del rettangolo che ha per altezza la lunghezza al tempo t e per base l'ampiezza dell'intervallo di tempo corrispondente a quella lunghezza
            for i = 1:size(storico, 1)-1
                durata = storico(i+1,1) - storico(i,1);
                lunghezza = storico(i,2);
                areaTotale = areaTotale + durata * lunghezza;
            end

            durataFinale = tempoFinale - storico(end,1);
            areaTotale = areaTotale + durataFinale * storico(end,2);  % area ultimo rettangolo (da ultimo evento a fine simulazione)

            lunghezzaMedia = areaTotale / tempoFinale;
        end

        function calcololunghezzaMediaCodaCassa(~, sim)

        end

        function stampaStatistiche(obj)
            fprintf("Statistiche della simulazione:\n");
            fprintf("• Clienti serviti: %d\n", obj.numeroClientiServiti);
            fprintf("• Clienti persi: %d\n", obj.numeroClientiPersi);
            fprintf("• Tempo medio di attesa in coda: %.2f minuti\n", obj.tempoMedioAttesaCoda);
            fprintf("• Lunghezza media della coda: %.2f\n", obj.lunghezzaMediaCoda);
        end

    end
end