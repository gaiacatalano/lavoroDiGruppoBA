classdef GenerazioneEvento < handle

    properties
        parametroEvento
        distribuzione
        prossimoEvento
    end

    methods

        function obj = GenerazioneEvento(parametroEvento, distribuzione)
            obj.parametroEvento = parametroEvento;
            obj.distribuzione = distribuzione;

            if length(parametroEvento) == 2
                obj.prossimoEvento = distribuzione(parametroEvento(1), parametroEvento(2));
            else
                obj.prossimoEvento = distribuzione(parametroEvento);
            end
        end

        % funzione che si occupa di generare l'evento successivo in base
        % alla distribuzione di probabilità e ai parametri relativi
        % all'evento
        function generaProssimoEvento(obj, clock)
            if length(obj.parametroEvento) == 2
                obj.prossimoEvento = clock + obj.distribuzione(obj.parametroEvento(1), obj.parametroEvento(2));
            else
                obj.prossimoEvento = clock + obj.distribuzione(obj.parametroEvento);
            end
        end
    end
end