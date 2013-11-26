% monta_lista (-L)
%   Reads a line of text, breaking it into a
%   a list of atomic terms: [this,is,an,example].
monta_lista(L):-
    leChar(X, T),
    completaLinha(X, T, L).

% leChar(-Char,-Type)
%  Reads a character and runs it through tipoChar/1.
leChar(X,T):-
    get0(C), % Gets a character from the current input source (check via 
	     % seeing/1).
    tipoChar(C,T,X).

% completaLinha(+FirstC,+FirstT,-L)
%  Given FirstC (the first character) and FirstT (its type), reads
%  and tokenizes the rest of the line into atoms and numbers.
completaLinha(_, end, []):-!.	% stop at end
completaLinha(_, blank, L):- % skip blanks
    !,
    monta_lista(L).
completaLinha(X, special, [A|L]):- 	% special char
    !,
    name(A, [X]),
    monta_lista(L).
completaLinha(X, ialpha,[A|[]]):-	% begin word
    !,
    name(A, [X]), !.
    %monta_lista(L).
completaLinha(X, alpha, [A|L]):-	% begin word
    completaPalavra(X, alpha, W, C0, T0),
    name(A, W),	% may have some problems with numbers
    completaLinha(C0, T0, L).

% completaPalavra(+X,+FirstT,-List,-FollC,-FollT)
%  Given X (the first character) and FirstT (its type)
%  reads the rest of a word, putting its characters into List.
completaPalavra(X,alpha,[X|List],X0,T0):-
    !,
    leChar(C1,T1),
    completaPalavra(C1,T1,List,X0,T0).
completaPalavra(X,T0,[],X,T0). % where FirstT is not alpha

% tipoChar(+Code,?Type,-NewCode)
%  Given an ASCII Code classifies the character as 'end'
%  (of line/file), 'blank', 'alpha'(numeric), or 'special',
%  and changes it to a potentially different character (NewCode).
tipoChar(10,end,10):- !.	% UNIX eol mark
tipoChar(13,end,13):- !.	% DOS eol mark
tipoChar(-1,end,-1):- !.	% get0 end of file code
tipoChar(46,ialpha,46):-!.  % '.'
tipoChar(63,ialpha,63):-!.  % '?'
tipoChar(Code,blank,32):-	% blanks, other CTRL codes
    Code =< 32,
    !.
tipoChar(Code,alpha,Code):-	% digits
    48 =< Code, Code =< 57,
    !.
tipoChar(Code,alpha,Code):-	% lower-case letters
    97 =< Code, Code =< 122,
    !.
tipoChar(Code,alpha,NewCode) :- % upper-case letters
	65 =< Code, Code =< 90,
	!,
	NewCode is Code + 32. % translate to lower case
tipoChar(Code,special,Code).	% all others
