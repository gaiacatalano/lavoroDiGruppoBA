classdef Coda < handle   % Coda con capacità massima e disciplina FIFO
    properties
        clienti
        lunghezza
        lunghezzaMassima
        numeroClientiServiti
        numeroClientiPersi  
    end

    methods
        function obj = Coda(lunghezzaMassima)
            obj.clienti = {};
            obj.lunghezza = 0;
            obj.lunghezzaMassima = lunghezzaMassima;
            obj.numeroClientiServiti = 0;
            obj.numeroClientiPersi = 0;
        end

        % function flagCodaVuota = codaVuota(obj)
        %     flagCodaVuota = (obj.lunghezza == 0);
        % end

        function aggiungi(obj, cliente)
            if obj.lunghezza < obj.lunghezzaMassima
                obj.clienti{end+1} = cliente;    
                obj.lunghezza = obj.lunghezza + 1;
                fprintf('Cliente aggiunto. Lunghezza coda: %d\n', obj.lunghezza);
            else
                obj.numeroClientiPersi = obj.numeroClientiPersi + 1;
            end
        end

        function cliente = rimuovi(obj)
            if  ~isempty(obj.clienti)       % se la coda è non vuota, c'è almeno un cliente in coda
                cliente = obj.clienti{1};
                obj.clienti(1) = [];       % rimuove il primo cliente in coda
                obj.numeroClientiServiti = obj.numeroClientiServiti + 1;
                fprintf("Clienti serviti: %d\n", obj.numeroClientiServiti);
                obj.lunghezza = obj.lunghezza - 1;
            else
                cliente = [];
            end
        end

        function cliente = primo(obj)    % restituisce il primo cliente senza rimuoverlo
            if ~isempty(obj.clienti)
                cliente = obj.clienti{1};
            else
                cliente = [];
            end
        end

        function decrementaDomanda(obj)  % riduco di 1 la domanda del primo cliente in coda
            if ~isempty(obj.clienti)
                obj.clienti{1}.domanda = obj.clienti{1}.domanda - 1;
            end
        end
    end
end