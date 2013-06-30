% reverse/2 is a built-in which we cannot override.
rvrse(X, Y) :-  X = [Head|Tail],
                Tail == [],
                Y = [Head].

rvrse(X, Y) :-  X = [Head|Tail],
                rvrse(Tail, Z),
                append(Z,[Head],Y).
