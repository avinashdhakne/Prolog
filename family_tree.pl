male(anish).
male(dev).
male(harish).
male(sunil).
male(nikhil).
male(jayesh).
male(virat).
male(pravin).
male(omkar).
male(rahul).
male(sameer).
male(yash).

female(priya).
female(kiran).
female(gayatri).
female(shreya).
female(dipika).
female(bhumi).
female(kriti).
female(radhika).
female(riddhi).
female(reshma).
female(saniya).
female(pooja).

married(anish,priya).
married(dev,kiran).
married(harish,gayatri).
married(sunil,shreya).
married(nikhil,dipika).
married(jayesh,bhumi).
married(virat,kriti).
married(pravin,radhika).
married(omkar,riddhi).

parent(kiran,anish,priya).
parent(harish,anish,priya).
parent(dipika,harish,gayatri).
parent(jayesh,harish,gayatri).
parent(bhumi,sunil,shreya).
parent(virat,sunil,shreya).
parent(pravin,jayesh,bhumi).
parent(riddhi,jayesh,bhumi).
parent(rahul,virat,kriti).
parent(reshma,virat,kriti).
parent(saniya,pravin,radhika).
parent(sameer,pravin,radhika).
parent(yash,omkar,riddhi).
parent(pooja,omkar,riddhi).

% matrimonial relations
couple(X,Y):-
    married(X,Y);married(Y,X).

husband(X,Y):-
    married(X,Y).

wife(X,Y):-
    married(Y,X).

% Siblings
sibling(X,Y):-
    parent(X,M,F),
    parent(Y,M,F).

brother(X,Y):-
    parent(X,M,F),
    parent(Y,M,F),
    male(X),X\=Y.

sister(X,Y):-
    parent(X,M,F),
    parent(Y,M,F),
    female(X),X\=Y.

% Parents
father(X,Y):-
    male(X),
    parent(Y,X,_).

mother(X,Y):-
    female(X),
    parent(Y,_,X).

child(X,Y):-
    (father(Y,X);mother(Y,X)).

son(X,Y):-
    (father(Y,X);mother(Y,X)),
    male(X).

daughter(X,Y):-
    (father(Y,X);mother(Y,X)),
    female(X).

% Grand-Parents
grandfather(X,Y):-
    father(X,Z),
    (father(Z,Y);mother(Z,Y)),
    male(X).

grandmother(X,Y):-
    mother(X,Z),
    (father(Z,Y);mother(Z,Y)),
    female(X).

greatgrandfather(X,Y):-
    grandfather(Z,Y),
    father(X,Z).

greatgrandmother(X,Y):-
    grandfather(Z,Y),
    mother(X,Z).

grandson(X,Y):-
    (grandfather(Y,X);grandmother(Y,X)),
    male(X).

grandaughter(X,Y):-
    (grandfather(Y,X);grandmother(Y,X)),
    female(X).

% uncle-aunt
uncle(X,Y):-
    male(X),
    (father(Z,Y);mother(Z,Y)),
    (brother(X,Z);(sister(M,Z),married(X,M));(sister(Z,M),married(M,X))).

aunt(X,Y):-
    female(X),
    (father(Z,Y);mother(Z,Y)),
    (sister(X,Z);(brother(M,Z),married(M,X));(brother(Z,M),married(X,M))).

% cousin sibings
cousin(X,Y):-
    (uncle(Z,Y);aunt(Z,Y)),
    child(X,Z).

cousinbrother(X,Y):-
    cousin(X,Y),
    male(X).

cousinsister(X,Y):-
    cousin(X,Y),
    female(Y).

% In-laws
brotherinlaw(X,Y):-
    (husband(Z,Y),brother(X,Z));
    (sister(M,Y),husband(X,M)).

sisterinlaw(X,Y):-
    (wife(Z,Y),sister(X,Z));
    (brother(M,Y),wife(X,M)).

fatherinlaw(X,Y):-
    couple(Z,Y),
    father(X,Z).

motherinlaw(X,Y):-
    couple(Z,Y),
    mother(X,Z).

nephew(X,Y):-
    uncle(Y,X),
    male(X).

niece(X,Y):-
    uncle(Y,X),
    female(X).

soninlaw(X,Y):-
    daughter(Z,Y),
    husband(X,Z).

daughterinlaw(X,Y):-
    son(Z,Y),
    wife(X,Z).







