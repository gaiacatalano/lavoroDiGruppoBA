classdef Pompa < handle
    
    properties
        id
        occupata % bool = 1 se la pompa è occupata
        cliente
        lato
        tempoRifornimento
        numClienti
        tempoTotaleInattivita
    end

    methods
        function obj = Pompa(id,lato)
            obj.id = id;
            obj.occupata = false;
            obj.lato = lato;
            obj.cliente = [];
            obj.tempoRifornimento = NaN;
            obj.numClienti = 0;
            obj.tempoTotaleInattivita = 0;
        end
        
        % funzione che occupa la pompa, assegnandole un cliente
        function obj = assegnaCliente(obj, cliente,tempoRifornimento)
            obj.occupata = true;
            obj.cliente = cliente;
            obj.tempoRifornimento = tempoRifornimento;
            obj.numClienti = obj.numClienti + 1;
        end
        
        % funzione che controlla se la pompa è libera
        function libera = pompaLibera(obj)
            libera = ~obj.occupata;
        end

        % funzione che libera la pompa
        function obj = libera(obj)
            obj.occupata = false;
            obj.cliente = [];
        end

        function aggiornaTempoTotaleInattivita(obj, autista)
            obj.tempoTotaleInattivita = obj.tempoTotaleInattivita + (autista.tempoUscita - autista.tempoFineRifornimento);
        end

    end
end
