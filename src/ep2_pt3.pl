:- [ep2_pt1].
:- [ep2_pt2].

pesquisa(X, S0, S):-
    S0=[quem|S1],
    predicado(Z, V, S1, S2),
    leciona(Z, Zs).

pesquisa(X, S0, S):-
    S0=[quem|S1],
    S1=[da|S2],
    artigo(S2,S3),
    S3=[que|S4],
    lecionam(X, Zs).

pesquisa(X, S0, S):-
    S0=[quando|S1],
    predicado(Z, V, S1, S2),
    aulas(Z, Zs).

pesquisa(X, S0, S):-
    artigo(S0, S1),
    S1=[que|S2],
    sujeito(X, S2, S3),
    verbo(S3, Y, S4),
    rleciona(X, Zs).

resposta2(X, A):-
    atom_concat(X, ' eh', P1),
    atom_concat(P1, ' as ', P2),
    rdsemana(A, P3),
    atom_concat(P2, P3, P4),
    write(P4),
    nl.

rdsemana([],'').
rdsemana([H | []],S):-
    dsemana(D,H), 
    string_concat(D,'',S), !.
rdsemana([H|T],S):-
    dsemana(D,H), rdsemana(T,R),
    string_concat(D,' e ',W), 
    string_concat(W,R,S).

resposta(X, A):-
    atom_concat('O(a) professor(a) ', X, P1),
    atom_concat(P1, ' da ', P2),
    atom_concat(P2, A, P3),
    atom_concat(P3, '.', P4),
    write(P4),
    nl.

leciona(X, Zs):-
    setof(Y, (da(Y, X), resposta(Y, X)), Ys).
rleciona(X, Zs):-
    setof(Y, (da(X, Y), resposta(X, Y)), Ys).
lecionam(X, Zs):-
    bagof(Y, (da(Y, X), resposta(Y, X)), Ys).
aulas(X, Zs):-
    setof(Y, (eh(X, Y), resposta2(X, Y)), Ys).

consulta(X):- 
    monta_lista(L),
    pesquisa(A, L, []).

fato(X):- 
    monta_lista(L),
    sentenca(A, L, []).

