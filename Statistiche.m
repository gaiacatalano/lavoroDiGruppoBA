classdef Statistiche < handle


    methods(Static)
        
        function attesaMedia = calcolaTempoMedioAttesaCoda(tempoTotaleAttesa, numeroClientiServiti)
            attesaMedia = tempoTotaleAttesa / numeroClientiServiti;
        end
        
        %calcolo la percentuale di 
        % (frazione di tempo di inattività sul tempo totale)/(frazione di clienti che hanno utilizzato la pompa rispetto al totale di quelli che hanno fatto rifornimento)
        function tempoMedio=  calcolaTempoMedioInattivita(pompa) 
            tempoMedio =  pompa.tempoTotaleInattivita/pompa.numClienti;
        end

        function lunghezzaMedia = calcolaLunghezzaMedia(sim, storico)
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
        
        function stampaGrafico(storico)
            tempo = storico(:,1);
            lunghezzaCoda = storico(:,2);
            figure;
            hold on;
            stairs(tempo, lunghezzaCoda, 'LineWidth', 1, 'Color', 'b');
            plot(tempo, lunghezzaCoda, 'bo', 'MarkerFaceColor', 'b');
            xlabel('Tempo');
            ylabel('Lunghezza della coda');
            title('Andamento della lunghezza della coda nel tempo');
            grid on;
            legend('Lunghezza coda', 'Punti di variazione');

        end

        function stampaStatistiche(sim)
            fprintf("Statistiche: \n");
            if isprop(sim, 'pompe')
                fprintf("- Tempo durata simulazione: %.2f minuti \n", sim.clock);
                fprintf("- Clienti persi: %d \n\n", sim.numeroClientiPersi);

                fprintf("- Clienti che hanno fatto rifornimento: %d\n", sim.numeroClientiServitiRifornimento);
                fprintf("- Tempo medio di attesa in coda per il rifornimento: %.2f minuti\n", Statistiche.calcolaTempoMedioAttesaCoda(sim.tempoTotaleAttesaRifornimento, sim.numeroClientiServitiRifornimento));
                fprintf("- Lunghezza media della coda per il rifornimento: %.2f\n\n",Statistiche.calcolaLunghezzaMedia(sim, sim.storicoCodaRifornimento));
                Statistiche.stampaGrafico(sim.storicoCodaRifornimento);

                fprintf("- Clienti che hanno pagato: %d\n", sim.numeroClientiServitiCassa);
                fprintf("- Tempo medio di attesa in coda per il pagamento: %.2f minuti\n", Statistiche.calcolaTempoMedioAttesaCoda(sim.tempoTotaleAttesaCassa, sim.numeroClientiServitiCassa));
                fprintf("- Lunghezza media della coda per il pagamento: %.2f\n\n", Statistiche.calcolaLunghezzaMedia(sim, sim.storicoCodaCassa));
                
                fprintf("- Clienti serviti e usciti dal sistema: %d\n", sim.numeroClientiUsciti);
                fprintf("- Tempo medio di permanenza nel sistema: %.2f minuti\n\n", Statistiche.calcolaTempoMedioAttesaCoda(sim.tempoTotale, sim.numeroClientiUsciti));
                
                fprintf("Statistiche delle pompe di rifornimento: \n"); 
                for i = 1:4
                    pompa = sim.pompe(i);
                    fprintf("Pompa %d, per veicoli con bocchetta a %s: \n", i, pompa.lato); 
                    fprintf("- Clienti serviti dalla pompa: %d\n", pompa.numClienti);
                    fprintf("- Tempo totale di inattività: %.2f minuti\n", pompa.tempoTotaleInattivita)
                    fprintf("- Tempo medio di inattività: %.2f minuti\n\n", Statistiche.calcolaTempoMedioInattivita(pompa));

                end
                
            else
                fprintf("- Tempo durata simulazione: %.2f minuti \n", sim.clock);
                fprintf("- Clienti serviti: %d\n", sim.numeroClientiServiti);
                fprintf("- Clienti persi: %d\n", sim.numeroClientiPersi);
                fprintf("- Tempo medio di attesa in coda: %.2f minuti\n", Statistiche.calcolaTempoMedioAttesaCoda(sim.tempoTotaleAttesa, sim.numeroClientiServiti));
                fprintf("- Lunghezza media della coda: %.2f\n\n", Statistiche.calcolaLunghezzaMedia(sim, sim.storicoCoda));
                Statistiche.stampaGrafico(sim.storicoCoda)
            end
        end

    end
end