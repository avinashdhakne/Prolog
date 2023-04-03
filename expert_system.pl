% data

% country(Name, Continent, Independace Year,
%         Economy (in millions),Develpment status,
%         Population (in million), Literacy (%))

country("India", "Asia", 1947, 3202, "Developing", 1393, 77).
country("China", "Asia", 1949, 16164, "Developing", 1411, 96).
country("Russia", "Asia", 1992, 1852, "Developing", 144, 99).
country("Japan", "Asia", 1947, 5087, "Developed", 125, 99).
country("Saudi Arabia", "Asia", 1932, 806, "Developed", 35, 87).
country("USA" , "North America", 1716, 22675, "Developed", 332, 99).
country("Canada", "North America", 1867, 1842, "Developed", 38, 99).
country("Mexico", "North America", 1810, 1304, "Developing", 131, 95).
country("Australia", "Australia", 1901, 1647, "Developed", 25, 96).
country("New Zealand", "Australia", 1840, 211, "Developed", 5, 99).
country("England", "Europe", 927, 3247, "Developed", 56, 99).
country("Germany", "Europe", 1871, 4859, "Developed", 83, 83).
country("France", "Europe", 1789, 2977, "Developed", 67, 64).
country("Egypt", "Africa", 1922, 363, "Developing", 105, 736).
country("Nigeria", "Africa", 1960, 487, "Developing", 211, 61).
country("South Africa", "Africa", 1961, 283, "Developing", 58, 87).
country("Brazil", "South America", 1822, 2862, "Developing", 215, 94).
country("Argentina", "South America", 1816, 452, "Developing", 46, 98).

world_region(Nation, Region, Independence, GDP, Development, Population, Education):-
    country(Nation, Continent, Independence, GDP, Development, Population, Education),
    (Region == "Asia-pacific" ->
     (Continent = "Asia"; Continent="North America");
     (Continent="Africa"; Continent="South America";Continent="Australia";Continent="Europe")
    ).

world_independence(Nation, Region, Independence, GDP, Development, Population, Education):-
    world_region(Nation, Region, Freedom, GDP, Development, Population, Education),
    (Independence == "After" ->
        (Freedom > 1886);
        (Freedom =< 1886)).

world_GDP(Nation, Region, Independence, GDP, Development, Population, Education):-
    world_independence(Nation, Region, Independence, Economy, Development, Population, Education),
    (GDP == "Rich" ->
        (Economy > 3000);
        (Economy =< 3000)).

world_population(Nation, Region, Independence, GDP, Development, Population, Education):-
    world_GDP(Nation, Region, Independence, GDP, Development, Census, Education),
    (Population == "Crowdy" ->
        (Census > 60);
        (Census =< 60)).

world_literacy(Nation, Region, Independence, GDP, Development, Population, Education):-
    world_population(Nation, Region, Independence, GDP, Development, Population, Literacy),
    (Education == "Smart" ->
        (Literacy > 80);
        (Literacy =< 80)).


start(Nation):-
    write("Answer Few question and I will let you know your country."), nl,
    write("Just put y if your answer is yes, or n if it is false"), nl, nl,

    % Question 1 -----
    write("1. Is country considered as developed?"),
    write("   "), write("a. Yes"), write("\t"), write(" b. No"), nl,
    read(Answer1),

    (Answer1 == 'y' ->
     Development = "Developed";
     Development = "Developing"),

    aggregate_all(count, country(Nation, _, _, _, Development, _, _), Count1),
    write("Total results found: "), write(Count1), nl,nl,

    (   Count1 == 0 ->
        write("No result found.");
        Count1 == 1 ->
        nl,write("Answer:  "), nl,country(Nation, _, _, _, Development, _, _);

    % Question 2 -----
    write("2. Is country situated in either Asia or North America"),
    write("   "), write("a. Yes"), write("\t"), write(" b. No"), nl,

    read(Answer2),

    (Answer2 == 'y' ->
        Region = "Asia-pacific";
        Region = "Rest-world"),

aggregate_all(count, world_region(Nation, Region, _, _, Development, _, _), Count2),

    write("Total results found: "), write(Count2), nl,nl,

    (   Count2 == 0 ->
        write("No result found.");
        Count2 == 1 ->
        write(Answer2), nl,world_region(Nation, Region, _, _, Development, _, _);

    % Question 3 -----
    write("3. Does country got independence before 1886"),
    write("   "), write("a. Yes"), write("\t"), write(" b. No"), nl,

    read(Answer3),

    (Answer3 == 'y' ->
        Independence = "Later";
        Independence = "After"),

    aggregate_all(count, world_independence(Nation, Region, Independence, _, Development, _, _), Count3),

    write("Total results found: "), write(Count3), nl,nl,

    (   Count3 == 0 ->
        write(Answer2), nl;
        Count3 == 1 ->
        nl,write("Answer: "), world_independence(Nation, Region, Independence, _, Development, _, _);
    % Question 4 -----

    write("4. Is Economy of country is more than 3 trillion dollers"),
    write("   "), write("a. Yes"), write("\t"), write(" b. No"), nl,

    read(Answer4),

    (Answer4 == 'y' ->
        GDP = "Rich";
        GDP = "Middle"),

    aggregate_all(count, world_GDP(Nation, Region, Independence, GDP, Development, _, _), Count4),

    write("Total results found: "), write(Count4), nl,nl,

    ((Count4 == 0) ->
        write("No result found");
    (Count4 == 1) ->
        nl,write("Answer: "), world_GDP(Nation, Region, Independence, GDP, Development, _, _);

    % Question 5 ------
    write("5. Is countrie's population is more than 6 cr."),
    write("   "), write("a. Yes"), write("\t"), write(" b. No"), nl,nl,

    read(Answer5),

    (Answer5 == 'y' ->
        Population = "Crowdy";
        Population = "Empty"),

    aggregate_all(count, world_population(Nation, Region, Independence, GDP, Development, Population, _), Count5),

    write("Total results found: "), write(Count5), nl,nl,

    (   Count5 == 0 ->
        write("No result found."), nl;
        Count5 == 1  ->
        nl,write("Answer: "), world_population(Nation, Region, Independence, GDP, Development, Population, _);

    % Question 6 -----
    write("4. Is country's literacy rate is more than 80%"),
    write("   "), write("a. Yes"), write("\t"), write(" b. No"), nl,

    read(Answer6),

    (Answer6 == 'y' ->
        Education = "Smart";
        Education = "Studying"),

    aggregate_all(count, world_literacy(Nation, Region, Independence, GDP, Development, Population, Education), Count6),

    write("Total results found: "), write(Count6), nl,nl,

    (   Count6 == 0 ->
        write("No result found.");
        Count6 == 1  ->
        nl,write("Answer: "), world_literacy(Nation, Region, Independence, GDP, Development, Population, Education))))))).







