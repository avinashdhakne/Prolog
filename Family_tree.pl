male(raghunath).
male(anish).
male(anand).
male(arjun).
male(aditya).
male(jaya ).
male(bhaskar).
male(balveer).
male(brijesh).
male(hitesh ).
male(dhruv ).
male(daksh ).
male(gautam ).
male(gaurav ).
male(jay ).
male(jeevan ).
male(jatin ).
male(jeet ).
male(darpan ).
male(girish ).
male(kartik ).
male(gopal).
male(krishna).
male(karan).
male(hemant).
male(ishan ).

/*
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
*/

female(radhabai).
female(anushka ).
female(aditi  ).
female(aradhna).
female(ambhika).
female(jeevika ).
female(bhanu ).
female(bhavana ).
female(bina ).
female(hemal ).
female(diksha ).
female(damini).
female(ganga ).
female(gauri ).
female(janki ).
female(deepa ).
female(gayatri ).
female(komal ).
female(kirti ).
female(isha ).
female(geeta ).
female(hira ).
female(kamala ).
female(kaveri ).


married(raghunath, radhabai ).
married(anish, anushka).
married(anand, aditi).
married(arjun, aradhna).
married(aditya, ambhika).
married(jayesh, jeevika ).
married(bhaskar, bhanu).
married(balveer, bhavana ).
married(brijesh, bina ).
married(daksh, damini).
married(gautam, ganga).
married(gaurav, gauri).
married(darpan, deepa).
married(girish, gayatri).
married(ishan, isha).
married(gopal, geeta).
married(hemant, hira).

/*
married(anish,priya).
married(dev,kiran).
married(harish,gayatri).
married(sunil,shreya).
married(nikhil,dipika).
married(jayesh,bhumi).
married(virat,kriti).
married(pravin,radhika).
married(omkar,riddhi).
*/

parent(anushka, raghunath, radhabai ).
parent(anand, raghunath, radhabai ).
parent(aradhna, raghunath, radhabai ).
parent(aditya, raghunath, radhabai ).
parent(jeevika, anish, anushka).
parent(bhanu, aditya, ambhika).
parent(bhavana, aditya, ambhika).
parent(brijesh, aditya, ambhika).
parent(hitesh, jayesh, jeevika ).
parent(hemal, jayesh, jeevika ).
parent(dhruv, bhaskar, bhanu).
parent(diksha, bhaskar, bhanu).
parent(daksh, brijesh, bina ).
parent(darpan, brijesh, bina ).
parent(ganga, daksh, damini).
parent(gaurav, daksh, damini).
parent(jay, gautam, ganga).
parent(janki, gautam, ganga).
parent(jeevan, gaurav, gauri).
parent(jatin, gaurav, gauri).
parent(jeet, gaurav, gauri).
parent(girish, darpan, deepa).
parent(kartik, girish, gayatri).
parent(komal, girish, gayatri).
parent(kirti, girish, gayatri).
parent(geeta, ishan, isha).
parent(hemant, ishan, isha).
parent(kamala, gopal, geeta).
parent(krishna, gopal, geeta).
parent(karan, hemant, hira).
parent(kaveri, hemant, hira).

/*
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
*/

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
    parent(Y,M,F),
    X\=Y.

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







