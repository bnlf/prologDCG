:- [ep2_pt1].
:- [ep2_pt2].

pesquisa(X, S0, S):-
    S0=[quem|S1],
    predicado(Z, V, S1, S2),
    disciplina(S2, A, S3),
    leciona(A, Zs).

pesquisa(X, S0, S):-
    S0=[quando|S1],
    predicado(Z, V, S1, S2),
    disciplina(S2, A, S3),
    aulas(A, Zs).

pesquisa(X, S0, S):-
    S0=[quem|S1],
    predicado(Z, V, S1, S2),
    artigo(S2, S3),
    S3=[que|S4],
    lecionam(X, Zs).

% pesquisa(X, S0, S):-
%     artigo(S0, S1),
%     S1=[que|S2],
%     artigo(S2, S3),
%     professor(S3, A, S4),
%     predicado(Z, V, S4, S5),
%     leciona(A, Zs).

% como não terminei essa implementação, coloquei aqui para não 
% impactar o pt1
predicado(Z, V, S0, S):-
    verbo(S0, SH, ST),
    V=SH.

resposta2(X, A):-
    atom_concat(X, ' eh', P1),
    atom_concat(P1, ' aas (falta dias da semana - recursao)', P2),
    %atom_concat(dsemana(P2, X), ' aas ', P2),
    write(P2),
    nl.

resposta(X, A):-
    atom_concat('O(a) professor(a) ', X, P1),
    atom_concat(P1, ' da ', P2),
    atom_concat(P2, A, P3),
    atom_concat(P3, '.', P4),
    write(P4),
    nl.

leciona(X, Zs):-
    setof(Y, (da(Y, X), resposta(Y, X)), Ys).
lecionam(X, Zs):-
    bagof(Y, (da(Y, X), resposta(Y, X)), Ys).
aulas(X, ZS):-
    setof(Y, (eh(Y, X), resposta2(Y, X)), Ys).

consulta(X):- 
    monta_lista(L),
    pesquisa(A, L, []).

fato(X):- 
    monta_lista(L),
    sentenca(A, L, []).

