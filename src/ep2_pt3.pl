:- [ep2_pt1].
:- [ep2_pt2].

pesquisa(X, S0, S):-
    S0=[quem|S1],
    predicado(Z, V, S1, S2),
    \+ disciplina(S2, A, S3),
    leciona(A, Zs).

pesquisa(X, S0, S):-
    S0=[quem|S1],
    predicado(Z, V, S1, S2),
    artigo(S2, S3),
    S3=[que|S4],
    lecionam(X, Zs).

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

consulta(X):- 
    monta_lista(L),
    pesquisa(A, L, []).

fato(X):- 
    monta_lista(L),
    sentenca(A, L, []).

