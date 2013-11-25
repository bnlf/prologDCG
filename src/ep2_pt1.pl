sentenca(X, S0, S):-
	sujeito(Y, S0, S1), 
	predicado(Z, S1, S2),
	assert(da(Y, Z)), 
	X = da(Y, Z).

sentenca(X, S0, S):-
	sujeito(Y, S0, S1), 
	predicado(Z, S1, S2),
	assert(eh(Y, Z)), 
	X = eh(Y, Z).

sujeito(X, S0, S):-	
	disciplina(S0, A, S), 
	X=A.
sujeito(X, S0, S):-
	artigo(S0, S1), 
	substantivo(S1, S2), 
	professor(S2, A, S), 
	X=A.

predicado(Y, S0, S):-
	verbo(S0, S1), 
	disciplina(S1, A, S2), 
	Y=A.
predicado(Y, S0, S):-
	verbo(S0, S1), 
	locAdverbial(S1, S2), 
	htElemento(S2, H, T),
	dsemana(H, D1),
	htElemento2(T, H2, T2),
	dsemana(H2, D2),
	Y=[D1, D2].

% suporte
htElemento([H|T], H, T).
htElemento2([_,H|T], H, T).

% pre-definidos
artigo([o|S], S).
artigo([a|S], S).

substantivo([professor|S], S).
substantivo([professora|S], S).

disciplina([mac239|S], mac239, S).
disciplina([mac425|S], mac425, S).
disciplina([mac122|S], mac122, S).

professor([marcelo|S], marcelo, S).
professor([renata|S], renata, S).
professor([leliane|S], leliane, S).

dsemana(segundas, 2).
dsemana(tercas, 3).
dsemana(quartas, 4).
dsemana(quintas, 5).
dsemana(sextas, 6).

verbo([da|S], S).
verbo([eh|S], S).
verbo([aas|S], S).

locAdverbial([aas|S], S).





