classdef Statistiche < handle

    properties
        numeroClientiServiti
        numeroClientiPersi
        tempoMedioAttesaCoda
        lunghezzaMediaCoda
    end

    methods
        function obj = Statistiche(simulazione)
            obj.numeroClientiServiti = simulazione.numeroClientiServiti;
            obj.numeroClientiPersi = simulazione.numeroClientiPersi;
            obj.tempoMedioAttesaCoda = 0;
            obj.lunghezzaMediaCoda = 0;
        end

        function attesaMedia = calcolaTempoMedioAttesaCoda(~, tempoTotaleAttesa, numeroClientiServiti)
            attesaMedia = tempoTotaleAttesa / numeroClientiServiti;
        end

        function lunghezzaMedia = calcolaLunghezzaMedia(~,sim, storico)
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

        function stampaStatistiche(obj, sim)
            if isprop(sim, 'pompe')
                fprintf("Statistiche della simulazione Benzinaio:\n");
                fprintf("- Clienti serviti: %d\n", sim.numeroClientiServiti);
                fprintf("- Clienti persi: %d\n", sim.numeroClientiPersi);
                fprintf("- Tempo medio di attesa in coda per il rifornimento: %.2f minuti\n", calcolaTempoMedioAttesaCoda(obj,sim.tempoTotaleAttesaRifornimento, sim.numeroClientiServiti));
                fprintf("- Lunghezza media della coda per il rifornimento: %.2f\n",calcolaLunghezzaMedia(obj, sim, sim.storicoCodaRifornimento));
                fprintf("- Tempo medio di attesa in coda per il pagamento: %.2f minuti\n", calcolaTempoMedioAttesaCoda(obj,sim.tempoTotaleAttesaCassa, sim.numeroClientiServiti));
                fprintf("- Lunghezza media della coda per il pagamento: %.2f\n",calcolaLunghezzaMedia(obj, sim, sim.storicoCodaCassa));
                fprintf("- Tempo medio di permanenza nel sistema: %.2f minuti\n", calcolaTempoMedioAttesaCoda(obj,sim.tempoTotale, sim.numeroClientiServiti));
                
            else
                fprintf("Statistiche della simulazione Chiosco di Panini:\n");
                fprintf("- Clienti serviti: %d\n", sim.numeroClientiServiti);
                fprintf("- Clienti persi: %d\n", sim.numeroClientiPersi);
                fprintf("- Tempo medio di attesa in coda: %.2f minuti\n", calcolaTempoMedioAttesaCoda(obj,sim.tempoTotaleAttesa, sim.numeroClientiServiti));
                fprintf("- Lunghezza media della coda: %.2f\n",calcolaLunghezzaMedia(obj, sim, sim.storicoCoda));
            end
        end

    end
end