-module(day1).
-export([count_words/1, count_to_ten/0, matching/1]).

% day1:count_words/1
array_count([]) -> 0;
array_count([_|Tail]) -> 1 + array_count(Tail).
count_words(Anything) -> array_count(string:tokens(Anything, " ")).

% day1:count_to_ten/0
count_to_ten() -> count_up(10).
count_up(X) when X > 1 -> count_up(X - 1), io:format("~w~n", [X]);
count_up(X) -> io:format("~w~n", [X]).

% day1:matching/1
matching({error, Message}) -> io:format("error: ~s~n", [Message]);
matching(success) -> io:format("success~n", []).
