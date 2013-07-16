% min/2 finds the smallest element of a list
min([Head|[]], X) :- X = Head.
min([Head|Tail], X) :- min(Tail, X1),
                       Head @> X1 -> X = X1 ; X = Head.
