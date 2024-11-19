% Base de dados de exercicios para diferentes objetivos
% Cada fato representa um exercicio especifico associado a series, repeticoes e instrucoes.

exercicio('Agachamento Livre', hipertrofia, '4 series de 10 repeticoes', 'Use uma barra com peso moderado e mantenha a postura correta.').
exercicio('Supino Reto', hipertrofia, '4 series de 8 repeticoes', 'Concentre-se na tecnica para maximizar a ativacao do peitoral.').
exercicio('Corrida na Esteira', perda_de_peso, '30 minutos em ritmo moderado', 'Mantenha um ritmo confortavel e constante.').
exercicio('Burpees', perda_de_peso, '3 series de 15 repeticoes', 'Realize movimentos explosivos para aumentar a queima calorica.').
exercicio('Prancha Abdominal', condicionamento, '3 series de 1 minuto', 'Mantenha o abdomen contraido e a coluna reta.').
exercicio('Polichinelo', condicionamento, '3 series de 20 repeticoes', 'Faca os movimentos de forma continua e com ritmo.').
exercicio('Levantamento Terra', hipertrofia, '4 series de 8 repeticoes', 'Use carga pesada e execute o movimento com controle.').

% Regras para definir planos de treino com base nos objetivos e experiencia do usuario
treino(hipertrofia) :- objetivo(ganhar_massa), experiencia(intermediario).
treino(hipertrofia) :- objetivo(ganhar_massa), experiencia(avancado).
treino(perda_de_peso) :- objetivo(emagrecer), disponibilidade(tempo_limitado).
treino(perda_de_peso) :- objetivo(emagrecer), disponibilidade(tempo_flexivel).
treino(condicionamento) :- objetivo(condicionamento_fisico).

% Interface para consulta do usuario
recomendar_treino :-
    write('Bem-vindo ao sistema de recomendacao de treinos!'), nl,
    perguntar_objetivo,
    perguntar_experiencia,
    perguntar_disponibilidade,
    sugerir_treino.

% Perguntar sobre o objetivo do usuario
perguntar_objetivo :-
    write('Qual e o seu objetivo principal na academia? (ganhar_massa, emagrecer, condicionamento_fisico): '), nl,
    read(Resposta),
    assertz(objetivo(Resposta)).

% Perguntar sobre a experiencia do usuario
perguntar_experiencia :-
    write('Qual e o seu nivel de experiencia? (iniciante, intermediario, avancado): '), nl,
    read(Resposta),
    assertz(experiencia(Resposta)).

% Perguntar sobre a disponibilidade de tempo do usuario
perguntar_disponibilidade :-
    write('Quanto tempo voce tem disponivel para treinar? (tempo_limitado, tempo_flexivel): '), nl,
    read(Resposta),
    assertz(disponibilidade(Resposta)).

% Sugerir treino com base nas respostas do usuario
sugerir_treino :-
    treino(Plano),
    format('Plano de treino recomendado: ~w~n', [Plano]),
    listar_exercicios(Plano),
    !. % Evita multiplas respostas
sugerir_treino :-
    write('Nao foi possivel recomendar um plano com base nas informacoes fornecidas. Por favor, consulte um treinador especializado.').

% Listar os exercicios associados ao plano de treino recomendado
listar_exercicios(Plano) :-
    exercicio(Exercicio, Plano, Series, Instrucoes),
    format('Exercicio: ~w~nSeries/Repeticoes: ~w~nInstrucoes: ~w~n~n', [Exercicio, Series, Instrucoes]),
    fail.
listar_exercicios(_). % Encerra o loop apos listar todos os exercicios.

% Exemplo de uso:
% ?- recomendar_treino.
