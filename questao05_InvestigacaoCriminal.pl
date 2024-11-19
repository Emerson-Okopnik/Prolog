% Base de Conhecimento Inicial

% Suspeitos
suspeito(joao).
suspeito(maria).
suspeito(carlos).

% Base de evidencias e fatos dinamicos
:- dynamic impressao_digital/2.
:- dynamic motivo/2.
:- dynamic testemunha/2.
:- dynamic relacao/2.

% Regras para identificar suspeitos
suspeito_recomendado(Suspeito) :-
    impressao_digital(Suspeito, lugar_crime),
    motivo(Suspeito, Motivo),
    format('~w e um suspeito devido a presenca no lugar do crime e motivo: ~w.~n', [Suspeito, Motivo]).

suspeito_recomendado(Suspeito) :-
    testemunha(Suspeito, Testemunho),
    format('~w e um suspeito devido ao testemunho: ~w.~n', [Suspeito, Testemunho]).

% Regras para teorias do crime
teoria(Suspeito, crime_passional) :-
    testemunha(Suspeito, visto_discutindo),
    relacao(Suspeito, intima),
    format('A teoria do crime passional e sugerida devido ao testemunho e relacao intima de ~w.~n', [Suspeito]).

teoria(Suspeito, crime_planejado) :-
    impressao_digital(Suspeito, lugar_crime),
    motivo(Suspeito, financeiro),
    format('A teoria do crime planejado e sugerida devido ao motivo financeiro e presenca de ~w no lugar do crime.~n', [Suspeito]).

teoria(Suspeito, ato_impulsivo) :-
    testemunha(Suspeito, proximidade_tempo),
    motivo(Suspeito, vinganca),
    format('A teoria de ato impulsivo e sugerida devido a proximidade temporal e motivo de vinganca de ~w.~n', [Suspeito]).

% Funcao interativa para o usuario
iniciar_investigacao :-
    write('=== Sistema de Investigacao Criminal ==='), nl,
    write('Escolha o suspeito para investigar (joao, maria, carlos): '),
    read(Suspeito),
    (suspeito(Suspeito) ->
        perguntar_evidencias(Suspeito),
        analisar_caso(Suspeito)
    ;
        write('Suspeito invalido. Tente novamente.'), nl, iniciar_investigacao).

perguntar_evidencias(Suspeito) :-
    format('Ha impressoes digitais de ~w no local do crime? (sim/nao): ', [Suspeito]),
    read(Resposta1),
    (Resposta1 == sim -> assert(impressao_digital(Suspeito, lugar_crime)) ; true),
    format('~w tem um motivo financeiro? (sim/nao): ', [Suspeito]),
    read(Resposta2),
    (Resposta2 == sim -> assert(motivo(Suspeito, financeiro)) ; true),
    format('Ha testemunhas que viram ~w proximo ao local do crime? (sim/nao): ', [Suspeito]),
    read(Resposta3),
    (Resposta3 == sim -> assert(testemunha(Suspeito, proximidade_tempo)) ; true),
    format('~w tem uma relacao intima com a vitima? (sim/nao): ', [Suspeito]),
    read(Resposta4),
    (Resposta4 == sim -> assert(relacao(Suspeito, intima)) ; true).

% Analise focada em um unico suspeito
analisar_caso(Suspeito) :-
    write('=== Analise do Caso ==='), nl,
    (suspeito_recomendado(Suspeito) ; write('Nenhuma evidencia concreta contra este suspeito.'), nl),
    (teoria(Suspeito, _) ; write('Nenhuma teoria se aplica a este suspeito.'), nl).
