monta_lista(L):-
    leChar(X, T),
    completaLinha(X, T, L).

leChar(X,T):-
    get0(C),
    tipoChar(C,T,X).

completaLinha(_, end, []):-!.
completaLinha(_, blank, L):-
    !,
    monta_lista(L).
completaLinha(X, special, [A|L]):-
    !,
    name(A, [X]),
    monta_lista(L).
completaLinha(X, ialpha,[A|[]]):-
    !,
    name(A, [X]), !.
    %monta_lista(L).
completaLinha(X, alpha, [A|L]):-
    completaPalavra(X, alpha, W, C0, T0),
    name(A, W),	
    completaLinha(C0, T0, L).

completaPalavra(X,alpha,[X|List],X0,T0):-
    !,
    leChar(C1,T1),
    completaPalavra(C1,T1,List,X0,T0).
completaPalavra(X,T0,[],X,T0). 

tipoChar(10,end,10):- !.	% UNIX eol mark
tipoChar(13,end,13):- !.	% DOS eol mark
tipoChar(-1,end,-1):- !.	% get0 eof code
tipoChar(46,ialpha,46):-!.  % '.'
tipoChar(63,ialpha,63):-!.  % '?'
tipoChar(Code,blank,32):-	% blanks, outros CTRL codes
    Code =< 32,
    !.
tipoChar(Code,alpha,Code):-	% digitos
    48 =< Code, Code =< 57,
    !.
tipoChar(Code,alpha,Code):-	% lower-case
    97 =< Code, Code =< 122,
    !.
tipoChar(Code,alpha,NewCode) :- % upper-case
	65 =< Code, Code =< 90,
	!,
	NewCode is Code + 32. % traduz para lower case
tipoChar(Code,special,Code).	% todos os outros
