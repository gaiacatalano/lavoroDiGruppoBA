classdef Coda < handle   

    properties
        clienti % lista di clienti nella coda
        lunghezza % lunghezza attuale coda
        lunghezzaMassima
        numeroClientiPersi  
    end

    methods

        function obj = Coda(lunghezzaMassima)
            obj.clienti = {};
            obj.lunghezza = 0;
            obj.lunghezzaMassima = lunghezzaMassima;
            obj.numeroClientiPersi = 0;
        end

        % funzione che aggiunte il cliente in coda
        function aggiungi(obj, cliente)
            if obj.lunghezza < obj.lunghezzaMassima
                obj.clienti{end+1} = cliente;    
                obj.lunghezza = obj.lunghezza + 1;
            else
                obj.numeroClientiPersi = obj.numeroClientiPersi + 1;
            end
        end

        % funzione che rimuove il cliente dalla coda
        function cliente = rimuovi(obj)
            if  ~isempty(obj.clienti)       
                cliente = obj.clienti{1};
                obj.clienti(1) = [];       
                obj.lunghezza = obj.lunghezza - 1;
            else
                cliente = [];
            end
        end

        % funzione che restituisce il primo cliente senza rimuoverlo
        function cliente = primo(obj)    
            if ~isempty(obj.clienti)
                cliente = obj.clienti{1};
            else
                cliente = [];
            end
        end

        % funzione che riduce di 1 la domanda del primo cliente in coda
        function decrementaDomanda(obj)  
            if ~isempty(obj.clienti)
                obj.clienti{1}.domanda = obj.clienti{1}.domanda - 1;
            end
        end

    end
    
end