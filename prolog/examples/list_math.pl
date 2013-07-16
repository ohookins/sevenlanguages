count(0, []).
count(Count, [_|Tail]) :- count(TailCount, Tail), Count is TailCount + 1.
% Head was replaced with _ above due to singleton variable warning from gprolog
sum(0, []).
sum(Total, [Head|Tail]) :- sum(Sum, Tail), Total is Head + Sum.

average(Average, List) :- sum(Sum, List), count(Count, List), Average is Sum/Count.
