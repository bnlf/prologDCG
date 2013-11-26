:- dynamic da/2.
:- dynamic eh/2.

sentenca(X, S0, S):-sujeito(Y, S0, S1), predicado(Z, V, S1, S2), V=da, assert(da(Y, Z)), X = da(Y, Z).
sentenca(X, S0, S):-sujeito(Y, S0, S1), predicado(Z, V, S1, S2), V=eh, assert(eh(Y, Z)), X = eh(Y, Z).
sentenca(X, S0, S):-sujeito(Y, S0, S1), predicado(D, Z, V, S1, S2), V=eh, assert(eh(D, Z)), X = eh(D, Z).

sujeito(X, S0, S):-	
	disciplina(S0, A, S), 
	X=A.
sujeito(X, S0, S):-
	artigo(S0, S1), 
	substantivo(S1, S2), 
	professor(S2, A, S), 
	X=A.

predicado(Y, V, S0, S):-
	verbo(S0, SH, ST),
	V=SH.
predicado(Y, V, S0, S):-
	verbo(S0, SH, ST),
	V=SH,
	disciplina(ST, A, S2), 
	Y=A.
predicado(Y, V, S0, S):-
	verbo(S0, SH, ST), 
	V=SH,
	locAdverbial(ST, S2), 
	diaSemana(S2, S3),
	Y=S3.
predicado(D, Y, V, S0, S):-
	verbo(S0, SH, ST),
	V=eh,
	disciplina(ST, A, S2),
	D=A, 
	locAdverbial(S2, S3), 
	diaSemana(S3, S4),
	Y=S4.

diaSemana([],[]).
diaSemana([H|[]], [HC|[]]) :- dsemana(H, HC), !.
diaSemana([H,_|T], [HC|TC]) :- dsemana(H, HC), diaSemana(T, TC).

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

dsemana(domingos, 1).
dsemana(segundas, 2).
dsemana(tercas, 3).
dsemana(quartas, 4).
dsemana(quintas, 5).
dsemana(sextas, 6).
dsemana(sabados, 7).

verbo([da|S], da, S).
verbo([eh|S], eh, S).

locAdverbial([aas|S], S).





