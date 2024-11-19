% Base de conhecimento para analise de problemas de veiculos

% Fatos - Sintomas e comportamentos relatados
% Estes sao os sintomas que podem ser reportados pelos usuarios.
sintoma_conhecido(motor_nao_liga).
sintoma_conhecido(luzes_fracas).
sintoma_conhecido(barulho_ao_frear).
sintoma_conhecido(pedal_freio_macio).
sintoma_conhecido(vazamento_de_oleo).
sintoma_conhecido(motor_superaquecido).

% Regras - Identificacao de problemas com base nos sintomas
% Estas regras correlacionam os sintomas com problemas comuns em veiculos.

% Regra para identificar que o problema e bateria fraca
problema(bateria_fraca) :- 
    sintoma(motor_nao_liga), 
    sintoma(luzes_fracas).

% Regra para identificar problemas de freios desgastados
problema(freio_desgastado) :- 
    sintoma(barulho_ao_frear), 
    sintoma(pedal_freio_macio).

% Regra para identificar problemas de vazamento de oleo
problema(vazamento_oleo_motor) :- 
    sintoma(vazamento_de_oleo).

% Regra para identificar problemas de superaquecimento do motor
problema(sistema_arrefecimento_falha) :- 
    sintoma(motor_superaquecido).

% Regras de seguranca
% Estas regras fornecem recomendacoes caso o problema identificado seja grave.

solucao(bateria_fraca, "Verifique a bateria e, se necessario, substitua.").
solucao(freio_desgastado, "Os freios precisam de manutencao imediata. Consulte um mecanico.").
solucao(vazamento_oleo_motor, "Pare o carro e procure um mecanico para avaliar o vazamento.").
solucao(sistema_arrefecimento_falha, "Verifique o sistema de arrefecimento. Nao use o veiculo ate o problema ser resolvido.").

% Regra geral de seguranca para problemas graves
conselho_seguranca :- 
    write("Este problema e grave. Leve o carro a um mecanico imediatamente.").

% Processa os sintomas fornecidos pelo usuario e os adiciona como fatos dinamicos
assertar_sintomas([]).
assertar_sintomas([Sintoma | Resto]) :-
    (   sintoma_conhecido(Sintoma)
    ->  assertz(sintoma(Sintoma))
    ;   write("Sintoma desconhecido: "), write(Sintoma), nl
    ),
    assertar_sintomas(Resto).

% Identifica o problema com base nos sintomas informados
identificar_problema :-
    problema(Problema),
    solucao(Problema, Solucao),
    nl,
    write("Problema identificado: "), write(Problema), nl,
    write("Solucao sugerida: "), write(Solucao), nl,
    conselho_seguranca, !.
identificar_problema :-
    nl,
    write("Nao foi possivel identificar o problema com os sintomas fornecidos. Consulte um mecanico."), nl.

% Interface do usuario
diagnosticar :-
    limpar, % Limpa os fatos dinamicos previamente adicionados
    write("Digite os sintomas do seu veiculo em formato de lista (ex: [motor_nao_liga, luzes_fracas, barulho_ao_frear, pedal_freio_macio]): "),
    nl,
    read(SintomasUsuario), % Le os sintomas como uma lista
    assertar_sintomas(SintomasUsuario), % Processa os sintomas
    identificar_problema.

% Limpa os sintomas adicionados para a proxima consulta
limpar :-
    retractall(sintoma(_)).
