% mysort/2 is a kinda insertion sort of integers
mysort(Unsorted, Sorted) :-
    remove_min(Unsorted, Smallest, TempResult),
    mysort(TempResult, TempSorted),
    myappend([Smallest], TempSorted, Sorted).

mysort([Element], Sorted) :-
    Sorted = [Element].

% remove_min/3 finds the smallest element of a list and removes it
remove_min(List, Min, Result) :-
    min(List, Min),
    remove(Min, List, Result).

% min/2 finds the smallest element of a list
min([Head|[]], X) :- X = Head.
min([Head|Tail], X) :- min(Tail, X1),
                       Head @> X1 -> X = X1; X = Head.

% remove/3 removes a given element from a list once
remove(Element, [Head|Tail], NewList) :-
    Head == Element -> NewList = Tail;
    remove(Element, Tail, TempList),
    append([Head], TempList, NewList).
